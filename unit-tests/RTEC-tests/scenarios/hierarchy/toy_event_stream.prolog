% This is our narrative of events, given as input.

updateSDE(hierarchy_1) :-
assertz(happensAtIE(go_to(chris, work), 9)),
assertz(happensAtIE(starts_working(chris), 9)),
assertz(happensAtIE(sleep_start(chris), 13)),
assertz(happensAtIE(sleep_end(chris), 14)),
assertz(happensAtIE(ends_working(chris), 18)),
assertz(happensAtIE(go_to(chris, home), 18)),
assertz(happensAtIE(go_to(chris, pub), 20)),
assertz(happensAtIE(win_lottery(chris),21)),
assertz(happensAtIE(lose_wallet(chris), 23)),
assertz(happensAtIE(win_lottery(chris),24)),
assertz(happensAtIE(lose_wallet(chris), 27)),
assertz(happensAtIE(go_to(chris, home), 28)),
assertz(happensAtIE(sleep_start(chris), 28)),
assertz(happensAtIE(sleep_end(chris), 32)),
assertz(happensAtIE(go_to(chris, work), 33)),
assertz(happensAtIE(starts_working(chris), 33)),
assertz(happensAtIE(win_lottery(chris),35)).

updateSDE(hierarchy_1,18) :-
assertz(happensAtIE(go_to(chris, work), 9)),
assertz(happensAtIE(starts_working(chris), 9)),
assertz(happensAtIE(sleep_start(chris), 13)),
assertz(happensAtIE(sleep_end(chris), 14)),
assertz(happensAtIE(ends_working(chris), 18)),
assertz(happensAtIE(go_to(chris, home), 18)).

updateSDE(hierarchy_1,27) :-
assertz(happensAtIE(go_to(chris, pub), 20)),
assertz(happensAtIE(win_lottery(chris),21)),
assertz(happensAtIE(lose_wallet(chris), 23)),
assertz(happensAtIE(win_lottery(chris),24)),
assertz(happensAtIE(lose_wallet(chris), 27)).

updateSDE(hierarchy_1,36) :-
assertz(happensAtIE(go_to(chris, home), 28)),
assertz(happensAtIE(sleep_start(chris), 28)),
assertz(happensAtIE(sleep_end(chris), 32)),
assertz(happensAtIE(go_to(chris, work), 33)),
assertz(happensAtIE(starts_working(chris), 33)),
assertz(happensAtIE(win_lottery(chris),35)).
