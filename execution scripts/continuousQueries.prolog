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

% continuousQueries(+App, +ParameterList) runs RTEC for the application App and the execution parameters provided in ParameterList
% Supported parameters: 
% 	window_size: The temporal length of windows. The eventRecognition/2 process of 'src/RTEC.prolog' is executed for each temporal window.
% 	step: The temporal distance between two consecutive query times.
% 	start_time: The first time-point to be processed by RTEC.
% 	end_time: The last time-point to be processed by RTEC.
%	clock_tick: the temporal distance between consecutive time-points (keep the default value for supported applications).
% 	input_mode: Three possible values: 
% 		'csv': RTEC opens the input csv files and asserts the input events in the appropriate window.
% 		'fifo': Live stream reasoning. RTEC reads the input events from named pipes and asserts them as soon as they arrive.
%   	'dynamic_predicates': RTEC consults directing the input prolog files containing the input events. Event assertions take place in the appropriate window. 
%	input_providers: a list of paths from which the event streams will be read. WARNING: must agree with the provided input_mode.
%	results_directory: the directory in which the log and result files of RTEC will be written.
%	event_description_files: a list of Prolog files containing at least two files: the compiled rules and the declarations of the application.
%	goals: a list of Prolog queries to execute before running RTEC. 
%	stream_rate: the expected rate at which the input streams have been sped up (only for 'fifo' mode). 
%	---> WARNING: the value of stream_rate should agree with the speed rate of the input providers (named pipes).
%	sde_batch: the default number of time-points each Prolog rule for asserting input events contains for supported applications.
%	---> WARNING: only for input_mode=dynamic_predicates 
%	dynamic_grounding_flag
%	stream_order_flag
%	preprocessing_flag
%	forget_threshold
%	dynamic_grounding_threshold

% Example executions (the values of unspecified parameters default to the values declared in 'handleApplication.prolog'): 
% 	"toy" use case, window_size=20, step=20, end_time=40:
% 		"continuousQueries(toy, [window_size=20, step=20, end_time=40])." 
% 	"netbill" use case, input_mode=fifo, input_providers=['path/to/fifo'], stream_rate=2 
% 		"continuousQueries(netbill, [input_mode=fifo,input_providers=['path/to/fifo'], stream_rate=2]). 
% 	"caviar" use case, window_size=200, step=200, two input csv files:  
% 		"continuousQueries(caviar, [window_size=200, step=200, input_mode=csv, input_providers=['../examples/caviar/dataset/csv/appearance.csv','../examples/caviar/dataset/csv/movementB.csv']])." 
%	--> The "csv" input mode is the default in the current version of the code, but we provided it to the script in case that the default has changed.

% There is also a 1-arity definition for continuousQueries for running an application with its default parameters specified in 'handleApplication.prolog'.
% For example, "continuousQueries(toy)." runs the same query as "continuousQueries(toy,[]).".
% continuousQueries(+ApplicationName)
% 	Possible queries:
%   	continuousQueries(toy).
% 		continuousQueries(caviar).
% 		continuousQueries(maritime).
% 		continuousQueries(voting).
% 		continuousQueries(netbill).
% 		continuousQueries(ctm).

continuousQueries(App, ParamList) :-
	handleProlog(Prolog, StatisticsFlag), 
	handleApplication(App, Prolog, ParamList, PrologFiles, InputMode, InputPaths, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch, StreamRate, Goals),
	% PrologFiles includes at least two files: the compiled rules and the declarations of the application. 
	% All files included in PrologFiles are consulted through the following predicate.
	%consultInputFiles(+PrologFiles)
	consultInputFiles(PrologFiles),
	% The user may provide as input a list named 'Goals', which contains queries to be ran by this script before executing RTEC.
	%executeUserGoals(+Goals)
	executeUserGoals(Goals), % run queries requested by the user.
	printLogo,
	openFilesOrPipes(InputMode, InputPaths, InputStreams, PointerPositions, LogFile, LogFileStream, ResultsFile, ResultsFileStream),
	% initialise RTEC, i.e., assert the parameters provided in the predicate below, so that they are accessible by any predicate.
	% initialiseRecognition(+StreamOrderFlag, +DynamicGroundingFlag, +PreprocessingFlag, +ForgetThreshold, +DynamicGroundingThreshold, +ClockTick),	
	initialiseRecognition(StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick),
	QueryTime is StartReasoningTime + Step,
	% In case that the input is a live stream, sleep until the first query time, which is specified with the <Step> parameter.
	sleep_if_fifo(InputMode, Step, StreamRate, 0),
	% querying(+InputStreams, +PointerPositions, +StatisticsFlag, +LogFileStream, +WM, +Step, +QueryTime, +EndReasoningTime, +[], -RecTimes, +[], -InputList, +([],[],[]), (-OutputListOutFVpairs,-OutputListOutLI,-OutputListOutLD), +SDEBatch)
	querying(InputMode, InputStreams, PointerPositions, StatisticsFlag, LogFileStream, ResultsFileStream, WM, Step, QueryTime, StartReasoningTime, EndReasoningTime, [], RecTimes, [], InputList, ([],[],[]), OutputLists, SDEBatch, StreamRate),
	% calculate and record the recognition time statistics
	logWindowStats(LogFileStream, RecTimes, InputList, OutputLists),
	closeFiles(InputMode, InputStreams, LogFileStream, ResultsFileStream), !.

continuousQueries(App) :- !,
	continuousQueries(App, []).

% execution stops when the previous query time is greater or equal to the designated last reasoning time 
querying(_InputStreams, _InputPointerPositions, _StatisticsFlag, _LogFileStream, _ResultsFileStream, _WM, Step, QueryTime, _StartReasoningTime, EndReasoningTime, RecTimes, RecTimes, InputList, InputList, OutputList, OutputList, _SDEBatch) :-
	PrevQueryTime is QueryTime-Step,
 	PrevQueryTime >= EndReasoningTime, !.

querying(InputMode, InputStreams, PointerPositions, StatisticsFlag, LogFileStream, ResultsFileStream, WM, Step, QueryTime, StartReasoningTime, EndReasoningTime, InitRecTime, RecTimes, InitInput, InputList, (InitOutputOutFVpairs,InitOutputOutLI,InitOutputOutLD), OutputList, SDEBatch, StreamRate) :-
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
	printRecognitions(ResultsFileStream, QueryTime, WM),
	% log window execution time
 	S is S2-S1, %S=T2,
 	writeResult(S, LogFileStream),
	% print statistics about window execution: recognition time, input entities and output entities.
	printAfterER(S, WindowStartTime, VerifiedQueryTime, OELI, OELT, InL, OutFVpairs, OutLI, OutLD),
	(
		% if the designated last time-point of reasoning has not been passed
		QueryTime < EndReasoningTime,
		% (i) compute the next query-time
		NextQueryTime is QueryTime+Step, !,  %% This cut is necessary to prevent the local stack from exploding.
		% (ii) sleep until the next query time 
		% after each window, except the first and the last one, sleep for an amount of tie calculated as the step minus the time used for event recognition on the current window.
		sleep_if_fifo(InputMode, Step, StreamRate, S),
		querying(InputMode, InputStreams, NewPointerPositions, StatisticsFlag, LogFileStream, ResultsFileStream, WM, Step, NextQueryTime, StartReasoningTime, EndReasoningTime, [S|InitRecTime], RecTimes, [InL|InitInput], InputList, ([OutFVpairs|InitOutputOutFVpairs],[OutLI|InitOutputOutLI],[OutLD|InitOutputOutLD]), OutputList, SDEBatch, StreamRate)
	;
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

% openFilesOrPipes(+InputMode, +InputPaths, -InputStreams, -PointerPositions, +LogFile, -LogFileStream, +ResultsFile, -ResultFileStream)
openFilesOrPipes(InputMode, InputPaths, InputStreams, PointerPositions, LogFile, LogFileStream, ResultsFile, ResultsFileStream):-
	open(LogFile, write, LogFileStream),
	open(ResultsFile, write, ResultsFileStream),
	(	
		% the dataset arrives in live stream(s)
		InputMode = fifo,
		%InputStreams = [],
		initLoaderThreads(InputPaths, InputStreams) % InputStreams contains thread ids in this case.
		;
		% the dataset is in csv file(s)
		InputMode = csv,
		openInputCSVFiles(InputPaths, InputStreams, PointerPositions)
		;
		% the dataset is in the form of Prolog assertions
		InputMode = dynamic_predicates,
		InputStreams = [], 		
		consultInputFiles(InputPaths)
	).

% Create a new execution thread for each named pipe in InputPipes.
% Each thread executes the goal: loadIELiveStream(InputPipe), which is specified in 'src/data loader/dataLoader.prolog' 
% Its function is to assert the events written in the pipe as soon as they arrive.
% initLoaderThreads(+InputPipes) 
initLoaderThreads([], []).
initLoaderThreads([InputPipe|RestPipes], [ThreadID|RestIDs]):-
	thread_create(loadIELiveStream(InputPipe), ThreadID),
	initLoaderThreads(RestPipes, RestIDs).

% Open one input stream for each input file, while maintaining the reading position in the stream.
% openInputCSVFiles(+InputFiles, -InputStreams, -PointerPositions)
openInputCSVFiles([], [], []).
openInputCSVFiles([File|MoreFiles], [Stream|MoreStreams], [Position|MorePositions]) :-
	open(File, read, Stream),
	stream_property(Stream, position(Position)),
	openInputCSVFiles(MoreFiles, MoreStreams, MorePositions).

% the InputFiles are Prolog assertions expressing an input narrative
% consultInputFiles(+InputFiles)
consultInputFiles([]).
consultInputFiles([File|MoreFiles]) :-
	consult(File),
	consultInputFiles(MoreFiles).

% run selected goals before execution.
% this is used, e.g., for asserting the agents in the MAS use cases.
executeUserGoals([]).
executeUserGoals([Goal|RestGoals]) :-
	Goal,
	executeUserGoals(RestGoals).

% closeFiles(+datasetfilesstreams, +logfilestream, +resultsfilestream)
% first case: there are no input streams, 
% ie the dataset is in the form of Prolog assertions
closeFiles(dynamic_predicates, [], LogFileStream, ResultsFileStream) :-
	close(LogFileStream),
	close(ResultsFileStream).	

% second case: the dataset is in csv files;
% in this case close each input stream;
closeFiles(csv, InputStreams, LogFileStream, ResultsFileStream) :-
	close(LogFileStream),
	close(ResultsFileStream),	
	closeInputFiles(InputStreams).

% third case: fifo mode;
% the InputStreams variable contains thread IDs;
% destroy all threads
closeFiles(fifo, ThreadIDs, LogFileStream, ResultsFileStream) :-
	close(LogFileStream),
	close(ResultsFileStream),
	assertz(rtecTermination),
	killThreads(ThreadIDs),
	retract(rtecTermination).

% closeInputFiles(+InputStreams)	
closeInputFiles([]). 
closeInputFiles([InputStream|MoreInputStreams]) :-
	close(InputStream),
	closeInputFiles(MoreInputStreams).

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
% sleep_if_fifo_between_windows(+InputMode, +Step, +StreamRate, +S)	
sleep_if_fifo(InputMode, Step, StreamRate, S):-
	(
		InputMode = fifo, 
		SleepTime is Step/StreamRate - S/1000,
		sleep_until_query_time(SleepTime)
	; 	\+ InputMode = fifo
	).
	
sleep_until_query_time(SleepTimeSec):-
	statistics(walltime,[TBeforeSleep,_T1]),	
	write('About to sleep for '), write(SleepTimeSec), write(' seconds.'), nl,
	sleep(SleepTimeSec),
	statistics(walltime,[TAfterSleep,_T2]),
	TSleep is (TAfterSleep - TBeforeSleep)/1000,
	write('I slept for '), write(TSleep), write(' seconds.'), nl.

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

