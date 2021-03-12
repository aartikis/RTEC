

updateSDE(negotiation_5, 0, 10) :-
  assert(happensAtIE( present_quote(1, 6, book6, 5), 8 )),
  assert(happensAtIE( send_EPO(1, iServer, book, 10 ), 3 )),
  assert(happensAtIE( present_quote(1, 6, book, 5), 1 )),
  assert(happensAtIE( present_quote(1, 6, book, 5), 2 )),
  % note that the merchant issues the request below (which is meaningless)
  assert(happensAtIE( request_quote(1, 6, book6), 4 )),
  assert(happensAtIE( request_quote(6, 1, book6), 7 )),
  assert(happensAtIE( present_quote(1, 6, book6, 5), 5 )),
  % no contract is established by the acceptance below since agent is suspended
  assert(happensAtIE( accept_quote(6, 1, book), 5 )),
  assert(happensAtIE( present_quote(1, 6, book6, 5), 6 )),
  % no contract is established by the acceptance below since agent is suspended
  assert(happensAtIE( accept_quote(6, 1, book), 9 )).

updateSDE(negotiation_5, 10, 20) :-
  assert(happensAtIE( present_quote(2, 1, book7, 5), 18 )),
  % this event below delayed/out of \omega and thus not considered
  assert(happensAtIE( present_quote(1, 6, book6, 5), 10 )),
  assert(happensAtIE( present_quote(1, 1, book6, 5), 18 )),
  assert(happensAtIE( send_goods(2, iServer, book2, book_content, key), 13 )),
  assert(happensAtIE( send_goods(2, iServer, book1, enc_book_content, key), 14 )),
  % agent 2 is not in the static information and thus we have no ground info for it
  assert(happensAtIE( present_quote(2, 1, book10, 5), 15 )),
  assert(happensAtIE( send_EPO(c1, iServer, book1, 6 ), 16 )),
  assert(happensAtIE( present_quote(1, 1, book6, 5), 19 )),
  assert(happensAtIE( present_quote(2, 1, book4, 5), 20 )).


