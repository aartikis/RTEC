/**********************************************************************************

 Script for running RTEC.
 Authors: Alexander Artikis and Manos Pitsikalis.
 Maintainer: Periklis Mantenoglou

 Run in YAP: yap -s 0 -h 0 -t 0 -l continuousQueries.prolog
 Run in SWI: swipl -l continuousQueries.prolog

 **********************************************************************************/

% load RTEC
:- ['../src/RTEC.prolog'].

% The data loader reads CSV files of input datasets, 
% converts the data to the appropriate RTEC predicates, 
% and asserts these predicates for RTEC to process.
:- ['../src/data loader/dataLoader.prolog'].

% handleApplication includes hard-coded execution parameters, such as 
% window and step sizes, for certain applications
% handleApplication assigns the parameter values provided by the user to the appropriate variables. 
% The parameters for which no value was provided are assigned an application-specific default value.
:- ['handleApplication.prolog'].
% The logger contains predicates for printing out logs and results.
:- ['logger.prolog'].

% Continuous query processing with RTEC on application <App> with the execution parameters <ParamList>.
% This predicate does not call the compiler, i.e., the given event description should be compiled.
% continuousQueries(+App,+ParamList)
continuousQueries(App, ParamList) :-
    % The flag we use to measure cpu time depends on the Prolog environment.
    handleProlog(Prolog, StatisticsFlag), 
    % Assign the value provided in <ParamList> to each parameter of RTEC. Assign the default value, if no value is provided in <ParamList>
    handleApplication(App, Prolog, ParamList, PrologFiles, InputMode, InputPaths, LogFile, OutputMode, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch, StreamRate, AllenMem),
    % <PrologFiles> includes, at the very least, the compiled rules of the event description.
    % The remaining files in <PrologFiles> contain background knowledge.
    consultInputFiles(PrologFiles),
    % The user may provide as input a list named 'Goals', which contains queries to be ran by this script before executing RTEC.
    %executeUserGoals(Goals), % run queries requested by the user.
    printLogo,
    % Depending on the <InputMode>, get the input streams or the ids of the threads that read from fifos/a socket.
    init_input(InputMode, InputPaths, InputStreams, PointerPositions, InputThreadIDs),
    % Create a log file for writing execution statistics.
    init_log_file(LogFile),
    QueryTime is StartReasoningTime + Step,
    init_output(OutputMode, ResultsFile, WM, Step, QueryTime, OutputThreadID),
    % initialise RTEC, i.e., assert the parameters provided in the predicate below, so that they are accessible by any predicate.
    initialiseRecognition(Step, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, AllenMem),
    % In case that the input is a live stream, sleep until the first query time, which is specified with the <Step> parameter.
    sleep_if_live_stream(InputMode, Step, StreamRate, 0),
    % This predicates runs RTEC for the next query time. Afterwards, it is being called recursively until we have passed the EndReasoningTime.
    querying(InputMode, InputStreams, PointerPositions, StatisticsFlag, LogFile, OutputMode, ResultsFile, OutputThreadID, WM, Step, QueryTime, StartReasoningTime, EndReasoningTime, [], RecTimes, [], InputList, ([],[],[]), OutputLists, SDEBatch, StreamRate),
    % Calculate and record the recognition time statistics
    closeInput(InputMode, InputPaths, InputStreams, InputThreadIDs),
    open(LogFile, append, LogFileStream),
    logWindowStats(LogFileStream, RecTimes, InputList, OutputLists),
    close(LogFileStream),
    closeOutput(OutputMode, OutputThreadID), !.

% Invokes continuousQueries/2 with an empty list of parameter values. Therefore, we use the default value of each parameter.
% continuousQueries(+App)
continuousQueries(App) :- !,
	continuousQueries(App, []).

% execution stops when the previous query time is greater or equal to the designated last reasoning time 
%querying(_InputMode,_InputStreams, _InputPointerPositions, _StatisticsFlag, _LogFile, _OutputMode, _ResultsFile, _WM, Step, QueryTime, _StartReasoningTime, EndReasoningTime, RecTimes, RecTimes, InputList, InputList, OutputList, OutputList, _SDEBatch, _StreamRate) :-
%PrevQueryTime is QueryTime-Step,
%PrevQueryTime >= EndReasoningTime, !.

querying(InputMode, InputStreams, PointerPositions, StatisticsFlag, LogFile, OutputMode, ResultsFile, OutputThreadID, WM, Step, QueryTime, StartReasoningTime, EndReasoningTime, InitRecTime, RecTimes, InitInput, InputList, (InitOutputOutFVpairs,InitOutputOutLI,InitOutputOutLD), OutputList, SDEBatch, StreamRate) :-
	getWindowStartTime(QueryTime, WM, StartReasoningTime, WindowStartTime),
	% VerifiedQueryTime=QueryTime when QueryTime =< EndReasoningTime
	% otherwise: VerifiedQueryTime=EndReasoningTime 
	verifyQueryTime(QueryTime, EndReasoningTime, VerifiedQueryTime),
	% load input data in (WindowStartTime, VerifiedQueryTime]
	loadNarrative(InputMode, InputStreams, WindowStartTime, VerifiedQueryTime, PointerPositions, NewPointerPositions, SDEBatch),
	printBeforeER(WindowStartTime, VerifiedQueryTime),	
	%%%%%%%%% compute the recognition time of the current window
	statistics(StatisticsFlag,[S1,_T1]),
	% eventRecognition(+QueryTime, +WM)
	% Note: the first argument of eventRecognition below remains QueryTime and not VerifiedQueryTime.
	% This way, we do not change the start time of event recognition.
	% When QueryTime =< EndReasoningTime then event recognition takes place in (QueryTime-WM,QueryTime]
	% Otherwise, event recognition takes place effectively in (QueryTime-WM,EndReasoningTime]
	% because no input data are loader after EndReasoningTime
	eventRecognition(QueryTime, WM),
	findall((F=V,L), (outputEntity(F=V),holdsFor(F=V,L),L\=[]), OELI),
	findall((EE,TT), (outputEntity(EE),happensAt(EE,TT)), OELT),
	statistics(StatisticsFlag,[S2,_T2]),
	% log the computed intervals of output entities
	% log window execution time
 	S is S2-S1, %S=T2,
	open(LogFile, append, LogFileStream),
 	writeResult(S, LogFileStream),
	close(LogFileStream),
	% print statistics about window execution: recognition time, input entities and output entities.
	printAfterER(S, WindowStartTime, VerifiedQueryTime, OELI, OELT, InL, OutFVpairs, OutLI, OutLD),
	(
		% if the designated last time-point of reasoning has not been passed
		QueryTime < EndReasoningTime,
		% (i) compute the next query-time
		NextQueryTime is QueryTime+Step, !,  %% This cut is necessary to prevent the local stack from exploding.
                % If the <OutputMode> is fifo, send a "ready" message to the thread writing the computed intervals into a named pipe.
        	(OutputMode=fifo, thread_send_message(OutputThreadID, printRecognitions) ;
                % If the <OutputMode> is file, this thread writes the computed intervals into a regular file.
         	 OutputMode=file, printRecognitions(ResultsFile, QueryTime, WM)),
		% (ii) sleep until the next query time 
		% after each window, except the first and the last one, sleep for an amount of tie calculated as the step minus the time used for event recognition on the current window.
		sleep_if_live_stream(InputMode, Step, StreamRate, S),
		querying(InputMode, InputStreams, NewPointerPositions, StatisticsFlag, LogFile, OutputMode, ResultsFile, OutputThreadID, WM, Step, NextQueryTime, StartReasoningTime, EndReasoningTime, [S|InitRecTime], RecTimes, [InL|InitInput], InputList, ([OutFVpairs|InitOutputOutFVpairs],[OutLI|InitOutputOutLI],[OutLD|InitOutputOutLD]), OutputList, SDEBatch, StreamRate)
	;
                % Since this is the final window, this thread has to wait for the thread executing printRecognitions to terminate before exiting.
                % This is why we have to wait for a "printRecognitionsOK" message in this case.
        	(OutputMode=fifo, thread_send_message(OutputThreadID, printRecognitions), thread_get_message(printRecognitionsOK(QueryTime)) ;
         	 OutputMode=file, printRecognitions(ResultsFile, QueryTime, WM)),
		% if the designated last time-point of reasoning has been passed, compute exit with the final execution metrics.
		QueryTime >= EndReasoningTime,
		RecTimes = [S|InitRecTime],
		InputList = [InL|InitInput],
		OutputList= ([OutFVpairs|InitOutputOutFVpairs],[OutLI|InitOutputOutLI],[OutLD|InitOutputOutLD])
	).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% handleProlog(-PrologCompiler, -StatisticsFlag) 
handleProlog(yap, cputime) :-
	current_prolog_flag(dialect, yap).
handleProlog(swi, runtime) :-
	current_prolog_flag(dialect, swi).

% init_input(+InputMode, +InputPaths, -InputStreams, -PointerPositions, -InputThreadIDs)
init_input(csv, InputPaths, InputStreams, PointerPositions, []):-
    openInputCSVFiles(InputPaths, InputStreams, PointerPositions).

% For <inputMode> "fifo", we one named pipe for each input provider.
% RTEC creates a new execution thread that continuously reads input events from each provider.
init_input(fifo, InputPaths, [], [], InputThreadIDs):-
    initLoaderThreads(InputPaths, InputThreadIDs).

% For the <InputMode> "socket", we use a server-client architecture.
% The <InputPaths> list contains one <SocketName>, which is initialised as a server socket from the side of RTEC.
% Multiple processes (that possibly live outside of Prolog) can connect as clients to the socket and push input events. 
% RTEC creates a new execution thread that listens for clients that attempt to connect to the socket.
% For each such client, we create a new thread that reads continuously the input events sent by the client.
init_input(socket, [SocketName], [], [], [ThreadID]):-
    initSocketLoaderThread(SocketName, ThreadID).

init_input(dynamic_predicates, InputPaths, [], [], []):-
    consultInputFiles(InputPaths).

% init_log_file(+LogFile)
init_log_file(LogFile):-
    create_file(LogFile).

% init_output(+OutputMode, +ResultsFile, +WM, +Step, +CurrentTime, -OutputThreadID),
init_output(file, ResultsFile, _, _, _, -1):-
    create_file(ResultsFile).
init_output(fifo, ResultsPipe, WM, Step, CurrentTime, OutputThreadID):-
    create_pipe(ResultsPipe),
    thread_self(ERThreadID),
    initWriterThread(ResultsPipe, WM, Step, CurrentTime, ERThreadID, OutputThreadID).


% touch <File>, so that it exists as an empty file before the execution of the first window.
%create_file(+File)
create_file(File):-
	open(File, write, FileStream),
	close(FileStream).

% touch <Pipe>, so that it exists as an empty file before the execution of the first window.
%create_pipe(+PipeName)
create_pipe(PipeName):-
    process_create(path(rm), ['-f', PipeName], []),
    process_create(path(mkfifo), [PipeName], []).

% Each thread executes the goal: loadIELiveStream(InputPipe), which is specified in 'src/data loader/dataLoader.prolog' 
% Its function is to assert the events written in the pipe as soon as they arrive.
% initLoaderThreads(+InputPipes) 
initLoaderThreads([], []).
initLoaderThreads([InputPipe|RestPipes], [ThreadID|RestIDs]):-
	thread_create(loadIELiveStream(InputPipe), ThreadID),
	initLoaderThreads(RestPipes, RestIDs).

% initSocketLoaderThread(+SocketName,-ThreadID)
initSocketLoaderThread(SocketName, ThreadID):-
	% Create a unix, i.e., local, socket.
        unix_domain_socket(Socket),
	% Create a socket in the current directory with name <SocketName>. 
	tcp_bind(Socket, SocketName),
	% The socket may have at most N clients. 
	tcp_listen(Socket, 1000), % N = 1000
	% Open the socket from the server side and fetch its input stream with file descriptor: <AcceptFd>.
	tcp_open_socket(Socket, StreamPair),
	stream_pair(StreamPair, AcceptFd, _),
        % create an execution thread that accepts connection requests to the socket.
        thread_create(dispatch_socket(AcceptFd), ThreadID).

% Create a new execution thread for writing the computed intervals into the output named pipe.
% This thread executes the predicate: sleep_and_write(OutputPipe, WM, CurrentTime). 
% The thread blocks the event recognition thread of RTEC sends it a "printRecognitions" message.
% Next, it writes the computed intervals into the output pipe.
% This process is repeated until the thread receives a kill signal from the thread performing event recognition.
%
% initWriterThread(+OutputPipe, +WM, +Step, +CurrentTime, +ERThreadID, -OutputThreadID):-
initWriterThread(OutputPipe, WM, Step, CurrentTime, ERThreadID, OutputThreadID):-
	thread_create(print_results_on_message(OutputPipe, WM, Step, CurrentTime, ERThreadID), OutputThreadID).

% print_results_on_message(+OutputPipe, +WM, +Step, +CurrentTime, +ERThreadID)
print_results_on_message(OutputPipe, WM, Step, CurrentTime, ERThreadID):-
    open(OutputPipe, append, OutputStream),
    print_results_on_message_loop(OutputStream, WM, Step, CurrentTime, ERThreadID).

% print_results_on_message_loop(+OutputStream, +WM, +Step, +CurrentTime, +ERThreadID)
print_results_on_message_loop(OutputStream, WM, Step, CurrentTime, ERThreadID):-
    thread_get_message(printRecognitions),
    printRecognitionsThread(OutputStream, CurrentTime, WM),
    thread_send_message(ERThreadID, printRecognitionsOK(CurrentTime)),
    NextTime is CurrentTime + Step,
    print_results_on_message_loop(OutputStream, WM, Step, NextTime, ERThreadID).

% Open one input stream for each input file, while maintaining the reading position in the stream.
% openInputCSVFiles(+InputFiles, -InputStreams, -PointerPositions)
openInputCSVFiles([], [], []).
openInputCSVFiles([File|MoreFiles], [Stream|MoreStreams], [Position|MorePositions]) :-
	open(File, read, Stream),
	stream_property(Stream, position(Position)),
	openInputCSVFiles(MoreFiles, MoreStreams, MorePositions).

% Consult each file in <InputFiles>.
% consultInputFiles(+InputFiles)
consultInputFiles([]).
consultInputFiles([File|MoreFiles]) :-
	consult(File),
	consultInputFiles(MoreFiles).

% Not used.
% run selected goals before execution.
% this is used, e.g., for asserting the agents in the MAS use cases.
%executeUserGoals([]).
%executeUserGoals([Goal|RestGoals]) :-
    %Goal,
    %executeUserGoals(RestGoals).

% closeFiles(+datasetfilesstreams, +logfilestream, +resultsfilestream)
% first case: there are no input streams, 
% ie the dataset is in the form of Prolog assertions
closeInput(dynamic_predicates, _, _, _).

% second case: the dataset is in csv files;
% in this case close each input stream;
closeInput(csv, _, InputStreams, _) :-
	closeStreamsList(InputStreams).

% third case: fifo mode;
% Destroy all threads in list ThreadIDs.
closeInput(fifo, _, _, ThreadIDs) :-
	killThreads(ThreadIDs).

% fourth case: socket mode;
% Destroy all threads in ThreadIDs (we have one thread in this case).
closeInput(socket, [SocketName], _, ThreadIDs) :-
    killThreads(ThreadIDs),
    process_create(path(rm), ['-f', SocketName], []).

% The output stream was closed by printRecognitions.
closeOutput(file, _).

% Kill the thread writing into the output pipe.
closeOutput(fifo, ThreadID) :-
	thread_signal(ThreadID, abort).

% closeInputFiles(+InputStreams)	
closeStreamsList([]). 
closeStreamsList([InputStream|MoreInputStreams]) :-
	close(InputStream),
	closeStreamsList(MoreInputStreams).

% killThreads(+InputStreams)	
killThreads([]).
killThreads([ThreadID|RestIDs]) :-
	thread_signal(ThreadID, abort),
	killThreads(RestIDs).

% getWindowStartTime(+QueryTime, +WM, +StartReasoningTime, -WindowStartTime)
% If QueryTime-WM=<StartReasoningTime, the window starts at StartReasoningTime
% Else, in the more general case that QueryTime-WM>StartReasoningTime, the window starts at QueryTime-WM
getWindowStartTime(QueryTime, WM, StartReasoningTime, StartReasoningTime):-
	QueryTime-WM=<StartReasoningTime, !.

getWindowStartTime(QueryTime, WM, _StartReasoningTime, WindowStartTime):-
	WindowStartTime is QueryTime - WM.	

% verifyQueryTime(+QueryTime, +EndReasoningTime, -VerifiedQueryTime)
% A given QueryTime is OK as long as it is less or equal to the designated last reasoning time; 
% otherwise, it is set to the designated last reasoning time
verifyQueryTime(QueryTime, EndReasoningTime, QueryTime) :-
	QueryTime =< EndReasoningTime, !.
verifyQueryTime(QueryTime, EndReasoningTime, EndReasoningTime) :-
 	write('***Attention***: QueryTime adjusted from '), write(QueryTime), 
	write(' to '), write(EndReasoningTime),
	writeln(' but QueryTime-WM remains the same.').

% if fifo, sleep until the next query time 
% sleep_if_live_stream_between_windows(+InputMode, +Step, +StreamRate, +S)	
sleep_if_live_stream(InputMode, Step, StreamRate, S):-
	(
		(InputMode = fifo ; InputMode = socket),
		SleepTime is Step/StreamRate - S/1000,
		sleep_until_query_time(SleepTime)
	; 	\+ InputMode = fifo, \+ InputMode = socket
	).
	
sleep_until_query_time(SleepTimeSec):-
	statistics(walltime,[TBeforeSleep,_T1]),	
	write('Output entity processing thread is about to sleep for '), write(SleepTimeSec), write(' seconds.'), nl,
	sleep(SleepTimeSec),
	statistics(walltime,[TAfterSleep,_T2]),
	TSleep is (TAfterSleep - TBeforeSleep)/1000,
	write('Output entity processing thread slept for '), write(TSleep), write(' seconds.'), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assert narrative (SDEs)
%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% loadNarrative(+InputMode, +InputStreams, +Start, +End, +PointerPositions, -NewPointerPositions, +SDEBatch)
loadNarrative(InputMode, InputStreams, Start, End, PointerPositions, NewPointerPositions, SDEBatch) :-
	(
		% use the csv data loader
		InputMode = csv,
		loadIEStreams(InputStreams, Start, End, PointerPositions, NewPointerPositions)
		;
		% use dynamic predicates 
		InputMode = dynamic_predicates,
		updateManySDE(Start, End, SDEBatch)
		;
		% when using named pipes, the input is being read by another Prolog thread 
		InputMode = fifo
		;
		% when using named pipes, the input is being read by another Prolog thread 
		InputMode = socket
	).


% updateManySDE(+Start, +End, +SDEBatch)

% assert SDE from +Start to +End using batches of +SDEBatch size
% updateSDE, as opposed to updateManySDE, is defined in an application-specific manner

updateManySDE(Start, End, SDEBatch) :-
	Diff is End-Start,
	Diff =< SDEBatch,
	%!,
	updateSDE(Start, End), !.	

updateManySDE(Start, End, SDEBatch) :-
	Diff is End-Start,
	Diff > SDEBatch,
	NewStart is Start+SDEBatch,
	updateSDE(Start, NewStart), !,
	updateManySDE(NewStart, End, SDEBatch).

updateManySDE(_, _, _).

