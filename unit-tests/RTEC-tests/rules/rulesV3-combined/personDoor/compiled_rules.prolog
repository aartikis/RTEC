initiatedAt(working(_110)=true, _150, _80, _156) :-
     happensAtIE(clock_in(_110),_80),_150=<_80,_80<_156,
     holdsAtProcessedSDFluent(_110,entering(_110,_132)=true,_80).

initiatedAt(brake(_110)=true, _148, _80, _154) :-
     happensAtIE(phone_rings(_110),_80),_148=<_80,_80<_154,
     holdsAtProcessedSimpleFluent(_110,working(_110)=true,_80).

terminatedAt(brake(_110)=true, _148, _80, _154) :-
     happensAtIE(phone_call_ends(_110),_80),_148=<_80,_80<_154,
     holdsAtProcessedSimpleFluent(_110,working(_110)=true,_80).

holdsForSDFluent(entering(_110,_112)=true,_80) :-
     holdsForProcessedSDFluent(_110,entering_oo(_110,_112)=true,_130),
     holdsForProcessedSDFluent(_110,entering_om(_110,_112)=true,_148),
     holdsForProcessedSDFluent(_110,entering_mo(_110,_112)=true,_166),
     holdsForProcessedSDFluent(_110,entering_mm(_110,_112)=true,_184),
     union_all([_130,_148,_166,_184],_80).

holdsForSDFluent(entering_oo(_110,_112)=true,_80) :-
     holdsForProcessedSDFluent(_110,far_from_overlaps_adjacent(_110,_112)=true,_130),
     holdsForProcessedSDFluent(_110,visible_door_not_person(_110,_112)=true,_148),
     overlaps(entering_oo(_110,_112)=true,0,_130,_148,union,true,_80).

holdsForSDFluent(entering_om(_110,_112)=true,_80) :-
     holdsForProcessedSDFluent(_110,far_from_overlaps_adjacent(_110,_112)=true,_130),
     holdsForProcessedSDFluent(_110,visible_door_not_person(_110,_112)=true,_148),
     meets(entering_om(_110,_112)=true,0,_130,_148,union,true,_80).

holdsForSDFluent(entering_mo(_110,_112)=true,_80) :-
     holdsForProcessedSDFluent(_110,far_from_meets_adjacent(_110,_112)=true,_130),
     holdsForProcessedSDFluent(_110,visible_door_not_person(_110,_112)=true,_148),
     overlaps(entering_mo(_110,_112)=true,0,_130,_148,union,true,_80).

holdsForSDFluent(entering_mm(_110,_112)=true,_80) :-
     holdsForProcessedSDFluent(_110,far_from_meets_adjacent(_110,_112)=true,_130),
     holdsForProcessedSDFluent(_110,visible_door_not_person(_110,_112)=true,_148),
     meets(entering_mm(_110,_112)=true,0,_130,_148,union,true,_80).

holdsForSDFluent(far_from_overlaps_adjacent(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,far_from(_110,_112)=true,_130),
     holdsForProcessedIE(_110,adjacent(_110,_112)=true,_148),
     overlaps(far_from_overlaps_adjacent(_110,_112)=true,0,_130,_148,union,true,_80).

holdsForSDFluent(far_from_meets_adjacent(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,far_from(_110,_112)=true,_130),
     holdsForProcessedIE(_110,adjacent(_110,_112)=true,_148),
     meets(far_from_meets_adjacent(_110,_112)=true,0,_130,_148,union,true,_80).

holdsForSDFluent(visible_door_not_person(_110,_112)=true,_80) :-
     holdsForProcessedIE(_112,visible_door(_112)=true,_128),
     holdsForProcessedIE(_110,visible_person(_110)=false,_144),
     intersect_all([_128,_144],_80).

holdsForSDFluent(brakeDuringWork(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,brake(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,working(_110)=true,_142),
     during(brakeDuringWork(_110)=true,0,_126,_142,source,true,_80).

fi(working(_114)=true,working(_114)=false,8):-
     grounding(working(_114)=true),
     grounding(working(_114)=false).

collectIntervals2(_84, far_from(_84,_86)=true) :-
     person(_84),door(_86).

collectIntervals2(_84, adjacent(_84,_86)=true) :-
     person(_84),door(_86).

collectIntervals2(_84, visible_person(_84)=true) :-
     person(_84).

collectIntervals2(_84, visible_person(_84)=false) :-
     person(_84).

collectIntervals2(_84, visible_door(_84)=true) :-
     door(_84).

grounding(clock_in(_412)) :- 
     person(_412).

grounding(phone_rings(_412)) :- 
     person(_412).

grounding(phone_call_ends(_412)) :- 
     person(_412).

grounding(far_from(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(adjacent(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(visible_person(_418)=true) :- 
     person(_418).

grounding(visible_person(_418)=false) :- 
     person(_418).

grounding(visible_door(_418)=true) :- 
     door(_418).

grounding(visible_door_not_person(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(far_from_meets_adjacent(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(far_from_overlaps_adjacent(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(entering_oo(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(entering_om(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(entering_mo(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(entering_mm(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(entering(_418,_420)=true) :- 
     person(_418),door(_420).

grounding(working(_418)=true) :- 
     person(_418).

grounding(working(_418)=false) :- 
     person(_418).

grounding(brake(_418)=true) :- 
     person(_418).

grounding(brakeDuringWork(_418)=true) :- 
     person(_418).

inputEntity(clock_in(_134)).
inputEntity(phone_rings(_134)).
inputEntity(phone_call_ends(_134)).
inputEntity(far_from(_140,_142)=true).
inputEntity(adjacent(_140,_142)=true).
inputEntity(visible_door(_140)=true).
inputEntity(visible_person(_140)=false).
inputEntity(visible_person(_140)=true).

outputEntity(working(_244)=true).
outputEntity(brake(_244)=true).
outputEntity(working(_244)=false).
outputEntity(entering(_244,_246)=true).
outputEntity(entering_oo(_244,_246)=true).
outputEntity(entering_om(_244,_246)=true).
outputEntity(entering_mo(_244,_246)=true).
outputEntity(entering_mm(_244,_246)=true).
outputEntity(far_from_overlaps_adjacent(_244,_246)=true).
outputEntity(far_from_meets_adjacent(_244,_246)=true).
outputEntity(visible_door_not_person(_244,_246)=true).
outputEntity(brakeDuringWork(_244)=true).

event(clock_in(_366)).
event(phone_rings(_366)).
event(phone_call_ends(_366)).

simpleFluent(working(_446)=true).
simpleFluent(brake(_446)=true).
simpleFluent(working(_446)=false).


sDFluent(entering(_576,_578)=true).
sDFluent(entering_oo(_576,_578)=true).
sDFluent(entering_om(_576,_578)=true).
sDFluent(entering_mo(_576,_578)=true).
sDFluent(entering_mm(_576,_578)=true).
sDFluent(far_from_overlaps_adjacent(_576,_578)=true).
sDFluent(far_from_meets_adjacent(_576,_578)=true).
sDFluent(visible_door_not_person(_576,_578)=true).
sDFluent(brakeDuringWork(_576)=true).
sDFluent(far_from(_576,_578)=true).
sDFluent(adjacent(_576,_578)=true).
sDFluent(visible_door(_576)=true).
sDFluent(visible_person(_576)=false).
sDFluent(visible_person(_576)=true).

index(clock_in(_662),_662).
index(phone_rings(_662),_662).
index(phone_call_ends(_662),_662).
index(working(_662)=true,_662).
index(brake(_662)=true,_662).
index(working(_662)=false,_662).
index(entering(_662,_722)=true,_662).
index(entering_oo(_662,_722)=true,_662).
index(entering_om(_662,_722)=true,_662).
index(entering_mo(_662,_722)=true,_662).
index(entering_mm(_662,_722)=true,_662).
index(far_from_overlaps_adjacent(_662,_722)=true,_662).
index(far_from_meets_adjacent(_662,_722)=true,_662).
index(visible_door_not_person(_662,_722)=true,_662).
index(brakeDuringWork(_662)=true,_662).
index(far_from(_662,_722)=true,_662).
index(adjacent(_662,_722)=true,_662).
index(visible_door(_662)=true,_662).
index(visible_person(_662)=false,_662).
index(visible_person(_662)=true,_662).


cachingOrder2(_1064, far_from_overlaps_adjacent(_1064,_1066)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_1064),door(_1066).

cachingOrder2(_1040, far_from_meets_adjacent(_1040,_1042)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_1040),door(_1042).

cachingOrder2(_1016, visible_door_not_person(_1016,_1018)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_1016),door(_1018).

cachingOrder2(_1496, entering_oo(_1496,_1498)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1496),door(_1498).

cachingOrder2(_1472, entering_om(_1472,_1474)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1472),door(_1474).

cachingOrder2(_1448, entering_mo(_1448,_1450)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1448),door(_1450).

cachingOrder2(_1424, entering_mm(_1424,_1426)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1424),door(_1426).

cachingOrder2(_1952, entering(_1952,_1954)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_1952),door(_1954).

cachingOrder2(_2120, working(_2120)=true) :- % level in dependency graph: 4, processing order in component: 1
     person(_2120).

cachingOrder2(_2120, working(_2120)=false) :- % level in dependency graph: 4, processing order in component: 2
     person(_2120).

cachingOrder2(_2346, brake(_2346)=true) :- % level in dependency graph: 5, processing order in component: 1
     person(_2346).

cachingOrder2(_2486, brakeDuringWork(_2486)=true) :- % level in dependency graph: 6, processing order in component: 1
     person(_2486).

