initiatedAt(strength(_106)=tired, _150, _76, _156) :-
     happensAtIE(ends_working(_106),_76),_150=<_76,_76<_156,
     holdsAtCyclic(_106,strength(_106)=lowering,_76).

initiatedAt(strength(_106)=lowering, _150, _76, _156) :-
     happensAtIE(starts_working(_106),_76),_150=<_76,_76<_156,
     holdsAtCyclic(_106,strength(_106)=full,_76).

initiatedAt(strength(_106)=full, _150, _76, _156) :-
     happensAtIE(sleep_end(_106),_76),_150=<_76,_76<_156,
     holdsAtCyclic(_106,strength(_106)=tired,_76).

initiatedAt(strength(_114)=full, _76, -1, _80) :-
     _76=< -1,
     -1<_80.

grounding(ends_working(_358)) :- 
     person(_358).

grounding(starts_working(_358)) :- 
     person(_358).

grounding(sleep_end(_358)) :- 
     person(_358).

grounding(strength(_364)=tired) :- 
     person(_364).

grounding(strength(_364)=lowering) :- 
     person(_364).

grounding(strength(_364)=full) :- 
     person(_364).

inputEntity(ends_working(_130)).
inputEntity(starts_working(_130)).
inputEntity(sleep_end(_130)).

outputEntity(strength(_210)=tired).
outputEntity(strength(_210)=lowering).
outputEntity(strength(_210)=full).

event(ends_working(_278)).
event(starts_working(_278)).
event(sleep_end(_278)).

simpleFluent(strength(_358)=tired).
simpleFluent(strength(_358)=lowering).
simpleFluent(strength(_358)=full).



index(ends_working(_490),_490).
index(starts_working(_490),_490).
index(sleep_end(_490),_490).
index(strength(_490)=tired,_490).
index(strength(_490)=lowering,_490).
index(strength(_490)=full,_490).

cyclic(strength(_700)=tired).
cyclic(strength(_700)=lowering).
cyclic(strength(_700)=full).

cachingOrder2(_808, strength(_808)=tired) :- % level in dependency graph: 1, processing order in component: 1
     person(_808).

cachingOrder2(_824, strength(_824)=lowering) :- % level in dependency graph: 1, processing order in component: 2
     person(_824).

cachingOrder2(_840, strength(_840)=full) :- % level in dependency graph: 1, processing order in component: 3
     person(_840).

