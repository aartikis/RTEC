initiatedAt(quote(M, C, GD)=true, T1, T, T2) :-
     happensAtIE(present_quote(M, C, GD), T),
     T1=<T,
     T<T2.

initiatedAt(quote(M, C, GD)=false, T1, T, T2) :-
     happensAtIE(accept_quote(C, M, GD), T),
     T1=<T,
     T<T2.

cachingOrder2(M, quote(M, C, GD)=true) :-
     person_pair(M, C), role_of(M, merchant),role_of(C,consumer), queryGoodsDescription(GD).
