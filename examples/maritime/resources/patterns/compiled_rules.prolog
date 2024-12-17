:- dynamic vessel/1, vpair/2.

initiatedAt(withinArea(_108,_110)=true, _140, _78, _146) :-
     happensAtIE(entersArea(_108,_116),_78),_140=<_78,_78<_146,
     areaType(_116,_110).

initiatedAt(gap(_108)=nearPorts, _148, _78, _154) :-
     happensAtIE(gap_start(_108),_78),_148=<_78,_78<_154,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_78).

initiatedAt(gap(_108)=farFromPorts, _152, _78, _158) :-
     happensAtIE(gap_start(_108),_78),_152=<_78,_78<_158,
     \+holdsAtProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_78).

initiatedAt(stopped(_108)=nearPorts, _148, _78, _154) :-
     happensAtIE(stop_start(_108),_78),_148=<_78,_78<_154,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_78).

initiatedAt(stopped(_108)=farFromPorts, _152, _78, _158) :-
     happensAtIE(stop_start(_108),_78),_152=<_78,_78<_158,
     \+holdsAtProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_78).

initiatedAt(lowSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(slow_motion_start(_108),_78),
     _124=<_78,
     _78<_130.

initiatedAt(changingSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(change_in_speed_start(_108),_78),
     _124=<_78,
     _78<_130.

initiatedAt(highSpeedNearCoast(_108)=true, _178, _78, _184) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_178=<_78,_78<_184,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_78),
     thresholds(hcNearCoastMax,_148),
     _114>_148.

initiatedAt(drifting(_108)=true, _176, _78, _182) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_176=<_78,_78<_182,
     thresholds(adriftAngThr,_130),
     _144 is abs(_116-_118),
     _144>_130.

initiatedAt(trawlSpeed(_108)=true, _202, _78, _208) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_202=<_78,_78<_208,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,fishing)=true,_78),
     thresholds(trawlspeedMin,_148),
     thresholds(trawlspeedMax,_154),
     _114>=_148,
     _114=<_154.

initiatedAt(trawlingMovement(_108)=true, _148, _78, _154) :-
     happensAtIE(change_in_heading(_108),_78),_148=<_78,_78<_154,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,fishing)=true,_78).

initiatedAt(tuggingSpeed(_108)=true, _178, _78, _184) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_178=<_78,_78<_184,
     thresholds(tuggingMin,_130),
     thresholds(tuggingMax,_136),
     _114>=_130,
     _114=<_136.

initiatedAt(sarSpeed(_108)=true, _154, _78, _160) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_154=<_78,_78<_160,
     thresholds(sarMinSpeed,_130),
     _114>_130.

initiatedAt(sarMovement(_108)=true, _124, _78, _130) :-
     happensAtIE(change_in_speed_start(_108),_78),
     _124=<_78,
     _78<_130.

initiatedAt(sarMovement(_108)=true, _124, _78, _130) :-
     happensAtIE(change_in_heading(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(withinArea(_108,_110)=true, _140, _78, _146) :-
     happensAtIE(leavesArea(_108,_116),_78),_140=<_78,_78<_146,
     areaType(_116,_110).

terminatedAt(withinArea(_108,_110)=true, _126, _78, _132) :-
     happensAtIE(gap_start(_108),_78),
     _126=<_78,
     _78<_132.

terminatedAt(gap(_108)=_84, _124, _78, _130) :-
     happensAtIE(gap_end(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(stopped(_108)=_84, _124, _78, _130) :-
     happensAtIE(stop_end(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(stopped(_108)=_84, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

terminatedAt(lowSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(slow_motion_end(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(lowSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(gap_start(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(changingSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(change_in_speed_end(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(changingSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(gap_start(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(highSpeedNearCoast(_108)=true, _154, _78, _160) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_154=<_78,_78<_160,
     thresholds(hcNearCoastMax,_130),
     _114=<_130.

terminatedAt(highSpeedNearCoast(_108)=true, _150, _78, _156) :-
     happensAtIE(leavesArea(_108,_114),_78),_150=<_78,_78<_156,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_78).

terminatedAt(movingSpeed(_108)=below, _160, _78, _166) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_160=<_78,_78<_166,
     thresholds(movingMin,_130),
     _114<_130.

terminatedAt(movingSpeed(_108)=below, _130, _78, _136) :-
     happensAtIE(gap_start(_108),_78),
     _130=<_78,
     _78<_136.

terminatedAt(drifting(_108)=true, _176, _78, _182) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_176=<_78,_78<_182,
     thresholds(adriftAngThr,_130),
     _144 is abs(_116-_118),
     _144=<_130.

terminatedAt(drifting(_108)=true, _124, _78, _130) :-
     happensAtIE(stop_start(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(trawlSpeed(_108)=true, _166, _78, _172) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_166=<_78,_78<_172,
     thresholds(trawlspeedMin,_130),
     thresholds(trawlspeedMax,_136),
     _114<_130.

terminatedAt(trawlSpeed(_108)=true, _166, _78, _172) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_166=<_78,_78<_172,
     thresholds(trawlspeedMin,_130),
     thresholds(trawlspeedMax,_136),
     _114>_136.

terminatedAt(trawlSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(gap_start(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(trawlingMovement(_108)=true, _150, _78, _156) :-
     happensAtIE(leavesArea(_108,_114),_78),_150=<_78,_78<_156,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,fishing)=true,_78).

terminatedAt(tuggingSpeed(_108)=true, _166, _78, _172) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_166=<_78,_78<_172,
     thresholds(tuggingMin,_130),
     thresholds(tuggingMax,_136),
     _114<_130.

terminatedAt(tuggingSpeed(_108)=true, _166, _78, _172) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_166=<_78,_78<_172,
     thresholds(tuggingMin,_130),
     thresholds(tuggingMax,_136),
     _114>_136.

terminatedAt(tuggingSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(gap_start(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(sarSpeed(_108)=true, _154, _78, _160) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_154=<_78,_78<_160,
     thresholds(sarMinSpeed,_130),
     _114=<_130.

terminatedAt(sarSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(gap_start(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(sarMovement(_108)=true, _124, _78, _130) :-
     happensAtIE(gap_start(_108),_78),
     _124=<_78,
     _78<_130.

holdsForSDFluent(movingSpeed(_108)=below,_78) :-
     happensAtIE(velocity(_108,_114,_116,_118),_124),
     vesselType(_108,_130),
     typeSpeed(_130,_136,_138,_140),
     _114<_136,
     \+happensAtIE(gap_start(_108),_124),
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=below,_78).

holdsForSDFluent(movingSpeed(_108)=normal,_78) :-
     happensAtIE(velocity(_108,_114,_116,_118),_124),
     vesselType(_108,_130),
     typeSpeed(_130,_136,_138,_140),
     _114>=_136,
     _114=<_138,
     \+happensAtIE(gap_start(_108),_124),
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=normal,_78).

holdsForSDFluent(movingSpeed(_108)=above,_78) :-
     happensAtIE(velocity(_108,_114,_116,_118),_124),
     vesselType(_108,_130),
     typeSpeed(_130,_136,_138,_140),
     _114>_138,
     \+happensAtIE(gap_start(_108),_124),
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=above,_78).

holdsForSDFluent(underWay(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=below,_124),
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=normal,_140),
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=above,_156),
     union_all([_124,_140,_156],_78).

holdsForSDFluent(trawling(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,withinArea(_108,fishing)=true,_126),
     holdsForProcessedSimpleFluent(_108,trawlSpeed(_108)=true,_142),
     holdsForProcessedSimpleFluent(_108,trawlingMovement(_108)=true,_158),
     intersect_all([_126,_142,_158],_182),
     thresholds(trawlingTime,_188),
     intDurGreater(_182,_188,_78).

holdsForSDFluent(anchoredOrMoored(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_124),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=nearPorts,_140),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,anchorage)=true,_158),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_176),
     relative_complement_all(_124,[_176],_190),
     intersect_all([_158,_190],_208),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_226),
     intersect_all([_140,_226],_244),
     union_all([_208,_244],_78).

holdsForSDFluent(rendezVous(_108,_110)=true,_78) :-
     holdsForProcessedIE(_108,proximity(_108,_110)=true,_128),
     \+oneIsTug(_108,_110),
     \+oneIsPilot(_108,_110),
     holdsForProcessedSimpleFluent(_108,lowSpeed(_108)=true,_164),
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_180),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_196),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_212),
     union_all([_164,_196],_230),
     union_all([_180,_212],_248),
     intersect_all([_230,_248,_128],_272),
     _272\=[],
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearPorts)=true,_296),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearPorts)=true,_314),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_332),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_350),
     relative_complement_all(_272,[_296,_314,_332,_350],_382),
     thresholds(rendezvousTime,_388),
     intDurGreater(_382,_388,_78).

holdsForSDFluent(tugging(_108,_110)=true,_78) :-
     holdsForProcessedIE(_108,proximity(_108,_110)=true,_128),
     oneIsTug(_108,_110),
     holdsForProcessedSimpleFluent(_108,tuggingSpeed(_108)=true,_150),
     holdsForProcessedSimpleFluent(_110,tuggingSpeed(_110)=true,_166),
     intersect_all([_128,_150,_166],_190),
     thresholds(tuggingTime,_196),
     intDurGreater(_190,_196,_78).

holdsForSDFluent(pilotOps(_108,_110)=true,_78) :-
     holdsForProcessedIE(_108,proximity(_108,_110)=true,_128),
     oneIsPilot(_108,_110),
     holdsForProcessedSimpleFluent(_108,lowSpeed(_108)=true,_150),
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_166),
     intersect_all([_128,_150,_166],_190),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_208),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_226),
     relative_complement_all(_190,[_208,_226],_246),
     _246\=[],
     _78=_246.

holdsForSDFluent(inSAR(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,sarSpeed(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,sarMovement(_108)=true,_140),
     intersect_all([_124,_140],_78).

holdsForSDFluent(loitering(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,lowSpeed(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_140),
     holdsForProcessedSDFluent(_108,anchoredOrMoored(_108)=true,_156),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_174),
     intersect_all([_124,_140],_192),
     relative_complement_all(_192,[_156,_174],_212),
     thresholds(loiteringTime,_218),
     intDurGreater(_212,_218,_78).

fi(trawlingMovement(_118)=true,trawlingMovement(_118)=false,_80):-
     thresholds(trawlingCrs,_80),
     grounding(trawlingMovement(_118)=true),
     grounding(trawlingMovement(_118)=false).

fi(sarMovement(_112)=true,sarMovement(_112)=false,1800):-
     grounding(sarMovement(_112)=true),
     grounding(sarMovement(_112)=false).

collectIntervals2(_82, proximity(_82,_84)=true) :-
     vpair(_82,_84).

needsGrounding(_296,_298,_300) :- 
     fail.

grounding(change_in_speed_start(_478)) :- 
     vessel(_478).

grounding(change_in_speed_end(_478)) :- 
     vessel(_478).

grounding(change_in_heading(_478)) :- 
     vessel(_478).

grounding(stop_start(_478)) :- 
     vessel(_478).

grounding(stop_end(_478)) :- 
     vessel(_478).

grounding(slow_motion_start(_478)) :- 
     vessel(_478).

grounding(slow_motion_end(_478)) :- 
     vessel(_478).

grounding(gap_start(_478)) :- 
     vessel(_478).

grounding(gap_end(_478)) :- 
     vessel(_478).

grounding(entersArea(_478,_480)) :- 
     vessel(_478),areaType(_480).

grounding(leavesArea(_478,_480)) :- 
     vessel(_478),areaType(_480).

grounding(coord(_478,_480,_482)) :- 
     vessel(_478).

grounding(velocity(_478,_480,_482,_484)) :- 
     vessel(_478).

grounding(proximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(gap(_484)=_480) :- 
     vessel(_484),portStatus(_480).

grounding(stopped(_484)=_480) :- 
     vessel(_484),portStatus(_480).

grounding(lowSpeed(_484)=true) :- 
     vessel(_484).

grounding(changingSpeed(_484)=true) :- 
     vessel(_484).

grounding(withinArea(_484,_486)=true) :- 
     vessel(_484),areaType(_486).

grounding(underWay(_484)=true) :- 
     vessel(_484).

grounding(sarSpeed(_484)=true) :- 
     vessel(_484),vesselType(_484,sar).

grounding(sarMovement(_484)=true) :- 
     vessel(_484),vesselType(_484,sar).

grounding(sarMovement(_484)=false) :- 
     vessel(_484),vesselType(_484,sar).

grounding(inSAR(_484)=true) :- 
     vessel(_484).

grounding(highSpeedNearCoast(_484)=true) :- 
     vessel(_484).

grounding(drifting(_484)=true) :- 
     vessel(_484).

grounding(anchoredOrMoored(_484)=true) :- 
     vessel(_484).

grounding(trawlSpeed(_484)=true) :- 
     vessel(_484),vesselType(_484,fishing).

grounding(movingSpeed(_484)=_480) :- 
     vessel(_484),movingStatus(_480).

grounding(pilotOps(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(tuggingSpeed(_484)=true) :- 
     vessel(_484).

grounding(tugging(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(rendezVous(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(trawlingMovement(_484)=true) :- 
     vessel(_484),vesselType(_484,fishing).

grounding(trawlingMovement(_484)=false) :- 
     vessel(_484),vesselType(_484,fishing).

grounding(trawling(_484)=true) :- 
     vessel(_484).

grounding(loitering(_484)=true) :- 
     vessel(_484).

p(trawlingMovement(_478)=true).

p(sarMovement(_478)=true).

inputEntity(entersArea(_132,_134)).
inputEntity(gap_start(_132)).
inputEntity(stop_start(_132)).
inputEntity(slow_motion_start(_132)).
inputEntity(change_in_speed_start(_132)).
inputEntity(velocity(_132,_134,_136,_138)).
inputEntity(change_in_heading(_132)).
inputEntity(leavesArea(_132,_134)).
inputEntity(gap_end(_132)).
inputEntity(stop_end(_132)).
inputEntity(slow_motion_end(_132)).
inputEntity(change_in_speed_end(_132)).
inputEntity(proximity(_138,_140)=true).
inputEntity(coord(_132,_134,_136)).

outputEntity(withinArea(_278,_280)=true).
outputEntity(gap(_278)=nearPorts).
outputEntity(gap(_278)=farFromPorts).
outputEntity(stopped(_278)=nearPorts).
outputEntity(stopped(_278)=farFromPorts).
outputEntity(lowSpeed(_278)=true).
outputEntity(changingSpeed(_278)=true).
outputEntity(highSpeedNearCoast(_278)=true).
outputEntity(drifting(_278)=true).
outputEntity(trawlSpeed(_278)=true).
outputEntity(trawlingMovement(_278)=true).
outputEntity(tuggingSpeed(_278)=true).
outputEntity(sarSpeed(_278)=true).
outputEntity(sarMovement(_278)=true).
outputEntity(movingSpeed(_278)=_274).
outputEntity(trawlingMovement(_278)=false).
outputEntity(sarMovement(_278)=false).
outputEntity(underWay(_278)=true).
outputEntity(trawling(_278)=true).
outputEntity(anchoredOrMoored(_278)=true).
outputEntity(rendezVous(_278,_280)=true).
outputEntity(tugging(_278,_280)=true).
outputEntity(pilotOps(_278,_280)=true).
outputEntity(inSAR(_278)=true).
outputEntity(loitering(_278)=true).

event(entersArea(_478,_480)).
event(gap_start(_478)).
event(stop_start(_478)).
event(slow_motion_start(_478)).
event(change_in_speed_start(_478)).
event(velocity(_478,_480,_482,_484)).
event(change_in_heading(_478)).
event(leavesArea(_478,_480)).
event(gap_end(_478)).
event(stop_end(_478)).
event(slow_motion_end(_478)).
event(change_in_speed_end(_478)).
event(coord(_478,_480,_482)).

simpleFluent(withinArea(_618,_620)=true).
simpleFluent(gap(_618)=nearPorts).
simpleFluent(gap(_618)=farFromPorts).
simpleFluent(stopped(_618)=nearPorts).
simpleFluent(stopped(_618)=farFromPorts).
simpleFluent(lowSpeed(_618)=true).
simpleFluent(changingSpeed(_618)=true).
simpleFluent(highSpeedNearCoast(_618)=true).
simpleFluent(drifting(_618)=true).
simpleFluent(trawlSpeed(_618)=true).
simpleFluent(trawlingMovement(_618)=true).
simpleFluent(tuggingSpeed(_618)=true).
simpleFluent(sarSpeed(_618)=true).
simpleFluent(sarMovement(_618)=true).
simpleFluent(movingSpeed(_618)=_614).
simpleFluent(trawlingMovement(_618)=false).
simpleFluent(sarMovement(_618)=false).


sDFluent(underWay(_832)=true).
sDFluent(trawling(_832)=true).
sDFluent(anchoredOrMoored(_832)=true).
sDFluent(rendezVous(_832,_834)=true).
sDFluent(tugging(_832,_834)=true).
sDFluent(pilotOps(_832,_834)=true).
sDFluent(inSAR(_832)=true).
sDFluent(loitering(_832)=true).
sDFluent(proximity(_832,_834)=true).

index(entersArea(_888,_942),_888).
index(gap_start(_888),_888).
index(stop_start(_888),_888).
index(slow_motion_start(_888),_888).
index(change_in_speed_start(_888),_888).
index(velocity(_888,_942,_944,_946),_888).
index(change_in_heading(_888),_888).
index(leavesArea(_888,_942),_888).
index(gap_end(_888),_888).
index(stop_end(_888),_888).
index(slow_motion_end(_888),_888).
index(change_in_speed_end(_888),_888).
index(coord(_888,_942,_944),_888).
index(withinArea(_888,_948)=true,_888).
index(gap(_888)=nearPorts,_888).
index(gap(_888)=farFromPorts,_888).
index(stopped(_888)=nearPorts,_888).
index(stopped(_888)=farFromPorts,_888).
index(lowSpeed(_888)=true,_888).
index(changingSpeed(_888)=true,_888).
index(highSpeedNearCoast(_888)=true,_888).
index(drifting(_888)=true,_888).
index(trawlSpeed(_888)=true,_888).
index(trawlingMovement(_888)=true,_888).
index(tuggingSpeed(_888)=true,_888).
index(sarSpeed(_888)=true,_888).
index(sarMovement(_888)=true,_888).
index(movingSpeed(_888)=_942,_888).
index(trawlingMovement(_888)=false,_888).
index(sarMovement(_888)=false,_888).
index(underWay(_888)=true,_888).
index(trawling(_888)=true,_888).
index(anchoredOrMoored(_888)=true,_888).
index(rendezVous(_888,_948)=true,_888).
index(tugging(_888,_948)=true,_888).
index(pilotOps(_888,_948)=true,_888).
index(inSAR(_888)=true,_888).
index(loitering(_888)=true,_888).
index(proximity(_888,_948)=true,_888).

cyclic(movingSpeed(_1296)=below).

cachingOrder2(_1544, movingSpeed(_1544)=_1540) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1544),movingStatus(_1540).

cachingOrder2(_1520, withinArea(_1520,_1522)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1520),areaType(_1522).

cachingOrder2(_1498, lowSpeed(_1498)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1498).

cachingOrder2(_1476, changingSpeed(_1476)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1476).

cachingOrder2(_1454, drifting(_1454)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1454).

cachingOrder2(_1432, tuggingSpeed(_1432)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1432).

cachingOrder2(_1410, sarSpeed(_1410)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1410),vesselType(_1410,sar).

cachingOrder2(_1372, sarMovement(_1372)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1372),vesselType(_1372,sar).

cachingOrder2(_1372, sarMovement(_1372)=false) :- % level in dependency graph: 1, processing order in component: 2
     vessel(_1372),vesselType(_1372,sar).

cachingOrder2(_2490, gap(_2490)=farFromPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2490),portStatus(farFromPorts).

cachingOrder2(_2506, gap(_2506)=nearPorts) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_2506),portStatus(nearPorts).

cachingOrder2(_2468, highSpeedNearCoast(_2468)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2468).

cachingOrder2(_2446, trawlSpeed(_2446)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2446),vesselType(_2446,fishing).

cachingOrder2(_2408, trawlingMovement(_2408)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2408),vesselType(_2408,fishing).

cachingOrder2(_2408, trawlingMovement(_2408)=false) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_2408),vesselType(_2408,fishing).

cachingOrder2(_2386, underWay(_2386)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2386).

cachingOrder2(_2362, tugging(_2362,_2364)=true) :- % level in dependency graph: 2, processing order in component: 1
     vpair(_2362,_2364).

cachingOrder2(_2338, pilotOps(_2338,_2340)=true) :- % level in dependency graph: 2, processing order in component: 1
     vpair(_2338,_2340).

cachingOrder2(_2316, inSAR(_2316)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2316).

cachingOrder2(_3390, stopped(_3390)=farFromPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_3390),portStatus(farFromPorts).

cachingOrder2(_3406, stopped(_3406)=nearPorts) :- % level in dependency graph: 3, processing order in component: 2
     vessel(_3406),portStatus(nearPorts).

cachingOrder2(_3368, trawling(_3368)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_3368).

cachingOrder2(_3730, anchoredOrMoored(_3730)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3730).

cachingOrder2(_3706, rendezVous(_3706,_3708)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3706,_3708).

cachingOrder2(_3958, loitering(_3958)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_3958).

collectGrounds([entersArea(_678,_692), gap_start(_678), stop_start(_678), slow_motion_start(_678), change_in_speed_start(_678), velocity(_678,_692,_694,_696), change_in_heading(_678), leavesArea(_678,_692), gap_end(_678), stop_end(_678), slow_motion_end(_678), change_in_speed_end(_678), coord(_678,_692,_694)],vessel(_678)).

collectGrounds([proximity(_666,_668)=true],vpair(_666,_668)).

dgrounded(withinArea(_1670,_1672)=true, vessel(_1670)).
dgrounded(gap(_1628)=nearPorts, vessel(_1628)).
dgrounded(gap(_1586)=farFromPorts, vessel(_1586)).
dgrounded(stopped(_1544)=nearPorts, vessel(_1544)).
dgrounded(stopped(_1502)=farFromPorts, vessel(_1502)).
dgrounded(lowSpeed(_1470)=true, vessel(_1470)).
dgrounded(changingSpeed(_1438)=true, vessel(_1438)).
dgrounded(highSpeedNearCoast(_1406)=true, vessel(_1406)).
dgrounded(drifting(_1374)=true, vessel(_1374)).
dgrounded(trawlSpeed(_1330)=true, vessel(_1330)).
dgrounded(trawlingMovement(_1286)=true, vessel(_1286)).
dgrounded(tuggingSpeed(_1254)=true, vessel(_1254)).
dgrounded(sarSpeed(_1210)=true, vessel(_1210)).
dgrounded(sarMovement(_1166)=true, vessel(_1166)).
dgrounded(movingSpeed(_1124)=_1120, vessel(_1124)).
dgrounded(trawlingMovement(_1080)=false, vessel(_1080)).
dgrounded(sarMovement(_1036)=false, vessel(_1036)).
dgrounded(underWay(_1004)=true, vessel(_1004)).
dgrounded(trawling(_972)=true, vessel(_972)).
dgrounded(anchoredOrMoored(_940)=true, vessel(_940)).
dgrounded(rendezVous(_904,_906)=true, vpair(_904,_906)).
dgrounded(tugging(_868,_870)=true, vpair(_868,_870)).
dgrounded(pilotOps(_832,_834)=true, vpair(_832,_834)).
dgrounded(inSAR(_800)=true, vessel(_800)).
dgrounded(loitering(_768)=true, vessel(_768)).
