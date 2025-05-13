:- dynamic id/1.

initiatedAt(person(_112)=true, _158, _82, _164) :-
     happensAtProcessedIE(_112,start(walking(_112)=true),_82),_158=<_82,_82<_164,
     \+happensAtIE(disappear(_112),_82).

initiatedAt(person(_112)=true, _158, _82, _164) :-
     happensAtProcessedIE(_112,start(running(_112)=true),_82),_158=<_82,_82<_164,
     \+happensAtIE(disappear(_112),_82).

initiatedAt(person(_112)=true, _158, _82, _164) :-
     happensAtProcessedIE(_112,start(active(_112)=true),_82),_158=<_82,_82<_164,
     \+happensAtIE(disappear(_112),_82).

initiatedAt(person(_112)=true, _158, _82, _164) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_82),_158=<_82,_82<_164,
     \+happensAtIE(disappear(_112),_82).

initiatedAt(person(_112)=false, _128, _82, _134) :-
     happensAtIE(disappear(_112),_82),
     _128=<_82,
     _82<_134.

initiatedAt(leaving_object(_112,_114)=true, _198, _82, _204) :-
     happensAtIE(appear(_114),_82),_198=<_82,_82<_204,
     holdsAtProcessedIE(_114,inactive(_114)=true,_82),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_82),
     holdsAtProcessedSDFluent(_112,closeSymmetric_30(_112,_114)=true,_82).

initiatedAt(leaving_object(_112,_114)=false, _130, _82, _136) :-
     happensAtIE(disappear(_114),_82),
     _130=<_82,
     _82<_136.

initiatedAt(meeting(_112,_114)=true, _182, _82, _188) :-
     happensAtProcessedSDFluent(_112,start(greeting1(_112,_114)=true),_82),_182=<_82,_82<_188,
     \+happensAtIE(disappear(_112),_82),
     \+happensAtIE(disappear(_114),_82).

initiatedAt(meeting(_112,_114)=true, _182, _82, _188) :-
     happensAtProcessedSDFluent(_112,start(greeting2(_112,_114)=true),_82),_182=<_82,_82<_188,
     \+happensAtIE(disappear(_112),_82),
     \+happensAtIE(disappear(_114),_82).

initiatedAt(meeting(_112,_114)=false, _140, _82, _146) :-
     happensAtProcessedIE(_112,start(running(_112)=true),_82),
     _140=<_82,
     _82<_146.

initiatedAt(meeting(_112,_114)=false, _140, _82, _146) :-
     happensAtProcessedIE(_114,start(running(_114)=true),_82),
     _140=<_82,
     _82<_146.

initiatedAt(meeting(_112,_114)=false, _140, _82, _146) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_82),
     _140=<_82,
     _82<_146.

initiatedAt(meeting(_112,_114)=false, _140, _82, _146) :-
     happensAtProcessedIE(_114,start(abrupt(_114)=true),_82),
     _140=<_82,
     _82<_146.

initiatedAt(meeting(_112,_114)=false, _142, _82, _148) :-
     happensAtProcessedSDFluent(_112,start(close_34(_112,_114)=false),_82),
     _142=<_82,
     _82<_148.

initiatedAt(meeting(_112,_114)=false, _130, _82, _136) :-
     happensAtIE(disappear(_112),_82),
     _130=<_82,
     _82<_136.

initiatedAt(meeting(_112,_114)=false, _130, _82, _136) :-
     happensAtIE(disappear(_114),_82),
     _130=<_82,
     _82<_136.

holdsForSDFluent(close_24(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,distance(_112,_114,24)=true,_82).

holdsForSDFluent(close_25(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,close_24(_112,_114)=true,_132),
     holdsForProcessedIE(_112,distance(_112,_114,25)=true,_152),
     union_all([_132,_152],_82).

holdsForSDFluent(close_30(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,close_25(_112,_114)=true,_132),
     holdsForProcessedIE(_112,distance(_112,_114,30)=true,_152),
     union_all([_132,_152],_82).

holdsForSDFluent(close_34(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,close_30(_112,_114)=true,_132),
     holdsForProcessedIE(_112,distance(_112,_114,34)=true,_152),
     union_all([_132,_152],_82).

holdsForSDFluent(close_34(_112,_114)=false,_82) :-
     holdsForProcessedSDFluent(_112,close_34(_112,_114)=true,_132),
     complement_all([_132],_82).

holdsForSDFluent(closeSymmetric_30(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,close_30(_112,_114)=true,_132),
     holdsForProcessedSDFluent(_114,close_30(_114,_112)=true,_150),
     union_all([_132,_150],_82).

holdsForSDFluent(greeting1(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,activeOrInactivePerson(_112)=true,_130),
     \+_130=[],
     holdsForProcessedSimpleFluent(_114,person(_114)=true,_156),
     \+_156=[],
     holdsForProcessedSDFluent(_112,close_25(_112,_114)=true,_184),
     \+_184=[],
     intersect_all([_130,_184,_156],_218),
     \+_218=[],
     !,
     holdsForProcessedIE(_114,running(_114)=true,_244),
     holdsForProcessedIE(_114,abrupt(_114)=true,_260),
     relative_complement_all(_218,[_244,_260],_82).

holdsForSDFluent(greeting1(_106,_108)=true,[]).

holdsForSDFluent(greeting2(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,walking(_112)=true,_130),
     \+_130=[],
     holdsForProcessedSDFluent(_114,activeOrInactivePerson(_114)=true,_156),
     \+_156=[],
     holdsForProcessedSDFluent(_114,close_25(_114,_112)=true,_184),
     \+_184=[],
     !,
     intersect_all([_130,_156,_184],_82).

holdsForSDFluent(greeting2(_106,_108)=true,[]).

holdsForSDFluent(activeOrInactivePerson(_112)=true,_82) :-
     holdsForProcessedIE(_112,active(_112)=true,_128),
     holdsForProcessedIE(_112,inactive(_112)=true,_144),
     holdsForProcessedSimpleFluent(_112,person(_112)=true,_160),
     intersect_all([_144,_160],_178),
     union_all([_128,_178],_82).

holdsForSDFluent(moving(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,walking(_112)=true,_130),
     holdsForProcessedIE(_114,walking(_114)=true,_146),
     intersect_all([_130,_146],_164),
     \+_164=[],
     holdsForProcessedSDFluent(_112,close_34(_112,_114)=true,_192),
     \+_192=[],
     !,
     intersect_all([_164,_192],_82).

holdsForSDFluent(moving(_106,_108)=true,[]).

holdsForSDFluent(fighting(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,abrupt(_112)=true,_130),
     holdsForProcessedIE(_114,abrupt(_114)=true,_146),
     union_all([_130,_146],_164),
     \+_164=[],
     holdsForProcessedSDFluent(_112,close_34(_112,_114)=true,_192),
     \+_192=[],
     intersect_all([_164,_192],_220),
     \+_220=[],
     !,
     holdsForProcessedIE(_112,inactive(_112)=true,_246),
     holdsForProcessedIE(_114,inactive(_114)=true,_262),
     union_all([_246,_262],_280),
     relative_complement_all(_220,[_280],_82).

holdsForSDFluent(fighting(_106,_108)=true,[]).

buildFromPoints2(_86, walking(_86)=true) :-
     id(_86).

buildFromPoints2(_86, active(_86)=true) :-
     id(_86).

buildFromPoints2(_86, inactive(_86)=true) :-
     id(_86).

buildFromPoints2(_86, running(_86)=true) :-
     id(_86).

buildFromPoints2(_86, abrupt(_86)=true) :-
     id(_86).

points(orientation(_380)=_376).

points(appearance(_380)=_376).

points(coord(_380,_382,_384)=true).

points(walking(_380)=true).

points(active(_380)=true).

points(inactive(_380)=true).

points(running(_380)=true).

points(abrupt(_380)=true).

grounding(appear(_380)) :- 
     id(_380).

grounding(disappear(_380)) :- 
     id(_380).

grounding(orientation(_386)=_382) :- 
     id(_386).

grounding(appearance(_386)=_382) :- 
     id(_386).

grounding(coord(_386,_388,_390)=_382) :- 
     id(_386).

grounding(walking(_386)=_382) :- 
     id(_386).

grounding(active(_386)=_382) :- 
     id(_386).

grounding(inactive(_386)=_382) :- 
     id(_386).

grounding(running(_386)=_382) :- 
     id(_386).

grounding(abrupt(_386)=_382) :- 
     id(_386).

grounding(close_24(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(close_25(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(close_30(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(close_34(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(close_34(_386,_388)=false) :- 
     id(_386),id(_388),_386@<_388.

grounding(closeSymmetric_30(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(walking(_386)=true) :- 
     id(_386).

grounding(active(_386)=true) :- 
     id(_386).

grounding(inactive(_386)=true) :- 
     id(_386).

grounding(abrupt(_386)=true) :- 
     id(_386).

grounding(running(_386)=true) :- 
     id(_386).

grounding(person(_386)=true) :- 
     id(_386).

grounding(activeOrInactivePerson(_386)=true) :- 
     id(_386).

grounding(greeting1(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(greeting2(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(leaving_object(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(meeting(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(moving(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

grounding(fighting(_386,_388)=true) :- 
     id(_386),id(_388),_386@<_388.

inputEntity(walking(_148)=true).
inputEntity(disappear(_142)).
inputEntity(running(_148)=true).
inputEntity(active(_148)=true).
inputEntity(abrupt(_148)=true).
inputEntity(appear(_142)).
inputEntity(inactive(_148)=true).
inputEntity(distance(_148,_150,_152)=true).
inputEntity(orientation(_148)=_144).
inputEntity(appearance(_148)=_144).
inputEntity(coord(_148,_150,_152)=_144).

outputEntity(person(_276)=true).
outputEntity(person(_276)=false).
outputEntity(leaving_object(_276,_278)=true).
outputEntity(leaving_object(_276,_278)=false).
outputEntity(meeting(_276,_278)=true).
outputEntity(meeting(_276,_278)=false).
outputEntity(close_24(_276,_278)=true).
outputEntity(close_25(_276,_278)=true).
outputEntity(close_30(_276,_278)=true).
outputEntity(close_34(_276,_278)=true).
outputEntity(close_34(_276,_278)=false).
outputEntity(closeSymmetric_30(_276,_278)=true).
outputEntity(greeting1(_276,_278)=true).
outputEntity(greeting2(_276,_278)=true).
outputEntity(activeOrInactivePerson(_276)=true).
outputEntity(moving(_276,_278)=true).
outputEntity(fighting(_276,_278)=true).

event(disappear(_434)).
event(appear(_434)).

simpleFluent(person(_514)=true).
simpleFluent(person(_514)=false).
simpleFluent(leaving_object(_514,_516)=true).
simpleFluent(leaving_object(_514,_516)=false).
simpleFluent(meeting(_514,_516)=true).
simpleFluent(meeting(_514,_516)=false).


sDFluent(close_24(_674,_676)=true).
sDFluent(close_25(_674,_676)=true).
sDFluent(close_30(_674,_676)=true).
sDFluent(close_34(_674,_676)=true).
sDFluent(close_34(_674,_676)=false).
sDFluent(closeSymmetric_30(_674,_676)=true).
sDFluent(greeting1(_674,_676)=true).
sDFluent(greeting2(_674,_676)=true).
sDFluent(activeOrInactivePerson(_674)=true).
sDFluent(moving(_674,_676)=true).
sDFluent(fighting(_674,_676)=true).
sDFluent(walking(_674)=true).
sDFluent(running(_674)=true).
sDFluent(active(_674)=true).
sDFluent(abrupt(_674)=true).
sDFluent(inactive(_674)=true).
sDFluent(distance(_674,_676,_678)=true).
sDFluent(orientation(_674)=_670).
sDFluent(appearance(_674)=_670).
sDFluent(coord(_674,_676,_678)=_670).

index(disappear(_796),_796).
index(appear(_796),_796).
index(person(_796)=true,_796).
index(person(_796)=false,_796).
index(leaving_object(_796,_862)=true,_796).
index(leaving_object(_796,_862)=false,_796).
index(meeting(_796,_862)=true,_796).
index(meeting(_796,_862)=false,_796).
index(close_24(_796,_862)=true,_796).
index(close_25(_796,_862)=true,_796).
index(close_30(_796,_862)=true,_796).
index(close_34(_796,_862)=true,_796).
index(close_34(_796,_862)=false,_796).
index(closeSymmetric_30(_796,_862)=true,_796).
index(greeting1(_796,_862)=true,_796).
index(greeting2(_796,_862)=true,_796).
index(activeOrInactivePerson(_796)=true,_796).
index(moving(_796,_862)=true,_796).
index(fighting(_796,_862)=true,_796).
index(walking(_796)=true,_796).
index(running(_796)=true,_796).
index(active(_796)=true,_796).
index(abrupt(_796)=true,_796).
index(inactive(_796)=true,_796).
index(distance(_796,_862,_864)=true,_796).
index(orientation(_796)=_856,_796).
index(appearance(_796)=_856,_796).
index(coord(_796,_862,_864)=_856,_796).


cachingOrder2(_1256, person(_1256)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1256).

cachingOrder2(_1216, close_24(_1216,_1218)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1216),id(_1218),_1216@<_1218.

cachingOrder2(_1532, close_25(_1532,_1534)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1532),id(_1534),_1532@<_1534.

cachingOrder2(_1510, activeOrInactivePerson(_1510)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1510).

cachingOrder2(_1836, close_30(_1836,_1838)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1836),id(_1838),_1836@<_1838.

cachingOrder2(_1812, greeting1(_1812,_1814)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1812),id(_1814),_1812@<_1814.

cachingOrder2(_1788, greeting2(_1788,_1790)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1788),id(_1790),_1788@<_1790.

cachingOrder2(_2262, close_34(_2262,_2264)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2262),id(_2264),_2262@<_2264.

cachingOrder2(_2280, close_34(_2280,_2282)=false) :- % level in dependency graph: 4, processing order in component: 2
     id(_2280),id(_2282),_2280@<_2282.

cachingOrder2(_2238, closeSymmetric_30(_2238,_2240)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2238),id(_2240),_2238@<_2240.

cachingOrder2(_2790, leaving_object(_2790,_2792)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2790),id(_2792),_2790@<_2792.

cachingOrder2(_2748, meeting(_2748,_2750)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2748),id(_2750),_2748@<_2750.

cachingOrder2(_2706, moving(_2706,_2708)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2706),id(_2708),_2706@<_2708.

cachingOrder2(_2682, fighting(_2682,_2684)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2682),id(_2684),_2682@<_2684.

collectGrounds([walking(_752)=true, walking(_752)=true, disappear(_752), running(_752)=true, running(_752)=true, active(_752)=true, active(_752)=true, abrupt(_752)=true, abrupt(_752)=true, appear(_752), inactive(_752)=true, inactive(_752)=true, orientation(_752)=_766, appearance(_752)=_766, coord(_752,_772,_774)=_766],id(_752)).

dgrounded(person(_1552)=true, id(_1552)).
dgrounded(leaving_object(_1496,_1498)=true, id(_1496)).
dgrounded(leaving_object(_1496,_1498)=true, id(_1498)).
dgrounded(meeting(_1440,_1442)=true, id(_1440)).
dgrounded(meeting(_1440,_1442)=true, id(_1442)).
dgrounded(close_24(_1384,_1386)=true, id(_1384)).
dgrounded(close_24(_1384,_1386)=true, id(_1386)).
dgrounded(close_25(_1328,_1330)=true, id(_1328)).
dgrounded(close_25(_1328,_1330)=true, id(_1330)).
dgrounded(close_30(_1272,_1274)=true, id(_1272)).
dgrounded(close_30(_1272,_1274)=true, id(_1274)).
dgrounded(close_34(_1216,_1218)=true, id(_1216)).
dgrounded(close_34(_1216,_1218)=true, id(_1218)).
dgrounded(close_34(_1160,_1162)=false, id(_1160)).
dgrounded(close_34(_1160,_1162)=false, id(_1162)).
dgrounded(closeSymmetric_30(_1104,_1106)=true, id(_1104)).
dgrounded(closeSymmetric_30(_1104,_1106)=true, id(_1106)).
dgrounded(greeting1(_1048,_1050)=true, id(_1048)).
dgrounded(greeting1(_1048,_1050)=true, id(_1050)).
dgrounded(greeting2(_992,_994)=true, id(_992)).
dgrounded(greeting2(_992,_994)=true, id(_994)).
dgrounded(activeOrInactivePerson(_960)=true, id(_960)).
dgrounded(moving(_904,_906)=true, id(_904)).
dgrounded(moving(_904,_906)=true, id(_906)).
dgrounded(fighting(_848,_850)=true, id(_848)).
dgrounded(fighting(_848,_850)=true, id(_850)).
