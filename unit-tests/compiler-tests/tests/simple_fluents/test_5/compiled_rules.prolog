initiatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_start(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

initiatedAt(rich(_5012)=true, _5054, _4982, _5060) :-
     happensAtIE(win_lottery(_5012),_4982),_5054=<_4982,_4982<_5060,
     \+holdsAtProcessedSimpleFluent(_5012,sleeping(_5012)=true,_4982).

initiatedAt(srich(_5012)=true, _5038, _4982, _5044) :-
     happensAtProcessedSimpleFluent(_5012,start(rich(_5012)=true),_4982),
     _5038=<_4982,
     _4982<_5044.

terminatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_end(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(lose_wallet(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(srich(_5012)=true, _5038, _4982, _5044) :-
     happensAtProcessedSimpleFluent(_5012,end(rich(_5012)=true),_4982),
     _5038=<_4982,
     _4982<_5044.

grounding(sleep_start(_5260)) :- 
     person(_5260).

grounding(sleep_end(_5260)) :- 
     person(_5260).

grounding(win_lottery(_5260)) :- 
     person(_5260).

grounding(lose_lottery(_5260)) :- 
     person(_5260).

grounding(sleeping(_5266)=true) :- 
     person(_5266).

grounding(rich(_5266)=true) :- 
     person(_5266).

grounding(srich(_5266)=true) :- 
     person(_5266).

inputEntity(sleep_start(_5036)).
inputEntity(win_lottery(_5036)).
inputEntity(sleep_end(_5036)).
inputEntity(lose_wallet(_5036)).
inputEntity(lose_lottery(_5036)).

outputEntity(sleeping(_5128)=true).
outputEntity(rich(_5128)=true).
outputEntity(srich(_5128)=true).

event(sleep_start(_5196)).
event(win_lottery(_5196)).
event(sleep_end(_5196)).
event(lose_wallet(_5196)).
event(lose_lottery(_5196)).

simpleFluent(sleeping(_5288)=true).
simpleFluent(rich(_5288)=true).
simpleFluent(srich(_5288)=true).


index(sleep_start(_5364),_5364).
index(win_lottery(_5364),_5364).
index(sleep_end(_5364),_5364).
index(lose_wallet(_5364),_5364).
index(lose_lottery(_5364),_5364).
index(sleeping(_5364)=true,_5364).
index(rich(_5364)=true,_5364).
index(srich(_5364)=true,_5364).


cachingOrder2(_5646, sleeping(_5646)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5646).

cachingOrder2(_5786, rich(_5786)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_5786).

cachingOrder2(_5926, srich(_5926)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_5926).

