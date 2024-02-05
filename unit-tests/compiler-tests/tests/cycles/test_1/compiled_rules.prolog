initiatedAt(strength(_5010)=tired, _5054, _4980, _5060) :-
     happensAtIE(ends_working(_5010),_4980),_5054=<_4980,_4980<_5060,
     holdsAtCyclic(_5010,strength(_5010)=lowering,_4980).

initiatedAt(strength(_5010)=lowering, _5054, _4980, _5060) :-
     happensAtIE(starts_working(_5010),_4980),_5054=<_4980,_4980<_5060,
     holdsAtCyclic(_5010,strength(_5010)=full,_4980).

initiatedAt(strength(_5010)=full, _5054, _4980, _5060) :-
     happensAtIE(sleep_end(_5010),_4980),_5054=<_4980,_4980<_5060,
     holdsAtCyclic(_5010,strength(_5010)=tired,_4980).

initiatedAt(strength(_5018)=full, _4980, -1, _4984) :-
     _4980=< -1,
     -1<_4984.

grounding(ends_working(_5262)) :- 
     person(_5262).

grounding(starts_working(_5262)) :- 
     person(_5262).

grounding(sleep_end(_5262)) :- 
     person(_5262).

grounding(strength(_5268)=tired) :- 
     person(_5268).

grounding(strength(_5268)=lowering) :- 
     person(_5268).

grounding(strength(_5268)=full) :- 
     person(_5268).

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

cachingOrder2(_5656, strength(_5656)=full) :- % level in dependency graph: 1, processing order in component: 1
     person(_5656).

cachingOrder2(_5672, strength(_5672)=lowering) :- % level in dependency graph: 1, processing order in component: 2
     person(_5672).

cachingOrder2(_5688, strength(_5688)=tired) :- % level in dependency graph: 1, processing order in component: 3
     person(_5688).

