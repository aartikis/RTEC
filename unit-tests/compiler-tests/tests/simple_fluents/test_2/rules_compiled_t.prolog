:-dynamic initiatedAt/4, terminatedAt/4.

initiatedAt(rich(X)=true, T1, T, T2) :-
    happensAtIE(win_lottery(X),T),T1=<T,T<T2,
    \+holdsAtProcessedSimpleFluent(X,sleeping(X)=true,T).
terminatedAt(rich(X)=true, T1, T, T2) :-
    happensAtIE(lose_wallet(X),T),
    T1=<T,
    T<T2.


cachingOrder2(X, rich(X)=true) :-person(X).
cachingOrder2(X, rich(X)=false) :-person(X).


