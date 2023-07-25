

/******************************* FORGET MECHANISM *********************************/


% the rule below deals with the case in which the input stream is not temporally sorted
forget(InitTime) :-
	input(unordered), !,
	nextTimePoint(InitTime, NewInitTime),
	eventsPerTimepointThreshold(EventsPerTimepointThreshold),
	% forget input entities/events
	%EventsPerTimepointThreshold=0.1,
	forgetEntity(InitTime, happensAtIE, EventsPerTimepointThreshold),
	%findall(E, (happensAtIE(E, T), T=<InitTime, retract(happensAtIE(E, T))), _),
	% forget the instances (time-points) of input entities/statically determined fluents
	forgetEntity(InitTime, holdsAtIE, EventsPerTimepointThreshold),
	%findall(U, (holdsAtIE(U, T), T=<InitTime, retract(holdsAtIE(U, T))), _),	
	% forget the intervals of input entities/statically determined fluents
	findall(E, (holdsForIESI(E, (Start,End)), dealWithInputFluents(E, Start, End, InitTime, NewInitTime)), _).

% the rule below deals with the case in which the input stream is temporally sorted

forget(InitTime) :-
	nextTimePoint(InitTime, NewInitTime),
	% forget input entities/events
	findall(E, dealWithInputEvents(E, InitTime), _),
	% forget the instances (time-points) of input entities/statically determined fluents
	findall(U, dealWithInputFluentsT(U, InitTime), _),	
	% forget the intervals of input entities/statically determined fluents
	findall(U, dealWithInputFluentsI(U, InitTime, NewInitTime), _).

% This predicate removes all instances of EntityName(= happensAtIE/holdsAtIE) before InitTime.
% The number of events and time-points before InitTime, as well as EventsPerTimepointThreshold decide which retract predicate will be used.
% Note that this predicate only works for entities with arity=2.
forgetEntity(InitTime, EntityName, EventsPerTimepointThreshold):-
	% Find all entities before InitTime and add them in a list with their respective time-points. 
	findall([Entity,T], (Entity=.. [EntityName, _E, T], Entity, T=<InitTime), EventsAndTimepoints), 
	zip(Events, Timepoints, EventsAndTimepoints), 
	% EventsNo is the number of events before InitTime.
	length(Events, EventsNo),
	% TimepointsNo is the number of distinct time-points before InitTime at which at one event of EntityName occurs.
	list_to_ord_set(Timepoints, TimepointsSet), length(TimepointsSet, TimepointsNo), 
	EventsNoThreshold is TimepointsNo*EventsPerTimepointThreshold, 
	(
		% The default case of forget which retracts one by one.
		EventsPerTimepointThreshold = -1, 
		retractallinList(Events)
		;
		% There are more events per time-point than specified by the threshold. So, use retractall at each time-point.
		EventsNo > EventsNoThreshold,
		retractallatTimepoints(EntityName, TimepointsSet)
		;
		% There are less events per time-point than specified by the threshold.So, retract one by one. 
		EventsNo =< EventsNoThreshold,
		retractallinList(Events)
	).

% Used to retract all instances of an Entity at any timepoint in TimepointList
% This predicate uses the build-in predicate retractall, once for each timepoint in TimepointList
% retractallatTimepoints(+EntityName, +TimepointList)
retractallatTimepoints(_, []).

retractallatTimepoints(EntityName, [Tcurr|Trest]):-
	Entity=.. [EntityName, _E, Tcurr],
	retractall(Entity),
	retractallatTimepoints(EntityName, Trest).

% Used to call retract for each entity in a list.
% This predicate does NOT use the build-in predicate retractall.
% retractallinList(+ListOfEntitiesToRetract)
retractallinList([]).

retractallinList([Entity|RestEntities]):-
	retract(Entity),
	retractallinList(RestEntities).


% if the entity starts after Qi-WM then keep it (do nothing)
dealWithInputFluents(_E, Start, _End, InitTime, _NewInitTime) :-
	Start>InitTime, !.

% if the entity ends before Qi-WM then delete it
dealWithInputFluents(E, Start, End, InitTime, _NewInitTime) :-
	End=<InitTime,
	retract(holdsForIESI(E,(Start,End))), !.

% if the entity starts before or on Qi-WM and ends after Qi-WM then break it
dealWithInputFluents(E, Start, End, _InitTime, NewInitTime) :-
	retract(holdsForIESI(E,(Start,End))), !, 
	\+ NewInitTime=End,
	assertz(holdsForIESI(E,(NewInitTime,End))). 


% stop looking after InitTime=Qi-WM
dealWithInputEvents(E, InitTime) :-
	happensAtIE(E,T),
	(
		T>InitTime, !
		;
		retract(happensAtIE(E,T))
	).

% stop looking after InitTime=Qi-WM
dealWithInputFluentsT(U, InitTime) :-
	holdsAtIE(U,T),
	(
		T>InitTime, !
		;
		retract(holdsAtIE(U,T))
	).


% stop looking after InitTime=Qi-WM
dealWithInputFluentsI(U, InitTime, NewInitTime) :-
	holdsForIESI(U, (Start, End)),	
	(
		Start>InitTime, !
		;
		End=<InitTime, 
		retract(holdsForIESI(U, (Start, End)))
		;		
		End>InitTime, 
		\+ NewInitTime=End,
		retract(holdsForIESI(U, (Start, End))), 
		assertz(holdsForIESI(U, (NewInitTime, End)))
	).

%% zip predicate %% 
zip([],[],[]).
zip([L|LT], [R|RT], [[L,R]|ZT]):- zip(LT, RT, ZT).

/************************************************************************************************** 
 Compute the list of intervals of input entities/statically determined fluents.
 If the intervals of the input entities are provided then RTEC simply collects these intervals 
 and stores them in a list --- see 'collectIntervals' flag.
 If the time points of the input entities are provided then RTEC may build the list
 of intervals --- see 'buildFromPoints' flag.
 **************************************************************************************************/

inputProcessing(InitTime, QueryTime) :-
	% collect the input entity/statically determined fluent intervals into a list	
	findall(F=V, 
		(
			% collectIntervals2/2 is produced in the compilation stage 
			% by combining collectIntervals/1, indexOf/2 and grounding/1
			collectIntervals2(Index, F=V),
			processIECollectI(Index, F=V, InitTime)
		), _),
	% build the list of input entity/statically determined fluent intervals 
	% given the time-points in which they are detected
	findall(F=V, 
		(
			% buildFromPoints2/2 is produced in the compilation stage 
			% by combining collectIntervals/1, indexOf/2 and grounding/1
			buildFromPoints2(Index, F=V),
			processIEBuildFP(Index, F=V, InitTime, QueryTime)
		), _).


%%%%%%% processIECollectI

processIECollectI(Index, F=V, InitTime) :-
	iePList(Index, F=V, RestrictedList, Extension), !,
	retract(iePList(Index, F=V, _, _)),
	amalgamatePeriods(Extension, RestrictedList, ExtendedPList),
	% the predicate below is defined in processSDFluents.prolog
	setTheSceneSDFluent(ExtendedPList, InitTime, BrokenPeriod), 
	holdsForIE(collectIntervals, F=V, NewPeriods),
	updateiePList(Index, F=V, NewPeriods, BrokenPeriod). 

% this predicate deals with the case where no intervals for F=V were computed at the previous query time
processIECollectI(Index, F=V, _InitTime) :-
	holdsForIE(collectIntervals, F=V, NewPeriods),
	updateiePList(Index, F=V, NewPeriods, []). 


%%%%%%% processIEBuildFP

processIEBuildFP(Index, F=V, InitTime, QueryTime) :-
	iePList(Index, F=V, RestrictedList, Extension), !,
	retract(iePList(Index, F=V, _, _)),
	amalgamatePeriods(Extension, RestrictedList, ExtendedPList),
	% the predicate below is defined in processSDFluents.prolog
	setTheSceneSDFluent(ExtendedPList, InitTime, BrokenPeriod), 
	holdsForIE(buildFromPoints, F=V, NewPeriods, QueryTime),
	updateiePList(Index, F=V, NewPeriods, BrokenPeriod). 

% this predicate deals with the case where no intervals for F=V were computed at the previous query time
processIEBuildFP(Index, F=V, _InitTime, QueryTime) :-
	holdsForIE(buildFromPoints, F=V, NewPeriods, QueryTime),
	updateiePList(Index, F=V, NewPeriods, []). 


%%%%%%% updateiePList

% if no IE intervals have been computed then do not assert anything
updateiePList(_Index, _U, [], []) :- !.

updateiePList(Index, F=V, NewPeriods, BrokenPeriod) :- 
	assertz(iePList(Index, F=V, NewPeriods, BrokenPeriod)).


%%%%%%% holdsForIE --- collectIntervals

% collect the list of intervals; setof sorts the list of intervals
holdsForIE(collectIntervals, IE, L) :-
 	setof(SingleI, holdsForIESI(IE, SingleI), L), !.

% if there is no holdsForIESI in the input then setof will fail
% in this case return the empty list of intervals
holdsForIE(collectIntervals, _IE, []).


%%%%%%% holdsForIE --- build intervals from points

holdsForIE(buildFromPoints, IE, L, QueryTime) :-
	% in this case we are given the IE at time-points using holdsAt
	% rather than intervals as in collectIntervals
	setof(T, holdsAtIE(IE, T), PointList), !, 
	% this is the application-dependent temporal distance between two points (eg video frames)
	temporalDistance(TemporalDistance),
	makeIntervalsFromAllPoints(PointList, TemporalDistance, QueryTime, [], L).

holdsForIE(buildFromPoints, _IE, [], _QueryTime).


% the predicate below builds an interval given a set of time-points and 
% the fixed temporal distance between any two consecutive time-points

makeIntervalsFromAllPoints([], _TemporalDistance, _QueryTime, L, L) :- !.

makeIntervalsFromAllPoints([Start|Tail], TemporalDistance, QueryTime, Temp, L) :-
	findEndofInterval([Start|Tail], TemporalDistance, QueryTime, End, Rest),
	append(Temp, [(Start,End)], NewTemp),
	makeIntervalsFromAllPoints(Rest, TemporalDistance, QueryTime, NewTemp, L).

	
findEndofInterval([LastTime], _TemporalDistance, LastTime, inf, []) :- !.

findEndofInterval([End], TemporalDistance, _LastTime, NextEnd, []) :- 
	!, 
	% nextTimePoint
	NextEnd is End+TemporalDistance-(End mod TemporalDistance). 

findEndofInterval([P1,P2|Tail], TemporalDistance, _LastTime, NextP1, [P2|Tail]) :-
	Diff is P2-P1,
	Diff>TemporalDistance, !, 
	% nextTimePoint
	NextP1 is P1+TemporalDistance-(P1 mod TemporalDistance).

findEndofInterval([_P1,P2|Tail], TemporalDistance, LastTime, End, Rest) :-
	findEndofInterval([P2|Tail], TemporalDistance, LastTime, End, Rest).
