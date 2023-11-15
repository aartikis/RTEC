initiatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(win_lottery(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

initiatedAt(location(_5012)=_4988, _5030, _4982, _5036) :-
     happensAtIE(go_to(_5012,_4988),_4982),
     _5030=<_4982,
     _4982<_5036.

initiatedAt(shappy(_5012)=true, _5038, _4982, _5044) :-
     happensAtProcessedSDFluent(_5012,startI(happy(_5012)=true),_4982),
     _5038=<_4982,
     _4982<_5044.

terminatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(lose_wallet(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(shappy(_5012)=true, _5038, _4982, _5044) :-
     happensAtProcessedSDFluent(_5012,end(happy(_5012)=true),_4982),
     _5038=<_4982,
     _4982<_5044.

holdsForSDFluent(happy(_5012)=true,_4982) :-
     holdsForProcessedSimpleFluent(_5012,rich(_5012)=true,_5028),
     holdsForProcessedSimpleFluent(_5012,location(_5012)=pub,_5044),
     union_all([_5028,_5044],_4982).

grounding(go_to(_5278,_5280)) :- 
     person(_5278),place(_5280).

grounding(lose_wallet(_5278)) :- 
     person(_5278).

grounding(win_lottery(_5278)) :- 
     person(_5278).

grounding(location(_5284)=_5280) :- 
     person(_5284),place(_5280).

grounding(rich(_5284)=true) :- 
     person(_5284).

grounding(happy(_5284)=true) :- 
     person(_5284).

grounding(shappy(_5284)=true) :- 
     person(_5284).

inputEntity(win_lottery(_5036)).
inputEntity(go_to(_5036,_5038)).
inputEntity(lose_wallet(_5036)).

outputEntity(rich(_5116)=true).
outputEntity(location(_5116)=_5112).
outputEntity(shappy(_5116)=true).
outputEntity(happy(_5116)=true).

event(win_lottery(_5190)).
event(go_to(_5190,_5192)).
event(lose_wallet(_5190)).

simpleFluent(rich(_5270)=true).
simpleFluent(location(_5270)=_5266).
simpleFluent(shappy(_5270)=true).

sDFluent(happy(_5344)=true).

index(win_lottery(_5352),_5352).
index(go_to(_5352,_5406),_5352).
index(lose_wallet(_5352),_5352).
index(rich(_5352)=true,_5352).
index(location(_5352)=_5406,_5352).
index(shappy(_5352)=true,_5352).
index(happy(_5352)=true,_5352).


cachingOrder2(_5650, rich(_5650)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5650).

cachingOrder2(_5628, location(_5628)=_5624) :- % level in dependency graph: 1, processing order in component: 1
     person(_5628),place(_5624).

cachingOrder2(_5870, happy(_5870)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_5870).

cachingOrder2(_6010, shappy(_6010)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_6010).

