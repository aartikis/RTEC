:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(srich(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(rich(_3162)=true),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(srich(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,end(rich(_3162)=true),_3134),
     _3186=<_3134,
     _3134<_3192.

cachingOrder2(_3138, srich(_3138)=true) :-
     person(_3138).
