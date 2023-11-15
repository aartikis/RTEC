initiatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_start(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

initiatedAt(location(_5012)=_4988, _5030, _4982, _5036) :-
     happensAtIE(go_to(_5012,_4988),_4982),
     _5030=<_4982,
     _4982<_5036.

initiatedAt(rich(_5012)=true, _5054, _4982, _5060) :-
     happensAtIE(win_lottery(_5012),_4982),_5054=<_4982,_4982<_5060,
     \+holdsAtProcessedSDFluent(_5012,sleeping_at_work(_5012)=true,_4982).

terminatedAt(sleeping(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(sleep_end(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(lose_wallet(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

holdsForSDFluent(sleeping_at_work(_5012)=true,_4982) :-
     holdsForProcessedSimpleFluent(_5012,sleeping(_5012)=true,_5028),
     holdsForProcessedSimpleFluent(_5012,location(_5012)=work,_5044),
     intersect_all([_5028,_5044],_4982).

grounding(sleep_start(_5278)) :- 
     person(_5278).

grounding(sleep_end(_5278)) :- 
     person(_5278).

grounding(go_to(_5278,_5280)) :- 
     person(_5278),place(_5280).

grounding(win_lottery(_5278)) :- 
     person(_5278).

grounding(lose_wallet(_5278)) :- 
     person(_5278).

grounding(sleeping(_5284)=true) :- 
     person(_5284).

grounding(location(_5284)=_5280) :- 
     person(_5284),place(_5280).

grounding(sleeping_at_work(_5284)=true) :- 
     person(_5284).

grounding(rich(_5284)=true) :- 
     person(_5284).

inputEntity(sleep_start(_5036)).
inputEntity(go_to(_5036,_5038)).
inputEntity(win_lottery(_5036)).
inputEntity(sleep_end(_5036)).
inputEntity(lose_wallet(_5036)).

outputEntity(sleeping(_5128)=true).
outputEntity(location(_5128)=_5124).
outputEntity(rich(_5128)=true).
outputEntity(sleeping_at_work(_5128)=true).

event(sleep_start(_5202)).
event(go_to(_5202,_5204)).
event(win_lottery(_5202)).
event(sleep_end(_5202)).
event(lose_wallet(_5202)).

simpleFluent(sleeping(_5294)=true).
simpleFluent(location(_5294)=_5290).
simpleFluent(rich(_5294)=true).

sDFluent(sleeping_at_work(_5368)=true).

index(sleep_start(_5376),_5376).
index(go_to(_5376,_5430),_5376).
index(win_lottery(_5376),_5376).
index(sleep_end(_5376),_5376).
index(lose_wallet(_5376),_5376).
index(sleeping(_5376)=true,_5376).
index(location(_5376)=_5430,_5376).
index(rich(_5376)=true,_5376).
index(sleeping_at_work(_5376)=true,_5376).


cachingOrder2(_5686, sleeping(_5686)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5686).

cachingOrder2(_5664, location(_5664)=_5660) :- % level in dependency graph: 1, processing order in component: 1
     person(_5664),place(_5660).

cachingOrder2(_5906, sleeping_at_work(_5906)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_5906).

cachingOrder2(_6046, rich(_6046)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_6046).

