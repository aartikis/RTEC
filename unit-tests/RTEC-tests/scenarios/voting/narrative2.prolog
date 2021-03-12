
updateSDE(voting_2, -1, 10) :-
assert(happensAtIE( propose(1, 1),           1)),
assert(happensAtIE( propose(1, 1),           2)),
assert(happensAtIE( second(2, 1),            3)),
assert(happensAtIE( second(2, 1),            5)),
assert(happensAtIE( vote(2, 1, aye),         6)),
assert(happensAtIE( vote(4, 1, aye),         6)),
assert(happensAtIE( vote(5, 1, nay),         6)),
assert(happensAtIE( vote(6, 1, nay),         6)),
assert(happensAtIE( vote(3, 1, nay),         6)),
assert(happensAtIE( vote(1, 1, aye),         6)),
assert(happensAtIE( vote(2, 1, aye),         7)),
assert(happensAtIE( close_ballot(2, 1),      8)),
assert(happensAtIE( close_ballot(2, 1),      9)).

updateSDE(voting_2, 9, 20) :-
assert(happensAtIE( declare(2, 1, carried),  10)),
assert(happensAtIE( propose(1, 1),           15)),
assert(happensAtIE( second(2, 1),            20)).

