holdsForSDFluent(entering_om(_1884,_1886)=true,_1854) :-
     holdsForProcessedSDFluent(_1884,far_from_overlaps_adjacent(_1884,_1886)=true,_1904),
     holdsForProcessedSDFluent(_1884,visible_car_not_person(_1884,_1886)=true,_1922),
     meets(entering_om(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(far_from_overlaps_adjacent(_1884,_1886)=true,_1854) :-
     holdsForProcessedIE(_1884,far_from(_1884,_1886)=true,_1904),
     holdsForProcessedIE(_1884,adjacent(_1884,_1886)=true,_1922),
     overlaps(far_from_overlaps_adjacent(_1884,_1886)=true,0,_1904,_1922,union,true,_1854).

holdsForSDFluent(visible_car_not_person(_1884,_1886)=true,_1854) :-
     holdsForProcessedIE(_1886,visible_car(_1886)=true,_1902),
     holdsForProcessedIE(_1884,visible_person(_1884)=false,_1918),
     intersect_all([_1902,_1918],_1854).

collectIntervals2(_1858, far_from(_1858,_1860)=true) :-
     person(_1858),car(_1860).

collectIntervals2(_1858, adjacent(_1858,_1860)=true) :-
     person(_1858),car(_1860).

collectIntervals2(_1858, visible_person(_1858)=true) :-
     person(_1858).

collectIntervals2(_1858, visible_person(_1858)=false) :-
     person(_1858).

collectIntervals2(_1858, visible_car(_1858)=true) :-
     car(_1858).

grounding(far_from(_2108,_2110)=true) :- 
     person(_2108),car(_2110).

grounding(adjacent(_2108,_2110)=true) :- 
     person(_2108),car(_2110).

grounding(visible_person(_2108)=true) :- 
     person(_2108).

grounding(visible_person(_2108)=false) :- 
     person(_2108).

grounding(visible_car(_2108)=true) :- 
     car(_2108).

grounding(visible_car_not_person(_2108,_2110)=true) :- 
     person(_2108),car(_2110).

grounding(far_from_meets_adjacent(_2108,_2110)=true) :- 
     person(_2108),car(_2110).

grounding(far_from_overlaps_adjacent(_2108,_2110)=true) :- 
     person(_2108),car(_2110).

grounding(entering_om(_2108,_2110)=true) :- 
     person(_2108),car(_2110).

inputEntity(far_from(_1920,_1922)=true).
inputEntity(adjacent(_1920,_1922)=true).
inputEntity(visible_car(_1920)=true).
inputEntity(visible_person(_1920)=false).
inputEntity(visible_person(_1920)=true).
inputEntity(far_from_meets_adjacent(_1920,_1922)=true).

outputEntity(entering_om(_2018,_2020)=true).
outputEntity(far_from_overlaps_adjacent(_2018,_2020)=true).
outputEntity(visible_car_not_person(_2018,_2020)=true).



sDFluent(entering_om(_2222,_2224)=true).
sDFluent(far_from_overlaps_adjacent(_2222,_2224)=true).
sDFluent(visible_car_not_person(_2222,_2224)=true).
sDFluent(far_from(_2222,_2224)=true).
sDFluent(adjacent(_2222,_2224)=true).
sDFluent(visible_car(_2222)=true).
sDFluent(visible_person(_2222)=false).
sDFluent(visible_person(_2222)=true).
sDFluent(far_from_meets_adjacent(_2222,_2224)=true).

index(entering_om(_2278,_2344)=true,_2278).
index(far_from_overlaps_adjacent(_2278,_2344)=true,_2278).
index(visible_car_not_person(_2278,_2344)=true,_2278).
index(far_from(_2278,_2344)=true,_2278).
index(adjacent(_2278,_2344)=true,_2278).
index(visible_car(_2278)=true,_2278).
index(visible_person(_2278)=false,_2278).
index(visible_person(_2278)=true,_2278).
index(far_from_meets_adjacent(_2278,_2344)=true,_2278).


cachingOrder2(_2596, far_from_overlaps_adjacent(_2596,_2598)=true) :- % level: 1
     person(_2596),car(_2598).

cachingOrder2(_2578, visible_car_not_person(_2578,_2580)=true) :- % level: 1
     person(_2578),car(_2580).

cachingOrder2(_2756, entering_om(_2756,_2758)=true) :- % level: 2
     person(_2756),car(_2758).

