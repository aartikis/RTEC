initiatedAt(working(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(starts_working(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(working(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(ends_working(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

fi(working(_1978)=true,working(_1978)=false,8):-
     grounding(working(_1978)=true),
     grounding(working(_1978)=false).

grounding(starts_working(_2242)) :- 
     person(_2242).

grounding(ends_working(_2242)) :- 
     person(_2242).

grounding(working(_2248)=true) :- 
     person(_2248).

grounding(working(_2248)=false) :- 
     person(_2248).

inputEntity(starts_working(_1998)).
inputEntity(ends_working(_1998)).

outputEntity(working(_2072)=true).
outputEntity(working(_2072)=false).

event(starts_working(_2134)).
event(ends_working(_2134)).

simpleFluent(working(_2208)=true).
simpleFluent(working(_2208)=false).



index(starts_working(_2334),_2334).
index(ends_working(_2334),_2334).
index(working(_2334)=true,_2334).
index(working(_2334)=false,_2334).


cachingOrder2(_2592, working(_2592)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2592).

cachingOrder2(_2592, working(_2592)=false) :- % level in dependency graph: 1, processing order in component: 2
     person(_2592).

