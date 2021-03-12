updateSDE(unsorted_cycles_1) :-
    assert(happensAtIE(sleep_end(chris), 18)),
    assert(happensAtIE(starts_working(chris), 9)),
    assert(happensAtIE(ends_working(chris), 14)),
    assert(happensAtIE(sleep_start(chris), 15)).

updateSDE(unsorted_cycles_1,10) :-
    assert(happensAtIE(sleep_end(chris), 18)).
updateSDE(unsorted_cycles_1,20):-
    assert(happensAtIE(ends_working(chris), 14)),
    assert(happensAtIE(sleep_start(chris), 15)),
    assert(happensAtIE(starts_working(chris), 9)).
