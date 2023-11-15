holdsForSDFluent(workingEfficiently(_5012)=true,_4982) :-
     holdsForProcessedIE(_5012,working(_5012)=true,_5028),
     holdsForProcessedIE(_5012,sleeping_at_work(_5012)=true,_5044),
     relative_complement_all(_5028,[_5044],_5058),
     findall((_5062,_5064),(member(_5058,(_5062,_5064)),_5092 is _5064-_5062,compare(>,_5092,2)),_4982).

grounding(working(_5248)=true) :- 
     person(_5248).

grounding(sleeping_at_work(_5248)=true) :- 
     person(_5248).

grounding(workingEfficiently(_5248)=true) :- 
     person(_5248).

inputEntity(working(_5042)=true).
inputEntity(sleeping_at_work(_5042)=true).

outputEntity(workingEfficiently(_5110)=true).



sDFluent(workingEfficiently(_5284)=true).
sDFluent(working(_5284)=true).
sDFluent(sleeping_at_work(_5284)=true).

index(workingEfficiently(_5304)=true,_5304).
index(working(_5304)=true,_5304).
index(sleeping_at_work(_5304)=true,_5304).


cachingOrder2(_5556, workingEfficiently(_5556)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5556).

