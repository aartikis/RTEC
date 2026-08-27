
updateSDE(voting_3, -1, 10) :-
assertz(happensAtIE( propose(1, 1),           5)),
assertz(happensAtIE( propose(1, 1),           9)).

updateSDE(voting_3, 9, 20) :-
assertz(happensAtIE( second(1, 1),           18)).

