initiatedAt(working(X)=true, T):-
    happensAt(starts_working(X),T).

terminatedAt(working(X)=true, T) :-
    happensAt(ends_working(X), T).

fi(working(X)=true,working(X)=false,8).

grounding(starts_working(X)):-
    person(X).

grounding(ends_working(X)):-
    person(X).

grounding(working(X)=true):-
    person(X).

grounding(working(X)=false):-
    person(X).
