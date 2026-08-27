

updateSDE(negotiation_2, 0, 10) :-
  assertz(happensAtIE( present_quote(1, 6, book6, 10), 8 )),
  assertz(happensAtIE( present_quote(1, 6, book6, 8), 9 )),
  assertz(happensAtIE( present_quote(1, 6, book6, 4), 10 )).

updateSDE(negotiation_2, 10, 20) :-
  assertz(happensAtIE( accept_quote(6, 1, book6), 11 )),
  assertz(happensAtIE( present_quote(1, 6, book6, 10), 12 )).


