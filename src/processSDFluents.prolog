

processSDFluent(Index, F=V, InitTime) :-
	sdFPList(Index, F=V, RestrictedList, Extension), 
    RestrictedList \= (_, _),!, % RestrictedList is not an RCT proceed normally
	retract(sdFPList(Index, F=V, _, _)),
	amalgamatePeriods(Extension, RestrictedList, ExtendedPList),
	setTheSceneSDFluent(ExtendedPList, InitTime, BrokenPeriod), 
	holdsForSDFluent(F=V, NewPeriods),
	updatesdFPList(Index, F=V, NewPeriods, BrokenPeriod). 

% this is used for SDFluents that produce RCTs
% at the moment it is separate but could be merged with the above
% for better code readbility
processSDFluent(Index, F=V, GWInitTime) :-
	sdFPList(Index, F=V, RestrictedListRCT, Extension),
    RestrictedListRCT = (RestrictedList, To), !, % RestrictedListRCT is an RCT
    min(To, GWInitTime, InitTime),
	retract(sdFPList(Index, F=V, _, _)),
    % merge extension with old new intervals of previous query
	amalgamatePeriods(Extension, RestrictedList, ExtendedPList),
    % returns the interval if it exists that overlaps inittime
	setTheSceneSDFluent(ExtendedPList, InitTime, BrokenPeriod), 
    % no change below (note new periods are an RCT)
	holdsForSDFluent(F=V, NewPeriods),
	updatesdFPList(Index, F=V, NewPeriods, BrokenPeriod). 

% this predicate deals with the case where no intervals for F=V were computed at the previous query time
processSDFluent(Index, F=V, _InitTime) :-
	holdsForSDFluent(F=V, NewPeriods),
	updatesdFPList(Index, F=V, NewPeriods, []). 


% deals with the interval, if any, that starts before or on Qi-WM and ends after Qi-WM
setTheSceneSDFluent(EPList, InitTime, BrokenPeriod) :-
	% look for an interval starting before or on Qi-WM and ending after Qi-WM
	member((Start,End1), EPList), 
	get_te(End1,End),
	gt(End,InitTime),
	(
		Start=<InitTime, nextTimePoint(InitTime,NewInitTime), BrokenPeriod=[(Start,NewInitTime)]
		;
		BrokenPeriod=[]
	), !.    

% all intervals end before Qi-WM 
setTheSceneSDFluent(_EPList, _InitTime, []).  

updatesdFPList(_Index, _U, [], []) :- !.

% if cutoff is equal to Tq no need to save results
updatesdFPList(_Index, _F=_V, ([],To), _BrokenPeriod):-
   queryTime(Tq), To = Tq, !. 

updatesdFPList(Index, F=V, NewPeriods, BrokenPeriod) :- 
	assertz(sdFPList(Index, F=V, NewPeriods, BrokenPeriod)).
