holdsForSDFluent(d=true,_80) :-
     holdsForProcessedIE(c,c=true,_118),
     holdsForProcessedIE(b,b=true,_130),
     during(d=true,0,_118,_130,target,true,_80).

holdsForSDFluent(e=true,_80) :-
     holdsForProcessedIE(a,a=true,_118),
     holdsForProcessedSDFluent(d,d=true,_130),
     overlaps(e=true,0,_118,_130,source,true,_80).

holdsForSDFluent(dBefore=true,_80) :-
     holdsForProcessedIE(cBefore,cBefore=true,_118),
     holdsForProcessedIE(bBefore,bBefore=true,_130),
     before(dBefore=true,0,_118,_130,union,true,_80).

holdsForSDFluent(eBefore=true,_80) :-
     holdsForProcessedIE(aBefore,aBefore=true,_118),
     holdsForProcessedSDFluent(dBefore,dBefore=true,_130),
     during(eBefore=true,0,_118,_130,source,true,_80).

holdsForSDFluent(dMeets=true,_80) :-
     holdsForProcessedIE(cMeets,cMeets=true,_118),
     holdsForProcessedIE(bMeets,bMeets=true,_130),
     meets(dMeets=true,0,_118,_130,union,true,_80).

holdsForSDFluent(eMeets=true,_80) :-
     holdsForProcessedIE(aMeets,aMeets=true,_118),
     holdsForProcessedSDFluent(dMeets,dMeets=true,_130),
     meets(eMeets=true,0,_118,_130,source,true,_80).

holdsForSDFluent(dStarts=true,_80) :-
     holdsForProcessedIE(cStarts,cStarts=true,_118),
     holdsForProcessedIE(bStarts,bStarts=true,_130),
     starts(dStarts=true,0,_118,_130,intersection,true,_80).

holdsForSDFluent(eStarts=true,_80) :-
     holdsForProcessedIE(aStarts,aStarts=true,_118),
     holdsForProcessedSDFluent(dStarts,dStarts=true,_130),
     overlaps(eStarts=true,0,_118,_130,source,true,_80).

holdsForSDFluent(dFinishes=true,_80) :-
     holdsForProcessedIE(cFinishes,cFinishes=true,_118),
     holdsForProcessedIE(bFinishes,bFinishes=true,_130),
     finishes(dFinishes=true,0,_118,_130,relative_complement_inverse,true,_80).

holdsForSDFluent(eFinishes=true,_80) :-
     holdsForProcessedIE(aFinishes,aFinishes=true,_118),
     holdsForProcessedSDFluent(dFinishes,dFinishes=true,_130),
     meets(eFinishes=true,0,_118,_130,source,true,_80).

holdsForSDFluent(dDuring=true,_80) :-
     holdsForProcessedIE(cDuring,cDuring=true,_118),
     holdsForProcessedIE(bDuring,bDuring=true,_130),
     during(dDuring=true,0,_118,_130,union,true,_80).

holdsForSDFluent(eDuring=true,_80) :-
     holdsForProcessedIE(aDuring,aDuring=true,_118),
     holdsForProcessedSDFluent(dDuring,dDuring=true,_130),
     overlaps(eDuring=true,0,_118,_130,source,true,_80).

holdsForSDFluent(dOverlaps=true,_80) :-
     holdsForProcessedIE(cOverlaps,cOverlaps=true,_118),
     holdsForProcessedIE(bOverlaps,bOverlaps=true,_130),
     overlaps(dOverlaps=true,0,_118,_130,relative_complement,true,_80).

holdsForSDFluent(eOverlaps=true,_80) :-
     holdsForProcessedIE(aOverlaps,aOverlaps=true,_118),
     holdsForProcessedSDFluent(dOverlaps,dOverlaps=true,_130),
     starts(eOverlaps=true,0,_118,_130,source,true,_80).

collectIntervals2(a, a=true) :-
     true.

collectIntervals2(b, b=true) :-
     true.

collectIntervals2(c, c=true) :-
     true.

collectIntervals2(aBefore, aBefore=true) :-
     true.

collectIntervals2(bBefore, bBefore=true) :-
     true.

collectIntervals2(cBefore, cBefore=true) :-
     true.

collectIntervals2(aMeets, aMeets=true) :-
     true.

collectIntervals2(bMeets, bMeets=true) :-
     true.

collectIntervals2(cMeets, cMeets=true) :-
     true.

collectIntervals2(aStarts, aStarts=true) :-
     true.

collectIntervals2(bStarts, bStarts=true) :-
     true.

collectIntervals2(cStarts, cStarts=true) :-
     true.

collectIntervals2(aFinishes, aFinishes=true) :-
     true.

collectIntervals2(bFinishes, bFinishes=true) :-
     true.

collectIntervals2(cFinishes, cFinishes=true) :-
     true.

collectIntervals2(aDuring, aDuring=true) :-
     true.

collectIntervals2(bDuring, bDuring=true) :-
     true.

collectIntervals2(cDuring, cDuring=true) :-
     true.

collectIntervals2(aOverlaps, aOverlaps=true) :-
     true.

collectIntervals2(bOverlaps, bOverlaps=true) :-
     true.

collectIntervals2(cOverlaps, cOverlaps=true) :-
     true.

grounding(a=true).

grounding(b=true).

grounding(c=true).

grounding(aBefore=true).

grounding(bBefore=true).

grounding(cBefore=true).

grounding(aMeets=true).

grounding(bMeets=true).

grounding(cMeets=true).

grounding(aStarts=true).

grounding(bStarts=true).

grounding(cStarts=true).

grounding(aFinishes=true).

grounding(bFinishes=true).

grounding(cFinishes=true).

grounding(aDuring=true).

grounding(bDuring=true).

grounding(cDuring=true).

grounding(aOverlaps=true).

grounding(bOverlaps=true).

grounding(cOverlaps=true).

grounding(d=true).

grounding(e=true).

grounding(dBefore=true).

grounding(eBefore=true).

grounding(dMeets=true).

grounding(eMeets=true).

grounding(dStarts=true).

grounding(eStarts=true).

grounding(dFinishes=true).

grounding(eFinishes=true).

grounding(dDuring=true).

grounding(eDuring=true).

grounding(dOverlaps=true).

grounding(eOverlaps=true).

inputEntity(c=true).
inputEntity(b=true).
inputEntity(a=true).
inputEntity(cBefore=true).
inputEntity(bBefore=true).
inputEntity(aBefore=true).
inputEntity(cMeets=true).
inputEntity(bMeets=true).
inputEntity(aMeets=true).
inputEntity(cStarts=true).
inputEntity(bStarts=true).
inputEntity(aStarts=true).
inputEntity(cFinishes=true).
inputEntity(bFinishes=true).
inputEntity(aFinishes=true).
inputEntity(cDuring=true).
inputEntity(bDuring=true).
inputEntity(aDuring=true).
inputEntity(cOverlaps=true).
inputEntity(bOverlaps=true).
inputEntity(aOverlaps=true).

outputEntity(d=true).
outputEntity(e=true).
outputEntity(dBefore=true).
outputEntity(eBefore=true).
outputEntity(dMeets=true).
outputEntity(eMeets=true).
outputEntity(dStarts=true).
outputEntity(eStarts=true).
outputEntity(dFinishes=true).
outputEntity(eFinishes=true).
outputEntity(dDuring=true).
outputEntity(eDuring=true).
outputEntity(dOverlaps=true).
outputEntity(eOverlaps=true).




sDFluent(d=true).
sDFluent(e=true).
sDFluent(dBefore=true).
sDFluent(eBefore=true).
sDFluent(dMeets=true).
sDFluent(eMeets=true).
sDFluent(dStarts=true).
sDFluent(eStarts=true).
sDFluent(dFinishes=true).
sDFluent(eFinishes=true).
sDFluent(dDuring=true).
sDFluent(eDuring=true).
sDFluent(dOverlaps=true).
sDFluent(eOverlaps=true).
sDFluent(c=true).
sDFluent(b=true).
sDFluent(a=true).
sDFluent(cBefore=true).
sDFluent(bBefore=true).
sDFluent(aBefore=true).
sDFluent(cMeets=true).
sDFluent(bMeets=true).
sDFluent(aMeets=true).
sDFluent(cStarts=true).
sDFluent(bStarts=true).
sDFluent(aStarts=true).
sDFluent(cFinishes=true).
sDFluent(bFinishes=true).
sDFluent(aFinishes=true).
sDFluent(cDuring=true).
sDFluent(bDuring=true).
sDFluent(aDuring=true).
sDFluent(cOverlaps=true).
sDFluent(bOverlaps=true).
sDFluent(aOverlaps=true).

index(d=true,d).
index(e=true,e).
index(dBefore=true,dBefore).
index(eBefore=true,eBefore).
index(dMeets=true,dMeets).
index(eMeets=true,eMeets).
index(dStarts=true,dStarts).
index(eStarts=true,eStarts).
index(dFinishes=true,dFinishes).
index(eFinishes=true,eFinishes).
index(dDuring=true,dDuring).
index(eDuring=true,eDuring).
index(dOverlaps=true,dOverlaps).
index(eOverlaps=true,eOverlaps).
index(c=true,c).
index(b=true,b).
index(a=true,a).
index(cBefore=true,cBefore).
index(bBefore=true,bBefore).
index(aBefore=true,aBefore).
index(cMeets=true,cMeets).
index(bMeets=true,bMeets).
index(aMeets=true,aMeets).
index(cStarts=true,cStarts).
index(bStarts=true,bStarts).
index(aStarts=true,aStarts).
index(cFinishes=true,cFinishes).
index(bFinishes=true,bFinishes).
index(aFinishes=true,aFinishes).
index(cDuring=true,cDuring).
index(bDuring=true,bDuring).
index(aDuring=true,aDuring).
index(cOverlaps=true,cOverlaps).
index(bOverlaps=true,bOverlaps).
index(aOverlaps=true,aOverlaps).


cachingOrder2(d, d=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(dBefore, dBefore=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(dMeets, dMeets=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(dStarts, dStarts=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(dFinishes, dFinishes=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(dDuring, dDuring=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(dOverlaps, dOverlaps=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(e, e=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

cachingOrder2(eBefore, eBefore=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

cachingOrder2(eMeets, eMeets=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

cachingOrder2(eStarts, eStarts=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

cachingOrder2(eFinishes, eFinishes=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

cachingOrder2(eDuring, eDuring=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

cachingOrder2(eOverlaps, eOverlaps=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

