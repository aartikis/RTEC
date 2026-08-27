initiatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(win_lottery(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

initiatedAt(location(_1974)=_1950, _1992, _1944, _1998) :-
     happensAtIE(go_to(_1974,_1950),_1944),
     _1992=<_1944,
     _1944<_1998.

terminatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(lose_wallet(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

holdsForSDFluent(infiniteBeers(_1974)=true,_1944) :-
     holdsForProcessedSimpleFluent(_1974,location(_1974)=pub,_1990),
     holdsForProcessedSimpleFluent(_1974,rich(_1974)=true,_2006),
     intersect_all([_1990,_2006],_1944).

grounding(go_to(_2240,_2242)) :- 
     person(_2240),place(_2242).

grounding(lose_wallet(_2240)) :- 
     person(_2240).

grounding(win_lottery(_2240)) :- 
     person(_2240).

grounding(location(_2246)=_2242) :- 
     person(_2246),place(_2242).

grounding(rich(_2246)=true) :- 
     person(_2246).

grounding(infiniteBeers(_2246)=true) :- 
     person(_2246).

inputEntity(win_lottery(_1998)).
inputEntity(go_to(_1998,_2000)).
inputEntity(lose_wallet(_1998)).

outputEntity(rich(_2078)=true).
outputEntity(location(_2078)=_2074).
outputEntity(infiniteBeers(_2078)=true).

event(win_lottery(_2146)).
event(go_to(_2146,_2148)).
event(lose_wallet(_2146)).

simpleFluent(rich(_2226)=true).
simpleFluent(location(_2226)=_2222).


sDFluent(infiniteBeers(_2350)=true).

index(win_lottery(_2358),_2358).
index(go_to(_2358,_2412),_2358).
index(lose_wallet(_2358),_2358).
index(rich(_2358)=true,_2358).
index(location(_2358)=_2412,_2358).
index(infiniteBeers(_2358)=true,_2358).


cachingOrder2(_2650, rich(_2650)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2650).

cachingOrder2(_2628, location(_2628)=_2624) :- % level in dependency graph: 1, processing order in component: 1
     person(_2628),place(_2624).

cachingOrder2(_2870, infiniteBeers(_2870)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_2870).

