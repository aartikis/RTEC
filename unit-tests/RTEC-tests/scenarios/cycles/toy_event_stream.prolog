updateSDE(cycles_strength_1) :-
    assert(happensAtIE(starts_working(chris), 9)),
    assert(happensAtIE(ends_working(chris), 14)),
    assert(happensAtIE(sleep_start(chris), 15)),
    assert(happensAtIE(sleep_end(chris), 18)).



updateSDE(cycles_strength_2) :-
    assert(happensAtIE(starts_working(chris), 9)),
    assert(happensAtIE(ends_working(chris), 9)),
    assert(happensAtIE(sleep_start(chris), 15)),
    assert(happensAtIE(sleep_end(chris), 18)).


updateSDE(cycles_big_1) :-
    assert(happensAtIE(smell_bacon(chris), 1)),
    assert(happensAtIE(found_bacon(chris), 7)),
    assert(happensAtIE(ate_bacon(chris), 10)),
    assert(happensAtIE(smell_bacon(chris), 12)),
    assert(happensAtIE(needsFood(chris), 15)).

updateSDE(cycles_big_2) :-
    assert(happensAtIE(smell_bacon(chris), 1)),
    assert(happensAtIE(found_bacon(chris), 7)),
    assert(happensAtIE(ate_bacon(chris), 1)),
    assert(happensAtIE(smell_bacon(chris), 12)),
    assert(happensAtIE(needsFood(chris), 15)).
