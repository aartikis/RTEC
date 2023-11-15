initiatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(win_lottery(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

initiatedAt(location(_5012)=_4988, _5030, _4982, _5036) :-
     happensAtIE(go_to(_5012,_4988),_4982),
     _5030=<_4982,
     _4982<_5036.

terminatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(lose_wallet(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

holdsForSDFluent(infiniteBeers(_5012)=true,_4982) :-
     holdsForProcessedSimpleFluent(_5012,location(_5012)=pub,_5028),
     holdsForProcessedSimpleFluent(_5012,rich(_5012)=true,_5044),
     intersect_all([_5028,_5044],_4982).

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

grounding(infiniteBeers(_5284)=true) :- 
     person(_5284).

inputEntity(win_lottery(_5036)).
inputEntity(go_to(_5036,_5038)).
inputEntity(lose_wallet(_5036)).

outputEntity(rich(_5116)=true).
outputEntity(location(_5116)=_5112).
outputEntity(infiniteBeers(_5116)=true).

event(win_lottery(_5184)).
event(go_to(_5184,_5186)).
event(lose_wallet(_5184)).

simpleFluent(rich(_5264)=true).
simpleFluent(location(_5264)=_5260).

sDFluent(infiniteBeers(_5332)=true).

index(win_lottery(_5340),_5340).
index(go_to(_5340,_5394),_5340).
index(lose_wallet(_5340),_5340).
index(rich(_5340)=true,_5340).
index(location(_5340)=_5394,_5340).
index(infiniteBeers(_5340)=true,_5340).


cachingOrder2(_5632, rich(_5632)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5632).

cachingOrder2(_5610, location(_5610)=_5606) :- % level in dependency graph: 1, processing order in component: 1
     person(_5610),place(_5606).

cachingOrder2(_5852, infiniteBeers(_5852)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_5852).

