

processSDFluent(Index, F=V, InitTime) :-
	sdFPList(Index, F=V, RestrictedList, Extension), !,
	retract(sdFPList(Index, F=V, _, _)),
	amalgamatePeriods(Extension, RestrictedList, ExtendedPList),
	setTheSceneSDFluent(ExtendedPList, InitTime, BrokenPeriod), 
	holdsForSDFluent(F=V, NewPeriods),
	updatesdFPList(Index, F=V, NewPeriods, BrokenPeriod). 

% this predicate deals with the case where no intervals for F=V were computed at the previous query time
processSDFluent(Index, F=V, _InitTime) :-
	holdsForSDFluent(F=V, NewPeriods),
	updatesdFPList(Index, F=V, NewPeriods, []). 


% deals with the interval, if any, that starts before or on Qi-WM and ends after Qi-WM
setTheSceneSDFluent(EPList, InitTime, BrokenPeriod) :-
	% look for an interval starting before or on Qi-WM and ending after Qi-WM
	member((Start,End), EPList), 
	gt(End,InitTime),
	(
		Start=<InitTime, nextTimePoint(InitTime,NewInitTime), BrokenPeriod=[(Start,NewInitTime)]
		;
		BrokenPeriod=[]
	), !.    

% all intervals end before Qi-WM 
setTheSceneSDFluent(_EPList, _InitTime, []).  


updatesdFPList(_Index, _U, [], []) :- !.

updatesdFPList(Index, F=V, NewPeriods, BrokenPeriod) :- 
	assertz(sdFPList(Index, F=V, NewPeriods, BrokenPeriod)).
