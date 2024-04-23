initiatedAt(rich(_8744)=true, _8760, _8714, _8766) :-
     happensAtIE(win_lottery(_8744),_8714),
     _8760=<_8714,
     _8714<_8766.

initiatedAt(location(_8744)=_8720, _8762, _8714, _8768) :-
     happensAtIE(go_to(_8744,_8720),_8714),
     _8762=<_8714,
     _8714<_8768.

terminatedAt(rich(_8744)=true, _8760, _8714, _8766) :-
     happensAtIE(lose_wallet(_8744),_8714),
     _8760=<_8714,
     _8714<_8766.

holdsForSDFluent(happy(_8744)=true,_8714) :-
     holdsForProcessedSimpleFluent(_8744,rich(_8744)=true,_8760),
     holdsForProcessedSimpleFluent(_8744,location(_8744)=pub,_8776),
     union_all([_8760,_8776],_8714).

grounding(go_to(_9028,_9030)) :- 
     person(_9028),place(_9030).

grounding(lose_wallet(_9028)) :- 
     person(_9028).

grounding(win_lottery(_9028)) :- 
     person(_9028).

grounding(location(_9034)=pub) :- 
     person(_9034).

grounding(location(_9034)=home) :- 
     person(_9034).

grounding(location(_9034)=work) :- 
     person(_9034).

grounding(rich(_9034)=true) :- 
     person(_9034).

grounding(happy(_9034)=true) :- 
     person(_9034).

inputEntity(win_lottery(_8768)).
inputEntity(go_to(_8768,_8770)).
inputEntity(lose_wallet(_8768)).

outputEntity(rich(_8848)=true).
outputEntity(location(_8848)=pub).
outputEntity(location(_8848)=home).
outputEntity(location(_8848)=work).
outputEntity(happy(_8848)=true).

event(win_lottery(_8928)).
event(go_to(_8928,_8930)).
event(lose_wallet(_8928)).

simpleFluent(rich(_9008)=true).
simpleFluent(location(_9008)=pub).
simpleFluent(location(_9008)=home).
simpleFluent(location(_9008)=work).

sDFluent(happy(_9088)=true).

index(go_to(_9148,_9096),_9096).
index(win_lottery(_9096),_9096).
index(lose_wallet(_9096),_9096).
index(rich(_9096)=true,_9096).
index(location(_9096)=pub,_9096).
index(location(_9096)=home,_9096).
index(location(_9096)=work,_9096).
index(happy(_9096)=true,_9096).


cachingOrder2(_9444, rich(_9444)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_9444).

cachingOrder2(_9422, location(_9422)=pub) :- % level in dependency graph: 1, processing order in component: 1
     person(_9422).

cachingOrder2(_9400, location(_9400)=home) :- % level in dependency graph: 1, processing order in component: 1
     person(_9400).

cachingOrder2(_9378, location(_9378)=work) :- % level in dependency graph: 1, processing order in component: 1
     person(_9378).

cachingOrder2(_9794, happy(_9794)=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_9794).

