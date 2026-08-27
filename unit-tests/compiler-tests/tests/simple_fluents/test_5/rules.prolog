% Rules defining output entities
initiatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_start(X),T).
terminatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_end(X),T).

initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+holdsAt(sleeping(X)=true,T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).

initiatedAt(srich(X)=true, T) :-
    happensAt(start(rich(X)=true), T).
terminatedAt(srich(X)=true, T) :-
    happensAt(end(rich(X)=true), T).

% Grounding of input entities 
grounding(sleep_start(X)):-
    person(X).
grounding(sleep_end(X)):-
    person(X).
grounding(win_lottery(X)):-
    person(X).
grounding(lose_lottery(X)):-
    person(X).

% Grounding of output entities
grounding(sleeping(X)=true):-
    person(X).
grounding(rich(X)=true):-
    person(X).
grounding(srich(X)=true):-
    person(X).
