updateSDE(tfaf_1) :-
%assert(happensAtIE(starts_working(chris),9)),
assert(happensAtIE(go_to(chris,work),9)),
assert(happensAtIE(win_lottery(chris), 13)),
%assert(happensAtIE(ends_working(chris),17)),
assert(happensAtIE(go_to(chris,home),17)),
assert(happensAtIE(lose_wallet(chris), 19)).

updateSDE(tfaf_2) :-
%assert(happensAtIE(starts_working(chris),9)),
assert(happensAtIE(go_to(chris,work),9)),
assert(happensAtIE(win_lottery(chris), 9)),
%assert(happensAtIE(ends_working(chris),17)),
assert(happensAtIE(go_to(chris,home),17)),
assert(happensAtIE(lose_wallet(chris), 19)).

updateSDE(tfaf_3) :-
assert(happensAtIE(starts_working(chris),9)),
assert(happensAtIE(go_to(chris,work),9)),
assert(happensAtIE(go_to(chris,pub),9)),
assert(happensAtIE(go_to(chris,home),17)).
%assert(happensAtIE(ends_working(chris),17)).

updateSDE(tfaf_4) :-
%assert(happensAtIE(starts_working(chris),9)),
assert(happensAtIE(go_to(chris,work),9)),
%assert(happensAtIE(ends_working(chris),21)),
assert(happensAtIE(go_to(chris,home),21)).

updateSDE(tfaf_5) :-
%assert(happensAtIE(starts_working(chris),9)),
assert(happensAtIE(go_to(chris,work),9)),
assert(happensAtIE(win_lottery(chris),21)).
