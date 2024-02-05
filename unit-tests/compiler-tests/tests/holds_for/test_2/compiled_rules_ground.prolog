:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

holdsForSDFluent(drunk(Person)=true,I) :-
    holdsForProcessedIE(Person,happy(Person)=true,I1),
    holdsForProcessedIE(Person,infiniteBeers(Person)=true,I2),
    intersect_all([I1,I2],I).

grounding(happy(Person)=true):-
    person(Person).

grounding(infiniteBeers(Person)=true):-
    person(Person).

grounding(drunk(Person)=true):-
    person(Person).

inputEntity(happy(_Person)=true).
inputEntity(infiniteBeers(_Person)=true).

outputEntity(drunk(_Person)=true).

sDFluent(drunk(_Person)=true).
sDFluent(happy(_Person)=true).
sDFluent(infiniteBeers(_Person)=true).

index(drunk(Person)=true, Person).
index(happy(Person)=true, Person).
index(infiniteBeers(Person)=true, Person).

cachingOrder2(Person, drunk(Person)=true) :- person(Person).

