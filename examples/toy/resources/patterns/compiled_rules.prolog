initiatedAt(rich(_5038)=true, _5054, _5008, _5060) :-
     happensAtIE(win_lottery(_5038),_5008),
     _5054=<_5008,
     _5008<_5060.

initiatedAt(location(_5038)=_5014, _5056, _5008, _5062) :-
     happensAtIE(go_to(_5038,_5014),_5008),
     _5056=<_5008,
     _5008<_5062.

terminatedAt(rich(_5038)=true, _5054, _5008, _5060) :-
     happensAtIE(lose_wallet(_5038),_5008),
     _5054=<_5008,
     _5008<_5060.

holdsForSDFluent(happy(_5038)=true,_5008) :-
     holdsForProcessedSimpleFluent(_5038,rich(_5038)=true,_5054),
     holdsForProcessedSimpleFluent(_5038,location(_5038)=pub,_5070),
     union_all([_5054,_5070],_5008).

grounding(go_to(_5322,_5324)) :- 
     person(_5322),place(_5324).

grounding(lose_wallet(_5322)) :- 
     person(_5322).

grounding(win_lottery(_5322)) :- 
     person(_5322).

grounding(location(_5328)=pub) :- 
     person(_5328).

grounding(location(_5328)=home) :- 
     person(_5328).

grounding(location(_5328)=work) :- 
     person(_5328).

grounding(rich(_5328)=true) :- 
     person(_5328).

grounding(happy(_5328)=true) :- 
     person(_5328).

inputEntity(win_lottery(_5062)).
inputEntity(go_to(_5062,_5064)).
inputEntity(lose_wallet(_5062)).

outputEntity(rich(_5142)=true).
outputEntity(location(_5142)=pub).
outputEntity(location(_5142)=home).
outputEntity(location(_5142)=work).
outputEntity(happy(_5142)=true).

event(win_lottery(_5222)).
event(go_to(_5222,_5224)).
event(lose_wallet(_5222)).

simpleFluent(rich(_5302)=true).
simpleFluent(location(_5302)=pub).
simpleFluent(location(_5302)=home).
simpleFluent(location(_5302)=work).

sDFluent(happy(_5382)=true).

index(go_to(_5442,_5390),_5390).
index(win_lottery(_5390),_5390).
index(lose_wallet(_5390),_5390).
index(rich(_5390)=true,_5390).
index(location(_5390)=pub,_5390).
index(location(_5390)=home,_5390).
index(location(_5390)=work,_5390).
index(happy(_5390)=true,_5390).


cachingOrder2(_5738, rich(_5738)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5738).

cachingOrder2(_5716, location(_5716)=pub) :- % level in dependency graph: 1, processing order in component: 1
     person(_5716).

cachingOrder2(_5694, location(_5694)=home) :- % level in dependency graph: 1, processing order in component: 1
     person(_5694).

cachingOrder2(_5672, location(_5672)=work) :- % level in dependency graph: 1, processing order in component: 1
     person(_5672).

cachingOrder2(_6088, happy(_6088)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_6088).

