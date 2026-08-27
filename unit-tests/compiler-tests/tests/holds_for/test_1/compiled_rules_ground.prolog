:- discontiguous initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

initiatedAt(rich(Person)=true, T1, T, T2) :-
     happensAtIE(win_lottery(Person),T),
     T1=<T,
     T<T2.

terminatedAt(rich(Person)=true, T1, T, T2) :-
     happensAtIE(lose_wallet(Person),T),
     T1=<T,
     T<T2.

initiatedAt(location(Person)=Place, T1, T, T2) :-
     happensAtIE(go_to(Person,Place),T),
     T1=<T,
     T<T2.

holdsForSDFluent(infiniteBeers(X)=true,I) :-
    holdsForProcessedSimpleFluent(X,location(X)=pub,I1),
    holdsForProcessedSimpleFluent(X,rich(X)=true,I2),
    intersect_all([I1,I2],I).

grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(lose_wallet(Person)) :- person(Person).
grounding(win_lottery(Person)) :- person(Person).

grounding(location(Person)=Place) :- person(Person), place(Place).
grounding(rich(Person)=true)      :- person(Person).
grounding(infiniteBeers(Person)=true)      :- person(Person).

inputEntity(win_lottery(_Person)).
inputEntity(go_to(_Person,_Place)).
inputEntity(lose_wallet(_Person)).

outputEntity(rich(_Person)=true).
outputEntity(location(_Person)=_Place).
outputEntity(infiniteBeers(_Person)=true).

event(win_lottery(_Person)).
event(go_to(_Person,_Place)).
event(lose_wallet(_Person)).

simpleFluent(rich(_Person)=true).
simpleFluent(location(_Person)=_5260).

sDFluent(infiniteBeers(_Person)=true).

index(win_lottery(Person),Person).
index(go_to(Person,_Place),Person).
index(lose_wallet(Person),Person).
index(rich(Person)=true,Person).
index(location(Person)=_Place,Person).
index(infiniteBeers(Person)=true,Person).


cachingOrder2(Person, rich(Person)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(Person).

cachingOrder2(Person, location(Person)=Place) :- % level in dependency graph: 1, processing order in component: 1
     person(Person),place(Place).

cachingOrder2(Person, infiniteBeers(Person)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(Person).



