:- dynamic id/1.

initiatedAt(person(_106)=true, _152, _76, _158) :-
     happensAtProcessedIE(_106,start(walking(_106)=true),_76),_152=<_76,_76<_158,
     \+happensAtIE(disappear(_106),_76).

initiatedAt(person(_106)=true, _152, _76, _158) :-
     happensAtProcessedIE(_106,start(running(_106)=true),_76),_152=<_76,_76<_158,
     \+happensAtIE(disappear(_106),_76).

initiatedAt(person(_106)=true, _152, _76, _158) :-
     happensAtProcessedIE(_106,start(active(_106)=true),_76),_152=<_76,_76<_158,
     \+happensAtIE(disappear(_106),_76).

initiatedAt(person(_106)=true, _152, _76, _158) :-
     happensAtProcessedIE(_106,start(abrupt(_106)=true),_76),_152=<_76,_76<_158,
     \+happensAtIE(disappear(_106),_76).

initiatedAt(person(_106)=false, _122, _76, _128) :-
     happensAtIE(disappear(_106),_76),
     _122=<_76,
     _76<_128.

initiatedAt(leaving_object(_106,_108)=true, _194, _76, _200) :-
     happensAtIE(appear(_108),_76),_194=<_76,_76<_200,
     holdsAtProcessedIE(_108,inactive(_108)=true,_76),
     holdsAtProcessedSimpleFluent(_106,person(_106)=true,_76),
     holdsAtProcessedSDFluent(_106,closeSymmetric(_106,_108,30)=true,_76).

initiatedAt(leaving_object(_106,_108)=false, _124, _76, _130) :-
     happensAtIE(disappear(_108),_76),
     _124=<_76,
     _76<_130.

initiatedAt(meeting(_106,_108)=true, _176, _76, _182) :-
     happensAtProcessedSDFluent(_106,start(greeting1(_106,_108)=true),_76),_176=<_76,_76<_182,
     \+happensAtIE(disappear(_106),_76),
     \+happensAtIE(disappear(_108),_76).

initiatedAt(meeting(_106,_108)=true, _176, _76, _182) :-
     happensAtProcessedSDFluent(_106,start(greeting2(_106,_108)=true),_76),_176=<_76,_76<_182,
     \+happensAtIE(disappear(_106),_76),
     \+happensAtIE(disappear(_108),_76).

initiatedAt(meeting(_106,_108)=false, _134, _76, _140) :-
     happensAtProcessedIE(_106,start(running(_106)=true),_76),
     _134=<_76,
     _76<_140.

initiatedAt(meeting(_106,_108)=false, _134, _76, _140) :-
     happensAtProcessedIE(_108,start(running(_108)=true),_76),
     _134=<_76,
     _76<_140.

initiatedAt(meeting(_106,_108)=false, _134, _76, _140) :-
     happensAtProcessedIE(_106,start(abrupt(_106)=true),_76),
     _134=<_76,
     _76<_140.

initiatedAt(meeting(_106,_108)=false, _134, _76, _140) :-
     happensAtProcessedIE(_108,start(abrupt(_108)=true),_76),
     _134=<_76,
     _76<_140.

initiatedAt(meeting(_106,_108)=false, _138, _76, _144) :-
     happensAtProcessedSDFluent(_106,start(close(_106,_108,34)=false),_76),
     _138=<_76,
     _76<_144.

holdsForSDFluent(close(_106,_108,24)=true,_76) :-
     holdsForProcessedIE(_106,distance(_106,_108,24)=true,_76).

holdsForSDFluent(close(_106,_108,25)=true,_76) :-
     holdsForProcessedSDFluent(_106,close(_106,_108,24)=true,_130),
     holdsForProcessedIE(_106,distance(_106,_108,25)=true,_150),
     union_all([_130,_150],_76).

holdsForSDFluent(close(_106,_108,30)=true,_76) :-
     holdsForProcessedSDFluent(_106,close(_106,_108,25)=true,_130),
     holdsForProcessedIE(_106,distance(_106,_108,30)=true,_150),
     union_all([_130,_150],_76).

holdsForSDFluent(close(_106,_108,34)=true,_76) :-
     holdsForProcessedSDFluent(_106,close(_106,_108,30)=true,_130),
     holdsForProcessedIE(_106,distance(_106,_108,34)=true,_150),
     union_all([_130,_150],_76).

holdsForSDFluent(close(_106,_108,_110)=false,_76) :-
     holdsForProcessedSDFluent(_106,close(_106,_108,_110)=true,_130),
     complement_all([_130],_76).

holdsForSDFluent(closeSymmetric(_106,_108,_110)=true,_76) :-
     holdsForProcessedSDFluent(_106,close(_106,_108,_110)=true,_130),
     holdsForProcessedSDFluent(_108,close(_108,_106,_110)=true,_150),
     union_all([_130,_150],_76).

holdsForSDFluent(greeting1(_106,_108)=true,_76) :-
     holdsForProcessedSDFluent(_106,activeOrInactivePerson(_106)=true,_124),
     \+_124=[],
     holdsForProcessedSimpleFluent(_108,person(_108)=true,_150),
     \+_150=[],
     holdsForProcessedSDFluent(_106,close(_106,_108,25)=true,_180),
     \+_180=[],
     intersect_all([_124,_180,_150],_214),
     \+_214=[],
     !,
     holdsForProcessedIE(_108,running(_108)=true,_240),
     holdsForProcessedIE(_108,abrupt(_108)=true,_256),
     relative_complement_all(_214,[_240,_256],_76).

holdsForSDFluent(greeting1(_100,_102)=true,[]).

holdsForSDFluent(greeting2(_106,_108)=true,_76) :-
     holdsForProcessedIE(_106,walking(_106)=true,_124),
     \+_124=[],
     holdsForProcessedSDFluent(_108,activeOrInactivePerson(_108)=true,_150),
     \+_150=[],
     holdsForProcessedSDFluent(_108,close(_108,_106,25)=true,_180),
     \+_180=[],
     !,
     intersect_all([_124,_150,_180],_76).

holdsForSDFluent(greeting2(_100,_102)=true,[]).

holdsForSDFluent(activeOrInactivePerson(_106)=true,_76) :-
     holdsForProcessedIE(_106,active(_106)=true,_122),
     holdsForProcessedIE(_106,inactive(_106)=true,_138),
     holdsForProcessedSimpleFluent(_106,person(_106)=true,_154),
     intersect_all([_138,_154],_172),
     union_all([_122,_172],_76).

holdsForSDFluent(moving(_106,_108)=true,_76) :-
     holdsForProcessedIE(_106,walking(_106)=true,_124),
     holdsForProcessedIE(_108,walking(_108)=true,_140),
     intersect_all([_124,_140],_158),
     \+_158=[],
     holdsForProcessedSDFluent(_106,close(_106,_108,34)=true,_188),
     \+_188=[],
     !,
     intersect_all([_158,_188],_76).

holdsForSDFluent(moving(_100,_102)=true,[]).

holdsForSDFluent(fighting(_106,_108)=true,_76) :-
     holdsForProcessedIE(_106,abrupt(_106)=true,_124),
     holdsForProcessedIE(_108,abrupt(_108)=true,_140),
     union_all([_124,_140],_158),
     \+_158=[],
     holdsForProcessedSDFluent(_106,close(_106,_108,24)=true,_188),
     \+_188=[],
     intersect_all([_158,_188],_216),
     \+_216=[],
     !,
     holdsForProcessedIE(_106,inactive(_106)=true,_242),
     holdsForProcessedIE(_108,inactive(_108)=true,_258),
     union_all([_242,_258],_276),
     relative_complement_all(_216,[_276],_76).

holdsForSDFluent(fighting(_100,_102)=true,[]).

buildFromPoints2(_80, walking(_80)=true) :-
     id(_80).

buildFromPoints2(_80, active(_80)=true) :-
     id(_80).

buildFromPoints2(_80, inactive(_80)=true) :-
     id(_80).

buildFromPoints2(_80, running(_80)=true) :-
     id(_80).

buildFromPoints2(_80, abrupt(_80)=true) :-
     id(_80).

points(orientation(_402)=_398).

points(appearance(_402)=_398).

points(coord(_402,_404,_406)=true).

points(walking(_402)=true).

points(active(_402)=true).

points(inactive(_402)=true).

points(running(_402)=true).

points(abrupt(_402)=true).

grounding(appear(_402)) :- 
     id(_402).

grounding(disappear(_402)) :- 
     id(_402).

grounding(orientation(_408)=_404) :- 
     id(_408).

grounding(appearance(_408)=_404) :- 
     id(_408).

grounding(coord(_408,_410,_412)=_404) :- 
     id(_408).

grounding(walking(_408)=_404) :- 
     id(_408).

grounding(active(_408)=_404) :- 
     id(_408).

grounding(inactive(_408)=_404) :- 
     id(_408).

grounding(running(_408)=_404) :- 
     id(_408).

grounding(abrupt(_408)=_404) :- 
     id(_408).

grounding(close(_408,_410,24)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(close(_408,_410,25)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(close(_408,_410,30)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(close(_408,_410,34)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(close(_408,_410,34)=false) :- 
     id(_408),id(_410),_408@<_410.

grounding(closeSymmetric(_408,_410,30)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(walking(_408)=true) :- 
     id(_408).

grounding(active(_408)=true) :- 
     id(_408).

grounding(inactive(_408)=true) :- 
     id(_408).

grounding(abrupt(_408)=true) :- 
     id(_408).

grounding(running(_408)=true) :- 
     id(_408).

grounding(person(_408)=true) :- 
     id(_408).

grounding(activeOrInactivePerson(_408)=true) :- 
     id(_408).

grounding(greeting1(_408,_410)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(greeting2(_408,_410)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(leaving_object(_408,_410)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(meeting(_408,_410)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(moving(_408,_410)=true) :- 
     id(_408),id(_410),_408@<_410.

grounding(fighting(_408,_410)=true) :- 
     id(_408),id(_410),_408@<_410.

inputEntity(walking(_136)=true).
inputEntity(disappear(_130)).
inputEntity(running(_136)=true).
inputEntity(active(_136)=true).
inputEntity(abrupt(_136)=true).
inputEntity(appear(_130)).
inputEntity(inactive(_136)=true).
inputEntity(distance(_136,_138,_140)=true).
inputEntity(orientation(_136)=_132).
inputEntity(appearance(_136)=_132).
inputEntity(coord(_136,_138,_140)=_132).

outputEntity(person(_258)=true).
outputEntity(person(_258)=false).
outputEntity(leaving_object(_258,_260)=true).
outputEntity(leaving_object(_258,_260)=false).
outputEntity(meeting(_258,_260)=true).
outputEntity(meeting(_258,_260)=false).
outputEntity(close(_258,_260,_262)=true).
outputEntity(close(_258,_260,_262)=false).
outputEntity(closeSymmetric(_258,_260,_262)=true).
outputEntity(greeting1(_258,_260)=true).
outputEntity(greeting2(_258,_260)=true).
outputEntity(activeOrInactivePerson(_258)=true).
outputEntity(moving(_258,_260)=true).
outputEntity(fighting(_258,_260)=true).

event(disappear(_392)).
event(appear(_392)).

simpleFluent(person(_466)=true).
simpleFluent(person(_466)=false).
simpleFluent(leaving_object(_466,_468)=true).
simpleFluent(leaving_object(_466,_468)=false).
simpleFluent(meeting(_466,_468)=true).
simpleFluent(meeting(_466,_468)=false).

sDFluent(close(_558,_560,_562)=true).
sDFluent(close(_558,_560,_562)=false).
sDFluent(closeSymmetric(_558,_560,_562)=true).
sDFluent(greeting1(_558,_560)=true).
sDFluent(greeting2(_558,_560)=true).
sDFluent(activeOrInactivePerson(_558)=true).
sDFluent(moving(_558,_560)=true).
sDFluent(fighting(_558,_560)=true).
sDFluent(walking(_558)=true).
sDFluent(running(_558)=true).
sDFluent(active(_558)=true).
sDFluent(abrupt(_558)=true).
sDFluent(inactive(_558)=true).
sDFluent(distance(_558,_560,_562)=true).
sDFluent(orientation(_558)=_554).
sDFluent(appearance(_558)=_554).
sDFluent(coord(_558,_560,_562)=_554).

index(disappear(_662),_662).
index(appear(_662),_662).
index(person(_662)=true,_662).
index(person(_662)=false,_662).
index(leaving_object(_662,_722)=true,_662).
index(leaving_object(_662,_722)=false,_662).
index(meeting(_662,_722)=true,_662).
index(meeting(_662,_722)=false,_662).
index(close(_662,_722,_724)=true,_662).
index(close(_662,_722,_724)=false,_662).
index(closeSymmetric(_662,_722,_724)=true,_662).
index(greeting1(_662,_722)=true,_662).
index(greeting2(_662,_722)=true,_662).
index(activeOrInactivePerson(_662)=true,_662).
index(moving(_662,_722)=true,_662).
index(fighting(_662,_722)=true,_662).
index(walking(_662)=true,_662).
index(running(_662)=true,_662).
index(active(_662)=true,_662).
index(abrupt(_662)=true,_662).
index(inactive(_662)=true,_662).
index(distance(_662,_722,_724)=true,_662).
index(orientation(_662)=_716,_662).
index(appearance(_662)=_716,_662).
index(coord(_662,_722,_724)=_716,_662).


cachingOrder2(_1114, close(_1114,_1116,_1232)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1114),id(_1116),_1114@<_1116.

cachingOrder2(_1092, person(_1092)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1092).

cachingOrder2(_1478, close(_1478,_1480,_1596)=false) :- % level in dependency graph: 2, processing order in component: 1
     id(_1478),id(_1480),_1478@<_1480.

cachingOrder2(_1452, closeSymmetric(_1452,_1454,_1720)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1452),id(_1454),_1452@<_1454.

cachingOrder2(_1430, activeOrInactivePerson(_1430)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1430).

cachingOrder2(_1406, moving(_1406,_1408)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1406),id(_1408),_1406@<_1408.

cachingOrder2(_1382, fighting(_1382,_1384)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1382),id(_1384),_1382@<_1384.

cachingOrder2(_2158, leaving_object(_2158,_2160)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2158),id(_2160),_2158@<_2160.

cachingOrder2(_2110, greeting1(_2110,_2112)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2110),id(_2112),_2110@<_2112.

cachingOrder2(_2086, greeting2(_2086,_2088)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2086),id(_2088),_2086@<_2088.

cachingOrder2(_2554, meeting(_2554,_2556)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2554),id(_2556),_2554@<_2556.

collectGrounds([walking(_734)=true, walking(_734)=true, disappear(_734), running(_734)=true, running(_734)=true, active(_734)=true, active(_734)=true, abrupt(_734)=true, abrupt(_734)=true, appear(_734), inactive(_734)=true, inactive(_734)=true, orientation(_734)=_748, appearance(_734)=_748, coord(_734,_754,_756)=_748],id(_734)).

dgrounded(person(_1540)=true, id(_1540)).
dgrounded(leaving_object(_1484,_1486)=true, id(_1484)).
dgrounded(leaving_object(_1484,_1486)=true, id(_1486)).
dgrounded(meeting(_1428,_1430)=true, id(_1428)).
dgrounded(meeting(_1428,_1430)=true, id(_1430)).
dgrounded(close(_1370,_1372,24)=true, id(_1370)).
dgrounded(close(_1370,_1372,24)=true, id(_1372)).
dgrounded(close(_1312,_1314,25)=true, id(_1312)).
dgrounded(close(_1312,_1314,25)=true, id(_1314)).
dgrounded(close(_1254,_1256,30)=true, id(_1254)).
dgrounded(close(_1254,_1256,30)=true, id(_1256)).
dgrounded(close(_1196,_1198,34)=true, id(_1196)).
dgrounded(close(_1196,_1198,34)=true, id(_1198)).
dgrounded(close(_1138,_1140,34)=false, id(_1138)).
dgrounded(close(_1138,_1140,34)=false, id(_1140)).
dgrounded(closeSymmetric(_1080,_1082,30)=true, id(_1080)).
dgrounded(closeSymmetric(_1080,_1082,30)=true, id(_1082)).
dgrounded(greeting1(_1024,_1026)=true, id(_1024)).
dgrounded(greeting1(_1024,_1026)=true, id(_1026)).
dgrounded(greeting2(_968,_970)=true, id(_968)).
dgrounded(greeting2(_968,_970)=true, id(_970)).
dgrounded(activeOrInactivePerson(_936)=true, id(_936)).
dgrounded(moving(_880,_882)=true, id(_880)).
dgrounded(moving(_880,_882)=true, id(_882)).
dgrounded(fighting(_824,_826)=true, id(_824)).
dgrounded(fighting(_824,_826)=true, id(_826)).
