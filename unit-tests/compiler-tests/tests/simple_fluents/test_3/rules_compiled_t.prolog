:-dynamic initiatedAt/4, terminatedAt/4.
initiatedAt(shappy(X)=true, T1, T, T2) :-
    happensAtProcessedSDFluent(X,startI(happy(X)=true),T),
    T1=<T,
    T<T2.
terminatedAt(shappy(X)=true, T1, T, T2) :-
    happensAtProcessedSDFluent(X,end(happy(X)=true),T),
    T1=<T,
    T<T2.

cachingOrder2(X, shappy(X)=true) :-person(X).


