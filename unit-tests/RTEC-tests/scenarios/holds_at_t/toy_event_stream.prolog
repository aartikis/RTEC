updateSDE(holds_at_t_1) :-
assert(happensAtIE(sleep_start(chris),9)),
assert(happensAtIE(win_lottery(chris),12)),
assert(happensAtIE(sleep_end(chris),21)).

updateSDE(holds_at_t,2, 9, 21) :-
assert(happensAtIE(go_to(chris, work), 9)),
assert(happensAtIE(starts_working(chris), 9)),
assert(happensAtIE(sleep_start(chris), 13)),
assert(happensAtIE(sleep_end(chris), 14)),
assert(happensAtIE(ends_working(chris), 18)),
assert(happensAtIE(go_to(chris, home), 18)),
assert(happensAtIE(go_to(chris, pub), 20)),
assert(happensAtIE(win_lottery(chris),21)).

updateSDE(holds_at_t_2) :-
assert(happensAtIE(sleep_start(chris),9)),
assert(happensAtIE(win_lottery(chris),8)),
assert(happensAtIE(sleep_end(chris),15)).

updateSDE(holds_at_t_3) :-
assert(happensAtIE(sleep_start(chris),9)),
assert(happensAtIE(win_lottery(chris),5)),
assert(happensAtIE(sleep_end(chris),15)).
