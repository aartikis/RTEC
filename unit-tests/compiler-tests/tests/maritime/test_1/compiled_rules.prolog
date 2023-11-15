:- dynamic vessel/1, vpair/2.

initiatedAt(withinArea(_106,_108)=true, _138, _76, _144) :-
     happensAtIE(entersArea(_106,_114),_76),_138=<_76,_76<_144,
     areaType(_114,_108).

initiatedAt(gap(_106)=nearPorts, _146, _76, _152) :-
     happensAtIE(gap_start(_106),_76),_146=<_76,_76<_152,
     holdsAtProcessedSimpleFluent(_106,withinArea(_106,nearPorts)=true,_76).

initiatedAt(gap(_106)=farFromPorts, _150, _76, _156) :-
     happensAtIE(gap_start(_106),_76),_150=<_76,_76<_156,
     \+holdsAtProcessedSimpleFluent(_106,withinArea(_106,nearPorts)=true,_76).

initiatedAt(stopped(_106)=nearPorts, _146, _76, _152) :-
     happensAtIE(stop_start(_106),_76),_146=<_76,_76<_152,
     holdsAtProcessedSimpleFluent(_106,withinArea(_106,nearPorts)=true,_76).

initiatedAt(stopped(_106)=farFromPorts, _150, _76, _156) :-
     happensAtIE(stop_start(_106),_76),_150=<_76,_76<_156,
     \+holdsAtProcessedSimpleFluent(_106,withinArea(_106,nearPorts)=true,_76).

initiatedAt(lowSpeed(_106)=true, _122, _76, _128) :-
     happensAtIE(slow_motion_start(_106),_76),
     _122=<_76,
     _76<_128.

initiatedAt(changingSpeed(_106)=true, _122, _76, _128) :-
     happensAtIE(change_in_speed_start(_106),_76),
     _122=<_76,
     _76<_128.

initiatedAt(highSpeedNearCoast(_106)=true, _182, _76, _188) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_182=<_76,_76<_188,
     thresholds(hcNearCoastMax,_128),
     \+inRange(_112,0,_128),
     holdsAtProcessedSimpleFluent(_106,withinArea(_106,nearCoast)=true,_76).

initiatedAt(movingSpeed(_106)=below, _182, _76, _188) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_182=<_76,_76<_188,
     vesselType(_106,_128),
     typeSpeed(_128,_134,_136,_138),
     thresholds(movingMin,_144),
     inRange(_112,_144,_134).

initiatedAt(movingSpeed(_106)=normal, _170, _76, _176) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_170=<_76,_76<_176,
     vesselType(_106,_128),
     typeSpeed(_128,_134,_136,_138),
     inRange(_112,_134,_136).

initiatedAt(movingSpeed(_106)=above, _170, _76, _176) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_170=<_76,_76<_176,
     vesselType(_106,_128),
     typeSpeed(_128,_134,_136,_138),
     inRange(_112,_136,inf).

initiatedAt(drifting(_106)=true, _206, _76, _212) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_206=<_76,_76<_212,
     _116=\=511.0,
     absoluteAngleDiff(_114,_116,_142),
     thresholds(adriftAngThr,_148),
     _142>_148,
     holdsAtProcessedSDFluent(_106,underWay(_106)=true,_76).

initiatedAt(tuggingSpeed(_106)=true, _166, _76, _172) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_166=<_76,_76<_172,
     thresholds(tuggingMin,_128),
     thresholds(tuggingMax,_134),
     inRange(_112,_128,_134).

initiatedAt(trawlSpeed(_106)=true, _190, _76, _196) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_190=<_76,_76<_196,
     thresholds(trawlspeedMin,_128),
     thresholds(trawlspeedMax,_134),
     inRange(_112,_128,_134),
     holdsAtProcessedSimpleFluent(_106,withinArea(_106,fishing)=true,_76).

initiatedAt(trawlingMovement(_106)=true, _146, _76, _152) :-
     happensAtIE(change_in_heading(_106),_76),_146=<_76,_76<_152,
     holdsAtProcessedSimpleFluent(_106,withinArea(_106,fishing)=true,_76).

initiatedAt(sarSpeed(_106)=true, _154, _76, _160) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_154=<_76,_76<_160,
     thresholds(sarMinSpeed,_128),
     inRange(_112,_128,inf).

initiatedAt(sarMovement(_106)=true, _122, _76, _128) :-
     happensAtIE(change_in_heading(_106),_76),
     _122=<_76,
     _76<_128.

initiatedAt(sarMovement(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(changingSpeed(_106)=true),_76),
     _132=<_76,
     _76<_138.

terminatedAt(withinArea(_106,_108)=true, _138, _76, _144) :-
     happensAtIE(leavesArea(_106,_114),_76),_138=<_76,_76<_144,
     areaType(_114,_108).

terminatedAt(withinArea(_106,_108)=true, _124, _76, _130) :-
     happensAtIE(gap_start(_106),_76),
     _124=<_76,
     _76<_130.

terminatedAt(gap(_106)=_82, _122, _76, _128) :-
     happensAtIE(gap_end(_106),_76),
     _122=<_76,
     _76<_128.

terminatedAt(stopped(_106)=_82, _122, _76, _128) :-
     happensAtIE(stop_end(_106),_76),
     _122=<_76,
     _76<_128.

terminatedAt(stopped(_106)=_82, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

terminatedAt(lowSpeed(_106)=true, _122, _76, _128) :-
     happensAtIE(slow_motion_end(_106),_76),
     _122=<_76,
     _76<_128.

terminatedAt(lowSpeed(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

terminatedAt(changingSpeed(_106)=true, _122, _76, _128) :-
     happensAtIE(change_in_speed_end(_106),_76),
     _122=<_76,
     _76<_128.

terminatedAt(changingSpeed(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

terminatedAt(highSpeedNearCoast(_106)=true, _154, _76, _160) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_154=<_76,_76<_160,
     thresholds(hcNearCoastMax,_128),
     inRange(_112,0,_128).

terminatedAt(highSpeedNearCoast(_106)=true, _134, _76, _140) :-
     happensAtProcessedSimpleFluent(_106,end(withinArea(_106,nearCoast)=true),_76),
     _134=<_76,
     _76<_140.

terminatedAt(movingSpeed(_106)=_82, _158, _76, _164) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_158=<_76,_76<_164,
     thresholds(movingMin,_128),
     \+inRange(_112,_128,inf).

terminatedAt(movingSpeed(_106)=_82, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

terminatedAt(drifting(_106)=true, _166, _76, _172) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_166=<_76,_76<_172,
     absoluteAngleDiff(_114,_116,_130),
     thresholds(adriftAngThr,_136),
     _130=<_136.

terminatedAt(drifting(_106)=true, _134, _76, _140) :-
     happensAtIE(velocity(_106,_112,_114,511.0),_76),
     _134=<_76,
     _76<_140.

terminatedAt(drifting(_106)=true, _132, _76, _138) :-
     happensAtProcessedSDFluent(_106,end(underWay(_106)=true),_76),
     _132=<_76,
     _76<_138.

terminatedAt(tuggingSpeed(_106)=true, _170, _76, _176) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_170=<_76,_76<_176,
     thresholds(tuggingMin,_128),
     thresholds(tuggingMax,_134),
     \+inRange(_112,_128,_134).

terminatedAt(tuggingSpeed(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

terminatedAt(trawlSpeed(_106)=true, _170, _76, _176) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_170=<_76,_76<_176,
     thresholds(trawlspeedMin,_128),
     thresholds(trawlspeedMax,_134),
     \+inRange(_112,_128,_134).

terminatedAt(trawlSpeed(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

terminatedAt(trawlSpeed(_106)=true, _134, _76, _140) :-
     happensAtProcessedSimpleFluent(_106,end(withinArea(_106,fishing)=true),_76),
     _134=<_76,
     _76<_140.

terminatedAt(trawlingMovement(_106)=true, _134, _76, _140) :-
     happensAtProcessedSimpleFluent(_106,end(withinArea(_106,fishing)=true),_76),
     _134=<_76,
     _76<_140.

terminatedAt(sarSpeed(_106)=true, _154, _76, _160) :-
     happensAtIE(velocity(_106,_112,_114,_116),_76),_154=<_76,_76<_160,
     thresholds(sarMinSpeed,_128),
     inRange(_112,0,_128).

terminatedAt(sarSpeed(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

terminatedAt(sarMovement(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(gap(_106)=_116),_76),
     _132=<_76,
     _76<_138.

holdsForSDFluent(underWay(_106)=true,_76) :-
     holdsForProcessedSimpleFluent(_106,movingSpeed(_106)=below,_122),
     holdsForProcessedSimpleFluent(_106,movingSpeed(_106)=normal,_138),
     holdsForProcessedSimpleFluent(_106,movingSpeed(_106)=above,_154),
     union_all([_122,_138,_154],_76).

holdsForSDFluent(anchoredOrMoored(_106)=true,_76) :-
     holdsForProcessedSimpleFluent(_106,stopped(_106)=farFromPorts,_122),
     holdsForProcessedSimpleFluent(_106,withinArea(_106,anchorage)=true,_140),
     intersect_all([_122,_140],_158),
     holdsForProcessedSimpleFluent(_106,stopped(_106)=nearPorts,_174),
     union_all([_158,_174],_192),
     thresholds(aOrMTime,_198),
     intDurGreater(_192,_198,_76).

holdsForSDFluent(tugging(_106,_108)=true,_76) :-
     holdsForProcessedIE(_106,proximity(_106,_108)=true,_126),
     oneIsTug(_106,_108),
     \+oneIsPilot(_106,_108),
     \+twoAreTugs(_106,_108),
     holdsForProcessedSimpleFluent(_106,tuggingSpeed(_106)=true,_168),
     holdsForProcessedSimpleFluent(_108,tuggingSpeed(_108)=true,_184),
     intersect_all([_126,_168,_184],_208),
     thresholds(tuggingTime,_214),
     intDurGreater(_208,_214,_76).

holdsForSDFluent(rendezVous(_106,_108)=true,_76) :-
     holdsForProcessedIE(_106,proximity(_106,_108)=true,_126),
     \+oneIsTug(_106,_108),
     \+oneIsPilot(_106,_108),
     holdsForProcessedSimpleFluent(_106,lowSpeed(_106)=true,_162),
     holdsForProcessedSimpleFluent(_108,lowSpeed(_108)=true,_178),
     holdsForProcessedSimpleFluent(_106,stopped(_106)=farFromPorts,_194),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_210),
     union_all([_162,_194],_228),
     union_all([_178,_210],_246),
     intersect_all([_228,_246,_126],_270),
     _270\=[],
     holdsForProcessedSimpleFluent(_106,withinArea(_106,nearPorts)=true,_294),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_312),
     holdsForProcessedSimpleFluent(_106,withinArea(_106,nearCoast)=true,_330),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_348),
     relative_complement_all(_270,[_294,_312,_330,_348],_380),
     thresholds(rendezvousTime,_386),
     intDurGreater(_380,_386,_76).

holdsForSDFluent(trawling(_106)=true,_76) :-
     holdsForProcessedSimpleFluent(_106,trawlSpeed(_106)=true,_122),
     holdsForProcessedSimpleFluent(_106,trawlingMovement(_106)=true,_138),
     intersect_all([_122,_138],_156),
     thresholds(trawlingTime,_162),
     intDurGreater(_156,_162,_76).

holdsForSDFluent(inSAR(_106)=true,_76) :-
     holdsForProcessedSimpleFluent(_106,sarSpeed(_106)=true,_122),
     holdsForProcessedSimpleFluent(_106,sarMovement(_106)=true,_138),
     intersect_all([_122,_138],_156),
     intDurGreater(_156,3600,_76).

holdsForSDFluent(loitering(_106)=true,_76) :-
     holdsForProcessedSimpleFluent(_106,lowSpeed(_106)=true,_122),
     holdsForProcessedSimpleFluent(_106,stopped(_106)=farFromPorts,_138),
     union_all([_122,_138],_156),
     holdsForProcessedSimpleFluent(_106,withinArea(_106,nearCoast)=true,_174),
     holdsForProcessedSDFluent(_106,anchoredOrMoored(_106)=true,_190),
     relative_complement_all(_156,[_174,_190],_210),
     thresholds(loiteringTime,_216),
     intDurGreater(_210,_216,_76).

holdsForSDFluent(pilotOps(_106,_108)=true,_76) :-
     holdsForProcessedIE(_106,proximity(_106,_108)=true,_126),
     oneIsPilot(_106,_108),
     holdsForProcessedSimpleFluent(_106,lowSpeed(_106)=true,_148),
     holdsForProcessedSimpleFluent(_108,lowSpeed(_108)=true,_164),
     holdsForProcessedSimpleFluent(_106,stopped(_106)=farFromPorts,_180),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_196),
     union_all([_148,_180],_214),
     union_all([_164,_196],_232),
     intersect_all([_214,_232,_126],_256),
     _256\=[],
     holdsForProcessedSimpleFluent(_106,withinArea(_106,nearCoast)=true,_280),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_298),
     relative_complement_all(_256,[_280,_298],_76).

fi(trawlingMovement(_116)=true,trawlingMovement(_116)=false,_78):-
     thresholds(trawlingCrs,_78),
     grounding(trawlingMovement(_116)=true),
     grounding(trawlingMovement(_116)=false).

fi(sarMovement(_110)=true,sarMovement(_110)=false,1800):-
     grounding(sarMovement(_110)=true),
     grounding(sarMovement(_110)=false).

collectIntervals2(_80, proximity(_80,_82)=true) :-
     vpair(_80,_82).

needsGrounding(_294,_296,_298) :- 
     fail.

grounding(change_in_speed_start(_476)) :- 
     vessel(_476).

grounding(change_in_speed_end(_476)) :- 
     vessel(_476).

grounding(change_in_heading(_476)) :- 
     vessel(_476).

grounding(stop_start(_476)) :- 
     vessel(_476).

grounding(stop_end(_476)) :- 
     vessel(_476).

grounding(slow_motion_start(_476)) :- 
     vessel(_476).

grounding(slow_motion_end(_476)) :- 
     vessel(_476).

grounding(gap_start(_476)) :- 
     vessel(_476).

grounding(gap_end(_476)) :- 
     vessel(_476).

grounding(entersArea(_476,_478)) :- 
     vessel(_476),areaType(_478).

grounding(leavesArea(_476,_478)) :- 
     vessel(_476),areaType(_478).

grounding(coord(_476,_478,_480)) :- 
     vessel(_476).

grounding(velocity(_476,_478,_480,_482)) :- 
     vessel(_476).

grounding(proximity(_482,_484)=true) :- 
     vpair(_482,_484).

grounding(gap(_482)=_478) :- 
     vessel(_482),portStatus(_478).

grounding(stopped(_482)=_478) :- 
     vessel(_482),portStatus(_478).

grounding(lowSpeed(_482)=true) :- 
     vessel(_482).

grounding(changingSpeed(_482)=true) :- 
     vessel(_482).

grounding(withinArea(_482,_484)=true) :- 
     vessel(_482),areaType(_484).

grounding(underWay(_482)=true) :- 
     vessel(_482).

grounding(sarSpeed(_482)=true) :- 
     vessel(_482),vesselType(_482,sar).

grounding(sarMovement(_482)=true) :- 
     vessel(_482),vesselType(_482,sar).

grounding(sarMovement(_482)=false) :- 
     vessel(_482),vesselType(_482,sar).

grounding(inSAR(_482)=true) :- 
     vessel(_482).

grounding(highSpeedNearCoast(_482)=true) :- 
     vessel(_482).

grounding(drifting(_482)=true) :- 
     vessel(_482).

grounding(anchoredOrMoored(_482)=true) :- 
     vessel(_482).

grounding(trawlSpeed(_482)=true) :- 
     vessel(_482),vesselType(_482,fishing).

grounding(movingSpeed(_482)=_478) :- 
     vessel(_482),movingStatus(_478).

grounding(pilotOps(_482,_484)=true) :- 
     vpair(_482,_484).

grounding(tuggingSpeed(_482)=true) :- 
     vessel(_482).

grounding(tugging(_482,_484)=true) :- 
     vpair(_482,_484).

grounding(rendezVous(_482,_484)=true) :- 
     vpair(_482,_484).

grounding(trawlingMovement(_482)=true) :- 
     vessel(_482),vesselType(_482,fishing).

grounding(trawlingMovement(_482)=false) :- 
     vessel(_482),vesselType(_482,fishing).

grounding(trawling(_482)=true) :- 
     vessel(_482).

grounding(loitering(_482)=true) :- 
     vessel(_482).

p(trawlingMovement(_476)=true).

p(sarMovement(_476)=true).

inputEntity(entersArea(_130,_132)).
inputEntity(gap_start(_130)).
inputEntity(stop_start(_130)).
inputEntity(slow_motion_start(_130)).
inputEntity(change_in_speed_start(_130)).
inputEntity(velocity(_130,_132,_134,_136)).
inputEntity(change_in_heading(_130)).
inputEntity(leavesArea(_130,_132)).
inputEntity(gap_end(_130)).
inputEntity(stop_end(_130)).
inputEntity(slow_motion_end(_130)).
inputEntity(change_in_speed_end(_130)).
inputEntity(proximity(_136,_138)=true).
inputEntity(coord(_130,_132,_134)).

outputEntity(withinArea(_276,_278)=true).
outputEntity(gap(_276)=nearPorts).
outputEntity(gap(_276)=farFromPorts).
outputEntity(stopped(_276)=nearPorts).
outputEntity(stopped(_276)=farFromPorts).
outputEntity(lowSpeed(_276)=true).
outputEntity(changingSpeed(_276)=true).
outputEntity(highSpeedNearCoast(_276)=true).
outputEntity(movingSpeed(_276)=below).
outputEntity(movingSpeed(_276)=normal).
outputEntity(movingSpeed(_276)=above).
outputEntity(drifting(_276)=true).
outputEntity(tuggingSpeed(_276)=true).
outputEntity(trawlSpeed(_276)=true).
outputEntity(trawlingMovement(_276)=true).
outputEntity(sarSpeed(_276)=true).
outputEntity(sarMovement(_276)=true).
outputEntity(trawlingMovement(_276)=false).
outputEntity(sarMovement(_276)=false).
outputEntity(underWay(_276)=true).
outputEntity(anchoredOrMoored(_276)=true).
outputEntity(tugging(_276,_278)=true).
outputEntity(rendezVous(_276,_278)=true).
outputEntity(trawling(_276)=true).
outputEntity(inSAR(_276)=true).
outputEntity(loitering(_276)=true).
outputEntity(pilotOps(_276,_278)=true).

event(entersArea(_488,_490)).
event(gap_start(_488)).
event(stop_start(_488)).
event(slow_motion_start(_488)).
event(change_in_speed_start(_488)).
event(velocity(_488,_490,_492,_494)).
event(change_in_heading(_488)).
event(leavesArea(_488,_490)).
event(gap_end(_488)).
event(stop_end(_488)).
event(slow_motion_end(_488)).
event(change_in_speed_end(_488)).
event(coord(_488,_490,_492)).

simpleFluent(withinArea(_628,_630)=true).
simpleFluent(gap(_628)=nearPorts).
simpleFluent(gap(_628)=farFromPorts).
simpleFluent(stopped(_628)=nearPorts).
simpleFluent(stopped(_628)=farFromPorts).
simpleFluent(lowSpeed(_628)=true).
simpleFluent(changingSpeed(_628)=true).
simpleFluent(highSpeedNearCoast(_628)=true).
simpleFluent(movingSpeed(_628)=below).
simpleFluent(movingSpeed(_628)=normal).
simpleFluent(movingSpeed(_628)=above).
simpleFluent(drifting(_628)=true).
simpleFluent(tuggingSpeed(_628)=true).
simpleFluent(trawlSpeed(_628)=true).
simpleFluent(trawlingMovement(_628)=true).
simpleFluent(sarSpeed(_628)=true).
simpleFluent(sarMovement(_628)=true).
simpleFluent(trawlingMovement(_628)=false).
simpleFluent(sarMovement(_628)=false).

sDFluent(underWay(_798)=true).
sDFluent(anchoredOrMoored(_798)=true).
sDFluent(tugging(_798,_800)=true).
sDFluent(rendezVous(_798,_800)=true).
sDFluent(trawling(_798)=true).
sDFluent(inSAR(_798)=true).
sDFluent(loitering(_798)=true).
sDFluent(pilotOps(_798,_800)=true).
sDFluent(proximity(_798,_800)=true).

index(entersArea(_854,_908),_854).
index(gap_start(_854),_854).
index(stop_start(_854),_854).
index(slow_motion_start(_854),_854).
index(change_in_speed_start(_854),_854).
index(velocity(_854,_908,_910,_912),_854).
index(change_in_heading(_854),_854).
index(leavesArea(_854,_908),_854).
index(gap_end(_854),_854).
index(stop_end(_854),_854).
index(slow_motion_end(_854),_854).
index(change_in_speed_end(_854),_854).
index(coord(_854,_908,_910),_854).
index(withinArea(_854,_914)=true,_854).
index(gap(_854)=nearPorts,_854).
index(gap(_854)=farFromPorts,_854).
index(stopped(_854)=nearPorts,_854).
index(stopped(_854)=farFromPorts,_854).
index(lowSpeed(_854)=true,_854).
index(changingSpeed(_854)=true,_854).
index(highSpeedNearCoast(_854)=true,_854).
index(movingSpeed(_854)=below,_854).
index(movingSpeed(_854)=normal,_854).
index(movingSpeed(_854)=above,_854).
index(drifting(_854)=true,_854).
index(tuggingSpeed(_854)=true,_854).
index(trawlSpeed(_854)=true,_854).
index(trawlingMovement(_854)=true,_854).
index(sarSpeed(_854)=true,_854).
index(sarMovement(_854)=true,_854).
index(trawlingMovement(_854)=false,_854).
index(sarMovement(_854)=false,_854).
index(underWay(_854)=true,_854).
index(anchoredOrMoored(_854)=true,_854).
index(tugging(_854,_914)=true,_854).
index(rendezVous(_854,_914)=true,_854).
index(trawling(_854)=true,_854).
index(inSAR(_854)=true,_854).
index(loitering(_854)=true,_854).
index(pilotOps(_854,_914)=true,_854).
index(proximity(_854,_914)=true,_854).


cachingOrder2(_1334, withinArea(_1334,_1336)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1334),areaType(_1336).

cachingOrder2(_1584, gap(_1584)=nearPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1584),portStatus(nearPorts).

cachingOrder2(_1562, gap(_1562)=farFromPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1562),portStatus(farFromPorts).

cachingOrder2(_1540, highSpeedNearCoast(_1540)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1540).

cachingOrder2(_1502, trawlingMovement(_1502)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1502),vesselType(_1502,fishing).

cachingOrder2(_1502, trawlingMovement(_1502)=false) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_1502),vesselType(_1502,fishing).

cachingOrder2(_2246, stopped(_2246)=nearPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2246),portStatus(nearPorts).

cachingOrder2(_2224, stopped(_2224)=farFromPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2224),portStatus(farFromPorts).

cachingOrder2(_2202, lowSpeed(_2202)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2202).

cachingOrder2(_2180, changingSpeed(_2180)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2180).

cachingOrder2(_2158, movingSpeed(_2158)=below) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2158),movingStatus(below).

cachingOrder2(_2136, movingSpeed(_2136)=normal) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2136),movingStatus(normal).

cachingOrder2(_2114, movingSpeed(_2114)=above) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2114),movingStatus(above).

cachingOrder2(_2092, tuggingSpeed(_2092)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2092).

cachingOrder2(_2070, trawlSpeed(_2070)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2070),vesselType(_2070,fishing).

cachingOrder2(_2048, sarSpeed(_2048)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2048),vesselType(_2048,sar).

cachingOrder2(_3228, sarMovement(_3228)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3228),vesselType(_3228,sar).

cachingOrder2(_3228, sarMovement(_3228)=false) :- % level in dependency graph: 4, processing order in component: 2
     vessel(_3228),vesselType(_3228,sar).

cachingOrder2(_3206, underWay(_3206)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3206).

cachingOrder2(_3184, anchoredOrMoored(_3184)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3184).

cachingOrder2(_3160, tugging(_3160,_3162)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3160,_3162).

cachingOrder2(_3136, rendezVous(_3136,_3138)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3136,_3138).

cachingOrder2(_3114, trawling(_3114)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3114).

cachingOrder2(_3090, pilotOps(_3090,_3092)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3090,_3092).

cachingOrder2(_3996, drifting(_3996)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_3996).

cachingOrder2(_3974, inSAR(_3974)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_3974).

cachingOrder2(_3952, loitering(_3952)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_3952).

collectGrounds([entersArea(_676,_690), gap_start(_676), stop_start(_676), slow_motion_start(_676), change_in_speed_start(_676), velocity(_676,_690,_692,_694), change_in_heading(_676), leavesArea(_676,_690), gap_end(_676), stop_end(_676), slow_motion_end(_676), change_in_speed_end(_676), coord(_676,_690,_692)],vessel(_676)).

collectGrounds([proximity(_664,_666)=true],vpair(_664,_666)).

dgrounded(withinArea(_1752,_1754)=true, vessel(_1752)).
dgrounded(gap(_1710)=nearPorts, vessel(_1710)).
dgrounded(gap(_1668)=farFromPorts, vessel(_1668)).
dgrounded(stopped(_1626)=nearPorts, vessel(_1626)).
dgrounded(stopped(_1584)=farFromPorts, vessel(_1584)).
dgrounded(lowSpeed(_1552)=true, vessel(_1552)).
dgrounded(changingSpeed(_1520)=true, vessel(_1520)).
dgrounded(highSpeedNearCoast(_1488)=true, vessel(_1488)).
dgrounded(movingSpeed(_1446)=below, vessel(_1446)).
dgrounded(movingSpeed(_1404)=normal, vessel(_1404)).
dgrounded(movingSpeed(_1362)=above, vessel(_1362)).
dgrounded(drifting(_1330)=true, vessel(_1330)).
dgrounded(tuggingSpeed(_1298)=true, vessel(_1298)).
dgrounded(trawlSpeed(_1254)=true, vessel(_1254)).
dgrounded(trawlingMovement(_1210)=true, vessel(_1210)).
dgrounded(sarSpeed(_1166)=true, vessel(_1166)).
dgrounded(sarMovement(_1122)=true, vessel(_1122)).
dgrounded(trawlingMovement(_1078)=false, vessel(_1078)).
dgrounded(sarMovement(_1034)=false, vessel(_1034)).
dgrounded(underWay(_1002)=true, vessel(_1002)).
dgrounded(anchoredOrMoored(_970)=true, vessel(_970)).
dgrounded(tugging(_934,_936)=true, vpair(_934,_936)).
dgrounded(rendezVous(_898,_900)=true, vpair(_898,_900)).
dgrounded(trawling(_866)=true, vessel(_866)).
dgrounded(inSAR(_834)=true, vessel(_834)).
dgrounded(loitering(_802)=true, vessel(_802)).
dgrounded(pilotOps(_766,_768)=true, vpair(_766,_768)).
