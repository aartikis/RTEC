
initiatedAt(strength(_X)=full,T1,-1,T2):-
    T1=<(-1), -1<T2.

initiatedAt(strength(X)=tired,T):-
    happensAt(ends_working(X),T),
    holdsAt(strength(X)=lowering,T).

initiatedAt(strength(X)=lowering,T):-
    happensAt(starts_working(X),T),
    holdsAt(strength(X)=full,T).

initiatedAt(strength(X)=full,T):-
    happensAt(sleep_end(X),T),
    holdsAt(strength(X)=tired,T).

grounding(ends_working(X)):-
    person(X).
grounding(starts_working(X)):-
    person(X).
grounding(sleep_end(X)):-
    person(X).

grounding(strength(X)=tired):-
    person(X).
grounding(strength(X)=lowering):-
    person(X).
grounding(strength(X)=full):-
    person(X).

