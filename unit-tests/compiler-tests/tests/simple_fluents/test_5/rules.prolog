

%%%%%% srich
initiatedAt(srich(X)=true, T) :-
    happensAt(start(rich(X)=true), T).

terminatedAt(srich(X)=true, T) :-
    happensAt(end(rich(X)=true), T).
