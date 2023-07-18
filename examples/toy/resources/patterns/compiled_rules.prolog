initiatedAt(rich(_5040)=true, _5056, _5010, _5062) :-
     happensAtIE(win_lottery(_5040),_5010),
     _5056=<_5010,
     _5010<_5062.

initiatedAt(location(_5040)=_5016, _5058, _5010, _5064) :-
     happensAtIE(go_to(_5040,_5016),_5010),
     _5058=<_5010,
     _5010<_5064.

terminatedAt(rich(_5040)=true, _5056, _5010, _5062) :-
     happensAtIE(lose_wallet(_5040),_5010),
     _5056=<_5010,
     _5010<_5062.

holdsForSDFluent(happy(_5040)=true,_5010) :-
     holdsForProcessedSimpleFluent(_5040,rich(_5040)=true,_5056),
     holdsForProcessedSimpleFluent(_5040,location(_5040)=pub,_5072),
     union_all([_5056,_5072],_5010).

grounding(go_to(_5324,_5326)) :- 
     person(_5324),place(_5326).

grounding(lose_wallet(_5324)) :- 
     person(_5324).

grounding(win_lottery(_5324)) :- 
     person(_5324).

grounding(location(_5330)=_5326) :- 
     person(_5330),place(_5326).

grounding(rich(_5330)=true) :- 
     person(_5330).

grounding(happy(_5330)=true) :- 
     person(_5330).

inputEntity(win_lottery(_5064)).
inputEntity(go_to(_5064,_5066)).
inputEntity(lose_wallet(_5064)).

outputEntity(rich(_5144)=true).
outputEntity(location(_5144)=_5140).
outputEntity(happy(_5144)=true).

event(win_lottery(_5212)).
event(go_to(_5212,_5214)).
event(lose_wallet(_5212)).

simpleFluent(rich(_5292)=true).
simpleFluent(location(_5292)=_5288).

sDFluent(happy(_5360)=true).

index(go_to(_5420,_5368),_5368).
index(win_lottery(_5368),_5368).
index(lose_wallet(_5368),_5368).
index(rich(_5368)=true,_5368).
index(location(_5368)=_5422,_5368).
index(happy(_5368)=true,_5368).


cachingOrder2(_5648, rich(_5648)=true) :- % level: 1
     person(_5648).

cachingOrder2(_5632, location(_5632)=_5628) :- % level: 1
     person(_5632),place(_5628).

cachingOrder2(_5786, happy(_5786)=true) :- % level: 2
     person(_5786).

