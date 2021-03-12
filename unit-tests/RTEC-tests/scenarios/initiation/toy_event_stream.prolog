updateSDE(initiation_1) :-
assert(happensAtIE(win_lottery(chris), 9)),
assert(happensAtIE(lose_wallet(chris), 13)),
assert(happensAtIE(win_lottery(chris), 13)),
assert(happensAtIE(lose_wallet(chris), 16)),
assert(happensAtIE(win_lottery(chris), 18)),
assert(happensAtIE(lose_wallet(chris), 21)).

updateSDE(initiation_2) :-
assert(happensAtIE(lose_wallet(chris), 13)),
assert(happensAtIE(win_lottery(chris), 13)),
assert(happensAtIE(lose_wallet(chris), 16)),
assert(happensAtIE(win_lottery(chris), 18)),
assert(happensAtIE(lose_wallet(chris), 21)).

updateSDE(initiation_3) :-
assert(happensAtIE(win_lottery(chris), 9)),
assert(happensAtIE(lose_wallet(chris), 13)),
assert(happensAtIE(win_lottery(chris), 14)),
assert(happensAtIE(lose_wallet(chris), 16)),
assert(happensAtIE(win_lottery(chris), 18)),
assert(happensAtIE(lose_wallet(chris), 21)).
