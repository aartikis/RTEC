:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(sleeping(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(sleep_start(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

terminatedAt(sleeping(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(sleep_end(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

cachingOrder2(_3138, sleeping(_3138)=true) :-
     person(_3138).
