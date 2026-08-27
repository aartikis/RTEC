:- discontiguous initiatedAt/4, terminatedAt/4.

initiatedAt(sleeping(Person)=true, T1, T, T2) :-
     happensAtIE(sleep_start(Person), T),
     T1=<T,
     T<T2.

terminatedAt(sleeping(Person)=true, T1,  T, T2) :-
     happensAtIE(sleep_end(Person), T),
    T1=<T,
    T<T2.

initiatedAt(rich(Person)=true, T1, T, T2) :-
    happensAtIE(win_lottery(Person),T), 
    T1=<T, T<T2,
    \+holdsAtProcessedSimpleFluent(Person,sleeping(Person)=true,T).

terminatedAt(rich(Person)=true, T1, T, T2) :-
    happensAtIE(lose_wallet(Person),T),
    T1=<T,
    T<T2.

grounding(sleep_start(Person)) :- 
     person(Person).

grounding(sleep_end(Person)) :- 
     person(Person).

grounding(win_lottery(Person)) :- 
     person(Person).

grounding(lose_lottery(Person)) :- 
     person(Person).

grounding(sleeping(Person)=true) :- 
     person(Person).

grounding(rich(Person)=true) :- 
     person(Person).

inputEntity(sleep_start(_Person)).
inputEntity(win_lottery(_Person)).
inputEntity(sleep_end(_Person)).
inputEntity(lose_wallet(_Person)).
inputEntity(lose_lottery(_Person)).

outputEntity(sleeping(_Person)=true).
outputEntity(rich(_Person)=true).

event(sleep_start(_Person)).
event(win_lottery(_Person)).
event(sleep_end(_Person)).
event(lose_wallet(_Person)).
event(lose_lottery(_Person)).

simpleFluent(sleeping(_Person)=true).
simpleFluent(rich(_Person)=true).

index(sleep_start(Person),Person).
index(win_lottery(Person),Person).
index(sleep_end(Person),Person).
index(lose_wallet(Person),Person).
index(lose_lottery(Person),Person).
index(sleeping(Person)=true,Person).
index(rich(Person)=true,Person).

cachingOrder2(Person, sleeping(Person)=true) :-
     person(Person).
cachingOrder2(Person, rich(Person)=true) :- 
    person(Person).

