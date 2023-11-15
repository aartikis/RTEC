

:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.


initiatedAt(strength(X)=tired, T1, T, T2) :-
    happensAtIE(ends_working(X),T),
    T1=<T,T<T2,
    holdsAtCyclic(X,strength(X)=lowering,T).
initiatedAt(strength(X)=lowering, T1, T, T2) :-
    happensAtIE(starts_working(X),T),
    T1=<T,T<T2,
    holdsAtCyclic(X,strength(X)=full,T).
initiatedAt(strength(X)=full, T1, T, T2) :-
    happensAtIE(sleep_end(X),T),
    T1=<T,T<T2,
    holdsAtCyclic(X,strength(X)=tired,T).

initiatedAt(strength(_X)=full, T1, -1, T2) :-
    T1=< -1,
    -1<T2.

grounding(ends_working(X)):-
    person(X).
grounding(starts_working(X)):-
    person(X).
grounding(sleep_end(X)):-
    person(X).

grounding(strength(X)=tired):-
    person(X).
grounding(strength(X)=lowering):-
    person(X).
grounding(strength(X)=full):-
    person(X).

inputEntity(ends_working(_5034)).
inputEntity(starts_working(_5034)).
inputEntity(sleep_end(_5034)).

outputEntity(strength(_5114)=tired).
outputEntity(strength(_5114)=lowering).
outputEntity(strength(_5114)=full).

event(ends_working(_5182)).
event(starts_working(_5182)).
event(sleep_end(_5182)).

simpleFluent(strength(_5262)=tired).
simpleFluent(strength(_5262)=lowering).
simpleFluent(strength(_5262)=full).


index(ends_working(_5338),_5338).
index(starts_working(_5338),_5338).
index(sleep_end(_5338),_5338).
index(strength(_5338)=tired,_5338).
index(strength(_5338)=lowering,_5338).
index(strength(_5338)=full,_5338).

cyclic(strength(_5548)=tired).
cyclic(strength(_5548)=lowering).
cyclic(strength(_5548)=full).

cachingOrder2(X, strength(X)=full) :-person(X).
cachingOrder2(X, strength(X)=tired) :-person(X).
cachingOrder2(X, strength(X)=lowering) :-person(X).

