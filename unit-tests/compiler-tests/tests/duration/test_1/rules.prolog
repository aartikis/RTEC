
%%%%% working
initiatedAt(working(X)=true, T):-
    happensAt(starts_working(X),T).

terminatedAt(working(X)=true, T) :-
    happensAt(ends_working(X), T).

maxDuration(working(X)=true,working(X)=false,8):-
    grounding(working(X)=true).

