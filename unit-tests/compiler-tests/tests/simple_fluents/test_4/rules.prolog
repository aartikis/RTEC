% Rules defining output entities
initiatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_start(X),T).
terminatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_end(X),T).

initiatedAt(location(X)=Y, T) :-
    happensAt(go_to(X,Y), T).

holdsFor(sleeping_at_work(X)=true,I):-
    holdsFor(sleeping(X)=true,I1),
    holdsFor(location(X)=work,I2),
    intersect_all([I1,I2],I).

initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+holdsAt(sleeping_at_work(X)=true,T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).

% Grounding of input entities 
grounding(sleep_start(Person)) :- person(Person).
grounding(sleep_end(Person)) :- person(Person).
grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(win_lottery(Person)) :- person(Person).
grounding(lose_wallet(Person)) :- person(Person).

% Grounding of output entities
grounding(sleeping(Person)=true) :- person(Person).
grounding(location(Person)=Place) :- person(Person), place(Place).
grounding(sleeping_at_work(Person)=true) :- person(Person).
grounding(rich(Person)=true) :- person(Person).

