initiatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_start(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

initiatedAt(rich(_1974)=true, _2016, _1944, _2022) :-
     happensAtIE(win_lottery(_1974),_1944),_2016=<_1944,_1944<_2022,
     \+holdsAtProcessedSimpleFluent(_1974,sleeping(_1974)=true,_1944).

initiatedAt(srich(_1974)=true, _2000, _1944, _2006) :-
     happensAtProcessedSimpleFluent(_1974,start(rich(_1974)=true),_1944),
     _2000=<_1944,
     _1944<_2006.

terminatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_end(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(lose_wallet(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(srich(_1974)=true, _2000, _1944, _2006) :-
     happensAtProcessedSimpleFluent(_1974,end(rich(_1974)=true),_1944),
     _2000=<_1944,
     _1944<_2006.

grounding(sleep_start(_2222)) :- 
     person(_2222).

grounding(sleep_end(_2222)) :- 
     person(_2222).

grounding(win_lottery(_2222)) :- 
     person(_2222).

grounding(lose_lottery(_2222)) :- 
     person(_2222).

grounding(sleeping(_2228)=true) :- 
     person(_2228).

grounding(rich(_2228)=true) :- 
     person(_2228).

grounding(srich(_2228)=true) :- 
     person(_2228).

inputEntity(sleep_start(_1998)).
inputEntity(win_lottery(_1998)).
inputEntity(sleep_end(_1998)).
inputEntity(lose_wallet(_1998)).
inputEntity(lose_lottery(_1998)).

outputEntity(sleeping(_2090)=true).
outputEntity(rich(_2090)=true).
outputEntity(srich(_2090)=true).

event(sleep_start(_2158)).
event(win_lottery(_2158)).
event(sleep_end(_2158)).
event(lose_wallet(_2158)).
event(lose_lottery(_2158)).

simpleFluent(sleeping(_2250)=true).
simpleFluent(rich(_2250)=true).
simpleFluent(srich(_2250)=true).



index(sleep_start(_2382),_2382).
index(win_lottery(_2382),_2382).
index(sleep_end(_2382),_2382).
index(lose_wallet(_2382),_2382).
index(lose_lottery(_2382),_2382).
index(sleeping(_2382)=true,_2382).
index(rich(_2382)=true,_2382).
index(srich(_2382)=true,_2382).


cachingOrder2(_2664, sleeping(_2664)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2664).

cachingOrder2(_2804, rich(_2804)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_2804).

cachingOrder2(_2944, srich(_2944)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_2944).

