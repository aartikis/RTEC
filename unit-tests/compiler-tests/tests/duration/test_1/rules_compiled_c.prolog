:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(working(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(starts_working(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

terminatedAt(working(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(ends_working(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

cachingOrder2(_3138, working(_3138)=true) :-
     person(_3138).

cachingOrder2(_3138, working(_3138)=false) :-
     person(_3138).

maxDuration(working(_3360)=true,working(_3360)=false,8) :- 
     grounding(working(_3360)=true).
