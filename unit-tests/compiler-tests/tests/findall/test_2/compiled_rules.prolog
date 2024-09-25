holdsForSDFluent(workingEfficiently(_1974)=true,_1944) :-
     holdsForProcessedIE(_1974,working(_1974)=true,_1990),
     holdsForProcessedIE(_1974,sleeping_at_work(_1974)=true,_2006),
     relative_complement_all(_1990,[_2006],_2020),
     findall((_2024,_2026),(member(_2020,(_2024,_2026)),holdsAtProcessedIE(_1974,location(_1974)=work,_2024)),_1944).

grounding(working(_2210)=true) :- 
     person(_2210).

grounding(sleeping_at_work(_2210)=true) :- 
     person(_2210).

grounding(location(_2210)=work) :- 
     person(_2210).

grounding(workingEfficiently(_2210)=true) :- 
     person(_2210).

inputEntity(working(_2004)=true).
inputEntity(sleeping_at_work(_2004)=true).
inputEntity(location(_2004)=work).

outputEntity(workingEfficiently(_2078)=true).




sDFluent(workingEfficiently(_2308)=true).
sDFluent(working(_2308)=true).
sDFluent(sleeping_at_work(_2308)=true).
sDFluent(location(_2308)=work).

index(workingEfficiently(_2334)=true,_2334).
index(working(_2334)=true,_2334).
index(sleeping_at_work(_2334)=true,_2334).
index(location(_2334)=work,_2334).


cachingOrder2(_2592, workingEfficiently(_2592)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2592).

