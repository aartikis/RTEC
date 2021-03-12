

updateSDE(negotiation_3, 0, 10) :-
  assert(happensAtIE( present_quote(1, 6, book6, 10), 1 )),
  assert(happensAtIE( present_quote(1, 6, book6, 10), 3 )),
  assert(happensAtIE( present_quote(1, 6, book6, 10), 4 )),
  assert(happensAtIE( present_quote(1, 6, book6, 10), 6 )),
  assert(happensAtIE( present_quote(1, 6, book6, 10), 8 )),
  assert(happensAtIE( present_quote(1, 6, book6, 8), 9 )),
  assert(happensAtIE( present_quote(1, 6, book6, 4), 10 )).

updateSDE(negotiation_3, 10, 20) :-
  assert(happensAtIE( present_quote(1, 6, book6, 10), 13 )).


