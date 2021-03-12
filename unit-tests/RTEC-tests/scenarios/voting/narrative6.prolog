

updateSDE(voting_6, -1, 10) :-
assert(happensAtIE( declare(2, 1, carried),  1)),
assert(happensAtIE( propose(1, 1),           2)),
assert(happensAtIE( declare(2, 1, carried),  3)),
assert(happensAtIE( propose(1, 1),           4)),
assert(happensAtIE( second(2, 1),            5)),
assert(happensAtIE( vote(2, 1, aye),         6)),
assert(happensAtIE( vote(4, 1, aye),         6)),
assert(happensAtIE( vote(5, 1, aye),         6)),
assert(happensAtIE( vote(6, 1, aye),         6)),
assert(happensAtIE( vote(3, 1, nay),         6)),
assert(happensAtIE( vote(1, 1, aye),         6)),
assert(happensAtIE( vote(2, 1, aye),         7)),
assert(happensAtIE( propose(1, 1),           8)).

updateSDE(voting_6, 9, 20) :-
assert(happensAtIE( close_ballot(2, 1),      19)),
assert(happensAtIE( second(2, 1),            20)),
assert(happensAtIE( propose(1, 1),           11)),
assert(happensAtIE( propose(1, 1),           15)),
assert(happensAtIE( declare(2, 1, not_carried),  15)).

