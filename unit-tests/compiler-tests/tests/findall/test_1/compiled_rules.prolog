holdsForSDFluent(workingEfficiently(_1974)=true,_1944) :-
     holdsForProcessedIE(_1974,working(_1974)=true,_1990),
     holdsForProcessedIE(_1974,sleeping_at_work(_1974)=true,_2006),
     relative_complement_all(_1990,[_2006],_2020),
     findall((_2024,_2026),(member(_2020,(_2024,_2026)),_2054 is _2026-_2024,compare(>,_2054,2)),_1944).

grounding(working(_2210)=true) :- 
     person(_2210).

grounding(sleeping_at_work(_2210)=true) :- 
     person(_2210).

grounding(workingEfficiently(_2210)=true) :- 
     person(_2210).

inputEntity(working(_2004)=true).
inputEntity(sleeping_at_work(_2004)=true).

outputEntity(workingEfficiently(_2072)=true).




sDFluent(workingEfficiently(_2302)=true).
sDFluent(working(_2302)=true).
sDFluent(sleeping_at_work(_2302)=true).

index(workingEfficiently(_2322)=true,_2322).
index(working(_2322)=true,_2322).
index(sleeping_at_work(_2322)=true,_2322).


cachingOrder2(_2574, workingEfficiently(_2574)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2574).

