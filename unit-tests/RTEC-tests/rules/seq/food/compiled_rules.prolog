initiatedAt(poweredOn(_108)=true, _124, _78, _130) :-
     happensAtIE(turnsOn(_108),_78),
     _124=<_78,
     _78<_130.

initiatedAt(placed(_108,_110)=true, _128, _78, _134) :-
     happensAtIE(place(_108,_110),_78),
     _128=<_78,
     _78<_134.

terminatedAt(poweredOn(_108)=true, _124, _78, _130) :-
     happensAtIE(turnsOff(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(placed(_108,_110)=true, _128, _78, _134) :-
     happensAtIE(remove(_108,_110),_78),
     _128=<_78,
     _78<_134.

holdsForSDFluent(recipePreparation(_108)=true,_78) :-
     holdsForProcessedSDFluent(stove,cooking(stove,_108)=true,_126),
     holdsForProcessedSDFluent(oven,cooking(oven,_108)=true,_144),
     rct_computation_formula(seq,0,recipePreparation(_108)=true,[cooking(stove,_108)=true,cooking(oven,_108)=true],[_126,_144],_78).

holdsForSDFluent(dishPreparation(_108)=true,_78) :-
     holdsForProcessedSDFluent(_108,recipePreparation(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,placed(_108,plate)=true,_142),
     rct_computation_formula(seq,1,dishPreparation(_108)=true,[recipePreparation(_108)=true,placed(_108,plate)=true],[_124,_142],_78).

holdsForSDFluent(cooking(_108,_110)=true,_78) :-
     holdsForProcessedSimpleFluent(_110,placed(_110,_108)=_116,_128),
     holdsForProcessedSimpleFluent(_108,poweredOn(_108)=_116,_144),
     intersect_all([_128,_144],_78).

needsGrounding(_296,_298,_300) :- 
     fail.

grounding(turnsOn(_410)) :- 
     device(_410).

grounding(turnsOff(_410)) :- 
     device(_410).

grounding(place(_410,_412)) :- 
     food(_410),device(_412).

grounding(remove(_410,_412)) :- 
     food(_410),device(_412).

grounding(poweredOn(_416)=true) :- 
     device(_416).

grounding(placed(_416,_418)=true) :- 
     food(_416),device(_418).

grounding(cooking(_416,_418)=true) :- 
     device(_416),food(_418).

grounding(recipePreparation(_416)=true) :- 
     food(_416).

grounding(dishPreparation(_416)=true) :- 
     food(_416).

inputEntity(turnsOn(_132)).
inputEntity(place(_132,_134)).
inputEntity(turnsOff(_132)).
inputEntity(remove(_132,_134)).

outputEntity(poweredOn(_218)=true).
outputEntity(placed(_218,_220)=true).
outputEntity(cooking(_218,_220)=true).
outputEntity(recipePreparation(_218)=true).
outputEntity(dishPreparation(_218)=true).

event(turnsOn(_298)).
event(place(_298,_300)).
event(turnsOff(_298)).
event(remove(_298,_300)).

simpleFluent(poweredOn(_384)=true).
simpleFluent(placed(_384,_386)=true).


sDFluent(cooking(_508,_510)=true).
sDFluent(recipePreparation(_508)=true).
sDFluent(dishPreparation(_508)=true).

index(turnsOn(_528),_528).
index(place(_528,_582),_528).
index(turnsOff(_528),_528).
index(remove(_528,_582),_528).
index(poweredOn(_528)=true,_528).
index(placed(_528,_588)=true,_528).
index(cooking(_528,_588)=true,_528).
index(recipePreparation(_528)=true,_528).
index(dishPreparation(_528)=true,_528).


cachingOrder2(_840, poweredOn(_840)=true) :- % level in dependency graph: 1, processing order in component: 1
     device(_840).

processingLevel(1,_840, poweredOn(_840)=true).
cachingOrder2(_816, placed(_816,_818)=true) :- % level in dependency graph: 1, processing order in component: 1
     food(_816),device(_818).

processingLevel(1,_816, placed(_816,_818)=true).
cachingOrder2(_1076, cooking(_1076,_1078)=true) :- % level in dependency graph: 2, processing order in component: 1
     device(_1076),food(_1078).

processingLevel(2,_1076, cooking(_1076,_1078)=true).
cachingOrder2(_1244, recipePreparation(_1244)=true) :- % level in dependency graph: 3, processing order in component: 1
     food(_1244).

processingLevel(3,_1244, recipePreparation(_1244)=true).
cachingOrder2(_1384, dishPreparation(_1384)=true) :- % level in dependency graph: 4, processing order in component: 1
     food(_1384).

processingLevel(4,_1384, dishPreparation(_1384)=true).
