initiatedAt(sleeping(Person)=true, T1, T, T2) :-
    happensAtIE(sleep_start(Person),T),
    T1=<T,
    T<T2.
terminatedAt(sleeping(Person)=true, T1, T, T2) :-
    happensAtIE(sleep_end(Person),T),
    T1=<T,
    T<T2.

grounding(sleep_start(Person)) :- 
     person(Person).

grounding(sleep_end(Person)) :- 
     person(Person).

grounding(sleeping(Person)=true) :- 
     person(Person).

inputEntity(sleep_start(_Person)).
inputEntity(sleep_end(_Person)).

outputEntity(sleeping(_Person)=true).

event(sleep_start(_Person)).
event(sleep_end(_Person)).

simpleFluent(sleeping(_Person)=true).

index(sleep_start(Person),Person).
index(sleep_end(Person),Person).
index(sleeping(Person)=true,Person).

cachingOrder2(Person, sleeping(Person)=true) :-
    person(Person).

