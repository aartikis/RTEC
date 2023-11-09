:- dynamic id/1.

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(running(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(active(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=false, _126, _80, _132) :-
     happensAtIE(disappear(_110),_80),
     _126=<_80,
     _80<_132.

initiatedAt(leaving_object(_110,_112)=true, _198, _80, _204) :-
     happensAtIE(appear(_112),_80),_198=<_80,_80<_204,
     holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     holdsAtProcessedSimpleFluent(_110,person(_110)=true,_80),
     holdsAtProcessedSDFluent(_110,closeSymmetric(_110,_112,30)=true,_80).

initiatedAt(leaving_object(_110,_112)=false, _128, _80, _134) :-
     happensAtIE(disappear(_112),_80),
     _128=<_80,
     _80<_134.

initiatedAt(meeting(_110,_112)=true, _180, _80, _186) :-
     happensAtProcessedSDFluent(_110,start(greeting1(_110,_112)=true),_80),_180=<_80,_80<_186,
     \+happensAtIE(disappear(_110),_80),
     \+happensAtIE(disappear(_112),_80).

initiatedAt(meeting(_110,_112)=true, _180, _80, _186) :-
     happensAtProcessedSDFluent(_110,start(greeting2(_110,_112)=true),_80),_180=<_80,_80<_186,
     \+happensAtIE(disappear(_110),_80),
     \+happensAtIE(disappear(_112),_80).

initiatedAt(meeting(_110,_112)=false, _138, _80, _144) :-
     happensAtProcessedIE(_110,start(running(_110)=true),_80),
     _138=<_80,
     _80<_144.

initiatedAt(meeting(_110,_112)=false, _138, _80, _144) :-
     happensAtProcessedIE(_112,start(running(_112)=true),_80),
     _138=<_80,
     _80<_144.

initiatedAt(meeting(_110,_112)=false, _138, _80, _144) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),
     _138=<_80,
     _80<_144.

initiatedAt(meeting(_110,_112)=false, _138, _80, _144) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     _138=<_80,
     _80<_144.

initiatedAt(meeting(_110,_112)=false, _142, _80, _148) :-
     happensAtProcessedSDFluent(_110,start(close(_110,_112,34)=false),_80),
     _142=<_80,
     _80<_148.

holdsForSDFluent(close(_110,_112,24)=true,_80) :-
     holdsForProcessedIE(_110,distance(_110,_112,24)=true,_80).

holdsForSDFluent(close(_110,_112,25)=true,_80) :-
     holdsForProcessedSDFluent(_110,close(_110,_112,24)=true,_134),
     holdsForProcessedIE(_110,distance(_110,_112,25)=true,_154),
     union_all([_134,_154],_80).

holdsForSDFluent(close(_110,_112,30)=true,_80) :-
     holdsForProcessedSDFluent(_110,close(_110,_112,25)=true,_134),
     holdsForProcessedIE(_110,distance(_110,_112,30)=true,_154),
     union_all([_134,_154],_80).

holdsForSDFluent(close(_110,_112,34)=true,_80) :-
     holdsForProcessedSDFluent(_110,close(_110,_112,30)=true,_134),
     holdsForProcessedIE(_110,distance(_110,_112,34)=true,_154),
     union_all([_134,_154],_80).

holdsForSDFluent(close(_110,_112,24)=false,_80) :-
     holdsForProcessedSDFluent(_110,close(_110,_112,24)=true,_134),
     complement_all([_134],_80).

holdsForSDFluent(closeSymmetric(_110,_112,24)=true,_80) :-
     holdsForProcessedSDFluent(_110,close(_110,_112,24)=true,_134),
     holdsForProcessedSDFluent(_112,close(_112,_110,24)=true,_154),
     union_all([_134,_154],_80).

holdsForSDFluent(greeting1(_110,_112)=true,_80) :-
     holdsForProcessedSDFluent(_110,activeOrInactivePerson(_110)=true,_128),
     \+_128=[],
     holdsForProcessedSimpleFluent(_112,person(_112)=true,_154),
     \+_154=[],
     holdsForProcessedSDFluent(_110,close(_110,_112,25)=true,_184),
     \+_184=[],
     intersect_all([_128,_184,_154],_218),
     \+_218=[],
     !,
     holdsForProcessedIE(_112,running(_112)=true,_244),
     holdsForProcessedIE(_112,abrupt(_112)=true,_260),
     relative_complement_all(_218,[_244,_260],_80).

holdsForSDFluent(greeting1(_104,_106)=true,[]).

holdsForSDFluent(greeting2(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,walking(_110)=true,_128),
     \+_128=[],
     holdsForProcessedSDFluent(_112,activeOrInactivePerson(_112)=true,_154),
     \+_154=[],
     holdsForProcessedSDFluent(_112,close(_112,_110,25)=true,_184),
     \+_184=[],
     !,
     intersect_all([_128,_154,_184],_80).

holdsForSDFluent(greeting2(_104,_106)=true,[]).

holdsForSDFluent(activeOrInactivePerson(_110)=true,_80) :-
     holdsForProcessedIE(_110,active(_110)=true,_126),
     holdsForProcessedIE(_110,inactive(_110)=true,_142),
     holdsForProcessedSimpleFluent(_110,person(_110)=true,_158),
     intersect_all([_142,_158],_176),
     union_all([_126,_176],_80).

holdsForSDFluent(moving(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,walking(_110)=true,_128),
     holdsForProcessedIE(_112,walking(_112)=true,_144),
     intersect_all([_128,_144],_162),
     \+_162=[],
     holdsForProcessedSDFluent(_110,close(_110,_112,34)=true,_192),
     \+_192=[],
     !,
     intersect_all([_162,_192],_80).

holdsForSDFluent(moving(_104,_106)=true,[]).

holdsForSDFluent(fighting(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,abrupt(_110)=true,_128),
     holdsForProcessedIE(_112,abrupt(_112)=true,_144),
     union_all([_128,_144],_162),
     \+_162=[],
     holdsForProcessedSDFluent(_110,close(_110,_112,24)=true,_192),
     \+_192=[],
     intersect_all([_162,_192],_220),
     \+_220=[],
     !,
     holdsForProcessedIE(_110,inactive(_110)=true,_246),
     holdsForProcessedIE(_112,inactive(_112)=true,_262),
     union_all([_246,_262],_280),
     relative_complement_all(_220,[_280],_80).

holdsForSDFluent(fighting(_104,_106)=true,[]).

buildFromPoints2(_84, walking(_84)=true) :-
     id(_84).

buildFromPoints2(_84, active(_84)=true) :-
     id(_84).

buildFromPoints2(_84, inactive(_84)=true) :-
     id(_84).

buildFromPoints2(_84, running(_84)=true) :-
     id(_84).

buildFromPoints2(_84, abrupt(_84)=true) :-
     id(_84).

points(orientation(_406)=_402).

points(appearance(_406)=_402).

points(coord(_406,_408,_410)=true).

points(walking(_406)=true).

points(active(_406)=true).

points(inactive(_406)=true).

points(running(_406)=true).

points(abrupt(_406)=true).

grounding(appear(_406)) :- 
     id(_406).

grounding(disappear(_406)) :- 
     id(_406).

grounding(orientation(_412)=_408) :- 
     id(_412).

grounding(appearance(_412)=_408) :- 
     id(_412).

grounding(coord(_412,_414,_416)=_408) :- 
     id(_412).

grounding(walking(_412)=_408) :- 
     id(_412).

grounding(active(_412)=_408) :- 
     id(_412).

grounding(inactive(_412)=_408) :- 
     id(_412).

grounding(running(_412)=_408) :- 
     id(_412).

grounding(abrupt(_412)=_408) :- 
     id(_412).

grounding(close(_412,_414,24)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(close(_412,_414,25)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(close(_412,_414,30)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(close(_412,_414,34)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(close(_412,_414,34)=false) :- 
     id(_412),id(_414),_412@<_414.

grounding(closeSymmetric(_412,_414,30)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(walking(_412)=true) :- 
     id(_412).

grounding(active(_412)=true) :- 
     id(_412).

grounding(inactive(_412)=true) :- 
     id(_412).

grounding(abrupt(_412)=true) :- 
     id(_412).

grounding(running(_412)=true) :- 
     id(_412).

grounding(person(_412)=true) :- 
     id(_412).

grounding(activeOrInactivePerson(_412)=true) :- 
     id(_412).

grounding(greeting1(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(greeting2(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(leaving_object(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(meeting(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(moving(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(fighting(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

inputEntity(walking(_140)=true).
inputEntity(disappear(_134)).
inputEntity(running(_140)=true).
inputEntity(active(_140)=true).
inputEntity(abrupt(_140)=true).
inputEntity(appear(_134)).
inputEntity(inactive(_140)=true).
inputEntity(distance(_140,_142,24)=true).
inputEntity(distance(_140,_142,25)=true).
inputEntity(distance(_140,_142,30)=true).
inputEntity(distance(_140,_142,34)=true).
inputEntity(orientation(_140)=_136).
inputEntity(appearance(_140)=_136).
inputEntity(coord(_140,_142,_144)=_136).

outputEntity(person(_280)=true).
outputEntity(person(_280)=false).
outputEntity(leaving_object(_280,_282)=true).
outputEntity(leaving_object(_280,_282)=false).
outputEntity(meeting(_280,_282)=true).
outputEntity(meeting(_280,_282)=false).
outputEntity(close(_280,_282,24)=true).
outputEntity(close(_280,_282,25)=true).
outputEntity(close(_280,_282,30)=true).
outputEntity(close(_280,_282,34)=true).
outputEntity(close(_280,_282,_284)=false).
outputEntity(closeSymmetric(_280,_282,_284)=true).
outputEntity(greeting1(_280,_282)=true).
outputEntity(greeting2(_280,_282)=true).
outputEntity(activeOrInactivePerson(_280)=true).
outputEntity(moving(_280,_282)=true).
outputEntity(fighting(_280,_282)=true).

event(disappear(_432)).
event(appear(_432)).

simpleFluent(person(_506)=true).
simpleFluent(person(_506)=false).
simpleFluent(leaving_object(_506,_508)=true).
simpleFluent(leaving_object(_506,_508)=false).
simpleFluent(meeting(_506,_508)=true).
simpleFluent(meeting(_506,_508)=false).

sDFluent(close(_598,_600,24)=true).
sDFluent(close(_598,_600,25)=true).
sDFluent(close(_598,_600,30)=true).
sDFluent(close(_598,_600,34)=true).
sDFluent(close(_598,_600,_602)=false).
sDFluent(closeSymmetric(_598,_600,_602)=true).
sDFluent(greeting1(_598,_600)=true).
sDFluent(greeting2(_598,_600)=true).
sDFluent(activeOrInactivePerson(_598)=true).
sDFluent(moving(_598,_600)=true).
sDFluent(fighting(_598,_600)=true).
sDFluent(walking(_598)=true).
sDFluent(running(_598)=true).
sDFluent(active(_598)=true).
sDFluent(abrupt(_598)=true).
sDFluent(inactive(_598)=true).
sDFluent(distance(_598,_600,24)=true).
sDFluent(distance(_598,_600,25)=true).
sDFluent(distance(_598,_600,30)=true).
sDFluent(distance(_598,_600,34)=true).
sDFluent(orientation(_598)=_594).
sDFluent(appearance(_598)=_594).
sDFluent(coord(_598,_600,_602)=_594).

index(disappear(_738),_738).
index(appear(_738),_738).
index(person(_738)=true,_738).
index(person(_738)=false,_738).
index(leaving_object(_738,_798)=true,_738).
index(leaving_object(_738,_798)=false,_738).
index(meeting(_738,_798)=true,_738).
index(meeting(_738,_798)=false,_738).
index(close(_738,_798,24)=true,_738).
index(close(_738,_798,25)=true,_738).
index(close(_738,_798,30)=true,_738).
index(close(_738,_798,34)=true,_738).
index(close(_738,_798,_800)=false,_738).
index(closeSymmetric(_738,_798,_800)=true,_738).
index(greeting1(_738,_798)=true,_738).
index(greeting2(_738,_798)=true,_738).
index(activeOrInactivePerson(_738)=true,_738).
index(moving(_738,_798)=true,_738).
index(fighting(_738,_798)=true,_738).
index(walking(_738)=true,_738).
index(running(_738)=true,_738).
index(active(_738)=true,_738).
index(abrupt(_738)=true,_738).
index(inactive(_738)=true,_738).
index(distance(_738,_798,24)=true,_738).
index(distance(_738,_798,25)=true,_738).
index(distance(_738,_798,30)=true,_738).
index(distance(_738,_798,34)=true,_738).
index(orientation(_738)=_792,_738).
index(appearance(_738)=_792,_738).
index(coord(_738,_798,_800)=_792,_738).


cachingOrder2(_1206, person(_1206)=true) :- % level: 1
     id(_1206).

cachingOrder2(_1190, person(_1190)=false). % level: 1
cachingOrder2(_1172, leaving_object(_1172,_1174)=false). % level: 1
cachingOrder2(_1152, close(_1152,_1154,24)=true) :- % level: 1
     id(_1152),id(_1154),_1152@<_1154.

cachingOrder2(_1438, close(_1438,_1440,25)=true) :- % level: 2
     id(_1438),id(_1440),_1438@<_1440.

cachingOrder2(_1418, close(_1418,_1420,34)=false) :- % level: 2
     id(_1418),id(_1420),_1418@<_1420.

cachingOrder2(_1398, closeSymmetric(_1398,_1400,30)=true) :- % level: 2
     id(_1398),id(_1400),_1398@<_1400.

cachingOrder2(_1382, activeOrInactivePerson(_1382)=true) :- % level: 2
     id(_1382).

cachingOrder2(_1364, fighting(_1364,_1366)=true) :- % level: 2
     id(_1364),id(_1366),_1364@<_1366.

cachingOrder2(_1804, close(_1804,_1806,30)=true) :- % level: 3
     id(_1804),id(_1806),_1804@<_1806.

cachingOrder2(_1786, greeting1(_1786,_1788)=true) :- % level: 3
     id(_1786),id(_1788),_1786@<_1788.

cachingOrder2(_1768, greeting2(_1768,_1770)=true) :- % level: 3
     id(_1768),id(_1770),_1768@<_1770.

cachingOrder2(_2062, meeting(_2062,_2064)=true) :- % level: 4
     id(_2062),id(_2064),_2062@<_2064.

cachingOrder2(_2042, close(_2042,_2044,34)=true) :- % level: 4
     id(_2042),id(_2044),_2042@<_2044.

cachingOrder2(_2260, leaving_object(_2260,_2262)=true) :- % level: 5
     id(_2260),id(_2262),_2260@<_2262.

cachingOrder2(_2242, moving(_2242,_2244)=true) :- % level: 5
     id(_2242),id(_2244),_2242@<_2244.

cachingOrder2(_2438, meeting(_2438,_2440)=false). % level: 6
collectGrounds([walking(_738)=true, walking(_738)=true, disappear(_738), running(_738)=true, running(_738)=true, active(_738)=true, active(_738)=true, abrupt(_738)=true, abrupt(_738)=true, appear(_738), inactive(_738)=true, inactive(_738)=true, orientation(_738)=_752, appearance(_738)=_752, coord(_738,_758,_760)=_752],id(_738)).

dgrounded(person(_1544)=true, id(_1544)).
dgrounded(leaving_object(_1488,_1490)=true, id(_1488)).
dgrounded(leaving_object(_1488,_1490)=true, id(_1490)).
dgrounded(meeting(_1432,_1434)=true, id(_1432)).
dgrounded(meeting(_1432,_1434)=true, id(_1434)).
dgrounded(close(_1374,_1376,24)=true, id(_1374)).
dgrounded(close(_1374,_1376,24)=true, id(_1376)).
dgrounded(close(_1316,_1318,25)=true, id(_1316)).
dgrounded(close(_1316,_1318,25)=true, id(_1318)).
dgrounded(close(_1258,_1260,30)=true, id(_1258)).
dgrounded(close(_1258,_1260,30)=true, id(_1260)).
dgrounded(close(_1200,_1202,34)=true, id(_1200)).
dgrounded(close(_1200,_1202,34)=true, id(_1202)).
dgrounded(close(_1142,_1144,34)=false, id(_1142)).
dgrounded(close(_1142,_1144,34)=false, id(_1144)).
dgrounded(closeSymmetric(_1084,_1086,30)=true, id(_1084)).
dgrounded(closeSymmetric(_1084,_1086,30)=true, id(_1086)).
dgrounded(greeting1(_1028,_1030)=true, id(_1028)).
dgrounded(greeting1(_1028,_1030)=true, id(_1030)).
dgrounded(greeting2(_972,_974)=true, id(_972)).
dgrounded(greeting2(_972,_974)=true, id(_974)).
dgrounded(activeOrInactivePerson(_940)=true, id(_940)).
dgrounded(moving(_884,_886)=true, id(_884)).
dgrounded(moving(_884,_886)=true, id(_886)).
dgrounded(fighting(_828,_830)=true, id(_828)).
dgrounded(fighting(_828,_830)=true, id(_830)).
