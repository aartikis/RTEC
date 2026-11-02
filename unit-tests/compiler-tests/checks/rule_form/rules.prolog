% The first condition of an initiatedAt rule is not a happensAt.
initiatedAt(rich(X)=true, T) :-
    holdsAt(location(X)=pub, T),
    happensAt(win_lottery(X), T).

% A holdsAt condition at a time-point other than the one of the head.
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T),
    \+ holdsAt(location(X)=home, T1).

% A holdsFor rule with a condition evaluated at a time-point.
holdsFor(happy(X)=true, I) :-
    holdsFor(rich(X)=true, I1),
    happensAt(win_lottery(X), _T),
    union_all([I1], I).

% The body of a holdsFor rule does not compute the interval list of the head.
holdsFor(sad(X)=true, I) :-
    holdsFor(rich(X)=false, _I1).

% A head without a value.
initiatedAt(location(X), T) :-
    happensAt(go_to(X, _Place), T).

% A background predicate first: the compiler attaches the time window to it, not to the happensAt.
initiatedAt(cheerful(X)=true, T) :-
    person(X),
    happensAt(win_lottery(X), T).

% happensAt rules whose first condition is a holdsAt, or a negation.
happensAt(celebrate(X), T) :-
    holdsAt(rich(X)=true, T),
    happensAt(win_lottery(X), T).
happensAt(complain(X), T) :-
    \+ happensAt(win_lottery(X), T),
    happensAt(lose_wallet(X), T).

% A start event inside a negation of several conditions.
initiatedAt(calm(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+ (happensAt(start(rich(X)=true), T), person(X)).

grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(lose_wallet(Person)) :- person(Person).
grounding(win_lottery(Person)) :- person(Person).
grounding(rich(Person)=true) :- person(Person).
grounding(happy(Person)=true) :- person(Person).
grounding(sad(Person)=true) :- person(Person).
grounding(cheerful(Person)=true) :- person(Person).
grounding(celebrate(Person)) :- person(Person).
grounding(complain(Person)) :- person(Person).
grounding(calm(Person)=true) :- person(Person).
