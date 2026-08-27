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


sDFluent(close(_614,_616,_618)=true).
sDFluent(close(_614,_616,_618)=false).
sDFluent(closeSymmetric(_614,_616,_618)=true).
sDFluent(greeting1(_614,_616)=true).
sDFluent(greeting2(_614,_616)=true).
sDFluent(activeOrInactivePerson(_614)=true).
sDFluent(moving(_614,_616)=true).
sDFluent(fighting(_614,_616)=true).
sDFluent(walking(_614)=true).
sDFluent(running(_614)=true).
sDFluent(active(_614)=true).
sDFluent(abrupt(_614)=true).
sDFluent(inactive(_614)=true).
sDFluent(distance(_614,_616,_618)=true).
sDFluent(orientation(_614)=_610).
sDFluent(appearance(_614)=_610).
sDFluent(coord(_614,_616,_618)=_610).

index(disappear(_718),_718).
index(appear(_718),_718).
index(person(_718)=true,_718).
index(person(_718)=false,_718).
index(leaving_object(_718,_778)=true,_718).
index(leaving_object(_718,_778)=false,_718).
index(meeting(_718,_778)=true,_718).
index(meeting(_718,_778)=false,_718).
index(close(_718,_778,_780)=true,_718).
index(close(_718,_778,_780)=false,_718).
index(closeSymmetric(_718,_778,_780)=true,_718).
index(greeting1(_718,_778)=true,_718).
index(greeting2(_718,_778)=true,_718).
index(activeOrInactivePerson(_718)=true,_718).
index(moving(_718,_778)=true,_718).
index(fighting(_718,_778)=true,_718).
index(walking(_718)=true,_718).
index(running(_718)=true,_718).
index(active(_718)=true,_718).
index(abrupt(_718)=true,_718).
index(inactive(_718)=true,_718).
index(distance(_718,_778,_780)=true,_718).
index(orientation(_718)=_772,_718).
index(appearance(_718)=_772,_718).
index(coord(_718,_778,_780)=_772,_718).


cachingOrder2(_1140, close(_1140,_1142,_1278)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1140),id(_1142),_1140@<_1142.

cachingOrder2(_1160, close(_1160,_1162,_1402)=false) :- % level in dependency graph: 1, processing order in component: 2
     id(_1160),id(_1162),_1160@<_1162.

cachingOrder2(_1118, person(_1118)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1118).

cachingOrder2(_1622, closeSymmetric(_1622,_1624,_1740)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1622),id(_1624),_1622@<_1624.

cachingOrder2(_1600, activeOrInactivePerson(_1600)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1600).

cachingOrder2(_1576, moving(_1576,_1578)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1576),id(_1578),_1576@<_1578.

cachingOrder2(_1552, fighting(_1552,_1554)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1552),id(_1554),_1552@<_1554.

cachingOrder2(_2172, leaving_object(_2172,_2174)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2172),id(_2174),_2172@<_2174.

cachingOrder2(_2130, greeting1(_2130,_2132)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2130),id(_2132),_2130@<_2132.

cachingOrder2(_2106, greeting2(_2106,_2108)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2106),id(_2108),_2106@<_2108.

cachingOrder2(_2586, meeting(_2586,_2588)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2586),id(_2588),_2586@<_2588.

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
