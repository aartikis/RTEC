% Rules defining output entities
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T).

terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).

initiatedAt(location(X)=Y, T) :-
    happensAt(go_to(X,Y), T).

holdsFor(happy(X)=true, I) :-
    holdsFor(rich(X)=true, I1),
    holdsFor(location(X)=pub, I2),
    union_all([I1,I2], I).

initiatedAt(shappy(X)=true,T):-
    happensAt(startI(happy(X)=true),T).
terminatedAt(shappy(X)=true,T):-
    happensAt(end(happy(X)=true),T).

% Grounding of input entities 
grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(lose_wallet(Person)) :- person(Person).
grounding(win_lottery(Person)) :- person(Person).

% Grounding of output entities
grounding(location(Person)=Place) :- person(Person), place(Place).
grounding(rich(Person)=true)      :- person(Person).
grounding(happy(Person)=true)     :- person(Person).
grounding(shappy(Person)=true)     :- person(Person).

