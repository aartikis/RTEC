updateSDE(deadlines_rich_1) :-
assertz(happensAtIE(win_lottery(chris), 9)),
assertz(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_2) :-
assertz(happensAtIE(win_lottery(chris), 9)),
assertz(happensAtIE(lose_wallet(chris), 11)).

updateSDE(deadlines_rich_3) :-
assertz(happensAtIE(win_lottery(chris), 9)),
assertz(happensAtIE(win_lottery(chris), 11)),
assertz(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_4) :-
assertz(happensAtIE(win_lottery(chris), 9)),
assertz(happensAtIE(win_lottery(chris), 13)),
assertz(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_5) :-
assertz(happensAtIE(win_lottery(chris), 1)),
assertz(happensAtIE(win_lottery(chris), 4)),
assertz(happensAtIE(win_lottery(chris), 7)),
assertz(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_6) :-
assertz(happensAtIE(win_lottery(chris), 1)),
assertz(happensAtIE(win_lottery(chris), 4)),
assertz(happensAtIE(win_lottery(chris), 7)).

updateSDE(deadlines_rich_7) :-
assertz(happensAtIE(win_lottery(chris), 1)),
assertz(happensAtIE(win_lottery(chris), 4)),
assertz(happensAtIE(win_lottery(chris), 7)),
assertz(happensAtIE(lose_wallet(chris), 8)).

updateSDE(deadlines_rich_8) :-
assertz(happensAtIE(win_lottery(chris), 1)),
assertz(happensAtIE(win_lottery(chris), 4)),
assertz(happensAtIE(lose_wallet(chris), 6)),
assertz(happensAtIE(win_lottery(chris), 7)).

updateSDE(deadlines_working_1) :-
assertz(happensAtIE(starts_working(chris), 9)),
assertz(happensAtIE(ends_working(chris), 21)).

updateSDE(deadlines_working_2) :-
assertz(happensAtIE(starts_working(chris), 9)),
assertz(happensAtIE(ends_working(chris), 14)).

updateSDE(deadlines_working_3) :-
assertz(happensAtIE(starts_working(chris), 9)),
assertz(happensAtIE(starts_working(chris), 12)),
assertz(happensAtIE(ends_working(chris), 21)).

updateSDE(deadlines_working_4) :-
assertz(happensAtIE(starts_working(chris), 9)),
assertz(happensAtIE(starts_working(chris), 17)),
assertz(happensAtIE(ends_working(chris), 21)).


updateSDE(deadlines_working_5) :-
assertz(happensAtIE(starts_working(chris), 2)),
assertz(happensAtIE(starts_working(chris), 7)),
assertz(happensAtIE(ends_working(chris), 15)).

updateSDE(deadlines_working_6) :-
assertz(happensAtIE(starts_working(chris), 1)),
assertz(happensAtIE(starts_working(chris), 4)),
assertz(happensAtIE(starts_working(chris), 7)).

updateSDE(deadlines_working_7) :-
assertz(happensAtIE(starts_working(chris), 1)),
assertz(happensAtIE(starts_working(chris), 4)),
assertz(happensAtIE(starts_working(chris), 6)),
assertz(happensAtIE(ends_working(chris), 8)).

updateSDE(deadlines_working_8) :-
assertz(happensAtIE(starts_working(chris), 1)),
assertz(happensAtIE(starts_working(chris), 4)),
assertz(happensAtIE(ends_working(chris), 6)),
assertz(happensAtIE(starts_working(chris), 7)).

