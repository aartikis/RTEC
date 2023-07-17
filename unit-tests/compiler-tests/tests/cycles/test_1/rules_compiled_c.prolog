:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(strength(_3162)=tired, _3204, _3134, _3210) :-
     happensAtIE(ends_working(_3162),_3134),_3204=<_3134,_3134<_3210,
     holdsAtCyclic(_3162,strength(_3162)=lowering,_3134).

initiatedAt(strength(_3162)=lowering, _3204, _3134, _3210) :-
     happensAtIE(starts_working(_3162),_3134),_3204=<_3134,_3134<_3210,
     holdsAtCyclic(_3162,strength(_3162)=full,_3134).

initiatedAt(strength(_3162)=full, _3204, _3134, _3210) :-
     happensAtIE(sleep_end(_3162),_3134),_3204=<_3134,_3134<_3210,
     holdsAtCyclic(_3162,strength(_3162)=tired,_3134).

initiatedAt(strength(_3170)=full, _3134, -1, _3138) :-
     _3134=< -1,
     -1<_3138.

cachingOrder2(_3138, strength(_3138)=full) :-
     person(_3138).

cachingOrder2(_3138, strength(_3138)=tired) :-
     person(_3138).

cachingOrder2(_3138, strength(_3138)=lowering) :-
     person(_3138).
