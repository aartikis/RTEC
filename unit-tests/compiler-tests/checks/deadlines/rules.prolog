initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T).

initiatedAt(location(X)=Place, T) :-
    happensAt(go_to(X, Place), T).

holdsFor(happy(X)=true, I) :-
    holdsFor(rich(X)=true, I).

initiatedAt(tired(X)=true, T) :-
    happensAt(go_to(X, gym), T).

% The two sides are different fluents.
fi(rich(X)=true, happy(X)=false, 10).

% The arguments of the two sides never match.
fi(location(alice)=pub, location(bob)=home, 10).

% The two sides match once their variables are unified: no warning.
fi(location(_X)=bar, location(_Y)=home, 10).

% The duration is a name.
fi(location(X)=work, location(X)=home, workTime).

% The duration is never bound.
fi(location(X)=gym, location(X)=home, Duration).

% The duration is not a positive integer.
fi(location(X)=school, location(X)=home, 0).

% A fi on a fluent-value pair defined by holdsFor rules.
fi(happy(X)=true, happy(X)=false, 5).

% A p without a fi.
p(location(_X)=home).

% A fi as a condition.
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T),
    fi(rich(X)=true, rich(X)=false, 5).

% The target value has no grounding.
fi(tired(X)=true, tired(X)=false, 20).

grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(win_lottery(Person)) :- person(Person).
grounding(lose_wallet(Person)) :- person(Person).
grounding(rich(Person)=true) :- person(Person).
grounding(tired(Person)=true) :- person(Person).
grounding(happy(Person)=true) :- person(Person).
grounding(happy(Person)=false) :- person(Person).
grounding(location(Person)=Place) :- person(Person), place(Place).
