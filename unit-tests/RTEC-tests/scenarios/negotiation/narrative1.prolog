

updateSDE(negotiation_1, 0, 10) :-
  assertz(happensAtIE( request_quote(6, 1, book6), 4 )),
  assertz(happensAtIE( present_quote(1, 6, book6, 10), 5 )),
  assertz(happensAtIE( present_quote(1, 4, book6, 10), 6 )),
  assertz(happensAtIE( request_quote(6, 1, book6), 7 )),
  assertz(happensAtIE( accept_quote(6, 1, book6), 8 )),
  assertz(happensAtIE( present_quote(1, 6, book6, 4), 10 )).

updateSDE(negotiation_1, 10, 20) :-
  assertz(happensAtIE( send_goods(1, iServer, book6, book_content, key), 11 )),
  assertz(happensAtIE( send_EPO(6, iServer, book6, 10 ), 11 )),
  assertz(happensAtIE( accept_quote(6, 1, book6), 15 )).


