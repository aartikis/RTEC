
% ========================
/*
EVENT RECOGNITION LOOP

--- initialiseRecognition(+InputFlag, +PreProcessingFlag, +TemporalDistance). 
InputFlag=ordered means that input facts are temporally sorted. 
InputFlag=any_other_value means that input facts are not temporally sorted. 
PreProcessingFlag=preprocessing means that there is a need for preprocessing by means of an application-dependent preProcessing/1. See the experiments on the CAVIAR dataset for an example of preprocessing.
PreProcessingFlag=any_other_value means that there is no need for preprocessing.
TemporalDistance is an integer denoting the distance between two consecutive time-points. Eg, in CAVIAR the temporal distance is 40.  

Assert input facts at your leisure, even in a non-chronological manner. Then perform event recognition:
--- eventRecognition(+Qi, +WM).
where Qi is the current query time, and WM is the 'working memory'.

A NOTE ON THE LISTS THAT ARE USED IN THE CODE

-simpleFPList/sdFPList(Index, F=V, RestrictedList, Extension) where RestrictedList is the list of periods of the simple (statically determined) fluent within (Qi-WM, Qi] and Extension is the period before Qi-WM. Extension must be amalgamated with RestrictedList in order to produce the correct result of event recognition at Qi. F=V is an output entity.
-iePList(Index, F=V, RestrictedList, Extension) like above, except that F=V is an input entity.
-evTList: the time-points of output entity/event within (Qi-WM, Qi].

---RTEC PREDICATES---

The predicates below are available to the user:

-happensAt(E, T) represents the time-points T in which an event E occurs.
-happensAt(start(F=V), T) represents a special event which takes place at the starting points of the maximal intervals of F=V. Similarly for happensAt(end(F=V), T). 
-initially(F=V) expresses that F=V at time 0.
-initiatedAt(F=V, _, T, _) states that at time T a period of time for which F=V is initiated. 
-terminatedAt(F=V, _, T, _) states that at time T a period of time for which F=V is terminated. 
-holdsFor(F=V, L) represents that the list of maximal intervals L during which F=V holds continuously.
-holdsAt(F=V, T) states that F=V holds at time-point T. 

The predicates above are compiled into the following:

-happensAtIE(E, T) represents the time-points T in which an input entity/event E occurs.
-happensAtProcessedIE(start(U), T) represents the time-points in which a special event 'start' occurs. The special event takes place at the starting points of the input entity/statically determined fluent U. The intervals of U are cached.  Similarly for happensAtProcessedIE(end(U), T).
-happensAtProcessedSimpleFluent(start(U), T) represents the time-points in which a special event 'start' occurs. The special event takes place at the starting points of the simple fluent U. The intervals of U are cached. Similarly for happensAtProcessedSimpleFluent(end(U), T).
-happensAtProcessedSDFluent(start(U), T) represents the time-points in which a special event 'start' occurs. The special event takes place at the starting points of the output entity/statically determined fluent U. The intervals of U are cached. Similarly for happensAtProcessedSDFluent(end(U), T).
-happensAtProcessed(E, T) represents the cached time-points T in which an output entity/event E occurs. E is not a start() or end() event.
-happensAtEv(E, T) represents the definition of an output entity/event.
-happensAt(E, T) is used for user interaction.

-holdsForIESI(U, I) represents an interval I in which an input entity/statically determined fluent U occurs. Note that the second argument of this predicate is a single interval, as opposed to a list of intervals; underlying sensor data processing systems report single intervals as opposed to lists of intervals.
-holdsForProcessedIE(Index, IE, L) retrieves the cached list of intervals of an input entity/statically determined fluent.
-holdsForProcessedSimpleFluent(Index, F=V, L) retrieves the cached list of intervals of a simple fluent.
-holdsForProcessedSDFluent(Index, F=V, L) retrieves the cached list of intervals of an output entity/statically determined fluent.
-holdsForSDFluent(F=V, L) represents the definition of a durative output entity/statically determined fluent.
-holdsFor(F=V, L) is used for user interaction.

-holdsAtProcessedIE(Index, F=V, T) checks whether a processed input entity/statically determined fluent holds at a given time-point.
-holdsAtProcessedSDFluent(Index, F=V, T) checks whether a cached output entity/statically determined fluent holds at a given time-point.
-holdsAtProcessedSimpleFluent(Index, F=V, T) checks whether a cached simple fluent holds at a given time-point.
-holdsAtSDFluent(Index, F=V, T) checks whether a statically determined fluent holds at a given time-point. This predicate is used when the intervals F=V are not cached.
-holdsAt(F=V, T) is used for user interaction.

NOTE: statically determined fluents are defined only in terms of interval manipulation constructs, ie they are not defined by means of holdsAt.
NOTE: The second argument in holdsAtX query should be ground.

DECLARATIONS:

-event(E) states that E is an event.
-simpleFluent(F=V) states that F=V is a simple fluent.
-sDFluent(F=V) states that F=V is a statically determined fluent.

-inputEntity(U) represents the input entities (events and/or statically determined fluents).
-outputEntity(U) represents the composite entities (events, simple fluents and/or statically determined fluents).

-collectIntervals(F=V) states that the list of intervals of input entity/statically determined fluent F=V will be produced by the RTEC input module by collecting the reported individual intervals
-buildIntervals(F=V) states that the list of intervals of input entity/statically determined fluent F=V will be produced by the RTEC input module by gathering the reported time-points
 
-temporalDistance(TD) denotes the temporal distance between consecutive time-points. In some applications, such as video surveillance, there is a fixed temporal distance between time-points (video frames). In other applications this is not the case and therefore temporalDistance/1 should be undefined.

-cachingOrder(Index, U) denotes the order of entity (event or fluent) processing. The first argument is the index of the entity.
*/

% ========================

:- set_prolog_flag(toplevel_print_options, [max_depth(400)]).
:- use_module(library(lists)).

loadSocketLibrary(socket):-
    use_module(library(socket)), !.

loadSocketLibrary(_).

%:- ['compiler.prolog']. %% After adding indexOf in compiler, some unit tests fail... so comment it for now...
:- ['inputModule.prolog'].
:- ['processSimpleFluents.prolog'].
:- ['processSDFluents.prolog'].
:- ['processEvents.prolog'].
:- ['utilities/interval-manipulation.prolog'].
:- ['utilities/amalgamate-periods.prolog'].
% Load the dynamic grounding module
:- ['dynamic grounding/dynamicGrounding.prolog'].
% Load module for handling deadlines
:- ['timeoutTreatment.prolog'].

/***** dynamic predicates *****/

% The predicates below are asserted/retracted
:- dynamic temporalDistance/1, input/1, noDynamicGrounding/0, preProcessing/1, initTime/1, queryTime/1, iePList/4, simpleFPList/4, sdFPList/4, evTList/3, happensAtIE/2, holdsForIESI/2, holdsAtIE/2, processedCyclic/2, initiallyCyclic/1, storedCyclicPoints/3, startingPoints/3.

% The predicates below may or may not appear in the event description of an application;
% thus they must be declared dynamic
:- dynamic collectIntervals2/2, buildFromPoints2/2, cyclic/1, fi/3, p/1, internalEntity/1, sDFluent/1,	simpleFluent/1, inputEntity/1, collectGrounds/2, dgrounded/2.

/***** multifile predicates *****/

:- multifile 
% holdsFor/2 and happensAt/2 are defined in this file and may also be defined in an event description
holdsFor/2, happensAt/2,
% these predicates may appear in the data files of an application
updateSDE/2, updateSDE/3, updateSDE/4,
% these predicates are used in processSimpleFluent.prolog
initially/1, initiatedAt/4, terminatedAt/4.

/***** discontiguous predicates *****/

:- discontiguous
% these predicates are defined in this file 
happensAtProcessedIE/3, happensAtProcessedSDFluent/3, happensAtProcessedSimpleFluent/3, deadlines1/3,
% these predicates may be part of the declarations of an event description 
inputEntity/1, internalEntity/1, outputEntity/1, index/2, event/1, simpleFluent/1, sDFluent/1, grounding/1, dgrounded/2,
% these predicates may be part of an event description 
holdsFor/2, holdsForSDFluent/2, initially/1, initiatedAt/2, terminatedAt/2, initiates/3, terminates/3, initiatedAt/4, terminatedAt/4, happensAt/2, fi/3, p/1,
% this predicate may appear in the data files of an application
updateSDE/4. 

/********************************** INITIALISE RECOGNITION ***********************************/



initialiseRecognition(InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance) :-
	assertz(temporalDistance(TemporalDistance)), 
	% Assert threshold for forget and dynamic grounding mechanisms here 
	% to avoid carrying these values forever 
	assertz(eventsPerTimepointThreshold(-1)), 
	assertz(groundTermOverlapThreshold(-1)), %
	(InputFlag=ordered, assertz(input(InputFlag)) ; assertz(input(unordered))),
	% if we need dynamic grounding then dynamicGrounding/1 is already defined
	% so there is no need to assert anything here
	(DynamicGroundingFlag=dynamicgrounding ; assertz(noDynamicGrounding)),	
	% if we need preprocessing then preProcessing/1 is already defined
	% so there is no need to assert anything here
	(PreProcessingFlag=preprocessing ; assertz(preProcessing(_))), !.


initialiseRecognition(InputFlag, DynamicGroundingFlag, PreProcessingFlag, ForgetThreshold, DynamicGroundingThreshold, TemporalDistance) :-
	assertz(temporalDistance(TemporalDistance)), 
	% Assert threshold for forget and dynamic grounding mechanisms here 
	% to avoid carrying these values forever 
	assertz(eventsPerTimepointThreshold(ForgetThreshold)), 
	assertz(groundTermOverlapThreshold(DynamicGroundingThreshold)), %
	(InputFlag=ordered, assertz(input(InputFlag)) ; assertz(input(unordered))),
	% if we need dynamic grounding then dynamicGrounding/1 is already defined
	% so there is no need to assert anything here
	(DynamicGroundingFlag=dynamicgrounding ; assertz(noDynamicGrounding)),	
	% if we need preprocessing then preProcessing/1 is already defined
	% so there is no need to assert anything here
	(PreProcessingFlag=preprocessing ; assertz(preProcessing(_))), !.


/************************************* EVENT RECOGNITION *************************************/


eventRecognition(QueryTime, WM) :-
	InitTime is QueryTime-WM,
	assertz(initTime(InitTime)),
	assertz(queryTime(QueryTime)),
    % delete input entities that have taken place before or on Qi-WM
	forget(InitTime),
	% calculate the items for which we will perform reasoning
	dynamicGrounding(InitTime, QueryTime),
	% compute the intervals of input entities/statically determined fluents
	inputProcessing(InitTime, QueryTime),
	preProcessing(QueryTime),
	% CYCLES #1 CHANGE
	prepareCyclic,
	% CYCLES & DEADLINES CHANGE
	findall((Index,F=V,SPoints), (startingPoints(Index,F=V,SPoints),retract(startingPoints(Index,F=V,SPoints))), _),
	% DEADLINES #1 CHANGE
	findall((F=V,Duration), (fi(F=V,_,Duration), deadlines1(F=V,Duration,InitTime)), _),
	% the order in which entities are processed makes a difference
	% start from lower-level entities and then move to higher-level entities
	% in this way the higher-level entities will use the CACHED lower-level entities
	% the order in which we process entities is set by cachingOrder/1 
	% which is specified in the domain-dependent file 
	% cachingOrder2/2 is produced in the compilation stage 
	% by combining cachingOrder/1, indexOf/2 and grounding/1
	findall(OE, (cachingOrder2(Index,OE), processEntity(Index,OE,InitTime,QueryTime)), _),
	% DEADLINES #2 CHANGE
	findall((F=V,Duration), (fi(F=V,_,Duration), deadlines2(F=V,Duration,InitTime)), _),
	retract(queryTime(QueryTime)),
	retract(initTime(InitTime)).

processEntity(Index, OE, InitTime, QueryTime) :-
	(
		% compute the intervals of output entities/statically determined fluents
		sDFluent(OE), 
		processSDFluent(Index, OE, InitTime) 
		;
		% compute the intervals of simple fluents 
		% (simple fluents are by definition output entities) 
		simpleFluent(OE), 
		processSimpleFluent(Index, OE, InitTime, QueryTime),
		% CYCLES #2 CHANGE (no need to assert if not cyclic)
		assertCyclic(Index, OE)
		;
		% compute the time-points of output entities/events
		event(OE), 
		processEvent(Index, OE)
	), !.


/******************* deadlines treatment *********************/

% Process deadline attempts computed at the previous query time

% the rule below deals with fluents whose expiration may be extended
% ie fi and p
% keep the happensAt(attempt(F=V),T) computed at the previous query time
% iff (a) holdsAt(F=V,nextTimePoint(Qi-WM)), (b) T>Qi-WM, and (c) T-Duration=<Qi-WM
deadlines1(F=V, Duration, InitTime) :-
	p(F=V), !,
	indexOf(Index, F=V), 
	retract( evTList(Index, attempt(F=V), ListofDeadlineAttempts) ),
	% (a) holdsAt(F=V,nextTimePoint(Qi-WM))
	simpleFPList(Index, F=V, I1, I2),
	amalgamatePeriods(I2, I1, I),
	nextTimePoint(InitTime, NextInitTime),
	tinIntervals(NextInitTime, I),
	% find the deadline attempt that satisfies conditions (b) and (c) mentioned above
	% this predicate is defined below
	findDeadlineAttempt(ListofDeadlineAttempts, Attempt, InitTime, Duration), 
	assertz( evTList(Index, attempt(F=V), Attempt) ).
	
% === find the deadline attempt that satisfies conditions (b) and (c) mentioned above	 ===
findDeadlineAttempt([], [], _, _) :- !.	

findDeadlineAttempt([Attempt], [Attempt], InitTime, Duration) :-
	% (b) the deadline attempt time is after Qi-WM
	Attempt>InitTime,
	% (c) the initiating conditions of the deadline attempt
	% are before or on Qi-WM	
	EarlyT is Attempt-Duration, EarlyT=<InitTime, !.

findDeadlineAttempt([_], [], _, _) :- !.	
	
findDeadlineAttempt([A1,A2|_Tail], [A1], InitTime, Duration) :-
	% (b) the deadline attempt time is after Qi-WM
	A1>InitTime,
	% (c) the initiating conditions of the deadline attempt
	% are before or on Qi-WM	
	EarlyT1 is A1-Duration, EarlyT1=<InitTime,
	EarlyT2 is A2-Duration, EarlyT2>InitTime, !.
	
findDeadlineAttempt([_A1,A2|Tail], Attempt, InitTime, Duration) :-
	findDeadlineAttempt([A2|Tail], Attempt, InitTime, Duration).
% === find the deadline attempt that satisfies conditions (b) and (c) mentioned above	 ===


% the rule below deals with fluents whose expiration may NOT be extended
% keep the happensAt(attempt(F=V),T) computed at the previous query time
% iff (a) holdsAt(F=V,nextTimePoint(Qi-WM)), (b) T>Qi-WM, (c) T-Duration=<Qi-WM and
% (d) T-Duration=S where S is the start of the interval starting 
% before or on Qi-WM and ending after for which F=V 
deadlines1(F=V, Duration, InitTime) :-
	indexOf(Index, F=V),
	retract( evTList(Index, attempt(F=V), ListofDeadlineAttempts) ),	
	% (a) holdsAt(F=V,nextTimePoint(Qi-WM))
	simpleFPList(Index, F=V, I1, I2),
	amalgamatePeriods(I2, I1, I),
	nextTimePoint(InitTime, NextInitTime),
	% we do not use tinIntervals as above because we also want S  
	member((S,E),I), gt(E,NextInitTime), !, S=<NextInitTime,
	member(Attempt, ListofDeadlineAttempts),
	% (b) the deadline attempt time is after Qi-WM
	Attempt>InitTime,
	EarlyT is Attempt-Duration, 
	% (c) the initiating conditions of the deadline attempt
	% are before or on Qi-WM	
	EarlyT=<InitTime,
	% (d) Attempt-Duration=S where S is the start of the interval  
	% starting before or on Qi-WM and ending after for which F=V 
	prevTimePoint(S,PrevS), EarlyT=PrevS, 
	% ListofDeadlineAttempts is sorted
	!,
	assertz( evTList(Index, attempt(F=V), [Attempt]) ).

% deadlines2/1 computes and stores the deadline attempts

% the two rules below deal with fluents whose expiration may be extended

% the rule below deals with the case where there are
% dealine attempts from the previous query time
deadlines2(F=V, Duration, InitTime) :-
	p(F=V),
	indexOf(Index, F=V),
	retract( evTList(Index, attempt(F=V), List) ), !,
	startingPoints(Index, F=V, SPoints),
	findall(T, 
		(member(S,SPoints), prevTimePoint(S,PrevS), PrevS>InitTime, T is PrevS+Duration), 
	NewList),
	append(List, NewList, AppendedList),
	% the predicate below is defined in processEvents.prolog
	updateevTList(Index, attempt(F=V), AppendedList).
% the rule below deals with the case where there are NO
% dealine attempts from the previous query time
deadlines2(F=V, Duration, InitTime) :-
	p(F=V), !,
	indexOf(Index, F=V),
	startingPoints(Index, F=V, SPoints),
	findall(T, 
		(member(S,SPoints), prevTimePoint(S,PrevS), PrevS>InitTime, T is PrevS+Duration), 
	NewList),
	% the predicate below is defined in processEvents.prolog
	updateevTList(Index, attempt(F=V), NewList).

% the two rules below deal with fluents whose expiration may NOT be extended

% the rule below deals with the case where there are
% dealine attempts from the previous query time
deadlines2(F=V, Duration, InitTime) :-
	indexOf(Index, F=V),
	retract( evTList(Index, attempt(F=V), List) ), !,
	simpleFPList(Index, F=V, I1, I2),
	amalgamatePeriods(I2, I1, I),
	findall(T, 
		(member((S,_),I), prevTimePoint(S,PrevS), PrevS>InitTime, T is PrevS+Duration), 
	NewList),
	append(List, NewList, AppendedList),
	% the predicate below is defined in processEvents.prolog
	updateevTList(Index, attempt(F=V), AppendedList).
% the rule below deals with the case where there are NO
% dealine attempts from the previous query time
deadlines2(F=V, Duration, InitTime) :-
	indexOf(Index, F=V),
	simpleFPList(Index, F=V, I1, I2),
	amalgamatePeriods(I2, I1, I),
	findall(T, 
		(member((S,_),I), prevTimePoint(S,PrevS), PrevS>InitTime, T is PrevS+Duration), 
	NewList), !,
	% the predicate below is defined in processEvents.prolog
	updateevTList(Index, attempt(F=V), NewList).


/******************* cycles treatment *********************/

prepareCyclic :-
	% check if there are cycles in the event description
	cyclic(_), !,
	findall((Index,F=V,L), (storedCyclicPoints(Index,F=V,L), retract(storedCyclicPoints(Index,F=V,L))), _),
	findall((Index,F=V), (processedCyclic(Index,F=V), retract(processedCyclic(Index,F=V))), _),
	findall(F=V, (initiallyCyclic(F=V), retract(initiallyCyclic(F=V))), _),
	assertInitiallyCyclic.
prepareCyclic.

assertInitiallyCyclic :-
	initTime(InitTime),
	InitTime>0, !, 
	nextTimePoint(InitTime, NextInitTime),
	findall(F=V, 
	  (
	    cyclic(F=V),
	    indexOf(Index, F=V),
	    simpleFPList(Index, F=V, I1, I2),
	    amalgamatePeriods(I2, I1, I),
	    tinIntervals(NextInitTime, I),
	    assertz(initiallyCyclic(F=V))), 
	  _).
assertInitiallyCyclic :-
	 % InitTime=<0
	 findall(F=V, 
	  (
	    cyclic(F=V),
	    grounding(F=V),
	    %initially(F=V),
	    initiatedAt(F=V, -1, -1, 0),
	    assertz(initiallyCyclic(F=V))), 
	  _).
	  
assertCyclic(Index, F=V) :- 
	  cyclic(F=V), !,
	  assertz(processedCyclic(Index, F=V)).
assertCyclic(_, _).

% T is ground when evaluating holdsAt
% if the intervals of the cyclic fluent have been already computed then look no further
holdsAtCyclic(Index, F=V, T) :-
	processedCyclic(Index, F=V), !,
	holdsAtProcessedSimpleFluent(Index, F=V, T).
% check whether we already know whether holdsAt(F=V, T)
holdsAtCyclic(Index, F=V, T) :-
	% storedSFPoints stores some, but not necessarily all points of a cyclic fluent
	% therefore, the cut in this rule has to go the end 
	storedCyclicPoints(Index, F=V, StoredPoints), 
	lastPointBeforeOrOnT(T, StoredPoints, (Point,Val)), !, 
	findFluentVal(Index, F=V, T, (Point,Val)).
% the rule below are classic EC simple fluent computation
holdsAtCyclic(Index, F=V, T) :-
	initTime(InitTime), 
	initPointBetween(Index, F=V, InitTime, InitPoint, T),
	nextTimePoint(InitPoint, NextPoint),
	notBrokenOrReInitiated(Index, F=V, NextPoint, T), 
	% since we computed a time-point for the cyclic fluent we store it 
	% in order to avoid recomputing it in the future
	addCyclicPoint(Index, F=V, T, t), !.
% store that we failed to prove holdsAt(F=V, T)
holdsAtCyclic(Index, F=V, T) :-
	addCyclicPoint(Index, F=V, T, f), !, false.
	
	
lastPointBeforeOrOnT(T, [(X,Val)], (X,Val)) :- !, X=<T.	
lastPointBeforeOrOnT(T, [(X1,Val1),(X2,_)|_], (X1,Val1)) :- X1=<T, X2>T, !.	
lastPointBeforeOrOnT(T, [(X,_)|Rest0], R) :-
	X<T, lastPointBeforeOrOnT(T, Rest0, R).		
	
findFluentVal(_Index, _U, T, (T,Val)) :- !, Val=t.
findFluentVal(Index, F=V, T, (Point,t)) :-
	notBrokenOrReInitiated(Index, F=V, Point, T), !,
	addCyclicPoint(Index, F=V, T, t).
findFluentVal(Index, F=V, T, (_Point,t)) :-
	addCyclicPoint(Index, F=V, T, f), !, false.
findFluentVal(Index, F=V, T, (Point,f)) :-
	startedBetween(Index, F=V, Point, InitPoint, T),
	nextTimePoint(InitPoint, NextPoint),
	notBrokenOrReInitiated(Index, F=V, NextPoint, T), !,
	addCyclicPoint(Index, F=V, T, t).
findFluentVal(Index, F=V, T, (_Point,f)) :-
	addCyclicPoint(Index, F=V, T, f), !, false.
	
% we are looking in the interval [Ts,Te)
notBrokenOrReInitiated(_, _, Ts, Te) :- Ts>=Te, !.
notBrokenOrReInitiated(Index, F=V, Ts, Te) :-
	brokenOnce(Index, F=V, Ts, T, Te), !,	
	nextTimePoint(T, NextT),
	startedBetween(Index, F=V, NextT, Init, Te),
	notBrokenOrReInitiated(Index, F=V, Init, Te).
notBrokenOrReInitiated(_, _, _, _).	

% we are looking in the interval [Ts,Te)
brokenOnce(Index, F=V1, Ts, T, Te) :-
	simpleFluent(F=V2), \+V2=V1, %grounding(F=V2), \+V2=V1,
	startedBetween(Index, F=V2, Ts, T, Te), !.
brokenOnce(_Index, F=V, Ts, T, Te) :-
	terminatedAt(F=V, Ts, T, Te), !.

% we are looking in the interval [Ts,Te)
startedBetween(_, _, Ts, _, Te) :- Ts>=Te, !, false.
startedBetween(Index, F=V, Ts, T, Te) :-
	startingPoints(Index, F=V, SPoints),
	member(SPoint, SPoints), 
	prevTimePoint(SPoint, T), 
	Ts=<T, !, T<Te.	
startedBetween(Index, F=V, Ts, T, Te) :-
	initiatedAt(F=V, Ts, T, Te), !,
	addStartingPoint(Index, F=V, T).

% we are looking in the interval [Ts,Te)
initPointBetween(Index, F=V, Ts, T, Te) :-
	startingPoints(Index, F=V, SPoints), 
	member(SPoint, SPoints), 
	prevTimePoint(SPoint, T), 
	Ts=<T, !, T<Te.	
initPointBetween(_Index, F=V, Ts, Ts, Te) :- 
	Ts<Te, initiallyCyclic(F=V), !.		
initPointBetween(Index, F=V, Ts, T, Te) :-
	nextTimePoint(Ts, NextTs),
	initiatedAt(F=V, NextTs, T, Te), !,
	addStartingPoint(Index, F=V, T).

	
addStartingPoint(Index, F=V, InitPoint) :-
	retract(startingPoints(Index, F=V, SPoints)), !,
	nextTimePoint(InitPoint, SPoint),
	insertNo(SPoint, SPoints, NewSPoints),
	assertz(startingPoints(Index, F=V, NewSPoints)).
addStartingPoint(Index, F=V, InitPoint) :-
	nextTimePoint(InitPoint, SPoint),
	assertz(startingPoints(Index, F=V, [SPoint])).
	
addCyclicPoint(Index, F=V, T, Val) :-
	retract(storedCyclicPoints(Index, F=V, OldCPoints)), !, 
	insertTuple((T,Val), OldCPoints, NewCPoints),
	assertz(storedCyclicPoints(Index, F=V, NewCPoints)).
addCyclicPoint(Index, F=V, T, Val) :-
	assertz(storedCyclicPoints(Index, F=V, [(T,Val)])).	

insertNo(X, [], [X]).
insertNo(X, [X|Rest], [X|Rest]) :- !.
insertNo(X, [Y|Rest], [X,Y|Rest]) :- X<Y, !.
insertNo(X, [Y|Rest0], [Y|Rest]) :- 
	insertNo(X, Rest0, Rest).		
	
insertTuple(X, [], [X]) :- !.
insertTuple((X,Val), [(X,Val)|Rest], [(X,Val)|Rest]) :- !.
insertTuple((X,Val), [(Y,Val2)|Rest], [(X,Val),(Y,Val2)|Rest]) :- X<Y, !.
insertTuple(X, [Y|Rest0], [Y|Rest]) :-
	insertTuple(X, Rest0, Rest).
	
/******************* entity index: use of cut to avoid backtracking *********************/

indexOf(Index, E) :-
	index(E, Index), !.

/******************* APPLICATION-INDEPENDENT holdsFor, holdsAt AND happensAt (INCARNATIONS) *********************/


%%%%%%% holdsFor as used in the body of entity definitions

% processed input entity/statically determined fluent
holdsForProcessedIE(Index, IE, L) :- 
  	iePList(Index, IE, L, _), !.

holdsForProcessedIE(_Index, _IE, []).

% cached simple fluent
holdsForProcessedSimpleFluent(Index, F=V, L) :-	
	simpleFPList(Index, F=V, L, _), !.

holdsForProcessedSimpleFluent(_Index, _U, []).

% cached output entity/statically determined fluent
holdsForProcessedSDFluent(Index, F=V, L) :- 
  	sdFPList(Index, F=V, L, _), !.

holdsForProcessedSDFluent(_Index, _U, []).


%%%%%%% holdsAt as used in the body of entity definitions

% T should be given in all 4 predicates below

% processed input entity/statically determined fluent
holdsAtProcessedIE(Index, F=V, T) :- 
  	iePList(Index, F=V, [H|Tail], _),
	tinIntervals(T, [H|Tail]).

% cached simple fluent
holdsAtProcessedSimpleFluent(Index, F=V, T) :-	
	simpleFPList(Index, F=V, [H|Tail], _),
	tinIntervals(T, [H|Tail]).

% cached output entity/statically determined fluent
holdsAtProcessedSDFluent(Index, F=V, T) :- 
  	sdFPList(Index, F=V, [H|Tail], _),
	tinIntervals(T, [H|Tail]).

% statically determined fluent that is neither an input entity nor an output entity
% ie the intervals of F=V are not cached
holdsAtSDFluent(F=V, T) :- 
  	holdsForSDFluent(F=V, [H|Tail]),
	tinIntervals(T, [H|Tail]).


%%%%%%% happensAt as used in the body of entity definitions

%%%% special event: the starting time of a fluent

%%% in each case below (input entity/statically determined fluent, simple fluent 
%%% and output entity/statically determined fluent), the first rule checks if 
%%% the first interval in (Qi-WM, Qi] is amalgamated with the last interval before Qi-WM
%%% If it is then start(F=V) does not take place at the starting time 
%%% of the first interval in (Qi-WM, Qi]

% compute the starting points of processed input entities/statically determined fluents
happensAtProcessedIE(Index, startI(F=V), S) :-
	iePList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]), 
	member((S,_E), Tail).
happensAtProcessedIE(Index, startI(F=V), S) :-
	iePList(Index, F=V, [H|Tail], []), 
	member((S,_E), [H|Tail]).
% compute the starting points of simple fluents
happensAtProcessedSimpleFluent(Index, startI(F=V), S) :-
	simpleFPList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]), 
	member((S,_E), Tail).
happensAtProcessedSimpleFluent(Index, startI(F=V), S) :-
	simpleFPList(Index, F=V, [H|Tail], []),
	member((S,_E), [H|Tail]).
% compute the starting points of output entities/statically determined fluents
happensAtProcessedSDFluent(Index, startI(F=V), S) :-
	sdFPList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]),  
	member((S,_E), Tail).
happensAtProcessedSDFluent(Index, startI(F=V), S) :-
	sdFPList(Index, F=V, [H|Tail], []), 
	member((S,_E), [H|Tail]).
	
% compute the starting points of processed input entities/statically determined fluents
happensAtProcessedIE(Index, start(F=V), T) :-
	iePList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]), 
	member((S,_E), Tail), prevTimePoint(S, T).
happensAtProcessedIE(Index, start(F=V), T) :-
	iePList(Index, F=V, [H|Tail], []), 
	member((S,_E), [H|Tail]), prevTimePoint(S, T).
% compute the starting points of simple fluents
happensAtProcessedSimpleFluent(Index, start(F=V), T) :-
	simpleFPList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]), 
	member((S,_E), Tail), prevTimePoint(S, T).
happensAtProcessedSimpleFluent(Index, start(F=V), T) :-
	simpleFPList(Index, F=V, [H|Tail], []),
	member((S,_E), [H|Tail]), prevTimePoint(S, T).
% compute the starting points of output entities/statically determined fluents
happensAtProcessedSDFluent(Index, start(F=V), T) :-
	sdFPList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]),  
	member((S,_E), Tail), prevTimePoint(S, T).
happensAtProcessedSDFluent(Index, start(F=V), T) :-
	sdFPList(Index, F=V, [H|Tail], []), 
	member((S,_E), [H|Tail]), prevTimePoint(S, T).

% start(F=V) is not defined for fluents that are neither input nor output entities, 
% ie fluents that are not cached
% For such fluents we do not have access to the last interval before Qi-WM 
% and therefore we cannot compute whether the last interval before Qi-WM 
% is amalgamated with the first interval in (Qi-WM,Qi]


%%%% special event: the ending time of a fluent interval 
/*
% compute the ending points of processed input entities/statically determined fluents
happensAtProcessedIE(Index, end(F=V), E) :-
	iePList(Index, F=V, [H|Tail], _), 
	member((_S,E), [H|Tail]), \+ E=inf.
% compute the ending points of simple fluents
happensAtProcessedSimpleFluent(Index, end(F=V), E) :-
	simpleFPList(Index, F=V, [H|Tail], _),
	member((_S,E), [H|Tail]), \+ E=inf.
% compute the ending points of output entities/statically determined fluents
happensAtProcessedSDFluent(Index, endO(F=V), E) :-
	sdFPList(Index, F=V, [H|Tail], _), 
	member((_S,E), [H|Tail]), \+ E=inf.
% compute the ending points of statically determined fluents
% that are neither input nor output entities, ie these fluents are not cached
happensAtSDFluent(endO(F=V), E) :-
	holdsForSDFluent(F=V, [H|Tail]), 
	member((_S,E), [H|Tail]), \+ E=inf.
*/
% compute the ending points of processed input entities/statically determined fluents
happensAtProcessedIE(Index, end(F=V), T) :-
	iePList(Index, F=V, [H|Tail], _), 
	member((_S,E), [H|Tail]), 
	\+ E=inf, prevTimePoint(E, T).
% compute the ending points of simple fluents
happensAtProcessedSimpleFluent(Index, end(F=V), T) :-
	simpleFPList(Index, F=V, [H|Tail], _),
	member((_S,E), [H|Tail]), 
	\+ E=inf, prevTimePoint(E, T).
% compute the ending points of output entities/statically determined fluents
happensAtProcessedSDFluent(Index, end(F=V), T) :-
	sdFPList(Index, F=V, [H|Tail], _), 
	member((_S,E), [H|Tail]), 
	\+ E=inf, prevTimePoint(E, T).
% compute the ending points of statically determined fluents
% that are neither input nor output entities, ie these fluents are not cached
happensAtSDFluent(end(F=V), T) :-
	holdsForSDFluent(F=V, [H|Tail]), 
	member((_S,E), [H|Tail]), 
	\+ E=inf, prevTimePoint(E, T).

%%%% happensAtProcessed for non-special events

% cached events
happensAtProcessed(Index, E, T) :-
	evTList(Index, E, L),
	member(T, L).


%%%%%%% USER INTERACTION %%%%%%%

%%%%%%% holdsFor is used ONLY for user interaction
%%%%%%% use iePList/simpleFPList/sdFPList and look no further

holdsFor(F=V, L) :-
	retrieveIntervals(F=V, L).

% retrieve the intervals of input entities (those for which we collect their intervals)
retrieveIntervals(F=V, L) :-
	% collectIntervals2/2 is produced in the compilation stage 
	% by combining collectIntervals/1, indexOf/2 and grounding/1
	collectIntervals2(Index, F=V),
	retrieveIEIntervals(Index, F=V, L).

% retrieve the intervals of input entities (those for which we build their intervals from time-points)
retrieveIntervals(F=V, L) :-
	% buildFromPoints2/2 is produced in the compilation stage 
	% by combining collectIntervals/1, indexOf/2 and grounding/1
	buildFromPoints2(Index, F=V),
	retrieveIEIntervals(Index, F=V, L).

% retrieve the intervals of output entities
retrieveIntervals(F=V, L) :-
	% cachingOrder2/2 is produced in the compilation stage 
	% by combining cachingOrder/1, indexOf/2 and grounding/1
	cachingOrder2(Index, F=V),
	retrieveOEIntervals(Index, F=V, L).


retrieveIEIntervals(Index, F=V, L) :-
	iePList(Index, F=V, RestrictedList, Extension), !,
	amalgamatePeriods(Extension, RestrictedList, L).

retrieveIEIntervals(_Index, _U, []).


retrieveOEIntervals(Index, F=V, L) :-
	sDFluent(F=V), !,
	retrieveOESDFluentIntervals(Index, F=V, L).

retrieveOEIntervals(Index, F=V, L) :-
	simpleFPList(Index, F=V, RestrictedList, Extension), !,
	amalgamatePeriods(Extension, RestrictedList, L).

retrieveOEIntervals(_Index, _U, []).


retrieveOESDFluentIntervals(Index, F=V, L) :-
	sdFPList(Index, F=V, RestrictedList, Extension), !,
	amalgamatePeriods(Extension, RestrictedList, L).

retrieveOESDFluentIntervals(_Index, _U, []).


%%%%%%% holdsAt is used ONLY for user interaction
% T should be given

holdsAt(F=V, T) :-
	holdsFor(F=V, [H|Tail]),
	tinIntervals(T, [H|Tail]).


tinIntervals(T, L) :-
	member((S,E), L),
	gt(E,T), !, S=<T.


%%%%%%% happensAt is used ONLY for user interaction

% retrieve the time-points of input entities
happensAt(E, T) :-
	inputEntity(E),
	happensAtIE(E, T).

% retrieve the time-points of output entities
happensAt(E, T) :-
	event(E), 
	% cachingOrder2/2 is produced in the compilation stage 
	% by combining cachingOrder/1, indexOf/2 and grounding/1
	cachingOrder2(Index, E),
	happensAtProcessed(Index, E, T).

