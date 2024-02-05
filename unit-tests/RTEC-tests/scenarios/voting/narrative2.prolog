
updateSDE(voting_2, -1, 10) :-
assertz(happensAtIE( propose(1, 1),           1)),
assertz(happensAtIE( propose(1, 1),           2)),
assertz(happensAtIE( second(2, 1),            3)),
assertz(happensAtIE( second(2, 1),            5)),
assertz(happensAtIE( vote(2, 1, aye),         6)),
assertz(happensAtIE( vote(4, 1, aye),         6)),
assertz(happensAtIE( vote(5, 1, nay),         6)),
assertz(happensAtIE( vote(6, 1, nay),         6)),
assertz(happensAtIE( vote(3, 1, nay),         6)),
assertz(happensAtIE( vote(1, 1, aye),         6)),
assertz(happensAtIE( vote(2, 1, aye),         7)),
assertz(happensAtIE( close_ballot(2, 1),      8)),
assertz(happensAtIE( close_ballot(2, 1),      9)).

updateSDE(voting_2, 9, 20) :-
assertz(happensAtIE( declare(2, 1, carried),  10)),
assertz(happensAtIE( propose(1, 1),           15)),
assertz(happensAtIE( second(2, 1),            20)).

