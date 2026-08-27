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

grounding(far_from(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(adjacent(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(visible_person(_362)=true) :- 
     person(_362).

grounding(visible_person(_362)=false) :- 
     person(_362).

grounding(visible_door(_362)=true) :- 
     door(_362).

grounding(visible_door_not_person(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(far_from_meets_adjacent(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(far_from_overlaps_adjacent(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(entering_oo(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(entering_om(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(entering_mo(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(entering_mm(_362,_364)=true) :- 
     person(_362),door(_364).

grounding(entering(_362,_364)=true) :- 
     person(_362),door(_364).

inputEntity(far_from(_140,_142)=true).
inputEntity(adjacent(_140,_142)=true).
inputEntity(visible_door(_140)=true).
inputEntity(visible_person(_140)=false).
inputEntity(visible_person(_140)=true).

outputEntity(entering(_226,_228)=true).
outputEntity(entering_oo(_226,_228)=true).
outputEntity(entering_om(_226,_228)=true).
outputEntity(entering_mo(_226,_228)=true).
outputEntity(entering_mm(_226,_228)=true).
outputEntity(far_from_overlaps_adjacent(_226,_228)=true).
outputEntity(far_from_meets_adjacent(_226,_228)=true).
outputEntity(visible_door_not_person(_226,_228)=true).




sDFluent(entering(_498,_500)=true).
sDFluent(entering_oo(_498,_500)=true).
sDFluent(entering_om(_498,_500)=true).
sDFluent(entering_mo(_498,_500)=true).
sDFluent(entering_mm(_498,_500)=true).
sDFluent(far_from_overlaps_adjacent(_498,_500)=true).
sDFluent(far_from_meets_adjacent(_498,_500)=true).
sDFluent(visible_door_not_person(_498,_500)=true).
sDFluent(far_from(_498,_500)=true).
sDFluent(adjacent(_498,_500)=true).
sDFluent(visible_door(_498)=true).
sDFluent(visible_person(_498)=false).
sDFluent(visible_person(_498)=true).

index(entering(_578,_638)=true,_578).
index(entering_oo(_578,_638)=true,_578).
index(entering_om(_578,_638)=true,_578).
index(entering_mo(_578,_638)=true,_578).
index(entering_mm(_578,_638)=true,_578).
index(far_from_overlaps_adjacent(_578,_638)=true,_578).
index(far_from_meets_adjacent(_578,_638)=true,_578).
index(visible_door_not_person(_578,_638)=true,_578).
index(far_from(_578,_638)=true,_578).
index(adjacent(_578,_638)=true,_578).
index(visible_door(_578)=true,_578).
index(visible_person(_578)=false,_578).
index(visible_person(_578)=true,_578).


cachingOrder2(_938, far_from_overlaps_adjacent(_938,_940)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_938),door(_940).

cachingOrder2(_914, far_from_meets_adjacent(_914,_916)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_914),door(_916).

cachingOrder2(_890, visible_door_not_person(_890,_892)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_890),door(_892).

cachingOrder2(_1370, entering_oo(_1370,_1372)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1370),door(_1372).

cachingOrder2(_1346, entering_om(_1346,_1348)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1346),door(_1348).

cachingOrder2(_1322, entering_mo(_1322,_1324)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1322),door(_1324).

cachingOrder2(_1298, entering_mm(_1298,_1300)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1298),door(_1300).

cachingOrder2(_1826, entering(_1826,_1828)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_1826),door(_1828).

