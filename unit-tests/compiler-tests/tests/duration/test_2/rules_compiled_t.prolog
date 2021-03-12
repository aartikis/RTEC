

:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2,maxDuration/3,maxDurationUE/3.

initiatedAt(rich(X)=true, T1, T, T2) :-
    happensAtIE(win_lottery(X),T),
    T1=<T,
    T<T2.
terminatedAt(rich(X)=true, T1, T, T2) :-
    happensAtIE(lose_wallet(X),T),
    T1=<T,
    T<T2.
maxDurationUE(rich(X)=true,rich(X)=false,4) :- grounding(rich(X)=true).
