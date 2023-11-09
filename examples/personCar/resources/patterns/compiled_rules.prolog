holdsForSDFluent(entering_om(_5044,_5046)=true,_5014) :-
     holdsForProcessedSDFluent(_5044,far_from_overlaps_adjacent(_5044,_5046)=true,_5064),
     holdsForProcessedSDFluent(_5044,visible_car_not_person(_5044,_5046)=true,_5082),
     meets(entering_om(_5044,_5046)=true,0,_5064,_5082,union,true,_5014).

holdsForSDFluent(far_from_overlaps_adjacent(_5044,_5046)=true,_5014) :-
     holdsForProcessedIE(_5044,far_from(_5044,_5046)=true,_5064),
     holdsForProcessedIE(_5044,adjacent(_5044,_5046)=true,_5082),
     overlaps(far_from_overlaps_adjacent(_5044,_5046)=true,0,_5064,_5082,union,true,_5014).

holdsForSDFluent(visible_car_not_person(_5044,_5046)=true,_5014) :-
     holdsForProcessedIE(_5046,visible_car(_5046)=true,_5062),
     holdsForProcessedIE(_5044,visible_person(_5044)=false,_5078),
     intersect_all([_5062,_5078],_5014).

collectIntervals2(_5018, far_from(_5018,_5020)=true) :-
     person(_5018),car(_5020).

collectIntervals2(_5018, adjacent(_5018,_5020)=true) :-
     person(_5018),car(_5020).

collectIntervals2(_5018, visible_person(_5018)=true) :-
     person(_5018).

collectIntervals2(_5018, visible_person(_5018)=false) :-
     person(_5018).

collectIntervals2(_5018, visible_car(_5018)=true) :-
     car(_5018).

grounding(far_from(_5296,_5298)=true) :- 
     person(_5296),car(_5298).

grounding(adjacent(_5296,_5298)=true) :- 
     person(_5296),car(_5298).

grounding(visible_person(_5296)=true) :- 
     person(_5296).

grounding(visible_person(_5296)=false) :- 
     person(_5296).

grounding(visible_car(_5296)=true) :- 
     car(_5296).

grounding(visible_car_not_person(_5296,_5298)=true) :- 
     person(_5296),car(_5298).

grounding(far_from_meets_adjacent(_5296,_5298)=true) :- 
     person(_5296),car(_5298).

grounding(far_from_overlaps_adjacent(_5296,_5298)=true) :- 
     person(_5296),car(_5298).

grounding(entering_om(_5296,_5298)=true) :- 
     person(_5296),car(_5298).

inputEntity(far_from(_5074,_5076)=true).
inputEntity(adjacent(_5074,_5076)=true).
inputEntity(visible_car(_5074)=true).
inputEntity(visible_person(_5074)=false).
inputEntity(visible_person(_5074)=true).
inputEntity(far_from_meets_adjacent(_5074,_5076)=true).

outputEntity(entering_om(_5166,_5168)=true).
outputEntity(far_from_overlaps_adjacent(_5166,_5168)=true).
outputEntity(visible_car_not_person(_5166,_5168)=true).



sDFluent(entering_om(_5352,_5354)=true).
sDFluent(far_from_overlaps_adjacent(_5352,_5354)=true).
sDFluent(visible_car_not_person(_5352,_5354)=true).
sDFluent(far_from(_5352,_5354)=true).
sDFluent(adjacent(_5352,_5354)=true).
sDFluent(visible_car(_5352)=true).
sDFluent(visible_person(_5352)=false).
sDFluent(visible_person(_5352)=true).
sDFluent(far_from_meets_adjacent(_5352,_5354)=true).

index(entering_om(_5408,_5468)=true,_5408).
index(far_from_overlaps_adjacent(_5408,_5468)=true,_5408).
index(visible_car_not_person(_5408,_5468)=true,_5408).
index(far_from(_5408,_5468)=true,_5408).
index(adjacent(_5408,_5468)=true,_5408).
index(visible_car(_5408)=true,_5408).
index(visible_person(_5408)=false,_5408).
index(visible_person(_5408)=true,_5408).
index(far_from_meets_adjacent(_5408,_5468)=true,_5408).


cachingOrder2(_5708, far_from_overlaps_adjacent(_5708,_5710)=true) :- % level: 1
     person(_5708),car(_5710).

cachingOrder2(_5690, visible_car_not_person(_5690,_5692)=true) :- % level: 1
     person(_5690),car(_5692).

cachingOrder2(_5862, entering_om(_5862,_5864)=true) :- % level: 2
     person(_5862),car(_5864).

