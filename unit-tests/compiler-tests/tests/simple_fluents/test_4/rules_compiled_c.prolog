:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(rich(_3162)=true, _3202, _3134, _3208) :-
     happensAtIE(win_lottery(_3162),_3134),_3202=<_3134,_3134<_3208,
     \+holdsAtProcessedSDFluent(_3162,sleeping_at_work(_3162)=true,_3134).

terminatedAt(rich(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(lose_wallet(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

cachingOrder2(_3138, rich(_3138)=true) :-
     person(_3138).

cachingOrder2(_3138, rich(_3138)=false) :-
     person(_3138).
