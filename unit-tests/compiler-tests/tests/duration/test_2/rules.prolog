
%%%%%% rich
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).

fi(rich(X)=true,rich(X)=false,4).
p(rich(_X)=true).

grounding(win_lottery(X)):-
    person(X).

grounding(lose_lottery(X)):-
    person(X).

grounding(rich(X)=true):-
    person(X).

grounding(rich(X)=false):-
    person(X).
