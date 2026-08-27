updateSDE(holds_at_t_1) :-
assertz(happensAtIE(sleep_start(chris),9)),
assertz(happensAtIE(win_lottery(chris),12)),
assertz(happensAtIE(sleep_end(chris),21)).

updateSDE(holds_at_t,2, 9, 21) :-
assertz(happensAtIE(go_to(chris, work), 9)),
assertz(happensAtIE(starts_working(chris), 9)),
assertz(happensAtIE(sleep_start(chris), 13)),
assertz(happensAtIE(sleep_end(chris), 14)),
assertz(happensAtIE(ends_working(chris), 18)),
assertz(happensAtIE(go_to(chris, home), 18)),
assertz(happensAtIE(go_to(chris, pub), 20)),
assertz(happensAtIE(win_lottery(chris),21)).

updateSDE(holds_at_t_2) :-
assertz(happensAtIE(sleep_start(chris),9)),
assertz(happensAtIE(win_lottery(chris),8)),
assertz(happensAtIE(sleep_end(chris),15)).

updateSDE(holds_at_t_3) :-
assertz(happensAtIE(sleep_start(chris),9)),
assertz(happensAtIE(win_lottery(chris),5)),
assertz(happensAtIE(sleep_end(chris),15)).
