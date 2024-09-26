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

initiatedAt(meeting(_110,_112)=false, _128, _80, _134) :-
     happensAtIE(disappear(_110),_80),
     _128=<_80,
     _80<_134.

initiatedAt(meeting(_110,_112)=false, _128, _80, _134) :-
     happensAtIE(disappear(_112),_80),
     _128=<_80,
     _80<_134.

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

holdsForSDFluent(close(_110,_112,_114)=false,_80) :-
     holdsForProcessedSDFluent(_110,close(_110,_112,_114)=true,_134),
     complement_all([_134],_80).

holdsForSDFluent(closeSymmetric(_110,_112,_114)=true,_80) :-
     holdsForProcessedSDFluent(_110,close(_110,_112,_114)=true,_134),
     holdsForProcessedSDFluent(_112,close(_112,_110,_114)=true,_154),
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
inputEntity(distance(_140,_142,_144)=true).
inputEntity(orientation(_140)=_136).
inputEntity(appearance(_140)=_136).
inputEntity(coord(_140,_142,_144)=_136).

outputEntity(person(_262)=true).
outputEntity(person(_262)=false).
outputEntity(leaving_object(_262,_264)=true).
outputEntity(leaving_object(_262,_264)=false).
outputEntity(meeting(_262,_264)=true).
outputEntity(meeting(_262,_264)=false).
outputEntity(close(_262,_264,_266)=true).
outputEntity(close(_262,_264,_266)=false).
outputEntity(closeSymmetric(_262,_264,_266)=true).
outputEntity(greeting1(_262,_264)=true).
outputEntity(greeting2(_262,_264)=true).
outputEntity(activeOrInactivePerson(_262)=true).
outputEntity(moving(_262,_264)=true).
outputEntity(fighting(_262,_264)=true).

event(disappear(_396)).
event(appear(_396)).

simpleFluent(person(_470)=true).
simpleFluent(person(_470)=false).
simpleFluent(leaving_object(_470,_472)=true).
simpleFluent(leaving_object(_470,_472)=false).
simpleFluent(meeting(_470,_472)=true).
simpleFluent(meeting(_470,_472)=false).


sDFluent(close(_618,_620,_622)=true).
sDFluent(close(_618,_620,_622)=false).
sDFluent(closeSymmetric(_618,_620,_622)=true).
sDFluent(greeting1(_618,_620)=true).
sDFluent(greeting2(_618,_620)=true).
sDFluent(activeOrInactivePerson(_618)=true).
sDFluent(moving(_618,_620)=true).
sDFluent(fighting(_618,_620)=true).
sDFluent(walking(_618)=true).
sDFluent(running(_618)=true).
sDFluent(active(_618)=true).
sDFluent(abrupt(_618)=true).
sDFluent(inactive(_618)=true).
sDFluent(distance(_618,_620,_622)=true).
sDFluent(orientation(_618)=_614).
sDFluent(appearance(_618)=_614).
sDFluent(coord(_618,_620,_622)=_614).

index(disappear(_722),_722).
index(appear(_722),_722).
index(person(_722)=true,_722).
index(person(_722)=false,_722).
index(leaving_object(_722,_782)=true,_722).
index(leaving_object(_722,_782)=false,_722).
index(meeting(_722,_782)=true,_722).
index(meeting(_722,_782)=false,_722).
index(close(_722,_782,_784)=true,_722).
index(close(_722,_782,_784)=false,_722).
index(closeSymmetric(_722,_782,_784)=true,_722).
index(greeting1(_722,_782)=true,_722).
index(greeting2(_722,_782)=true,_722).
index(activeOrInactivePerson(_722)=true,_722).
index(moving(_722,_782)=true,_722).
index(fighting(_722,_782)=true,_722).
index(walking(_722)=true,_722).
index(running(_722)=true,_722).
index(active(_722)=true,_722).
index(abrupt(_722)=true,_722).
index(inactive(_722)=true,_722).
index(distance(_722,_782,_784)=true,_722).
index(orientation(_722)=_776,_722).
index(appearance(_722)=_776,_722).
index(coord(_722,_782,_784)=_776,_722).


cachingOrder2(_1144, close(_1144,_1146,_1282)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1144),id(_1146),_1144@<_1146.

cachingOrder2(_1164, close(_1164,_1166,_1406)=false) :- % level in dependency graph: 1, processing order in component: 2
     id(_1164),id(_1166),_1164@<_1166.

cachingOrder2(_1122, person(_1122)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1122).

cachingOrder2(_1626, closeSymmetric(_1626,_1628,_1744)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1626),id(_1628),_1626@<_1628.

cachingOrder2(_1604, activeOrInactivePerson(_1604)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1604).

cachingOrder2(_1580, moving(_1580,_1582)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1580),id(_1582),_1580@<_1582.

cachingOrder2(_1556, fighting(_1556,_1558)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1556),id(_1558),_1556@<_1558.

cachingOrder2(_2176, leaving_object(_2176,_2178)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2176),id(_2178),_2176@<_2178.

cachingOrder2(_2134, greeting1(_2134,_2136)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2134),id(_2136),_2134@<_2136.

cachingOrder2(_2110, greeting2(_2110,_2112)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2110),id(_2112),_2110@<_2112.

cachingOrder2(_2590, meeting(_2590,_2592)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2590),id(_2592),_2590@<_2592.

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
