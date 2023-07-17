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

holdsForSDFluent(rich_before_pub(_5040)=true,_5010) :-
     holdsForProcessedSimpleFluent(_5040,rich(_5040)=true,_5056),
     holdsForProcessedSimpleFluent(_5040,location(_5040)=pub,_5072),
     before(rich_before_pub(_5040)=true,0,_5056,_5072,union,true,_5010).

holdsForSDFluent(rich_starts_happy(_5040)=true,_5010) :-
     holdsForProcessedSimpleFluent(_5040,rich(_5040)=true,_5056),
     holdsForProcessedSDFluent(_5040,happy(_5040)=true,_5072),
     starts(rich_starts_happy(_5040)=true,0,_5056,_5072,source,true,_5010).

holdsForSDFluent(rich_finishes_happy(_5040)=true,_5010) :-
     holdsForProcessedSimpleFluent(_5040,rich(_5040)=true,_5056),
     holdsForProcessedSDFluent(_5040,happy(_5040)=true,_5072),
     finishes(rich_finishes_happy(_5040)=true,0,_5056,_5072,source,true,_5010).

holdsForSDFluent(pub_during_happy(_5040)=true,_5010) :-
     holdsForProcessedSimpleFluent(_5040,location(_5040)=pub,_5056),
     holdsForProcessedSDFluent(_5040,happy(_5040)=true,_5072),
     during(pub_during_happy(_5040)=true,0,_5056,_5072,source,true,_5010).

holdsForSDFluent(rich_overlaps_pub(_5040)=true,_5010) :-
     holdsForProcessedSimpleFluent(_5040,rich(_5040)=true,_5056),
     holdsForProcessedSimpleFluent(_5040,location(_5040)=pub,_5072),
     overlaps(rich_overlaps_pub(_5040)=true,0,_5056,_5072,union,true,_5010).

holdsForSDFluent(rich_equal_happy(_5040)=true,_5010) :-
     holdsForProcessedSimpleFluent(_5040,rich(_5040)=true,_5056),
     holdsForProcessedSDFluent(_5040,happy(_5040)=true,_5072),
     equal(rich_equal_happy(_5040)=true,0,_5056,_5072,source,true,_5010).

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

grounding(rich_before_pub(_5330)=true) :- 
     person(_5330).

grounding(rich_before_pub_before_home(_5330)=true) :- 
     person(_5330).

grounding(rich_starts_happy(_5330)=true) :- 
     person(_5330).

grounding(rich_finishes_happy(_5330)=true) :- 
     person(_5330).

grounding(pub_during_happy(_5330)=true) :- 
     person(_5330).

grounding(rich_overlaps_pub(_5330)=true) :- 
     person(_5330).

grounding(rich_equal_happy(_5330)=true) :- 
     person(_5330).

inputEntity(win_lottery(_5064)).
inputEntity(go_to(_5064,_5066)).
inputEntity(lose_wallet(_5064)).
inputEntity(rich_before_pub_before_home(_5070)=true).

outputEntity(rich(_5150)=true).
outputEntity(location(_5150)=_5146).
outputEntity(happy(_5150)=true).
outputEntity(rich_before_pub(_5150)=true).
outputEntity(rich_starts_happy(_5150)=true).
outputEntity(rich_finishes_happy(_5150)=true).
outputEntity(pub_during_happy(_5150)=true).
outputEntity(rich_overlaps_pub(_5150)=true).
outputEntity(rich_equal_happy(_5150)=true).

event(win_lottery(_5254)).
event(go_to(_5254,_5256)).
event(lose_wallet(_5254)).

simpleFluent(rich(_5334)=true).
simpleFluent(location(_5334)=_5330).

sDFluent(happy(_5402)=true).
sDFluent(rich_before_pub(_5402)=true).
sDFluent(rich_starts_happy(_5402)=true).
sDFluent(rich_finishes_happy(_5402)=true).
sDFluent(pub_during_happy(_5402)=true).
sDFluent(rich_overlaps_pub(_5402)=true).
sDFluent(rich_equal_happy(_5402)=true).
sDFluent(rich_before_pub_before_home(_5402)=true).

index(go_to(_5504,_5452),_5452).
index(win_lottery(_5452),_5452).
index(lose_wallet(_5452),_5452).
index(rich(_5452)=true,_5452).
index(location(_5452)=_5506,_5452).
index(happy(_5452)=true,_5452).
index(rich_before_pub(_5452)=true,_5452).
index(rich_starts_happy(_5452)=true,_5452).
index(rich_finishes_happy(_5452)=true,_5452).
index(pub_during_happy(_5452)=true,_5452).
index(rich_overlaps_pub(_5452)=true,_5452).
index(rich_equal_happy(_5452)=true,_5452).
index(rich_before_pub_before_home(_5452)=true,_5452).


cachingOrder2(_5774, rich(_5774)=true) :- % level: 1
     person(_5774).

cachingOrder2(_5758, location(_5758)=_5754) :- % level: 1
     person(_5758),place(_5754).

cachingOrder2(_5944, happy(_5944)=true) :- % level: 2
     person(_5944).

cachingOrder2(_5928, rich_before_pub(_5928)=true) :- % level: 2
     person(_5928).

cachingOrder2(_5912, rich_overlaps_pub(_5912)=true) :- % level: 2
     person(_5912).

cachingOrder2(_6152, rich_starts_happy(_6152)=true) :- % level: 3
     person(_6152).

cachingOrder2(_6136, rich_finishes_happy(_6136)=true) :- % level: 3
     person(_6136).

cachingOrder2(_6120, pub_during_happy(_6120)=true) :- % level: 3
     person(_6120).

cachingOrder2(_6104, rich_equal_happy(_6104)=true) :- % level: 3
     person(_6104).

