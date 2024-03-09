initiatedAt(rich(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(win_lottery(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

initiatedAt(location(_1882)=_1858, _1900, _1852, _1906) :-
     happensAtIE(go_to(_1882,_1858),_1852),
     _1900=<_1852,
     _1852<_1906.

terminatedAt(rich(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(lose_wallet(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

holdsForSDFluent(happy(_1882)=true,_1852) :-
     holdsForProcessedSimpleFluent(_1882,rich(_1882)=true,_1898),
     holdsForProcessedSimpleFluent(_1882,location(_1882)=pub,_1914),
     union_all([_1898,_1914],_1852).

grounding(go_to(_2138,_2140)) :- 
     person(_2138),place(_2140).

grounding(lose_wallet(_2138)) :- 
     person(_2138).

grounding(win_lottery(_2138)) :- 
     person(_2138).

grounding(location(_2144)=pub) :- 
     person(_2144).

grounding(location(_2144)=home) :- 
     person(_2144).

grounding(location(_2144)=work) :- 
     person(_2144).

grounding(rich(_2144)=true) :- 
     person(_2144).

grounding(happy(_2144)=true) :- 
     person(_2144).

inputEntity(win_lottery(_1912)).
inputEntity(go_to(_1912,_1914)).
inputEntity(lose_wallet(_1912)).

outputEntity(rich(_1998)=true).
outputEntity(location(_1998)=pub).
outputEntity(location(_1998)=home).
outputEntity(location(_1998)=work).
outputEntity(happy(_1998)=true).

event(win_lottery(_2084)).
event(go_to(_2084,_2086)).
event(lose_wallet(_2084)).

simpleFluent(rich(_2170)=true).
simpleFluent(location(_2170)=pub).
simpleFluent(location(_2170)=home).
simpleFluent(location(_2170)=work).

sDFluent(happy(_2256)=true).

index(go_to(_2322,_2264),_2264).
index(win_lottery(_2264),_2264).
index(lose_wallet(_2264),_2264).
index(rich(_2264)=true,_2264).
index(location(_2264)=pub,_2264).
index(location(_2264)=home,_2264).
index(location(_2264)=work,_2264).
index(happy(_2264)=true,_2264).


cachingOrder2(_2630, rich(_2630)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2630).

cachingOrder2(_2608, location(_2608)=pub) :- % level in dependency graph: 1, processing order in component: 1
     person(_2608).

cachingOrder2(_2586, location(_2586)=home) :- % level in dependency graph: 1, processing order in component: 1
     person(_2586).

cachingOrder2(_2564, location(_2564)=work) :- % level in dependency graph: 1, processing order in component: 1
     person(_2564).

cachingOrder2(_2986, happy(_2986)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_2986).

