

updateSDE(negotiation_2, 0, 10) :-
  assert(happensAtIE( present_quote(1, 6, book6, 10), 8 )),
  assert(happensAtIE( present_quote(1, 6, book6, 8), 9 )),
  assert(happensAtIE( present_quote(1, 6, book6, 4), 10 )).

updateSDE(negotiation_2, 10, 20) :-
  assert(happensAtIE( accept_quote(6, 1, book6), 11 )),
  assert(happensAtIE( present_quote(1, 6, book6, 10), 12 )).


