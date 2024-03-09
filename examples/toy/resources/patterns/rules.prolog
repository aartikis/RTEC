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

% The elements of these domains are derived from the ground arguments of input entitites
%dynamicDomain(person(_)).

% Grounding of input entities 
grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(lose_wallet(Person)) :- person(Person).
grounding(win_lottery(Person)) :- person(Person).

% Grounding of output entities
grounding(location(Person)=pub) :- person(Person).
grounding(location(Person)=home) :- person(Person).
grounding(location(Person)=work) :- person(Person).
grounding(rich(Person)=true)      :- person(Person).
grounding(happy(Person)=true)     :- person(Person).

% Index facts are optional 
index(go_to(_, Place), Place).
