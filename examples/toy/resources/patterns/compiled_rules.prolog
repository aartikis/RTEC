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

grounding(location(_5332)=_5328) :- 
     person(_5332),place(_5328).

grounding(rich(_5332)=true) :- 
     person(_5332).

grounding(happy(_5332)=true) :- 
     person(_5332).

inputEntity(win_lottery(_5066)).
inputEntity(go_to(_5066,_5068)).
inputEntity(lose_wallet(_5066)).

outputEntity(rich(_5146)=true).
outputEntity(location(_5146)=_5142).
outputEntity(happy(_5146)=true).

event(win_lottery(_5214)).
event(go_to(_5214,_5216)).
event(lose_wallet(_5214)).

simpleFluent(rich(_5294)=true).
simpleFluent(location(_5294)=_5290).

sDFluent(happy(_5362)=true).

index(go_to(_5422,_5370),_5370).
index(win_lottery(_5370),_5370).
index(lose_wallet(_5370),_5370).
index(rich(_5370)=true,_5370).
index(location(_5370)=_5424,_5370).
index(happy(_5370)=true,_5370).


cachingOrder2(_5662, rich(_5662)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5662).

cachingOrder2(_5640, location(_5640)=_5636) :- % level in dependency graph: 1, processing order in component: 1
     person(_5640),place(_5636).

cachingOrder2(_5882, happy(_5882)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_5882).

