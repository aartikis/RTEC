updateSDE(cycles_strength_1) :-
    assertz(happensAtIE(starts_working(chris), 9)),
    assertz(happensAtIE(ends_working(chris), 14)),
    assertz(happensAtIE(sleep_start(chris), 15)),
    assertz(happensAtIE(sleep_end(chris), 18)).



updateSDE(cycles_strength_2) :-
    assertz(happensAtIE(starts_working(chris), 9)),
    assertz(happensAtIE(ends_working(chris), 9)),
    assertz(happensAtIE(sleep_start(chris), 15)),
    assertz(happensAtIE(sleep_end(chris), 18)).


updateSDE(cycles_big_1) :-
    assertz(happensAtIE(smell_bacon(chris), 1)),
    assertz(happensAtIE(found_bacon(chris), 7)),
    assertz(happensAtIE(ate_bacon(chris), 10)),
    assertz(happensAtIE(smell_bacon(chris), 12)),
    assertz(happensAtIE(needsFood(chris), 15)).

updateSDE(cycles_big_2) :-
    assertz(happensAtIE(smell_bacon(chris), 1)),
    assertz(happensAtIE(found_bacon(chris), 7)),
    assertz(happensAtIE(ate_bacon(chris), 1)),
    assertz(happensAtIE(smell_bacon(chris), 12)),
    assertz(happensAtIE(needsFood(chris), 15)).
