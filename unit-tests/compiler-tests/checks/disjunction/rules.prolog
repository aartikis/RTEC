% A disjunction in the body of an initiatedAt rule.
initiatedAt(rich(X)=true, T) :-
    (   happensAt(win_lottery(X), T)
    ;   happensAt(inherit(X), T)
    ).

% A disjunction in the body of a holdsFor rule.
holdsFor(happy(X)=true, I) :-
    (   holdsFor(rich(X)=true, I)
    ;   holdsFor(location(X)=pub, I)
    ).

% The bodies of holdsAt rules support disjunction: no warning.
holdsAt(content(X)=true, T) :-
    (   holdsAt(rich(X)=true, T)
    ;   holdsAt(location(X)=pub, T)
    ).

% The compiler drops a holdsAt rule with '->', also inside a ';'.
holdsAt(calm(X)=true, T) :-
    (   holdsAt(rich(X)=true, T)
    ->  holdsAt(location(X)=home, T)
    ;   holdsAt(location(X)=pub, T)
    ).

% A ';' next to other conditions.
initiatedAt(lucky(X)=true, T) :-
    happensAt(win_lottery(X), T),
    (   holdsAt(location(X)=pub, T)
    ;   holdsAt(location(X)=home, T)
    ).

% An if-then-else.
initiatedAt(careful(X)=true, T) :-
    (   happensAt(win_lottery(X), T)
    ->  true
    ;   happensAt(inherit(X), T)
    ).

% A start event in a happensAt rule whose body is a ';'.
happensAt(cheer(X), T) :-
    (   happensAt(start(rich(X)=true), T)
    ;   happensAt(inherit(X), T)
    ).

% An end event inside a negated ';'.
initiatedAt(steady(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+ (happensAt(end(rich(X)=true), T) ; happensAt(inherit(X), T)).

grounding(win_lottery(Person)) :- person(Person).
grounding(inherit(Person)) :- person(Person).
grounding(rich(Person)=true) :- person(Person).
grounding(happy(Person)=true) :- person(Person).
grounding(calm(Person)=true) :- person(Person).
grounding(lucky(Person)=true) :- person(Person).
grounding(careful(Person)=true) :- person(Person).
grounding(cheer(Person)) :- person(Person).
grounding(steady(Person)=true) :- person(Person).
