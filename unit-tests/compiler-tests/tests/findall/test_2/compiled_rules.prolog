holdsForSDFluent(workingEfficiently(_5012)=true,_4982) :-
     holdsForProcessedIE(_5012,working(_5012)=true,_5028),
     holdsForProcessedIE(_5012,sleeping_at_work(_5012)=true,_5044),
     relative_complement_all(_5028,[_5044],_5058),
     findall((_5062,_5064),(member(_5058,(_5062,_5064)),holdsAtProcessedIE(_5012,location(_5012)=work,_5062)),_4982).

grounding(working(_5248)=true) :- 
     person(_5248).

grounding(sleeping_at_work(_5248)=true) :- 
     person(_5248).

grounding(location(_5248)=work) :- 
     person(_5248).

grounding(workingEfficiently(_5248)=true) :- 
     person(_5248).

inputEntity(working(_5042)=true).
inputEntity(sleeping_at_work(_5042)=true).
inputEntity(location(_5042)=work).

outputEntity(workingEfficiently(_5116)=true).



sDFluent(workingEfficiently(_5290)=true).
sDFluent(working(_5290)=true).
sDFluent(sleeping_at_work(_5290)=true).
sDFluent(location(_5290)=work).

index(workingEfficiently(_5316)=true,_5316).
index(working(_5316)=true,_5316).
index(sleeping_at_work(_5316)=true,_5316).
index(location(_5316)=work,_5316).


cachingOrder2(_5574, workingEfficiently(_5574)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5574).

