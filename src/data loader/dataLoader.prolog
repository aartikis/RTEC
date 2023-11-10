/************************************************************************************************

****************************************DATA LOADER:*********************************************
Read CSV files of input datasets, convert the data to the RTEC predicates, 
and assert these predicates for RTEC to process.
*************************************************************************************************
********************************
Written by: Elias Alevizos
Maintained by: Alexander Artikis
********************************
*************************************************************************************************

Goal: Load input entities from CSV file(s) with arrival time in (StartPoint, EndPoint].

There is a distinction between input entity arrival time and occurrence time;
the former expresses the time at which the entity arrived at RTEC, while the latter
expresses the time at which the entity was detected by the sensor.
The arrival time is not translated to the Event Calculus predicates, 
but considered when deciding with input entities should be loaded.


Supported input entities: 
-events (instantaneous); translated to happensAtIE
-fluents with a given interval; translated to holdsForIESI
-fluents with a given time-point; translated to holdsAtIE


Event format: 
EventType(string)|ArrivalTime(int)|OccurenceTime(int)|Attribute1|...|AttributeN

Example: happensAtIE(stop_enter(75, bus, 008, early), 5) <->
	 stop_enter|5|5|75|bus|008|early

Fluent with interval format: 
FluentType(string)|ArrivalTime(int)|StartOccurenceTime(int)|EndOccurenceTime(int)|Value|Attribute1|...|AttributeN

Example: holdsForIESI(sharp_turn(75, bus)=very_sharp, (4, 7)) <->
	 sharp_turn|7|4|7|very_sharp|75|bus

Fluent with time-point format: 
FluentType(string)|ArrivalTime(int)|OccurenceTime(int)|Value|Attribute1|...|AttributeN

Example: holdsAtIE(coord(id0, 262, 285)=true, 680) <->
	 coord|680|680|true|id0|262|285
     

Notes: 
-For efficiency, we do NOT check that an entity in a CSV file has the same arguments 
 as those stated in the declarations of the event description.
-The error messages arising from errors in the CSV files are only displayed at the terminal,
 and are not logged in some file.

*************************************************************************************************/


% manualCSVReader includes predicates for processing CSV files
% that do NOT exist in YAP, but exist in SWI Prolog
:- ['manualCSVReader.prolog'].

% needsGrounding/3 is used for dynamic grounding. 
% points/1 may be defined in the declarations of an event description,
% and expresses that the instances of an input statically determined fluent 
% will be reported as time-points as opposed to intervals.
% These predicates are declared dynamic because SWI will complain
% when they are not defined. 
:- dynamic needsGrounding/3, points/1.

% dispatch_socket(+AcceptFd)
dispatch_socket(AcceptFd):-
    % Block until a client connects to the socket.
    tcp_accept(AcceptFd, Socket, _Peer),
    % Create a new thread that reads continuously the events sent by the client.
    thread_create(process_socket_client(Socket), _, [ detached(true) ]),
    % The current thread loops forever on dispatch_socket.
    % This is done because additional clients may attempt to connect to the socket.
    dispatch_socket(AcceptFd).

% process_socket_client(+Socket)
process_socket_client(Socket):-
    %setup_call_cleanup(:Setup,:Goal,:Cleanup)
    % Setup->Open socket and get the event stream coming from the client.
    % Goal->Read continuously the incoming rows of InStream until there is an end_of_file.
    % Cleanup->Close stream.
    setup_call_cleanup(
        (tcp_open_socket(Socket, StreamPair), stream_pair(StreamPair, InStream, _OutStream), set_input(InStream)),
        read_rows_until_empty(InStream),
        close(StreamPair)
    ).

% read_rows_until_empty(+InStream)
read_rows_until_empty(InStream):-
	% Read the first line of the stream,
	get_row_from_line(InStream, Row),
	(Row=[] ->  true % If Row is empty, i.e., end_of_file, return. 
	;
        getIEFromRowandAssertIt(Row), % assert event in Row.
        read_rows_until_empty(InStream) % end_of_file has not been found, so continue reading from InStream, i.e., loop back.
	).

% Opens a named pipe, and then reads continuously from the pipe and asserts all input events
% at the time that they are read, regardless of time-stamp 
% loadIELiveStream(+PipeName)
loadIELiveStream(PipeFileName):-
	open(PipeFileName, read, Stream, [eof_action(reset)]), % open the pipe for reading. 
	% eof_action(reset) -> when reaching the end_of_file character in the pipe, do not stop 
	%					   but continue reading eof until a new event appears.
	set_input(Stream), % $Stream is the current input stream.
	loadIERealTimeStreamLoop(Stream).

% loadIERealTimeStreamLoop(+Stream, +StreamPosition)
% process a stream arriving in real time... 
loadIERealTimeStreamLoop(Stream) :-
	get_row_from_line(Stream, Row),
	(Row=[] ->  true % If Row is empty, i.e., end_of_file, continue. 
		;
        %write(Row), nl,	   
        getIEFromRowandAssertIt(Row)), % assert event in Row.
	loadIERealTimeStreamLoop(Stream). % continue reading from the pipe. This is an infinite loop.

% loadIEStreams(+InputStreams, +StartPoint, +EndPoint, +InputStreamPositions, -NewInputStreamPositions)
% load SDEs in the range of (StartPoint, EndPoint]

loadIEStreams([_Stream], _StartPoint, _EndPoint, [end_of_file], [end_of_file]) :- !.

loadIEStreams([Stream], StartPoint, EndPoint, [StreamPosition], [NewStreamPosition]) :- 
	!, 
	% set Stream as input
	set_input(Stream),
	loadSingleIEStream(Stream, StartPoint, EndPoint, StreamPosition, NewStreamPosition).

loadIEStreams([_Stream|Streams], StartPoint, EndPoint, [end_of_file|SPs], [end_of_file|NSPs]) :-
	!, loadIEStreams(Streams, StartPoint, EndPoint, SPs, NSPs).

loadIEStreams([Stream|Streams], StartPoint, EndPoint, [StreamPosition|SPs], [NewStreamPosition|NSPs]) :-
	% set Stream as input
	set_input(Stream),
	loadSingleIEStream(Stream, StartPoint, EndPoint, StreamPosition, NewStreamPosition),
	loadIEStreams(Streams, StartPoint, EndPoint, SPs, NSPs).
		

% loadSingleIEStream(+Stream, +StartPoint, +EndPoint, +StreamPosition, -NewStreamPosition)
% process an individual input stream 
loadSingleIEStream(Stream, StartPoint, EndPoint, StreamPosition, NewStreamPosition) :-
	% the predicate below does not exist in yap
	% csv_read_file_row(Stream,Row,[line(Line),separator(0'|)]),
	% so, use manualCSVReader instead
	% creates a row from a line of the input stream
	% get_row_from_line(+Stream, -Row, +StreamPosition, -NextStreamPosition),
	get_row_from_line(Stream, Row, StreamPosition, NextStreamPosition),
	% arg(+ArgumentNumber, +Row, -IEArrivalTime)
	% IEArrivalTime becomes the second argument of Row
	% IEArrivalTime expresses the arrival time of the input entity of Row
	getRowArgument(2, Row, IEArrivalTime),
	% processRow(+Row, +StartPoint, +EndPoint, +IEArrivalTime, -ProcessingOutcome),
	processRow(Row, StartPoint, EndPoint, IEArrivalTime, ProcessingOutcome),
	(
		ProcessingOutcome = passed_endpoint, !,
		% the StreamPosition does not change
		NewStreamPosition = StreamPosition
		;
		ProcessingOutcome = end_of_file, !, 
		NewStreamPosition = end_of_file
		;
		% ProcessingOutcome = keep_processing
		loadSingleIEStream(Stream, StartPoint, EndPoint, NextStreamPosition, NewStreamPosition)
	).


% processRow(+Row, +StartPoint, +EndPoint, +IEArrivalTime, -ProcessingOutcome)

% first case: end of file has been reached
processRow([], _StartPoint, _EndPoint, _IEArrivalTime, end_of_file) :- !.

% second case: StartPoint has not been reached	
processRow(_Row, StartPoint, _EndPoint, IEArrivalTime, keep_processing) :-
	StartPoint >= IEArrivalTime, !.
	
% third case: process rows until reaching the EndPoint	
processRow(Row, StartPoint, EndPoint, IEArrivalTime, Outcome) :-
	StartPoint < IEArrivalTime,
	(
		% we have not reached the EndPoint
		EndPoint >= IEArrivalTime, !, 
		Outcome = keep_processing,
		% getIEFromRowandAssertIt(+Row),
		% distill the input entity of Row and assert it in the RTEC format
		getIEFromRowandAssertIt(Row)
		;
		% we have passed the EndPoint
		Outcome = passed_endpoint
	).
	

% getIEFromRowandAssertIt(+Row)
% distill the input entity from Row and assert in the RTEC format
getIEFromRowandAssertIt(Row) :-
	% IElabel becomes the first argument of Row
	getRowArgument(1, Row, IElabel),
	(
		% check whether the given input entity is an event
		event(E), E=..[IElabel|_], inputEntity(E), !, 
		% assertEvent(+Row),
		% distill from Row the event instance and assert it 
		assertEvent(Row)
		;
		% check whether the given input entity is a statically determined fluent	
		inputEntity(F=V), F=..[IElabel|_], sDFluent(F=V), !,
		% assertFluent(+Row)	
		% distill from Row the fluent instance and assert it 
		assertFluent(Row)
	),
	% checkGrounding(+IElabel, +Row) deals with dynamic grounding
	checkGrounding(IElabel, Row).

% Row contains neither an input event 
% not an input statically determined fluent 
getIEFromRowandAssertIt(Row) :-
	write('ERROR IN INPUT CSV; LINE: '), writeln(Row).


% getRowArgument(+N, +Row, -Arg)
% return the Nth argument of row
% the built-in arg/3 raises exception in case of
% empty row, and thus we had to address this
getRowArgument(_N, [], []) :- !.
getRowArgument(N, Row, Arg) :- 	
	arg(N, Row, Arg).
	

% assertEvent(+Row)
% distill from Row the event instance and assert it in the RTEC format 	
assertEvent(Row) :-
	% get rid of row atom and Arrival time 
	Row =.. [_RowAtom|[EventLabel|[_ArrivalTime|[OccurenceTime|EventAttributes]]]],
	Event =.. [EventLabel|EventAttributes],
	assertz( happensAtIE(Event, OccurenceTime) ), !.

% the event arrival time or occurrence time is missing
assertEvent(Row) :-
	write('ERROR IN INPUT CSV; LINE: '), writeln(Row).


% assertFluent(+Row)	
% distill from Row the instantaneous instance of Fluent=Value and assert it in the RTEC format 
assertFluent(Row) :-
	% get rid of row atom and arrival time 
	Row =.. [_RowAtom|[FluentLabel|[_ArrivalTime|[OccurenceTime|[Value|FluentAttributes]]]]],
	Fluent =.. [FluentLabel|FluentAttributes],
	% check that the fluent should be represented by means of holdsAtIE
	% points/1 is defined in the declarations of an event description
	% points(Fluent=Value), !,
	points(Fluent=Value), !,
	assertz( holdsAtIE(Fluent=Value, OccurenceTime) ).
	
% distill from Row the durative instance of Fluent=Value and assert it in the RTEC format 
assertFluent(Row) :-
	% get rid of row atom and arrival time 
	Row =.. [_RowAtom|[FluentLabel|[_ArrivalTime|[StartOccurenceTime|[EndOccurenceTime|[Value|FluentAttributes]]]]]],
	Fluent =.. [FluentLabel|FluentAttributes],
	assertz( holdsForIESI(Fluent=Value, (StartOccurenceTime,EndOccurenceTime)) ), !.

% the fluent in the CSV file is not consistent with the declarations of the event description
% Note: we do not check the attributes of the fluent
assertFluent(Row) :-
	write('ERROR IN INPUT CSV; LINE: '), writeln(Row).


% this predicate deals with dynamic grounding
% checkGrounding(+IEType, +Row)
checkGrounding(IEType, Row) :-
	(
		findGroundings(IEType, Row)
		;
		true
	).

% this predicate deals with dynamic grounding, ie
% writes explicitly a domain-dependent predicate declaring the index for dynamic grounding
% this works under the assumption that the declaration files include a predicate of the form 
% needsGrounding(EventType, Index, ToGround) stating the Index of EventType and writing as ToGround	
% findGroundings(+IEType, +Row)
findGroundings(IEType, Row) :-
	needsGrounding(IEType, Index, ToGround),
	Row =.. [_H|T],
	nth0(Index, T, Value),
	GroundFact =.. [ToGround | [Value]],
	\+ clause(GroundFact, _Body),
	assertz(GroundFact),
	fail.
	
