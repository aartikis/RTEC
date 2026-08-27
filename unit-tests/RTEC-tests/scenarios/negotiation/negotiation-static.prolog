
agent(1).
%agent(2).
%agent(3).
agent(4).
%agent(5).
agent(6).
%agent(7).
%agent(8).
%agent(9).
%agent(10).

role(merchant).
role(consumer).

role_of(C, consumer) :- agent(C).
role_of(M, merchant) :- agent(M).

queryGoodsDescription(book1).
queryGoodsDescription(book2).
queryGoodsDescription(book4).
queryGoodsDescription(book6).
queryGoodsDescription(book7).
queryGoodsDescription(book10).
queryGoodsDescription(book).


price(_, _).
decrypt(_, _, _).
meets(_, _).
