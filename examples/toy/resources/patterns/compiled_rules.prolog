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

grounding(location(_2144)=_2140) :- 
     person(_2144),place(_2140).

grounding(rich(_2144)=true) :- 
     person(_2144).

grounding(happy(_2144)=true) :- 
     person(_2144).

inputEntity(win_lottery(_1912)).
inputEntity(go_to(_1912,_1914)).
inputEntity(lose_wallet(_1912)).

outputEntity(rich(_1998)=true).
outputEntity(location(_1998)=_1994).
outputEntity(happy(_1998)=true).

event(win_lottery(_2072)).
event(go_to(_2072,_2074)).
event(lose_wallet(_2072)).

simpleFluent(rich(_2158)=true).
simpleFluent(location(_2158)=_2154).

sDFluent(happy(_2232)=true).

index(go_to(_2298,_2240),_2240).
index(win_lottery(_2240),_2240).
index(lose_wallet(_2240),_2240).
index(rich(_2240)=true,_2240).
index(location(_2240)=_2300,_2240).
index(happy(_2240)=true,_2240).


cachingOrder2(_2538, rich(_2538)=true) :- % level: 1
     person(_2538).

cachingOrder2(_2522, location(_2522)=_2518) :- % level: 1
     person(_2522),place(_2518).

cachingOrder2(_2682, happy(_2682)=true) :- % level: 2
     person(_2682).

