:- discontiguous initiatedAt/4, terminatedAt/4.

initiatedAt(sleeping(Person)=true, T1, T, T2) :-
     happensAtIE(sleep_start(Person),T),
     T1=<T,
     T<T2.

initiatedAt(location(Person)=Place, T1, T, T2) :-
     happensAtIE(go_to(Person,Place),T),
     T1=<T,
     T<T2.

terminatedAt(sleeping(Person)=true, T1, T, T2) :-
     happensAtIE(sleep_end(Person),T),
     T1=<T,
     T<T2.

holdsForSDFluent(sleeping_at_work(Person)=true, I) :-
     holdsForProcessedSimpleFluent(Person,sleeping(Person)=true, I1),
     holdsForProcessedSimpleFluent(Person,location(Person)=work, I2),
     intersect_all([I1, I2], I).

initiatedAt(rich(Person)=true, T1, T, T2) :-
     happensAtIE(win_lottery(Person),T),T1=<T,T<T2,
     \+holdsAtProcessedSDFluent(Person,sleeping_at_work(Person)=true,T).

terminatedAt(rich(Person)=true, T1, T, T2) :-
     happensAtIE(lose_wallet(Person),T),
     T1=<T,
     T<T2.

grounding(sleep_start(Person)) :- 
     person(Person).

grounding(sleep_end(Person)) :- 
     person(Person).

grounding(go_to(Person,_5280)) :- 
     person(Person),place(_5280).

grounding(win_lottery(Person)) :- 
     person(Person).

grounding(lose_wallet(Person)) :- 
     person(Person).

grounding(sleeping(Person)=true) :- 
     person(Person).

grounding(location(Person)=Place) :- 
     person(Person),place(Place).

grounding(sleeping_at_work(Person)=true) :- 
     person(Person).

grounding(rich(Person)=true) :- 
     person(Person).

inputEntity(sleep_start(_Person)).
inputEntity(go_to(_Person,_Place)).
inputEntity(win_lottery(_Person)).
inputEntity(sleep_end(_Person)).
inputEntity(lose_wallet(_Person)).

outputEntity(sleeping(_Person)=true).
outputEntity(location(_Person)=_5124).
outputEntity(rich(_Person)=true).
outputEntity(sleeping_at_work(_Person)=true).

event(sleep_start(_Person)).
event(go_to(_Person,_Place)).
event(win_lottery(_Person)).
event(sleep_end(_Person)).
event(lose_wallet(_Person)).

simpleFluent(sleeping(_Person)=true).
simpleFluent(location(_Person)=_Place).
simpleFluent(rich(_Person)=true).

sDFluent(sleeping_at_work(_Person)=true).

index(sleep_start(Person),Person).
index(go_to(Person,_Place),Person).
index(win_lottery(Person),Person).
index(sleep_end(Person),Person).
index(lose_wallet(Person),Person).
index(sleeping(Person)=true,Person).
index(location(Person)=_Place,Person).
index(rich(Person)=true,Person).
index(sleeping_at_work(Person)=true,Person).

cachingOrder2(Person, sleeping(Person)=true) :- % level: 1
     person(Person).

cachingOrder2(Person, location(Person)=Place) :- % level: 1
     person(Person),place(Place).

cachingOrder2(Person, sleeping_at_work(Person)=true) :- % level: 2
     person(Person).

cachingOrder2(Person, rich(Person)=true) :- % level: 3
     person(Person).

