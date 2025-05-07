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
     holdsForProcessedIE(_112,distance(_112,_114)=true,_82).

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
inputEntity(distance(_148,_150)=true).
inputEntity(distance(_148,_150,_152)=true).
inputEntity(orientation(_148)=_144).
inputEntity(appearance(_148)=_144).
inputEntity(coord(_148,_150,_152)=_144).

outputEntity(person(_282)=true).
outputEntity(person(_282)=false).
outputEntity(leaving_object(_282,_284)=true).
outputEntity(leaving_object(_282,_284)=false).
outputEntity(meeting(_282,_284)=true).
outputEntity(meeting(_282,_284)=false).
outputEntity(close_24(_282,_284)=true).
outputEntity(close_25(_282,_284)=true).
outputEntity(close_30(_282,_284)=true).
outputEntity(close_34(_282,_284)=true).
outputEntity(close_34(_282,_284)=false).
outputEntity(closeSymmetric_30(_282,_284)=true).
outputEntity(greeting1(_282,_284)=true).
outputEntity(greeting2(_282,_284)=true).
outputEntity(activeOrInactivePerson(_282)=true).
outputEntity(moving(_282,_284)=true).
outputEntity(fighting(_282,_284)=true).

event(disappear(_440)).
event(appear(_440)).

simpleFluent(person(_520)=true).
simpleFluent(person(_520)=false).
simpleFluent(leaving_object(_520,_522)=true).
simpleFluent(leaving_object(_520,_522)=false).
simpleFluent(meeting(_520,_522)=true).
simpleFluent(meeting(_520,_522)=false).


sDFluent(close_24(_680,_682)=true).
sDFluent(close_25(_680,_682)=true).
sDFluent(close_30(_680,_682)=true).
sDFluent(close_34(_680,_682)=true).
sDFluent(close_34(_680,_682)=false).
sDFluent(closeSymmetric_30(_680,_682)=true).
sDFluent(greeting1(_680,_682)=true).
sDFluent(greeting2(_680,_682)=true).
sDFluent(activeOrInactivePerson(_680)=true).
sDFluent(moving(_680,_682)=true).
sDFluent(fighting(_680,_682)=true).
sDFluent(walking(_680)=true).
sDFluent(running(_680)=true).
sDFluent(active(_680)=true).
sDFluent(abrupt(_680)=true).
sDFluent(inactive(_680)=true).
sDFluent(distance(_680,_682)=true).
sDFluent(distance(_680,_682,_684)=true).
sDFluent(orientation(_680)=_676).
sDFluent(appearance(_680)=_676).
sDFluent(coord(_680,_682,_684)=_676).

index(disappear(_808),_808).
index(appear(_808),_808).
index(person(_808)=true,_808).
index(person(_808)=false,_808).
index(leaving_object(_808,_874)=true,_808).
index(leaving_object(_808,_874)=false,_808).
index(meeting(_808,_874)=true,_808).
index(meeting(_808,_874)=false,_808).
index(close_24(_808,_874)=true,_808).
index(close_25(_808,_874)=true,_808).
index(close_30(_808,_874)=true,_808).
index(close_34(_808,_874)=true,_808).
index(close_34(_808,_874)=false,_808).
index(closeSymmetric_30(_808,_874)=true,_808).
index(greeting1(_808,_874)=true,_808).
index(greeting2(_808,_874)=true,_808).
index(activeOrInactivePerson(_808)=true,_808).
index(moving(_808,_874)=true,_808).
index(fighting(_808,_874)=true,_808).
index(walking(_808)=true,_808).
index(running(_808)=true,_808).
index(active(_808)=true,_808).
index(abrupt(_808)=true,_808).
index(inactive(_808)=true,_808).
index(distance(_808,_874)=true,_808).
index(distance(_808,_874,_876)=true,_808).
index(orientation(_808)=_868,_808).
index(appearance(_808)=_868,_808).
index(coord(_808,_874,_876)=_868,_808).


cachingOrder2(_1274, person(_1274)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1274).

cachingOrder2(_1234, close_24(_1234,_1236)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1234),id(_1236),_1234@<_1236.

cachingOrder2(_1550, close_25(_1550,_1552)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1550),id(_1552),_1550@<_1552.

cachingOrder2(_1528, activeOrInactivePerson(_1528)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1528).

cachingOrder2(_1854, close_30(_1854,_1856)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1854),id(_1856),_1854@<_1856.

cachingOrder2(_1830, greeting1(_1830,_1832)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1830),id(_1832),_1830@<_1832.

cachingOrder2(_1806, greeting2(_1806,_1808)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1806),id(_1808),_1806@<_1808.

cachingOrder2(_2280, close_34(_2280,_2282)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2280),id(_2282),_2280@<_2282.

cachingOrder2(_2298, close_34(_2298,_2300)=false) :- % level in dependency graph: 4, processing order in component: 2
     id(_2298),id(_2300),_2298@<_2300.

cachingOrder2(_2256, closeSymmetric_30(_2256,_2258)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2256),id(_2258),_2256@<_2258.

cachingOrder2(_2808, leaving_object(_2808,_2810)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2808),id(_2810),_2808@<_2810.

cachingOrder2(_2766, meeting(_2766,_2768)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2766),id(_2768),_2766@<_2768.

cachingOrder2(_2724, moving(_2724,_2726)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2724),id(_2726),_2724@<_2726.

cachingOrder2(_2700, fighting(_2700,_2702)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2700),id(_2702),_2700@<_2702.

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
