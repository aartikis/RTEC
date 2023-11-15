holdsForSDFluent(drunk(_5012)=true,_4982) :-
     holdsForProcessedIE(_5012,happy(_5012)=true,_5028),
     holdsForProcessedIE(_5012,infiniteBeers(_5012)=true,_5044),
     intersect_all([_5028,_5044],_4982).

grounding(happy(_5266)=true) :- 
     person(_5266).

grounding(infiniteBeers(_5266)=true) :- 
     person(_5266).

grounding(drunk(_5266)=true) :- 
     person(_5266).

inputEntity(happy(_5042)=true).
inputEntity(infiniteBeers(_5042)=true).

outputEntity(drunk(_5110)=true).



sDFluent(drunk(_5284)=true).
sDFluent(happy(_5284)=true).
sDFluent(infiniteBeers(_5284)=true).

index(drunk(_5304)=true,_5304).
index(happy(_5304)=true,_5304).
index(infiniteBeers(_5304)=true,_5304).


cachingOrder2(_5556, drunk(_5556)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5556).

