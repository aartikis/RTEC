updateSDE(cycles_deadlines_1) :-
    assertz(happensAtIE(smell_bacon(chris), 1)),
    assertz(happensAtIE(found_bacon(chris), 3)),
    assertz(happensAtIE(ate_bacon(chris), 10)),
    assertz(happensAtIE(ate_food(chris), 10)),
    assertz(happensAtIE(smell_bacon(chris), 12)).
%    assertz(happensAtIE(needsFood(chris), 15)).

updateSDE(cycles_deadlines_2) :-
    assertz(happensAtIE(smell_bacon(chris), 1)),
    assertz(happensAtIE(found_bacon(chris), 3)),
    assertz(happensAtIE(ate_bacon(chris), 8)),
    assertz(happensAtIE(ate_food(chris), 8)),
    assertz(happensAtIE(smell_bacon(chris), 16)).

updateSDE(cycles_deadlines_3) :-
    assertz(happensAtIE(smell_bacon(chris), 1)),
    assertz(happensAtIE(found_bacon(chris), 3)),
    assertz(happensAtIE(ate_food(chris), 7)),
    assertz(happensAtIE(ate_food(chris), 8)).

updateSDE(cycles_deadlines_4) :-
    assertz(happensAtIE(smell_bacon(chris), 1)),
    assertz(happensAtIE(found_bacon(chris), 3)),
    assertz(happensAtIE(ate_food(chris), 7)),
    assertz(happensAtIE(ate_food(chris), 10)).

updateSDE(cycles_deadlines_5) :-
    assertz(happensAtIE(smell_bacon(chris), 1)),
    assertz(happensAtIE(smell_bacon(chris), 5)).
