:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(shappy(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSDFluent(_3162,startI(happy(_3162)=true),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(shappy(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSDFluent(_3162,end(happy(_3162)=true),_3134),
     _3186=<_3134,
     _3134<_3192.

cachingOrder2(_3138, shappy(_3138)=true) :-
     person(_3138).
