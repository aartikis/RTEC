initiatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_start(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

initiatedAt(rich(_1974)=true, _2016, _1944, _2022) :-
     happensAtIE(win_lottery(_1974),_1944),_2016=<_1944,_1944<_2022,
     \+holdsAtProcessedSimpleFluent(_1974,sleeping(_1974)=true,_1944).

terminatedAt(sleeping(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(sleep_end(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

terminatedAt(rich(_1974)=true, _1990, _1944, _1996) :-
     happensAtIE(lose_wallet(_1974),_1944),
     _1990=<_1944,
     _1944<_1996.

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

inputEntity(sleep_start(_1998)).
inputEntity(win_lottery(_1998)).
inputEntity(sleep_end(_1998)).
inputEntity(lose_wallet(_1998)).
inputEntity(lose_lottery(_1998)).

outputEntity(sleeping(_2090)=true).
outputEntity(rich(_2090)=true).

event(sleep_start(_2152)).
event(win_lottery(_2152)).
event(sleep_end(_2152)).
event(lose_wallet(_2152)).
event(lose_lottery(_2152)).

simpleFluent(sleeping(_2244)=true).
simpleFluent(rich(_2244)=true).



index(sleep_start(_2370),_2370).
index(win_lottery(_2370),_2370).
index(sleep_end(_2370),_2370).
index(lose_wallet(_2370),_2370).
index(lose_lottery(_2370),_2370).
index(sleeping(_2370)=true,_2370).
index(rich(_2370)=true,_2370).


cachingOrder2(_2646, sleeping(_2646)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_2646).

cachingOrder2(_2786, rich(_2786)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_2786).

