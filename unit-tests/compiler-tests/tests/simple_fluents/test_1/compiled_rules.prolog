initiatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_start(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_end(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

grounding(sleep_start(_2222)) :- 
     person(_2222).

grounding(sleep_end(_2222)) :- 
     person(_2222).

grounding(sleeping(_2228)=true) :- 
     person(_2228).

inputEntity(sleep_start(_1998)).
inputEntity(sleep_end(_1998)).

outputEntity(sleeping(_2072)=true).

event(sleep_start(_2128)).
event(sleep_end(_2128)).

simpleFluent(sleeping(_2202)=true).



index(sleep_start(_2322),_2322).
index(sleep_end(_2322),_2322).
index(sleeping(_2322)=true,_2322).


cachingOrder2(_2574, sleeping(_2574)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2574).

