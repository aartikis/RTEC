

updateSDE(negotiation_5, 0, 10) :-
  assertz(happensAtIE( present_quote(1, 6, book6, 5), 8 )),
  assertz(happensAtIE( send_EPO(1, iServer, book, 10 ), 3 )),
  assertz(happensAtIE( present_quote(1, 6, book, 5), 1 )),
  assertz(happensAtIE( present_quote(1, 6, book, 5), 2 )),
  % note that the merchant issues the request below (which is meaningless)
  assertz(happensAtIE( request_quote(1, 6, book6), 4 )),
  assertz(happensAtIE( request_quote(6, 1, book6), 7 )),
  assertz(happensAtIE( present_quote(1, 6, book6, 5), 5 )),
  % no contract is established by the acceptance below since agent is suspended
  assertz(happensAtIE( accept_quote(6, 1, book), 5 )),
  assertz(happensAtIE( present_quote(1, 6, book6, 5), 6 )),
  % no contract is established by the acceptance below since agent is suspended
  assertz(happensAtIE( accept_quote(6, 1, book), 9 )).

updateSDE(negotiation_5, 10, 20) :-
  assertz(happensAtIE( present_quote(2, 1, book7, 5), 18 )),
  % this event below delayed/out of \omega and thus not considered
  assertz(happensAtIE( present_quote(1, 6, book6, 5), 10 )),
  assertz(happensAtIE( present_quote(1, 1, book6, 5), 18 )),
  assertz(happensAtIE( send_goods(2, iServer, book2, book_content, key), 13 )),
  assertz(happensAtIE( send_goods(2, iServer, book1, enc_book_content, key), 14 )),
  % agent 2 is not in the static information and thus we have no ground info for it
  assertz(happensAtIE( present_quote(2, 1, book10, 5), 15 )),
  assertz(happensAtIE( send_EPO(c1, iServer, book1, 6 ), 16 )),
  assertz(happensAtIE( present_quote(1, 1, book6, 5), 19 )),
  assertz(happensAtIE( present_quote(2, 1, book4, 5), 20 )).


