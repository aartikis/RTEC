initiatedAt(rich(_5042)=true, _5058, _5012, _5064) :-
     happensAtIE(win_lottery(_5042),_5012),
     _5058=<_5012,
     _5012<_5064.

initiatedAt(location(_5042)=_5018, _5060, _5012, _5066) :-
     happensAtIE(go_to(_5042,_5018),_5012),
     _5060=<_5012,
     _5012<_5066.

terminatedAt(rich(_5042)=true, _5058, _5012, _5064) :-
     happensAtIE(lose_wallet(_5042),_5012),
     _5058=<_5012,
     _5012<_5064.

holdsForSDFluent(happy(_5042)=true,_5012) :-
     holdsForProcessedSimpleFluent(_5042,rich(_5042)=true,_5058),
     holdsForProcessedSimpleFluent(_5042,location(_5042)=pub,_5074),
     union_all([_5058,_5074],_5012).

grounding(go_to(_5326,_5328)) :- 
     person(_5326),place(_5328).

grounding(lose_wallet(_5326)) :- 
     person(_5326).

grounding(win_lottery(_5326)) :- 
     person(_5326).

grounding(location(_5332)=pub) :- 
     person(_5332).

grounding(location(_5332)=home) :- 
     person(_5332).

grounding(location(_5332)=work) :- 
     person(_5332).

grounding(rich(_5332)=true) :- 
     person(_5332).

grounding(happy(_5332)=true) :- 
     person(_5332).

inputEntity(win_lottery(_5066)).
inputEntity(go_to(_5066,_5068)).
inputEntity(lose_wallet(_5066)).

outputEntity(rich(_5146)=true).
outputEntity(location(_5146)=pub).
outputEntity(location(_5146)=home).
outputEntity(location(_5146)=work).
outputEntity(happy(_5146)=true).

event(win_lottery(_5226)).
event(go_to(_5226,_5228)).
event(lose_wallet(_5226)).

simpleFluent(rich(_5306)=true).
simpleFluent(location(_5306)=pub).
simpleFluent(location(_5306)=home).
simpleFluent(location(_5306)=work).

sDFluent(happy(_5386)=true).

index(go_to(_5446,_5394),_5394).
index(win_lottery(_5394),_5394).
index(lose_wallet(_5394),_5394).
index(rich(_5394)=true,_5394).
index(location(_5394)=pub,_5394).
index(location(_5394)=home,_5394).
index(location(_5394)=work,_5394).
index(happy(_5394)=true,_5394).


cachingOrder2(_5742, rich(_5742)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5742).

cachingOrder2(_5720, location(_5720)=pub) :- % level in dependency graph: 1, processing order in component: 1
     person(_5720).

cachingOrder2(_5698, location(_5698)=home) :- % level in dependency graph: 1, processing order in component: 1
     person(_5698).

cachingOrder2(_5676, location(_5676)=work) :- % level in dependency graph: 1, processing order in component: 1
     person(_5676).

cachingOrder2(_6092, happy(_6092)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_6092).

