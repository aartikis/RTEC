initiatedAt(working(X)=true, T1, T, T2) :-
    happensAtIE(starts_working(X),T),
    T1=<T,
    T<T2.

terminatedAt(working(X)=true, T1, T, T2) :-
    happensAtIE(ends_working(X),T),
    T1=<T,
    T<T2.

fi(working(X)=true,working(X)=false,8) :- grounding(working(X)=true), grounding(working(X)=false).

grounding(starts_working(X)):-
    person(X).

grounding(ends_working(X)):-
    person(X).

grounding(working(X)=true):-
    person(X).

grounding(working(X)=false):-
    person(X).

inputEntity(starts_working(_Person)).
inputEntity(ends_working(_Person)).

outputEntity(working(_Person)=true).
outputEntity(working(_Person)=false).

event(starts_working(_Person)).
event(ends_working(_Person)).

simpleFluent(working(_Person)=true).
simpleFluent(working(_Person)=false).

index(starts_working(Person),Person).
index(ends_working(Person),Person).
index(working(Person)=true,Person).
index(working(Person)=false,Person).

cachingOrder2(Person, working(Person)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(Person).

cachingOrder2(Person, working(Person)=false) :- % level in dependency graph: 1, processing order in component: 2
     person(Person).

