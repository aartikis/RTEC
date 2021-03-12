

:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.


initiatedAt(strength(X)=tired, T1, T, T2) :-
    happensAtIE(ends_working(X),T),
    T1=<T,T<T2,
    holdsAtCyclic(X,strength(X)=lowering,T).
initiatedAt(strength(X)=lowering, T1, T, T2) :-
    happensAtIE(starts_working(X),T),
    T1=<T,T<T2,
    holdsAtCyclic(X,strength(X)=full,T).
initiatedAt(strength(X)=full, T1, T, T2) :-
    happensAtIE(sleep_end(X),T),
    T1=<T,T<T2,
    holdsAtCyclic(X,strength(X)=tired,T).

initiatedAt(strength(_X)=full, T1, -1, T2) :-
    T1=< -1,
    -1<T2.

cachingOrder2(X, strength(X)=full) :-person(X).
cachingOrder2(X, strength(X)=tired) :-person(X).
cachingOrder2(X, strength(X)=lowering) :-person(X).

