
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

:- set_prolog_flag(toplevel_print_options, [max_depth(100000)]).
:- use_module(library(lists)).

:- ['compiler.prolog'].
:- ['inputModule.prolog'].
:- ['processSimpleFluents.prolog'].
:- ['processSDFluents.prolog'].
:- ['processEvents.prolog'].
:- ['utilities/interval-manipulation.prolog'].
:- ['utilities/amalgamate-periods.prolog'].

:- dynamic temporalDistance/1, input/1, preProcessing/1, initTime/1, iePList/4, simpleFPList/4, sdFPList/4, evTList/3, happensAtIE/2, holdsForIESI/2, holdsAtIE/2.


/********************************** INITIALISE RECOGNITION ***********************************/


initialiseRecognition(InputFlag, PreProcessingFlag, TemporalDistance) :-
	assert(temporalDistance(TemporalDistance)),
	(InputFlag=ordered, assert(input(InputFlag)) ; assert(input(unordered))),
	% if we need preprocessing then preProcessing/1 is already defined
	% so there is no need to assert anything here
	(PreProcessingFlag=preprocessing ; assert(preProcessing(_))), !.


/************************************* EVENT RECOGNITION *************************************/


eventRecognition(QueryTime, WM) :-
	InitTime is QueryTime-WM,
	assert(initTime(InitTime)),
        % delete input entities that have taken place before or on Qi-WM
	forget(InitTime),
	% compute the intervals of input entities/statically determined fluents
	inputProcessing(InitTime, QueryTime),
	preProcessing(QueryTime),
	% the order in which entities are processed makes a difference
	% start from lower-level entities and then move to higher-level entities
	% in this way the higher-level entities will use the CACHED lower-level entities
	% the order in which we process entities is set by cachingOrder/1 
	% which is specified in the domain-dependent file 
	% cachingOrder2/2 is produced in the compilation stage 
	% by combining cachingOrder/1, indexOf/2 and grounding/1
	findall(OE, (cachingOrder2(Index,OE), processEntity(Index,OE,InitTime,QueryTime)), _),
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
		processSimpleFluent(Index, OE, InitTime, QueryTime)
		;
		% compute the time-points of output entities/events
		processEvent(Index, OE)
	), !.



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
happensAtProcessedIE(Index, start(F=V), S) :-
	iePList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]), !,
	member((S,_E), Tail).

happensAtProcessedIE(Index, start(F=V), S) :-
	iePList(Index, F=V, [H|Tail], _), 
	member((S,_E), [H|Tail]).

% compute the starting points of simple fluents
happensAtProcessedSimpleFluent(Index, start(F=V), S) :-
	simpleFPList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]), !,
	member((S,_E), Tail).

happensAtProcessedSimpleFluent(Index, start(F=V), S) :-
	simpleFPList(Index, F=V, [H|Tail], _),
	member((S,_E), [H|Tail]).

% compute the starting points of output entities/statically determined fluents
happensAtProcessedSDFluent(Index, start(F=V), S) :-
	sdFPList(Index, F=V, [(IntervalBreakingPoint,_)|Tail], [(_,IntervalBreakingPoint)]), !, 
	member((S,_E), Tail).

happensAtProcessedSDFluent(Index, start(F=V), S) :-
	sdFPList(Index, F=V, [H|Tail], _), 
	member((S,_E), [H|Tail]).
	
% start(F=V) is not defined for fluents that are neither input nor output entities, 
% ie fluents that are not cached
% For such fluents we do not have access to the last interval before Qi-WM 
% and therefore we cannot compute whether the last interval before Qi-WM 
% is amalgamated with the first interval in (Qi-WM,Qi]


%%%% special event: the ending time of a fluent

% compute the ending points of processed input entities/statically determined fluents
happensAtProcessedIE(Index, end(F=V), E) :-
	iePList(Index, F=V, [H|Tail], _), 
	member((_S,E), [H|Tail]),
	\+ E=inf.

% compute the ending points of simple fluents
happensAtProcessedSimpleFluent(Index, end(F=V), E) :-
	simpleFPList(Index, F=V, [H|Tail], _),
	member((_S,E), [H|Tail]),
	\+ E=inf.

% compute the ending points of output entities/statically determined fluents
happensAtProcessedSDFluent(Index, end(F=V), E) :-
	sdFPList(Index, F=V, [H|Tail], _), 
	member((_S,E), [H|Tail]),
	\+ E=inf.
	
% compute the ending points of statically determined fluents
% that are neither input nor output entities, ie these fluents are not cached
happensAtSDFluent(end(F=V), E) :-
	holdsForSDFluent(F=V, [H|Tail]), 
	member((_S,E), [H|Tail]),
	\+ E=inf.


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

