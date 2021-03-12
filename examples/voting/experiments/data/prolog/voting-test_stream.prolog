

updateSDE(0, 10) :-
assert(happensAtIE( propose(1, 1),           1)),
assert(happensAtIE( propose(1, 1),           2)),
assert(happensAtIE( declare(1, 1, carried),  3)),
assert(happensAtIE( propose(1, 1),           4)),
%assert(happensAtIE( second(2, 1),            5)),
assert(happensAtIE( vote(2, 1, aye),         6)),
assert(happensAtIE( vote(4, 1, aye),         6)),
assert(happensAtIE( vote(5, 1, nay),         6)),
assert(happensAtIE( vote(6, 1, nay),         6)),
assert(happensAtIE( vote(3, 1, nay),         6)),
assert(happensAtIE( vote(1, 1, aye),         6)),
assert(happensAtIE( vote(2, 1, aye),         7)),
assert(happensAtIE( close_ballot(2, 1),      8)).
%assert(happensAtIE( declare(2, 1, carried),  9)).
%assert(happensAtIE( propose(1, 1),           10)).

updateSDE(10, 20) :-
%assert(happensAtIE( declare(1, 1, carried),  12)),
assert(happensAtIE( second(2, 1),            20)),
assert(happensAtIE( propose(1, 1),           15)),
%assert(happensAtIE( close_ballot(1, 1),      14)),
%assert(happensAtIE( declare(1, 1, not_carried),  15)),
assert(happensAtIE( propose(1, 1),           16)),
%assert(happensAtIE( second(2, 1),            17)),
%assert(happensAtIE( close_ballot(1, 1),      18)),
assert(happensAtIE( declare(1, 1, carried),  17)).

