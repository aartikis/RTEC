initiatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_start(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

initiatedAt(location(_1974)=_1950, _1992, _1944, _1998) :-
     happensAtIE(go_to(_1974,_1950),_1944),
     _1992=<_1944,
     _1944<_1998.

initiatedAt(rich(_1974)=true, _2016, _1944, _2022) :-
     happensAtIE(win_lottery(_1974),_1944),_2016=<_1944,_1944<_2022,
     \+holdsAtProcessedSDFluent(_1974,sleeping_at_work(_1974)=true,_1944).

terminatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_end(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(lose_wallet(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

holdsForSDFluent(sleeping_at_work(_1974)=true,_1944) :-
     holdsForProcessedSimpleFluent(_1974,sleeping(_1974)=true,_1990),
     holdsForProcessedSimpleFluent(_1974,location(_1974)=work,_2006),
     intersect_all([_1990,_2006],_1944).

grounding(sleep_start(_2240)) :- 
     person(_2240).

grounding(sleep_end(_2240)) :- 
     person(_2240).

grounding(go_to(_2240,_2242)) :- 
     person(_2240),place(_2242).

grounding(win_lottery(_2240)) :- 
     person(_2240).

grounding(lose_wallet(_2240)) :- 
     person(_2240).

grounding(sleeping(_2246)=true) :- 
     person(_2246).

grounding(location(_2246)=_2242) :- 
     person(_2246),place(_2242).

grounding(sleeping_at_work(_2246)=true) :- 
     person(_2246).

grounding(rich(_2246)=true) :- 
     person(_2246).

inputEntity(sleep_start(_1998)).
inputEntity(go_to(_1998,_2000)).
inputEntity(win_lottery(_1998)).
inputEntity(sleep_end(_1998)).
inputEntity(lose_wallet(_1998)).

outputEntity(sleeping(_2090)=true).
outputEntity(location(_2090)=_2086).
outputEntity(rich(_2090)=true).
outputEntity(sleeping_at_work(_2090)=true).

event(sleep_start(_2164)).
event(go_to(_2164,_2166)).
event(win_lottery(_2164)).
event(sleep_end(_2164)).
event(lose_wallet(_2164)).

simpleFluent(sleeping(_2256)=true).
simpleFluent(location(_2256)=_2252).
simpleFluent(rich(_2256)=true).


sDFluent(sleeping_at_work(_2386)=true).

index(sleep_start(_2394),_2394).
index(go_to(_2394,_2448),_2394).
index(win_lottery(_2394),_2394).
index(sleep_end(_2394),_2394).
index(lose_wallet(_2394),_2394).
index(sleeping(_2394)=true,_2394).
index(location(_2394)=_2448,_2394).
index(rich(_2394)=true,_2394).
index(sleeping_at_work(_2394)=true,_2394).


cachingOrder2(_2704, sleeping(_2704)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2704).

cachingOrder2(_2682, location(_2682)=_2678) :- % level in dependency graph: 1, processing order in component: 1
     person(_2682),place(_2678).

cachingOrder2(_2924, sleeping_at_work(_2924)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_2924).

cachingOrder2(_3064, rich(_3064)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_3064).

