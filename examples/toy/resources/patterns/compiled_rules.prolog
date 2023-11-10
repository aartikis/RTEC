:- dynamic person/1.

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

holdsForSDFluent(rich_before_pub(_5042)=true,_5012) :-
     holdsForProcessedSimpleFluent(_5042,rich(_5042)=true,_5058),
     holdsForProcessedSimpleFluent(_5042,location(_5042)=pub,_5074),
     before(rich_before_pub(_5042)=true,0,_5058,_5074,union,true,_5012).

holdsForSDFluent(rich_starts_happy(_5042)=true,_5012) :-
     holdsForProcessedSimpleFluent(_5042,rich(_5042)=true,_5058),
     holdsForProcessedSDFluent(_5042,happy(_5042)=true,_5074),
     starts(rich_starts_happy(_5042)=true,0,_5058,_5074,source,true,_5012).

holdsForSDFluent(rich_finishes_happy(_5042)=true,_5012) :-
     holdsForProcessedSimpleFluent(_5042,rich(_5042)=true,_5058),
     holdsForProcessedSDFluent(_5042,happy(_5042)=true,_5074),
     finishes(rich_finishes_happy(_5042)=true,0,_5058,_5074,source,true,_5012).

holdsForSDFluent(pub_during_happy(_5042)=true,_5012) :-
     holdsForProcessedSimpleFluent(_5042,location(_5042)=pub,_5058),
     holdsForProcessedSDFluent(_5042,happy(_5042)=true,_5074),
     during(pub_during_happy(_5042)=true,0,_5058,_5074,source,true,_5012).

holdsForSDFluent(rich_overlaps_pub(_5042)=true,_5012) :-
     holdsForProcessedSimpleFluent(_5042,rich(_5042)=true,_5058),
     holdsForProcessedSimpleFluent(_5042,location(_5042)=pub,_5074),
     overlaps(rich_overlaps_pub(_5042)=true,0,_5058,_5074,union,true,_5012).

holdsForSDFluent(rich_equal_happy(_5042)=true,_5012) :-
     holdsForProcessedSimpleFluent(_5042,rich(_5042)=true,_5058),
     holdsForProcessedSDFluent(_5042,happy(_5042)=true,_5074),
     equal(rich_equal_happy(_5042)=true,0,_5058,_5074,source,true,_5012).

grounding(go_to(_5342,_5344)) :- 
     person(_5342),place(_5344).

grounding(lose_wallet(_5342)) :- 
     person(_5342).

grounding(win_lottery(_5342)) :- 
     person(_5342).

grounding(location(_5348)=_5344) :- 
     person(_5348),place(_5344).

grounding(rich(_5348)=true) :- 
     person(_5348).

grounding(happy(_5348)=true) :- 
     person(_5348).

grounding(rich_before_pub(_5348)=true) :- 
     person(_5348).

grounding(rich_before_pub_before_home(_5348)=true) :- 
     person(_5348).

grounding(rich_starts_happy(_5348)=true) :- 
     person(_5348).

grounding(rich_finishes_happy(_5348)=true) :- 
     person(_5348).

grounding(pub_during_happy(_5348)=true) :- 
     person(_5348).

grounding(rich_overlaps_pub(_5348)=true) :- 
     person(_5348).

grounding(rich_equal_happy(_5348)=true) :- 
     person(_5348).

inputEntity(win_lottery(_5066)).
inputEntity(go_to(_5066,_5068)).
inputEntity(lose_wallet(_5066)).
inputEntity(rich_before_pub_before_home(_5072)=true).

outputEntity(rich(_5152)=true).
outputEntity(location(_5152)=_5148).
outputEntity(happy(_5152)=true).
outputEntity(rich_before_pub(_5152)=true).
outputEntity(rich_starts_happy(_5152)=true).
outputEntity(rich_finishes_happy(_5152)=true).
outputEntity(pub_during_happy(_5152)=true).
outputEntity(rich_overlaps_pub(_5152)=true).
outputEntity(rich_equal_happy(_5152)=true).

event(win_lottery(_5256)).
event(go_to(_5256,_5258)).
event(lose_wallet(_5256)).

simpleFluent(rich(_5336)=true).
simpleFluent(location(_5336)=_5332).

sDFluent(happy(_5404)=true).
sDFluent(rich_before_pub(_5404)=true).
sDFluent(rich_starts_happy(_5404)=true).
sDFluent(rich_finishes_happy(_5404)=true).
sDFluent(pub_during_happy(_5404)=true).
sDFluent(rich_overlaps_pub(_5404)=true).
sDFluent(rich_equal_happy(_5404)=true).
sDFluent(rich_before_pub_before_home(_5404)=true).

index(go_to(_5506,_5454),_5454).
index(win_lottery(_5454),_5454).
index(lose_wallet(_5454),_5454).
index(rich(_5454)=true,_5454).
index(location(_5454)=_5508,_5454).
index(happy(_5454)=true,_5454).
index(rich_before_pub(_5454)=true,_5454).
index(rich_starts_happy(_5454)=true,_5454).
index(rich_finishes_happy(_5454)=true,_5454).
index(pub_during_happy(_5454)=true,_5454).
index(rich_overlaps_pub(_5454)=true,_5454).
index(rich_equal_happy(_5454)=true,_5454).
index(rich_before_pub_before_home(_5454)=true,_5454).


cachingOrder2(_5776, rich(_5776)=true) :- % level: 1
     person(_5776).

cachingOrder2(_5760, location(_5760)=_5756) :- % level: 1
     person(_5760),place(_5756).

cachingOrder2(_5946, happy(_5946)=true) :- % level: 2
     person(_5946).

cachingOrder2(_5930, rich_before_pub(_5930)=true) :- % level: 2
     person(_5930).

cachingOrder2(_5914, rich_overlaps_pub(_5914)=true) :- % level: 2
     person(_5914).

cachingOrder2(_6154, rich_starts_happy(_6154)=true) :- % level: 3
     person(_6154).

cachingOrder2(_6138, rich_finishes_happy(_6138)=true) :- % level: 3
     person(_6138).

cachingOrder2(_6122, pub_during_happy(_6122)=true) :- % level: 3
     person(_6122).

cachingOrder2(_6106, rich_equal_happy(_6106)=true) :- % level: 3
     person(_6106).

collectGrounds([win_lottery(_5254), go_to(_5254,_5268), lose_wallet(_5254), rich_before_pub_before_home(_5254)=true],person(_5254)).

dgrounded(rich(_5610)=true, person(_5610)).
dgrounded(location(_5568)=_5564, person(_5568)).
dgrounded(happy(_5536)=true, person(_5536)).
dgrounded(rich_before_pub(_5504)=true, person(_5504)).
dgrounded(rich_starts_happy(_5472)=true, person(_5472)).
dgrounded(rich_finishes_happy(_5440)=true, person(_5440)).
dgrounded(pub_during_happy(_5408)=true, person(_5408)).
dgrounded(rich_overlaps_pub(_5376)=true, person(_5376)).
dgrounded(rich_equal_happy(_5344)=true, person(_5344)).
