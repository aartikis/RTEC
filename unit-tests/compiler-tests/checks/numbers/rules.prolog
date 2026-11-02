% A name where a number is needed.
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X, Amount), T),
    Amount > richThreshold.

% Evaluable constants are numbers: no warning.
initiatedAt(lucky(X)=true, T) :-
    happensAt(win_lottery(X, Amount), T),
    Amount > pi.

% A name on the right of is.
initiatedAt(budget(X)=B, T) :-
    happensAt(win_lottery(X, Amount), T),
    B is Amount * taxRate.

% An interval list where a number is needed.
holdsFor(happy(X)=true, I) :-
    holdsFor(rich(X)=true, I1),
    I1 \= [],
    I1 > 0,
    union_all([I1], I).

grounding(win_lottery(Person, _Amount)) :- person(Person).
grounding(rich(Person)=true) :- person(Person).
grounding(lucky(Person)=true) :- person(Person).
grounding(budget(Person)=_B) :- person(Person).
grounding(happy(Person)=true) :- person(Person).
