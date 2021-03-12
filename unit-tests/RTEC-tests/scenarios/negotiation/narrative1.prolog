

updateSDE(negotiation_1, 0, 10) :-
  assert(happensAtIE( request_quote(6, 1, book6), 4 )),
  assert(happensAtIE( present_quote(1, 6, book6, 10), 5 )),
  assert(happensAtIE( present_quote(1, 4, book6, 10), 6 )),
  assert(happensAtIE( request_quote(6, 1, book6), 7 )),
  assert(happensAtIE( accept_quote(6, 1, book6), 8 )),
  assert(happensAtIE( present_quote(1, 6, book6, 4), 10 )).

updateSDE(negotiation_1, 10, 20) :-
  assert(happensAtIE( send_goods(1, iServer, book6, book_content, key), 11 )),
  assert(happensAtIE( send_EPO(6, iServer, book6, 10 ), 11 )),
  assert(happensAtIE( accept_quote(6, 1, book6), 15 )).


