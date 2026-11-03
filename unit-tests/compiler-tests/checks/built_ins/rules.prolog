% union_all with three arguments.
holdsFor(happy(X)=true, I) :-
    holdsFor(rich(X)=true, I1),
    holdsFor(location(X)=pub, I2),
    union_all(I1, [I2], I).

% A single interval list where a list of interval lists is needed.
holdsFor(content(X)=true, I) :-
    holdsFor(rich(X)=true, I1),
    union_all(I1, I).

% holdsAt of a fluent without a value.
initiatedAt(location(X)=pub, T) :-
    happensAt(go_to(X, pub), T),
    \+ holdsAt(rich(X), T).

% happensAt of a fluent-value pair.
terminatedAt(rich(X)=true, T) :-
    happensAt(location(X)=pub, T).

% The start of a fluent without a value.
initiatedAt(tired(X)=true, T) :-
    happensAt(start(location(X)), T).

% An output mode of an Allen relation that the code does not accept.
holdsFor(drinking(X)=true, I) :-
    holdsFor(location(X)=pub, I1),
    holdsFor(rich(X)=true, I2),
    during(I1, I2, intersect, I).

% An Allen relation outside a holdsFor rule.
initiatedAt(lucky(X)=true, T) :-
    happensAt(win_lottery(X), T),
    allen(before, [(1,5)], [(6,9)], source, _I).

% holdsAt without a time-point.
initiatedAt(cheerful(X)=true, T) :-
    happensAt(win_lottery(X), T),
    holdsAt(rich(X)=true).

grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(win_lottery(Person)) :- person(Person).
grounding(location(Person)=pub) :- person(Person).
grounding(rich(Person)=true) :- person(Person).
grounding(happy(Person)=true) :- person(Person).
grounding(content(Person)=true) :- person(Person).
grounding(tired(Person)=true) :- person(Person).
grounding(drinking(Person)=true) :- person(Person).
grounding(lucky(Person)=true) :- person(Person).
grounding(cheerful(Person)=true) :- person(Person).
