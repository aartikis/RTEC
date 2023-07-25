

processEvent(Index, E) :-
	evTList(Index, E, L), !,
	retract(evTList(Index, E, L)),
	findall(T, happensAtEv(E,T), ListofTimePoints),
	updateevTList(Index, E, ListofTimePoints). 

% this predicate deals with the case where no time-points for E were computed at the previous query time
processEvent(Index, E) :-
	findall(T, happensAtEv(E,T), ListofTimePoints),
	updateevTList(Index, E, ListofTimePoints). 


updateevTList(_Index, _E, []) :- !.

updateevTList(Index, E, ListofTimePoints) :- 
	assertz(evTList(Index, E, ListofTimePoints)).
