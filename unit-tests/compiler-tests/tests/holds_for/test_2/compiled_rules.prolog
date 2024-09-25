holdsForSDFluent(drunk(_1974)=true,_1944) :-
     holdsForProcessedIE(_1974,happy(_1974)=true,_1990),
     holdsForProcessedIE(_1974,infiniteBeers(_1974)=true,_2006),
     intersect_all([_1990,_2006],_1944).

grounding(happy(_2228)=true) :- 
     person(_2228).

grounding(infiniteBeers(_2228)=true) :- 
     person(_2228).

grounding(drunk(_2228)=true) :- 
     person(_2228).

inputEntity(happy(_2004)=true).
inputEntity(infiniteBeers(_2004)=true).

outputEntity(drunk(_2072)=true).




sDFluent(drunk(_2302)=true).
sDFluent(happy(_2302)=true).
sDFluent(infiniteBeers(_2302)=true).

index(drunk(_2322)=true,_2322).
index(happy(_2322)=true,_2322).
index(infiniteBeers(_2322)=true,_2322).


cachingOrder2(_2574, drunk(_2574)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2574).

