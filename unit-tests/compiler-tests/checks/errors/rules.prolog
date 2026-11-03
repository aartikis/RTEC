% Mistakes on which the compiler cannot finish. Each one is an error: all of them are reported, and then the
% compilation stops without compiling anything.

initiatedAt(location(X)=Place, T) :-
    happensAt(go_to(X, Place), T).

% A head whose fluent is a variable.
terminatedAt(Fluent=true, T) :-
    happensAt(lose_wallet(X), T),
    Fluent = rich(X).

% A holdsAt condition whose fluent is a variable.
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    holdsAt(Fluent=true, T),
    Fluent = lucky(X).

% An fi whose target fluent is a variable.
fi(rich(X)=true, _Fluent=false, 10).

% An fi whose target matches its source.
fi(location(X)=pub, location(X)=pub, 10).

% Not an error: a variable fluent in the source of an fi, which the body of the fi binds.
fi(Source, rich(X)=false, 10) :-
    Source = (rich(X)=true).

grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(lose_wallet(Person)) :- person(Person).
grounding(win_lottery(Person)) :- person(Person).
grounding(location(Person)=Place) :- person(Person), place(Place).
grounding(rich(Person)=true) :- person(Person).
grounding(rich(Person)=false) :- person(Person).
