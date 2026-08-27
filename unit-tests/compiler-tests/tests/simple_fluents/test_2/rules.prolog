%%%%%% rich
initiatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_start(X),T).
terminatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_end(X),T).

initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+holdsAt(sleeping(X)=true,T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).

grounding(sleep_start(X)):-
    person(X).
grounding(sleep_end(X)):-
    person(X).
grounding(win_lottery(X)):-
    person(X).
grounding(lose_lottery(X)):-
    person(X).

grounding(sleeping(X)=true):-
    person(X).
grounding(rich(X)=true):-
    person(X).
