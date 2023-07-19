holdsForSDFluent(entering(_1884,_1886)=true,_1854) :-
     holdsForProcessedSDFluent(_1884,entering_oo(_1884,_1886)=true,_1904),
     holdsForProcessedSDFluent(_1884,entering_om(_1884,_1886)=true,_1922),
     holdsForProcessedSDFluent(_1884,entering_mo(_1884,_1886)=true,_1940),
     holdsForProcessedSDFluent(_1884,entering_mm(_1884,_1886)=true,_1958),
     union_all([_1904,_1922,_1940,_1958],_1854).

holdsForSDFluent(entering_oo(_1884,_1886)=true,_1854) :-
     holdsForProcessedSDFluent(_1884,far_from_overlaps_adjacent(_1884,_1886)=true,_1904),
     holdsForProcessedSDFluent(_1884,visible_door_not_person(_1884,_1886)=true,_1922),
     overlaps(entering_oo(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(entering_om(_1884,_1886)=true,_1854) :-
     holdsForProcessedSDFluent(_1884,far_from_overlaps_adjacent(_1884,_1886)=true,_1904),
     holdsForProcessedSDFluent(_1884,visible_door_not_person(_1884,_1886)=true,_1922),
     meets(entering_om(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(entering_mo(_1884,_1886)=true,_1854) :-
     holdsForProcessedSDFluent(_1884,far_from_meets_adjacent(_1884,_1886)=true,_1904),
     holdsForProcessedSDFluent(_1884,visible_door_not_person(_1884,_1886)=true,_1922),
     overlaps(entering_mo(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(entering_mm(_1884,_1886)=true,_1854) :-
     holdsForProcessedSDFluent(_1884,far_from_meets_adjacent(_1884,_1886)=true,_1904),
     holdsForProcessedSDFluent(_1884,visible_door_not_person(_1884,_1886)=true,_1922),
     meets(entering_mm(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(far_from_overlaps_adjacent(_1884,_1886)=true,_1854) :-
     holdsForProcessedIE(_1884,far_from(_1884,_1886)=true,_1904),
     holdsForProcessedIE(_1884,adjacent(_1884,_1886)=true,_1922),
     overlaps(far_from_overlaps_adjacent(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(far_from_meets_adjacent(_1884,_1886)=true,_1854) :-
     holdsForProcessedIE(_1884,far_from(_1884,_1886)=true,_1904),
     holdsForProcessedIE(_1884,adjacent(_1884,_1886)=true,_1922),
     meets(far_from_meets_adjacent(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(visible_door_not_person(_1884,_1886)=true,_1854) :-
     holdsForProcessedIE(_1886,visible_door(_1886)=true,_1902),
     holdsForProcessedIE(_1884,visible_person(_1884)=false,_1918),
     intersect_all([_1902,_1918],_1854).

collectIntervals2(_1858, far_from(_1858,_1860)=true) :-
     person(_1858),door(_1860).

collectIntervals2(_1858, adjacent(_1858,_1860)=true) :-
     person(_1858),door(_1860).

collectIntervals2(_1858, visible_person(_1858)=true) :-
     person(_1858).

collectIntervals2(_1858, visible_person(_1858)=false) :-
     person(_1858).

collectIntervals2(_1858, visible_door(_1858)=true) :-
     door(_1858).

grounding(far_from(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(adjacent(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(visible_person(_2108)=true) :- 
     person(_2108).

grounding(visible_person(_2108)=false) :- 
     person(_2108).

grounding(visible_door(_2108)=true) :- 
     door(_2108).

grounding(visible_door_not_person(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(far_from_meets_adjacent(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(far_from_overlaps_adjacent(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(entering_oo(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(entering_om(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(entering_mo(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(entering_mm(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

grounding(entering(_2108,_2110)=true) :- 
     person(_2108),door(_2110).

inputEntity(far_from(_1920,_1922)=true).
inputEntity(adjacent(_1920,_1922)=true).
inputEntity(visible_door(_1920)=true).
inputEntity(visible_person(_1920)=false).
inputEntity(visible_person(_1920)=true).

outputEntity(entering(_2012,_2014)=true).
outputEntity(entering_oo(_2012,_2014)=true).
outputEntity(entering_om(_2012,_2014)=true).
outputEntity(entering_mo(_2012,_2014)=true).
outputEntity(entering_mm(_2012,_2014)=true).
outputEntity(far_from_overlaps_adjacent(_2012,_2014)=true).
outputEntity(far_from_meets_adjacent(_2012,_2014)=true).
outputEntity(visible_door_not_person(_2012,_2014)=true).



sDFluent(entering(_2246,_2248)=true).
sDFluent(entering_oo(_2246,_2248)=true).
sDFluent(entering_om(_2246,_2248)=true).
sDFluent(entering_mo(_2246,_2248)=true).
sDFluent(entering_mm(_2246,_2248)=true).
sDFluent(far_from_overlaps_adjacent(_2246,_2248)=true).
sDFluent(far_from_meets_adjacent(_2246,_2248)=true).
sDFluent(visible_door_not_person(_2246,_2248)=true).
sDFluent(far_from(_2246,_2248)=true).
sDFluent(adjacent(_2246,_2248)=true).
sDFluent(visible_door(_2246)=true).
sDFluent(visible_person(_2246)=false).
sDFluent(visible_person(_2246)=true).

index(entering(_2326,_2392)=true,_2326).
index(entering_oo(_2326,_2392)=true,_2326).
index(entering_om(_2326,_2392)=true,_2326).
index(entering_mo(_2326,_2392)=true,_2326).
index(entering_mm(_2326,_2392)=true,_2326).
index(far_from_overlaps_adjacent(_2326,_2392)=true,_2326).
index(far_from_meets_adjacent(_2326,_2392)=true,_2326).
index(visible_door_not_person(_2326,_2392)=true,_2326).
index(far_from(_2326,_2392)=true,_2326).
index(adjacent(_2326,_2392)=true,_2326).
index(visible_door(_2326)=true,_2326).
index(visible_person(_2326)=false,_2326).
index(visible_person(_2326)=true,_2326).


cachingOrder2(_2686, far_from_overlaps_adjacent(_2686,_2688)=true) :- % level: 1
     person(_2686),door(_2688).

cachingOrder2(_2668, far_from_meets_adjacent(_2668,_2670)=true) :- % level: 1
     person(_2668),door(_2670).

cachingOrder2(_2650, visible_door_not_person(_2650,_2652)=true) :- % level: 1
     person(_2650),door(_2652).

cachingOrder2(_2944, entering_oo(_2944,_2946)=true) :- % level: 2
     person(_2944),door(_2946).

cachingOrder2(_2926, entering_om(_2926,_2928)=true) :- % level: 2
     person(_2926),door(_2928).

cachingOrder2(_2908, entering_mo(_2908,_2910)=true) :- % level: 2
     person(_2908),door(_2910).

cachingOrder2(_2890, entering_mm(_2890,_2892)=true) :- % level: 2
     person(_2890),door(_2892).

cachingOrder2(_3192, entering(_3192,_3194)=true) :- % level: 3
     person(_3192),door(_3194).

