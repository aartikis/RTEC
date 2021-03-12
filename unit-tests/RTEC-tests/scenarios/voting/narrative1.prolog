
updateSDE(voting_1, -1, 10) :-
assert(happensAtIE( propose(1, 1),           1)),
assert(happensAtIE( second(2, 1),            5)),
assert(happensAtIE( vote(2, 1, aye),         6)),
assert(happensAtIE( vote(4, 1, aye),         6)),
assert(happensAtIE( vote(5, 1, nay),         6)),
assert(happensAtIE( vote(6, 1, nay),         6)),
assert(happensAtIE( vote(3, 1, nay),         6)),
assert(happensAtIE( vote(1, 1, aye),         6)),
assert(happensAtIE( vote(2, 1, aye),         7)),
assert(happensAtIE( close_ballot(2, 1),      8)),
assert(happensAtIE( declare(2, 1, carried),  9)).

updateSDE(voting_1, 9, 20) :-
assert(happensAtIE( propose(1, 1),           15)),
assert(happensAtIE( second(2, 1),            20)).

