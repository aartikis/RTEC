updateSDE(deadlines_rich_1) :-
assert(happensAtIE(win_lottery(chris), 9)),
assert(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_2) :-
assert(happensAtIE(win_lottery(chris), 9)),
assert(happensAtIE(lose_wallet(chris), 11)).

updateSDE(deadlines_rich_3) :-
assert(happensAtIE(win_lottery(chris), 9)),
assert(happensAtIE(win_lottery(chris), 11)),
assert(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_4) :-
assert(happensAtIE(win_lottery(chris), 9)),
assert(happensAtIE(win_lottery(chris), 13)),
assert(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_5) :-
assert(happensAtIE(win_lottery(chris), 1)),
assert(happensAtIE(win_lottery(chris), 4)),
assert(happensAtIE(win_lottery(chris), 7)),
assert(happensAtIE(lose_wallet(chris), 21)).

updateSDE(deadlines_rich_6) :-
assert(happensAtIE(win_lottery(chris), 1)),
assert(happensAtIE(win_lottery(chris), 4)),
assert(happensAtIE(win_lottery(chris), 7)).

updateSDE(deadlines_rich_7) :-
assert(happensAtIE(win_lottery(chris), 1)),
assert(happensAtIE(win_lottery(chris), 4)),
assert(happensAtIE(win_lottery(chris), 7)),
assert(happensAtIE(lose_wallet(chris), 8)).

updateSDE(deadlines_rich_8) :-
assert(happensAtIE(win_lottery(chris), 1)),
assert(happensAtIE(win_lottery(chris), 4)),
assert(happensAtIE(lose_wallet(chris), 6)),
assert(happensAtIE(win_lottery(chris), 7)).

updateSDE(deadlines_working_1) :-
assert(happensAtIE(starts_working(chris), 9)),
assert(happensAtIE(ends_working(chris), 21)).

updateSDE(deadlines_working_2) :-
assert(happensAtIE(starts_working(chris), 9)),
assert(happensAtIE(ends_working(chris), 14)).

updateSDE(deadlines_working_3) :-
assert(happensAtIE(starts_working(chris), 9)),
assert(happensAtIE(starts_working(chris), 12)),
assert(happensAtIE(ends_working(chris), 21)).

updateSDE(deadlines_working_4) :-
assert(happensAtIE(starts_working(chris), 9)),
assert(happensAtIE(starts_working(chris), 17)),
assert(happensAtIE(ends_working(chris), 21)).


updateSDE(deadlines_working_5) :-
assert(happensAtIE(starts_working(chris), 2)),
assert(happensAtIE(starts_working(chris), 7)),
assert(happensAtIE(ends_working(chris), 15)).

updateSDE(deadlines_working_6) :-
assert(happensAtIE(starts_working(chris), 1)),
assert(happensAtIE(starts_working(chris), 4)),
assert(happensAtIE(starts_working(chris), 7)).

updateSDE(deadlines_working_7) :-
assert(happensAtIE(starts_working(chris), 1)),
assert(happensAtIE(starts_working(chris), 4)),
assert(happensAtIE(starts_working(chris), 6)),
assert(happensAtIE(ends_working(chris), 8)).

updateSDE(deadlines_working_8) :-
assert(happensAtIE(starts_working(chris), 1)),
assert(happensAtIE(starts_working(chris), 4)),
assert(happensAtIE(ends_working(chris), 6)),
assert(happensAtIE(starts_working(chris), 7)).

