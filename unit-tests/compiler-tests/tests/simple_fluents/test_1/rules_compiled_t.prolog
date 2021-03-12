:-dynamic initiatedAt/4, terminatedAt/4.

initiatedAt(sleeping(X)=true, T1, T, T2) :-
    happensAtIE(sleep_start(X),T),
    T1=<T,
    T<T2.
terminatedAt(sleeping(X)=true, T1, T, T2) :-
    happensAtIE(sleep_end(X),T),
    T1=<T,
    T<T2.

cachingOrder2(X, sleeping(X)=true) :-person(X).


