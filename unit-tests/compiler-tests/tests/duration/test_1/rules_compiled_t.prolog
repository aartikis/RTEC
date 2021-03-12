

:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2,maxDuration/3,maxDurationUE/3.

initiatedAt(working(X)=true, T1, T, T2) :-
    happensAtIE(starts_working(X),T),
    T1=<T,
    T<T2.
terminatedAt(working(X)=true, T1, T, T2) :-
    happensAtIE(ends_working(X),T),
    T1=<T,
    T<T2.
maxDuration(working(X)=true,working(X)=false,8) :- grounding(working(X)=true).
