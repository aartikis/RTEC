updateSDE(initiation_1) :-
assertz(happensAtIE(win_lottery(chris), 9)),
assertz(happensAtIE(lose_wallet(chris), 13)),
assertz(happensAtIE(win_lottery(chris), 13)),
assertz(happensAtIE(lose_wallet(chris), 16)),
assertz(happensAtIE(win_lottery(chris), 18)),
assertz(happensAtIE(lose_wallet(chris), 21)).

updateSDE(initiation_2) :-
assertz(happensAtIE(lose_wallet(chris), 13)),
assertz(happensAtIE(win_lottery(chris), 13)),
assertz(happensAtIE(lose_wallet(chris), 16)),
assertz(happensAtIE(win_lottery(chris), 18)),
assertz(happensAtIE(lose_wallet(chris), 21)).

updateSDE(initiation_3) :-
assertz(happensAtIE(win_lottery(chris), 9)),
assertz(happensAtIE(lose_wallet(chris), 13)),
assertz(happensAtIE(win_lottery(chris), 14)),
assertz(happensAtIE(lose_wallet(chris), 16)),
assertz(happensAtIE(win_lottery(chris), 18)),
assertz(happensAtIE(lose_wallet(chris), 21)).
