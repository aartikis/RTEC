initiatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(win_lottery(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

initiatedAt(location(_1974)=_1950, _1992, _1944, _1998) :-
     happensAtIE(go_to(_1974,_1950),_1944),
     _1992=<_1944,
     _1944<_1998.

initiatedAt(shappy(_1974)=true, _2000, _1944, _2006) :-
     happensAtProcessedSDFluent(_1974,startI(happy(_1974)=true),_1944),
     _2000=<_1944,
     _1944<_2006.

terminatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(lose_wallet(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(shappy(_1974)=true, _2000, _1944, _2006) :-
     happensAtProcessedSDFluent(_1974,end(happy(_1974)=true),_1944),
     _2000=<_1944,
     _1944<_2006.

holdsForSDFluent(happy(_1974)=true,_1944) :-
     holdsForProcessedSimpleFluent(_1974,rich(_1974)=true,_1990),
     holdsForProcessedSimpleFluent(_1974,location(_1974)=pub,_2006),
     union_all([_1990,_2006],_1944).

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

grounding(happy(_2246)=true) :- 
     person(_2246).

grounding(shappy(_2246)=true) :- 
     person(_2246).

inputEntity(win_lottery(_1998)).
inputEntity(go_to(_1998,_2000)).
inputEntity(lose_wallet(_1998)).

outputEntity(rich(_2078)=true).
outputEntity(location(_2078)=_2074).
outputEntity(shappy(_2078)=true).
outputEntity(happy(_2078)=true).

event(win_lottery(_2152)).
event(go_to(_2152,_2154)).
event(lose_wallet(_2152)).

simpleFluent(rich(_2232)=true).
simpleFluent(location(_2232)=_2228).
simpleFluent(shappy(_2232)=true).


sDFluent(happy(_2362)=true).

index(win_lottery(_2370),_2370).
index(go_to(_2370,_2424),_2370).
index(lose_wallet(_2370),_2370).
index(rich(_2370)=true,_2370).
index(location(_2370)=_2424,_2370).
index(shappy(_2370)=true,_2370).
index(happy(_2370)=true,_2370).


cachingOrder2(_2668, rich(_2668)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2668).

cachingOrder2(_2646, location(_2646)=_2642) :- % level in dependency graph: 1, processing order in component: 1
     person(_2646),place(_2642).

cachingOrder2(_2888, happy(_2888)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_2888).

cachingOrder2(_3028, shappy(_3028)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_3028).

