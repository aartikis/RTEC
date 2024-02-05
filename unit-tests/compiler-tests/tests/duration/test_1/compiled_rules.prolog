initiatedAt(working(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(starts_working(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(working(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(ends_working(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

fi(working(_5016)=true,working(_5016)=false,8):-
     grounding(working(_5016)=true),
     grounding(working(_5016)=false).

grounding(starts_working(_5280)) :- 
     person(_5280).

grounding(ends_working(_5280)) :- 
     person(_5280).

grounding(working(_5286)=true) :- 
     person(_5286).

grounding(working(_5286)=false) :- 
     person(_5286).

inputEntity(starts_working(_5036)).
inputEntity(ends_working(_5036)).

outputEntity(working(_5110)=true).
outputEntity(working(_5110)=false).

event(starts_working(_5172)).
event(ends_working(_5172)).

simpleFluent(working(_5246)=true).
simpleFluent(working(_5246)=false).


index(starts_working(_5316),_5316).
index(ends_working(_5316),_5316).
index(working(_5316)=true,_5316).
index(working(_5316)=false,_5316).


cachingOrder2(_5574, working(_5574)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5574).

cachingOrder2(_5574, working(_5574)=false) :- % level in dependency graph: 1, processing order in component: 2
     person(_5574).

