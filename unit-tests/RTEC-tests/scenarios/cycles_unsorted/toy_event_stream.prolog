updateSDE(unsorted_cycles_1) :-
    assertz(happensAtIE(sleep_end(chris), 18)),
    assertz(happensAtIE(starts_working(chris), 9)),
    assertz(happensAtIE(ends_working(chris), 14)),
    assertz(happensAtIE(sleep_start(chris), 15)).

updateSDE(unsorted_cycles_1,10) :-
    assertz(happensAtIE(sleep_end(chris), 18)).
updateSDE(unsorted_cycles_1,20):-
    assertz(happensAtIE(ends_working(chris), 14)),
    assertz(happensAtIE(sleep_start(chris), 15)),
    assertz(happensAtIE(starts_working(chris), 9)).
