

processSimpleFluent(Index, F=V, InitTime, QueryTime) :-
	isThereASimpleFPList(Index, F=V, ExtendedPList),
	setTheSceneSimpleFluent(ExtendedPList, F=V, InitTime, StPoint), 
	% compute the starting points within (Qi-WM,Qi] 
	computeStartingPoints(F=V, InitTime, QueryTime, InitList),
	% append the starting point of the interval, if any, starting
	% before or on Qi-WM and ending after Qi-WM   
	% to the starting points computed at this stage  
	addPoint(StPoint, InitList, CompleteInitList),
	% compute new intervals
	holdsForSimpleFluent(F=V, NewIntervals, InitTime, QueryTime, CompleteInitList),
	% update simpleFPList
	computesimpleFPList(NewIntervals, InitTime, RestrictedPeriods, Extension),
	updatesimpleFPList(Index, F=V, RestrictedPeriods, Extension).


isThereASimpleFPList(Index, F=V, ExtendedPList) :-
	simpleFPList(Index, F=V, RestrictedList, Extension), !,
	retract(simpleFPList(Index, F=V, _, _)),
	amalgamatePeriods(Extension, RestrictedList, ExtendedPList).

% this predicate deals with the case where no intervals for F=V were computed at the previous query time
isThereASimpleFPList(_Index, _U, []).


addPoint([], L, L) :- !.
addPoint([P], L, [P|L]).


/************************************************************************************************************* 
   This predicate is similar to setTheSceneSDFluent. The main difference is that instead of breaking
   the interval, if any, that starts before or on Qi-Memory and ends after Qi-Memory, we delete it (the 
   interval) and keep the starting point. cachedHoldsFor will create the fluent intervals given this 
   starting point and other starting and ending points within (Qi-WM,WM]. 
 *************************************************************************************************************/

% deals with the case in which InitTime=<0
setTheSceneSimpleFluent(_EPList, F=V, InitTime, StPoint) :-
	InitTime=<0,
	( 
		initially(F=V), StPoint=[0] 
		;
		StPoint=[] 
	), !.

% there is no need to update starting points in this case
% if there were any starting points then the first argument would not have been empty
setTheSceneSimpleFluent([], _U, _InitTime, []) :- !.

% deals with the interval, if any, that starts before or on Qi-WM and ends after Qi-WM
setTheSceneSimpleFluent(EPList, _U, InitTime, StPoint) :-
	% look for an interval starting before or on Qi-WM and ending after Qi-WM
	InitTimePlus1 is InitTime+1,
	member((Start,End), EPList), 
	gt(End,InitTimePlus1),
	StartMinus1 is Start-1,
	(
		StartMinus1=<InitTime, StPoint=[Start]
		;
		StPoint=[]
	), !.    

% all intervals end before Qi-WM 
setTheSceneSimpleFluent(_EPList, _U, _InitTime, []).


/****** compute starting points ******/

computeStartingPoints(F=V, InitTime, QueryTime, InitList) :-
	initList(F=V, InitTime, QueryTime, InitList).

% find the initiating time-points within (Qi-WM,Qi]

initList(F=V, InitTime, QueryTime, InitList) :-
	EndTime is QueryTime+1,
	setof(T, initPoint(F=V, InitTime, EndTime, T), InitList), !.

% if there is no initiating point

initList(_, _, _, []).
 

initPoint(F=V, InitTime, EndTime, NextTs) :-
	initiatedAt(F=V, InitTime, Ts, EndTime),
	nextTimePoint(Ts, NextTs).   


/****** compute ending points ******/

computeEndingPoints(F=V, InitTime, QueryTime, TerminList) :-
	terminList(F=V, InitTime, QueryTime, TerminList).


% find the terminating time-points within (Qi-WM,Qi]

terminList(F=V, InitTime, QueryTime, TerminList) :-
	EndTime is QueryTime+1,
	setof(T, termPoint(F=V, InitTime, EndTime, T), TerminList), !.

% if there is no terminating point

terminList(_, _, _, []).


termPoint(F=V, InitTime, EndTime, NextTs) :-
	broken(F=V, InitTime, Ts, EndTime),
	nextTimePoint(Ts, NextTs).


% BROKEN

broken(U, Ts, Tf, T) :-
	terminatedAt(U, Ts, Tf, T).

broken(F=V1, Ts, Tstar, T) :-
	initiatedAt(F=V2, Ts, Tstar, T), 
	(strong_initiates ; V1 \= V2).   
  
% strong_initiates.
strong_initiates :- fail.    %% weak initiates 


/****** compute new intervals given the computed starting and ending points ******/

holdsForSimpleFluent(_U, [], _InitTime, _QueryTime, []) :- !.

holdsForSimpleFluent(U, PeriodList, InitTime, QueryTime, InitList) :-
	% compute the ending points within (Qi-WM,Qi]
	computeEndingPoints(U, InitTime, QueryTime, TerminList),
	makeIntervalsFromSEPoints(InitList, TerminList, PeriodList).
      

% the predicate below works under the assumption that the lists of 
% initiating and terminating points are temporally sorted

makeIntervalsFromSEPoints([Ts], EPoints, [Period]) :-
	member(Tf, EPoints), 
	Ts<Tf, !,  
	Period = (Ts,Tf).

makeIntervalsFromSEPoints([Ts], _EPoints, [Period]) :- !,
	Period = (Ts,inf).    % simpler to deal with than since(Ts).

makeIntervalsFromSEPoints([Ts,Tnext|MoreTs], EPoints, [Period|MorePeriods]) :-
	member(Tf, EPoints), 
	Ts<Tf,
	(
		Tf<Tnext,
		Period=(Ts,Tf),
		append( _, [Tf|MoreEPoints], EPoints ), !,
		makeIntervalsFromSEPoints([Tnext|MoreTs], MoreEPoints, MorePeriods)
		;
		% U is neither initiated nor terminated between Ts and Tnext
		% need to amalgamate (Ts,Tnext) with next period found
		% Period=(Ts,Tf)
		% makeIntervalsFromSEPoints([Tnext|MoreTs], U, [(Tnext,Tf)|MorePeriods])	
		Period=(Ts,Tf), 
		MorePeriods=MoreX, 
        	append( _, [Tf|MoreEPoints], EPoints ), !,
		makeIntervalsFromSEPoints([Tnext|MoreTs], [Tf|MoreEPoints], [(Tnext,Tf)|MoreX])
	).

makeIntervalsFromSEPoints([Ts,_Tnext|_MoreTs], _EPoints, [(Ts,inf)]).


/****** computesimpleFPList  ******/


computesimpleFPList([], _InitTime, [], []) :- !.

computesimpleFPList([(Start,End)|Tail], InitTime, [(Start,End)|Tail], []) :-
	Start>InitTime, !.

computesimpleFPList([(Start,End)|Tail], InitTime, [(NewInitTime,End)|Tail], [(Start,NewInitTime)]) :-
	nextTimePoint(InitTime, NewInitTime), 
	\+ NewInitTime = End, !.

computesimpleFPList([Head|Tail], _InitTime, Tail, [Head]).


/****** updateSimpleFPList  ******/

updatesimpleFPList(_Index, _U, [], []) :- !.

updatesimpleFPList(Index, F=V, NewPeriods, BrokenPeriod) :- 
	assert(simpleFPList(Index, F=V, NewPeriods, BrokenPeriod)).






