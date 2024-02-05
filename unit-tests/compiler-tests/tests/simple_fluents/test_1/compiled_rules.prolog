initiatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_start(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_end(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

grounding(sleep_start(_5260)) :- 
     person(_5260).

grounding(sleep_end(_5260)) :- 
     person(_5260).

grounding(sleeping(_5266)=true) :- 
     person(_5266).

inputEntity(sleep_start(_5036)).
inputEntity(sleep_end(_5036)).

outputEntity(sleeping(_5110)=true).

event(sleep_start(_5166)).
event(sleep_end(_5166)).

simpleFluent(sleeping(_5240)=true).


index(sleep_start(_5304),_5304).
index(sleep_end(_5304),_5304).
index(sleeping(_5304)=true,_5304).


cachingOrder2(_5556, sleeping(_5556)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5556).

