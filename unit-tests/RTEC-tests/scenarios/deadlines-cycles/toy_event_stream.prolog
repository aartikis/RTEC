updateSDE(cycles_deadlines_1) :-
    assert(happensAtIE(smell_bacon(chris), 1)),
    assert(happensAtIE(found_bacon(chris), 3)),
    assert(happensAtIE(ate_bacon(chris), 10)),
    assert(happensAtIE(ate_food(chris), 10)),
    assert(happensAtIE(smell_bacon(chris), 12)).
%    assert(happensAtIE(needsFood(chris), 15)).

updateSDE(cycles_deadlines_2) :-
    assert(happensAtIE(smell_bacon(chris), 1)),
    assert(happensAtIE(found_bacon(chris), 3)),
    assert(happensAtIE(ate_bacon(chris), 8)),
    assert(happensAtIE(ate_food(chris), 8)),
    assert(happensAtIE(smell_bacon(chris), 16)).

updateSDE(cycles_deadlines_3) :-
    assert(happensAtIE(smell_bacon(chris), 1)),
    assert(happensAtIE(found_bacon(chris), 3)),
    assert(happensAtIE(ate_food(chris), 7)),
    assert(happensAtIE(ate_food(chris), 8)).

updateSDE(cycles_deadlines_4) :-
    assert(happensAtIE(smell_bacon(chris), 1)),
    assert(happensAtIE(found_bacon(chris), 3)),
    assert(happensAtIE(ate_food(chris), 7)),
    assert(happensAtIE(ate_food(chris), 10)).

updateSDE(cycles_deadlines_5) :-
    assert(happensAtIE(smell_bacon(chris), 1)),
    assert(happensAtIE(smell_bacon(chris), 5)).
