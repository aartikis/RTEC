%%%%%% sleeping
initiatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_start(X),T).
terminatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_end(X),T).

grounding(sleep_start(X)):-
    person(X).
grounding(sleep_end(X)):-
    person(X).

grounding(sleeping(X)=true):-
    person(X).
