updateSDE(tfaf_1) :-
%assertz(happensAtIE(starts_working(chris),9)),
assertz(happensAtIE(go_to(chris,work),9)),
assertz(happensAtIE(win_lottery(chris), 13)),
%assertz(happensAtIE(ends_working(chris),17)),
assertz(happensAtIE(go_to(chris,home),17)),
assertz(happensAtIE(lose_wallet(chris), 19)).

updateSDE(tfaf_2) :-
%assertz(happensAtIE(starts_working(chris),9)),
assertz(happensAtIE(go_to(chris,work),9)),
assertz(happensAtIE(win_lottery(chris), 9)),
%assertz(happensAtIE(ends_working(chris),17)),
assertz(happensAtIE(go_to(chris,home),17)),
assertz(happensAtIE(lose_wallet(chris), 19)).

updateSDE(tfaf_3) :-
assertz(happensAtIE(starts_working(chris),9)),
assertz(happensAtIE(go_to(chris,work),9)),
assertz(happensAtIE(go_to(chris,pub),9)),
assertz(happensAtIE(go_to(chris,home),17)).
%assertz(happensAtIE(ends_working(chris),17)).

updateSDE(tfaf_4) :-
%assertz(happensAtIE(starts_working(chris),9)),
assertz(happensAtIE(go_to(chris,work),9)),
%assertz(happensAtIE(ends_working(chris),21)),
assertz(happensAtIE(go_to(chris,home),21)).

updateSDE(tfaf_5) :-
%assertz(happensAtIE(starts_working(chris),9)),
assertz(happensAtIE(go_to(chris,work),9)),
assertz(happensAtIE(win_lottery(chris),21)).
