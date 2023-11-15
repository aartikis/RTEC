initiatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_start(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

initiatedAt(rich(_5012)=true, _5054, _4982, _5060) :-
     happensAtIE(win_lottery(_5012),_4982),_5054=<_4982,_4982<_5060,
     \+holdsAtProcessedSimpleFluent(_5012,sleeping(_5012)=true,_4982).

terminatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_end(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(lose_wallet(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

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

inputEntity(sleep_start(_5036)).
inputEntity(win_lottery(_5036)).
inputEntity(sleep_end(_5036)).
inputEntity(lose_wallet(_5036)).
inputEntity(lose_lottery(_5036)).

outputEntity(sleeping(_5128)=true).
outputEntity(rich(_5128)=true).

event(sleep_start(_5190)).
event(win_lottery(_5190)).
event(sleep_end(_5190)).
event(lose_wallet(_5190)).
event(lose_lottery(_5190)).

simpleFluent(sleeping(_5282)=true).
simpleFluent(rich(_5282)=true).


index(sleep_start(_5352),_5352).
index(win_lottery(_5352),_5352).
index(sleep_end(_5352),_5352).
index(lose_wallet(_5352),_5352).
index(lose_lottery(_5352),_5352).
index(sleeping(_5352)=true,_5352).
index(rich(_5352)=true,_5352).


cachingOrder2(_5628, sleeping(_5628)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5628).

cachingOrder2(_5768, rich(_5768)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_5768).

