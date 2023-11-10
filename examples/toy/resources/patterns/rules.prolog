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

holdsFor(rich_before_pub(X)=true, I) :-
    holdsFor(rich(X)=true, Ir),
    holdsFor(location(X)=pub,Ip),
    before(Ir, Ip, union, I).

%holdsFor(rich_before_pub_before_home(X)=true, I) :-
%    holdsFor(rich(X)=true, Ir),
%    holdsFor(location(X)=pub,Ip),
%    before(Ir, Ip, target, Iinter),
%    holdsFor(location(X)=home, Ih),
%    before(Iinter, Ih, target, I).

holdsFor(rich_starts_happy(X)=true, I) :-
    holdsFor(rich(X)=true, Ir),
    holdsFor(happy(X)=true, Ih),
    starts(Ir, Ih, source, I).

holdsFor(rich_finishes_happy(X)=true, I) :-
    holdsFor(rich(X)=true, Ir),
    holdsFor(happy(X)=true, Ih),
    finishes(Ir, Ih, source, I).

holdsFor(pub_during_happy(X)=true, I) :-
    holdsFor(location(X)=pub, Ip),
    holdsFor(happy(X)=true, Ih),
    during(Ip, Ih, source, I).

holdsFor(rich_overlaps_pub(X)=true, I) :-
    holdsFor(rich(X)=true, Ir),
    holdsFor(location(X)=pub, Ip),
    overlaps(Ir, Ip, union, I).

holdsFor(rich_equal_happy(X)=true, I) :-
    holdsFor(rich(X)=true, Ir),
    holdsFor(happy(X)=true, Ih),
    equal(Ir, Ih, source, I).

% The elements of these domains are derived from the ground arguments of input entitites
dynamicDomain(person(_)).

% Grounding of input entities 
grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(lose_wallet(Person)) :- person(Person).
grounding(win_lottery(Person)) :- person(Person).

% Grounding of output entities
grounding(location(Person)=Place) :- person(Person), place(Place).
grounding(rich(Person)=true)      :- person(Person).
grounding(happy(Person)=true)     :- person(Person).
grounding(rich_before_pub(Person)=true)     :- person(Person).
grounding(rich_before_pub_before_home(Person)=true):- person(Person).
grounding(rich_starts_happy(Person)=true)     :- person(Person).
grounding(rich_finishes_happy(Person)=true)     :- person(Person).
grounding(pub_during_happy(Person)=true)     :- person(Person).
grounding(rich_overlaps_pub(Person)=true)     :- person(Person).
grounding(rich_equal_happy(Person)=true)     :- person(Person).

% Index facts are optional 
index(go_to(_, Place), Place).
