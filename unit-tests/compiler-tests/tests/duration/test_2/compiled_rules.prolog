initiatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(win_lottery(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(lose_wallet(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

fi(rich(_1978)=true,rich(_1978)=false,4):-
     grounding(rich(_1978)=true),
     grounding(rich(_1978)=false).

grounding(win_lottery(_2258)) :- 
     person(_2258).

grounding(lose_lottery(_2258)) :- 
     person(_2258).

grounding(rich(_2264)=true) :- 
     person(_2264).

grounding(rich(_2264)=false) :- 
     person(_2264).

p(rich(_2258)=true).

inputEntity(win_lottery(_1998)).
inputEntity(lose_wallet(_1998)).
inputEntity(lose_lottery(_1998)).

outputEntity(rich(_2078)=true).
outputEntity(rich(_2078)=false).

event(win_lottery(_2140)).
event(lose_wallet(_2140)).
event(lose_lottery(_2140)).

simpleFluent(rich(_2220)=true).
simpleFluent(rich(_2220)=false).



index(win_lottery(_2346),_2346).
index(lose_wallet(_2346),_2346).
index(lose_lottery(_2346),_2346).
index(rich(_2346)=true,_2346).
index(rich(_2346)=false,_2346).


cachingOrder2(_2610, rich(_2610)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2610).

cachingOrder2(_2610, rich(_2610)=false) :- % level in dependency graph: 1, processing order in component: 2
     person(_2610).

