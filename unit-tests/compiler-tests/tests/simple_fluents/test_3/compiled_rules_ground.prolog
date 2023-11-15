:- discontiguous initiatedAt/4, terminatedAt/4.

initiatedAt(rich(Person)=true, T1, T, T2) :-
     happensAtIE(win_lottery(Person), T),
     T1=<T,
     T<T2.

initiatedAt(location(Person)=Place, T1, T, T2) :-
     happensAtIE(go_to(Person,Place),T),
     T1=<T,
     T<T2.

terminatedAt(rich(Person)=true, T1, T, T2) :-
     happensAtIE(lose_wallet(Person),T),
     T1=<T,
     T<T2.

holdsForSDFluent(happy(Person)=true, I) :-
     holdsForProcessedSimpleFluent(Person,rich(Person)=true,I1),
     holdsForProcessedSimpleFluent(Person,location(Person)=pub,I2),
     union_all([I1,I2],I).

initiatedAt(shappy(Person)=true, T1, T, T2) :-
    happensAtProcessedSDFluent(Person,startI(happy(Person)=true),T),
    T1=<T,
    T<T2.
terminatedAt(shappy(Person)=true, T1, T, T2) :-
    happensAtProcessedSDFluent(Person,end(happy(Person)=true),T),
    T1=<T,
    T<T2.

grounding(go_to(Person, Place)) :- person(Person), place(Place).
grounding(lose_wallet(Person)) :- person(Person).
grounding(win_lottery(Person)) :- person(Person).

grounding(location(Person)=Place) :- person(Person), place(Place).
grounding(rich(Person)=true)      :- person(Person).
grounding(happy(Person)=true)     :- person(Person).
grounding(shappy(Person)=true)     :- person(Person).

inputEntity(win_lottery(_Person)).
inputEntity(go_to(_Person,_Place)).
inputEntity(lose_wallet(_Person)).

outputEntity(rich(_Person)=true).
outputEntity(location(_Person)=_Place).
outputEntity(shappy(_Person)=true).
outputEntity(happy(_Person)=true).

event(win_lottery(_Person)).
event(go_to(_Person,_Place)).
event(lose_wallet(_Person)).

simpleFluent(rich(_Person)=true).
simpleFluent(location(_Person)=_Place).
simpleFluent(shappy(_Person)=true).

sDFluent(happy(_Person)=true).

index(win_lottery(Person),Person).
index(go_to(Person,_Place),Person).
index(lose_wallet(Person),Person).
index(rich(Person)=true,Person).
index(location(Person)=_Place,Person).
index(shappy(Person)=true,Person).
index(happy(Person)=true,Person).

cachingOrder2(Person, rich(Person)=true) :- 
     person(Person).

cachingOrder2(Person, location(Person)=Place) :- 
     person(Person), place(Place).

cachingOrder2(Person, happy(Person)=true) :-
     person(Person).

cachingOrder2(Person, shappy(Person)=true) :-
    person(Person).

