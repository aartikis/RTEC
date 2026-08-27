initiatedAt(rich(Person)=true, T1, T, T2) :-
    happensAtIE(win_lottery(Person),T),
    T1=<T,
    T<T2.

terminatedAt(rich(Person)=true, T1, T, T2) :-
    happensAtIE(lose_wallet(Person),T),
    T1=<T,
    T<T2.

fi(rich(Person)=true,rich(Person)=false,4) :- grounding(rich(Person)=true), grounding(rich(Person)=false).
p(rich(_Person)=true).

grounding(win_lottery(Person)):-
    person(Person).

grounding(lose_lottery(Person)):-
    person(Person).

grounding(rich(Person)=true):-
    person(Person).

grounding(rich(Person)=false):-
    person(Person).

inputEntity(win_lottery(_Person)).
inputEntity(lose_wallet(_Person)).
inputEntity(lose_lottery(_Person)).

outputEntity(rich(_Person)=true).
outputEntity(rich(_Person)=false).

event(win_lottery(_Person)).
event(lose_wallet(_Person)).
event(lose_lottery(_Person)).

simpleFluent(rich(_Person)=true).
simpleFluent(rich(_Person)=false).


index(win_lottery(Person),Person).
index(lose_wallet(Person),Person).
index(lose_lottery(Person),Person).
index(rich(Person)=true,Person).
index(rich(Person)=false,Person).


cachingOrder2(Person, rich(Person)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(Person).

cachingOrder2(Person, rich(Person)=false) :- % level in dependency graph: 1, processing order in component: 2
     person(Person).

