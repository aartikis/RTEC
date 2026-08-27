:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

holdsFor(drunk(X)=true,I) :-
    holdsFor(happy(X)=true,I1),
    holdsFor(infiniteBeers(X)=true,I2),
    intersect_all([I1,I2], I).

grounding(happy(Person)=true):-
    person(Person).

grounding(infiniteBeers(Person)=true):-
    person(Person).

grounding(drunk(Person)=true):-
    person(Person).

