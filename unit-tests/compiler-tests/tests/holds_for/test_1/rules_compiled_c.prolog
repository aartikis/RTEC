:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
holdsForSDFluent(infiniteBeers(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,location(_3162)=pub,_3178),
     holdsForProcessedSimpleFluent(_3162,rich(_3162)=true,_3194),
     intersect_all([_3178,_3194],_3134).

cachingOrder2(_3138, infiniteBeers(_3138)=true) :-
     person(_3138).
