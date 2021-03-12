% This is our narrative of events, given as input.

updateSDE(hierarchy_1) :-
assert(happensAtIE(go_to(chris, work), 9)),
assert(happensAtIE(starts_working(chris), 9)),
assert(happensAtIE(sleep_start(chris), 13)),
assert(happensAtIE(sleep_end(chris), 14)),
assert(happensAtIE(ends_working(chris), 18)),
assert(happensAtIE(go_to(chris, home), 18)),
assert(happensAtIE(go_to(chris, pub), 20)),
assert(happensAtIE(win_lottery(chris),21)),
assert(happensAtIE(lose_wallet(chris), 23)),
assert(happensAtIE(win_lottery(chris),24)),
assert(happensAtIE(lose_wallet(chris), 27)),
assert(happensAtIE(go_to(chris, home), 28)),
assert(happensAtIE(sleep_start(chris), 28)),
assert(happensAtIE(sleep_end(chris), 32)),
assert(happensAtIE(go_to(chris, work), 33)),
assert(happensAtIE(starts_working(chris), 33)),
assert(happensAtIE(win_lottery(chris),35)).

updateSDE(hierarchy_1,18) :-
assert(happensAtIE(go_to(chris, work), 9)),
assert(happensAtIE(starts_working(chris), 9)),
assert(happensAtIE(sleep_start(chris), 13)),
assert(happensAtIE(sleep_end(chris), 14)),
assert(happensAtIE(ends_working(chris), 18)),
assert(happensAtIE(go_to(chris, home), 18)).

updateSDE(hierarchy_1,27) :-
assert(happensAtIE(go_to(chris, pub), 20)),
assert(happensAtIE(win_lottery(chris),21)),
assert(happensAtIE(lose_wallet(chris), 23)),
assert(happensAtIE(win_lottery(chris),24)),
assert(happensAtIE(lose_wallet(chris), 27)).

updateSDE(hierarchy_1,36) :-
assert(happensAtIE(go_to(chris, home), 28)),
assert(happensAtIE(sleep_start(chris), 28)),
assert(happensAtIE(sleep_end(chris), 32)),
assert(happensAtIE(go_to(chris, work), 33)),
assert(happensAtIE(starts_working(chris), 33)),
assert(happensAtIE(win_lottery(chris),35)).
