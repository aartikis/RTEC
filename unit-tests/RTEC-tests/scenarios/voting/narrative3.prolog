
updateSDE(voting_3, -1, 10) :-
assert(happensAtIE( propose(1, 1),           5)),
assert(happensAtIE( propose(1, 1),           9)).

updateSDE(voting_3, 9, 20) :-
assert(happensAtIE( second(1, 1),           18)).

