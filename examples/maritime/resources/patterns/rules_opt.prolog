:- dynamic vessel/1, vpair/2.

initiatedAt(withinArea(_110,_112)=true, _142, _80, _148) :-
     happensAtIE(entersArea(_110,_118),_80),_142=<_80,_80<_148,
     areaType(_118,_112).

initiatedAt(gap(_110)=nearPorts, _150, _80, _156) :-
     happensAtIE(gap_start(_110),_80),_150=<_80,_80<_156,
     holdsAtProcessedSimpleFluent(_110,withinArea(_110,nearPorts)=true,_80).

initiatedAt(gap(_110)=farFromPorts, _154, _80, _160) :-
     happensAtIE(gap_start(_110),_80),_154=<_80,_80<_160,
     \+holdsAtProcessedSimpleFluent(_110,withinArea(_110,nearPorts)=true,_80).

initiatedAt(stopped(_110)=nearPorts, _150, _80, _156) :-
     happensAtIE(stop_start(_110),_80),_150=<_80,_80<_156,
     holdsAtProcessedSimpleFluent(_110,withinArea(_110,nearPorts)=true,_80).

initiatedAt(stopped(_110)=farFromPorts, _154, _80, _160) :-
     happensAtIE(stop_start(_110),_80),_154=<_80,_80<_160,
     \+holdsAtProcessedSimpleFluent(_110,withinArea(_110,nearPorts)=true,_80).

initiatedAt(lowSpeed(_110)=true, _126, _80, _132) :-
     happensAtIE(slow_motion_start(_110),_80),
     _126=<_80,
     _80<_132.

initiatedAt(changingSpeed(_110)=true, _126, _80, _132) :-
     happensAtIE(change_in_speed_start(_110),_80),
     _126=<_80,
     _80<_132.

initiatedAt(highSpeedNearCoast(_110)=true, _186, _80, _192) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_186=<_80,_80<_192,
     thresholds(hcNearCoastMax,_132),
     \+inRange(_116,0,_132),
     holdsAtProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_80).

initiatedAt(movingSpeed(_110)=below, _186, _80, _192) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_186=<_80,_80<_192,
     vesselType(_110,_132),
     typeSpeed(_132,_138,_140,_142),
     thresholds(movingMin,_148),
     inRange(_116,_148,_138).

initiatedAt(movingSpeed(_110)=normal, _174, _80, _180) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_174=<_80,_80<_180,
     vesselType(_110,_132),
     typeSpeed(_132,_138,_140,_142),
     inRange(_116,_138,_140).

initiatedAt(movingSpeed(_110)=above, _174, _80, _180) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_174=<_80,_80<_180,
     vesselType(_110,_132),
     typeSpeed(_132,_138,_140,_142),
     inRange(_116,_140,inf).

initiatedAt(drifting(_110)=true, _210, _80, _216) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_210=<_80,_80<_216,
     _120=\=511.0,
     absoluteAngleDiff(_118,_120,_146),
     thresholds(adriftAngThr,_152),
     _146>_152,
     holdsAtProcessedSDFluent(_110,underWay(_110)=true,_80).

initiatedAt(tuggingSpeed(_110)=true, _170, _80, _176) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_170=<_80,_80<_176,
     thresholds(tuggingMin,_132),
     thresholds(tuggingMax,_138),
     inRange(_116,_132,_138).

initiatedAt(trawlSpeed(_110)=true, _194, _80, _200) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_194=<_80,_80<_200,
     thresholds(trawlspeedMin,_132),
     thresholds(trawlspeedMax,_138),
     inRange(_116,_132,_138),
     holdsAtProcessedSimpleFluent(_110,withinArea(_110,fishing)=true,_80).

initiatedAt(trawlingMovement(_110)=true, _150, _80, _156) :-
     happensAtIE(change_in_heading(_110),_80),_150=<_80,_80<_156,
     holdsAtProcessedSimpleFluent(_110,withinArea(_110,fishing)=true,_80).

initiatedAt(sarSpeed(_110)=true, _158, _80, _164) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_158=<_80,_80<_164,
     thresholds(sarMinSpeed,_132),
     inRange(_116,_132,inf).

initiatedAt(sarMovement(_110)=true, _126, _80, _132) :-
     happensAtIE(change_in_heading(_110),_80),
     _126=<_80,
     _80<_132.

initiatedAt(sarMovement(_110)=true, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(changingSpeed(_110)=true),_80),
     _136=<_80,
     _80<_142.

terminatedAt(withinArea(_110,_112)=true, _142, _80, _148) :-
     happensAtIE(leavesArea(_110,_118),_80),_142=<_80,_80<_148,
     areaType(_118,_112).

terminatedAt(withinArea(_110,_112)=true, _128, _80, _134) :-
     happensAtIE(gap_start(_110),_80),
     _128=<_80,
     _80<_134.

terminatedAt(gap(_110)=_86, _126, _80, _132) :-
     happensAtIE(gap_end(_110),_80),
     _126=<_80,
     _80<_132.

terminatedAt(stopped(_110)=_86, _126, _80, _132) :-
     happensAtIE(stop_end(_110),_80),
     _126=<_80,
     _80<_132.

terminatedAt(stopped(_110)=_86, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

terminatedAt(lowSpeed(_110)=true, _126, _80, _132) :-
     happensAtIE(slow_motion_end(_110),_80),
     _126=<_80,
     _80<_132.

terminatedAt(lowSpeed(_110)=true, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

terminatedAt(changingSpeed(_110)=true, _126, _80, _132) :-
     happensAtIE(change_in_speed_end(_110),_80),
     _126=<_80,
     _80<_132.

terminatedAt(changingSpeed(_110)=true, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

terminatedAt(highSpeedNearCoast(_110)=true, _158, _80, _164) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_158=<_80,_80<_164,
     thresholds(hcNearCoastMax,_132),
     inRange(_116,0,_132).

terminatedAt(highSpeedNearCoast(_110)=true, _138, _80, _144) :-
     happensAtProcessedSimpleFluent(_110,end(withinArea(_110,nearCoast)=true),_80),
     _138=<_80,
     _80<_144.

terminatedAt(movingSpeed(_110)=_86, _162, _80, _168) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_162=<_80,_80<_168,
     thresholds(movingMin,_132),
     \+inRange(_116,_132,inf).

terminatedAt(movingSpeed(_110)=_86, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

terminatedAt(drifting(_110)=true, _170, _80, _176) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_170=<_80,_80<_176,
     absoluteAngleDiff(_118,_120,_134),
     thresholds(adriftAngThr,_140),
     _134=<_140.

terminatedAt(drifting(_110)=true, _138, _80, _144) :-
     happensAtIE(velocity(_110,_116,_118,511.0),_80),
     _138=<_80,
     _80<_144.

terminatedAt(drifting(_110)=true, _136, _80, _142) :-
     happensAtProcessedSDFluent(_110,end(underWay(_110)=true),_80),
     _136=<_80,
     _80<_142.

terminatedAt(tuggingSpeed(_110)=true, _174, _80, _180) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_174=<_80,_80<_180,
     thresholds(tuggingMin,_132),
     thresholds(tuggingMax,_138),
     \+inRange(_116,_132,_138).

terminatedAt(tuggingSpeed(_110)=true, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

terminatedAt(trawlSpeed(_110)=true, _174, _80, _180) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_174=<_80,_80<_180,
     thresholds(trawlspeedMin,_132),
     thresholds(trawlspeedMax,_138),
     \+inRange(_116,_132,_138).

terminatedAt(trawlSpeed(_110)=true, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

terminatedAt(trawlSpeed(_110)=true, _138, _80, _144) :-
     happensAtProcessedSimpleFluent(_110,end(withinArea(_110,fishing)=true),_80),
     _138=<_80,
     _80<_144.

terminatedAt(trawlingMovement(_110)=true, _138, _80, _144) :-
     happensAtProcessedSimpleFluent(_110,end(withinArea(_110,fishing)=true),_80),
     _138=<_80,
     _80<_144.

terminatedAt(sarSpeed(_110)=true, _158, _80, _164) :-
     happensAtIE(velocity(_110,_116,_118,_120),_80),_158=<_80,_80<_164,
     thresholds(sarMinSpeed,_132),
     inRange(_116,0,_132).

terminatedAt(sarSpeed(_110)=true, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

terminatedAt(sarMovement(_110)=true, _136, _80, _142) :-
     happensAtProcessedSimpleFluent(_110,start(gap(_110)=_120),_80),
     _136=<_80,
     _80<_142.

holdsForSDFluent(underWay(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,movingSpeed(_110)=below,_126),
     holdsForProcessedSimpleFluent(_110,movingSpeed(_110)=normal,_142),
     holdsForProcessedSimpleFluent(_110,movingSpeed(_110)=above,_158),
     union_all([_126,_142,_158],_80).

holdsForSDFluent(anchoredOrMoored(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_126),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,anchorage)=true,_144),
     intersect_all([_126,_144],_162),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=nearPorts,_178),
     union_all([_162,_178],_80).

holdsForSDFluent(tugging(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,proximity(_110,_112)=true,_130),
     holdsForProcessedSimpleFluent(_110,tuggingSpeed(_110)=true,_146),
     holdsForProcessedSimpleFluent(_112,tuggingSpeed(_112)=true,_162),
     intersect_all([_130,_146,_162],_80).

holdsForSDFluent(rendezVous(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,proximity(_110,_112)=true,_130),
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_146),
     holdsForProcessedSimpleFluent(_112,lowSpeed(_112)=true,_162),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_178),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_194),
     union_all([_146,_178],_212),
     union_all([_162,_194],_230),
     intersect_all([_212,_230,_130],_254),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearPorts)=true,_272),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_290),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_308),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_326),
     relative_complement_all(_254,[_272,_290,_308,_326],_80).

holdsForSDFluent(trawling(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,trawlSpeed(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,trawlingMovement(_110)=true,_142),
     intersect_all([_126,_142],_80).

holdsForSDFluent(inSAR(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,sarSpeed(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,sarMovement(_110)=true,_142),
     intersect_all([_126,_142],_80).

holdsForSDFluent(loitering(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_142),
     union_all([_126,_142],_160),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_178),
     holdsForProcessedSDFluent(_110,anchoredOrMoored(_110)=true,_194),
     relative_complement_all(_160,[_178,_194],_80).

holdsForSDFluent(pilotOps(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,proximity(_110,_112)=true,_130),
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_146),
     holdsForProcessedSimpleFluent(_112,lowSpeed(_112)=true,_162),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_178),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_194),
     union_all([_146,_178],_212),
     union_all([_162,_194],_230),
     intersect_all([_212,_230,_130],_254),
     _254\=[],
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_278),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_296),
     relative_complement_all(_254,[_278,_296],_80).

fi(trawlingMovement(_120)=true,trawlingMovement(_120)=false,_82):-
     thresholds(trawlingCrs,_82),
     grounding(trawlingMovement(_120)=true),
     grounding(trawlingMovement(_120)=false).

fi(sarMovement(_114)=true,sarMovement(_114)=false,1800):-
     grounding(sarMovement(_114)=true),
     grounding(sarMovement(_114)=false).

collectIntervals2(_84, proximity(_84,_86)=true) :-
     vpair(_84,_86).

needsGrounding(_298,_300,_302) :- 
     fail.

grounding(change_in_speed_start(_480)) :- 
     vessel(_480).

grounding(change_in_speed_end(_480)) :- 
     vessel(_480).

grounding(change_in_heading(_480)) :- 
     vessel(_480).

grounding(stop_start(_480)) :- 
     vessel(_480).

grounding(stop_end(_480)) :- 
     vessel(_480).

grounding(slow_motion_start(_480)) :- 
     vessel(_480).

grounding(slow_motion_end(_480)) :- 
     vessel(_480).

grounding(gap_start(_480)) :- 
     vessel(_480).

grounding(gap_end(_480)) :- 
     vessel(_480).

grounding(entersArea(_480,_482)) :- 
     vessel(_480),areaType(_482).

grounding(leavesArea(_480,_482)) :- 
     vessel(_480),areaType(_482).

grounding(coord(_480,_482,_484)) :- 
     vessel(_480).

grounding(velocity(_480,_482,_484,_486)) :- 
     vessel(_480).

grounding(proximity(_486,_488)=true) :- 
     vpair(_486,_488).

grounding(gap(_486)=_482) :- 
     vessel(_486),portStatus(_482).

grounding(stopped(_486)=_482) :- 
     vessel(_486),portStatus(_482).

grounding(lowSpeed(_486)=true) :- 
     vessel(_486).

grounding(changingSpeed(_486)=true) :- 
     vessel(_486).

grounding(withinArea(_486,_488)=true) :- 
     vessel(_486),areaType(_488).

grounding(underWay(_486)=true) :- 
     vessel(_486).

grounding(sarSpeed(_486)=true) :- 
     vessel(_486),vesselType(_486,sar).

grounding(sarMovement(_486)=true) :- 
     vessel(_486),vesselType(_486,sar).

grounding(sarMovement(_486)=false) :- 
     vessel(_486),vesselType(_486,sar).

grounding(inSAR(_486)=true) :- 
     vessel(_486).

grounding(highSpeedNearCoast(_486)=true) :- 
     vessel(_486).

grounding(drifting(_486)=true) :- 
     vessel(_486).

grounding(anchoredOrMoored(_486)=true) :- 
     vessel(_486).

grounding(trawlSpeed(_486)=true) :- 
     vessel(_486),vesselType(_486,fishing).

grounding(movingSpeed(_486)=_482) :- 
     vessel(_486),movingStatus(_482).

grounding(pilotOps(_486,_488)=true) :- 
     vpair(_486,_488).

grounding(tuggingSpeed(_486)=true) :- 
     vessel(_486).

grounding(tugging(_486,_488)=true) :- 
     vpair(_486,_488).

grounding(rendezVous(_486,_488)=true) :- 
     vpair(_486,_488).

grounding(trawlingMovement(_486)=true) :- 
     vessel(_486),vesselType(_486,fishing).

grounding(trawlingMovement(_486)=false) :- 
     vessel(_486),vesselType(_486,fishing).

grounding(trawling(_486)=true) :- 
     vessel(_486).

grounding(loitering(_486)=true) :- 
     vessel(_486).

p(trawlingMovement(_480)=true).

p(sarMovement(_480)=true).

inputEntity(entersArea(_134,_136)).
inputEntity(gap_start(_134)).
inputEntity(stop_start(_134)).
inputEntity(slow_motion_start(_134)).
inputEntity(change_in_speed_start(_134)).
inputEntity(velocity(_134,_136,_138,_140)).
inputEntity(change_in_heading(_134)).
inputEntity(leavesArea(_134,_136)).
inputEntity(gap_end(_134)).
inputEntity(stop_end(_134)).
inputEntity(slow_motion_end(_134)).
inputEntity(change_in_speed_end(_134)).
inputEntity(proximity(_140,_142)=true).
inputEntity(coord(_134,_136,_138)).

outputEntity(withinArea(_280,_282)=true).
outputEntity(gap(_280)=nearPorts).
outputEntity(gap(_280)=farFromPorts).
outputEntity(stopped(_280)=nearPorts).
outputEntity(stopped(_280)=farFromPorts).
outputEntity(lowSpeed(_280)=true).
outputEntity(changingSpeed(_280)=true).
outputEntity(highSpeedNearCoast(_280)=true).
outputEntity(movingSpeed(_280)=below).
outputEntity(movingSpeed(_280)=normal).
outputEntity(movingSpeed(_280)=above).
outputEntity(drifting(_280)=true).
outputEntity(tuggingSpeed(_280)=true).
outputEntity(trawlSpeed(_280)=true).
outputEntity(trawlingMovement(_280)=true).
outputEntity(sarSpeed(_280)=true).
outputEntity(sarMovement(_280)=true).
outputEntity(trawlingMovement(_280)=false).
outputEntity(sarMovement(_280)=false).
outputEntity(underWay(_280)=true).
outputEntity(anchoredOrMoored(_280)=true).
outputEntity(tugging(_280,_282)=true).
outputEntity(rendezVous(_280,_282)=true).
outputEntity(trawling(_280)=true).
outputEntity(inSAR(_280)=true).
outputEntity(loitering(_280)=true).
outputEntity(pilotOps(_280,_282)=true).

event(entersArea(_492,_494)).
event(gap_start(_492)).
event(stop_start(_492)).
event(slow_motion_start(_492)).
event(change_in_speed_start(_492)).
event(velocity(_492,_494,_496,_498)).
event(change_in_heading(_492)).
event(leavesArea(_492,_494)).
event(gap_end(_492)).
event(stop_end(_492)).
event(slow_motion_end(_492)).
event(change_in_speed_end(_492)).
event(coord(_492,_494,_496)).

simpleFluent(withinArea(_632,_634)=true).
simpleFluent(gap(_632)=nearPorts).
simpleFluent(gap(_632)=farFromPorts).
simpleFluent(stopped(_632)=nearPorts).
simpleFluent(stopped(_632)=farFromPorts).
simpleFluent(lowSpeed(_632)=true).
simpleFluent(changingSpeed(_632)=true).
simpleFluent(highSpeedNearCoast(_632)=true).
simpleFluent(movingSpeed(_632)=below).
simpleFluent(movingSpeed(_632)=normal).
simpleFluent(movingSpeed(_632)=above).
simpleFluent(drifting(_632)=true).
simpleFluent(tuggingSpeed(_632)=true).
simpleFluent(trawlSpeed(_632)=true).
simpleFluent(trawlingMovement(_632)=true).
simpleFluent(sarSpeed(_632)=true).
simpleFluent(sarMovement(_632)=true).
simpleFluent(trawlingMovement(_632)=false).
simpleFluent(sarMovement(_632)=false).

sDFluent(underWay(_802)=true).
sDFluent(anchoredOrMoored(_802)=true).
sDFluent(tugging(_802,_804)=true).
sDFluent(rendezVous(_802,_804)=true).
sDFluent(trawling(_802)=true).
sDFluent(inSAR(_802)=true).
sDFluent(loitering(_802)=true).
sDFluent(pilotOps(_802,_804)=true).
sDFluent(proximity(_802,_804)=true).

index(entersArea(_858,_912),_858).
index(gap_start(_858),_858).
index(stop_start(_858),_858).
index(slow_motion_start(_858),_858).
index(change_in_speed_start(_858),_858).
index(velocity(_858,_912,_914,_916),_858).
index(change_in_heading(_858),_858).
index(leavesArea(_858,_912),_858).
index(gap_end(_858),_858).
index(stop_end(_858),_858).
index(slow_motion_end(_858),_858).
index(change_in_speed_end(_858),_858).
index(coord(_858,_912,_914),_858).
index(withinArea(_858,_918)=true,_858).
index(gap(_858)=nearPorts,_858).
index(gap(_858)=farFromPorts,_858).
index(stopped(_858)=nearPorts,_858).
index(stopped(_858)=farFromPorts,_858).
index(lowSpeed(_858)=true,_858).
index(changingSpeed(_858)=true,_858).
index(highSpeedNearCoast(_858)=true,_858).
index(movingSpeed(_858)=below,_858).
index(movingSpeed(_858)=normal,_858).
index(movingSpeed(_858)=above,_858).
index(drifting(_858)=true,_858).
index(tuggingSpeed(_858)=true,_858).
index(trawlSpeed(_858)=true,_858).
index(trawlingMovement(_858)=true,_858).
index(sarSpeed(_858)=true,_858).
index(sarMovement(_858)=true,_858).
index(trawlingMovement(_858)=false,_858).
index(sarMovement(_858)=false,_858).
index(underWay(_858)=true,_858).
index(anchoredOrMoored(_858)=true,_858).
index(tugging(_858,_918)=true,_858).
index(rendezVous(_858,_918)=true,_858).
index(trawling(_858)=true,_858).
index(inSAR(_858)=true,_858).
index(loitering(_858)=true,_858).
index(pilotOps(_858,_918)=true,_858).
index(proximity(_858,_918)=true,_858).


cachingOrder2(_1338, withinArea(_1338,_1340)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1338),areaType(_1340).

cachingOrder2(_1588, gap(_1588)=nearPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1588),portStatus(nearPorts).

cachingOrder2(_1566, gap(_1566)=farFromPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1566),portStatus(farFromPorts).

cachingOrder2(_1544, highSpeedNearCoast(_1544)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1544).

cachingOrder2(_1506, trawlingMovement(_1506)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1506),vesselType(_1506,fishing).

cachingOrder2(_1506, trawlingMovement(_1506)=false) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_1506),vesselType(_1506,fishing).

cachingOrder2(_2250, stopped(_2250)=nearPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2250),portStatus(nearPorts).

cachingOrder2(_2228, stopped(_2228)=farFromPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2228),portStatus(farFromPorts).

cachingOrder2(_2206, lowSpeed(_2206)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2206).

cachingOrder2(_2184, changingSpeed(_2184)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2184).

cachingOrder2(_2162, movingSpeed(_2162)=below) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2162),movingStatus(below).

cachingOrder2(_2140, movingSpeed(_2140)=normal) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2140),movingStatus(normal).

cachingOrder2(_2118, movingSpeed(_2118)=above) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2118),movingStatus(above).

cachingOrder2(_2096, tuggingSpeed(_2096)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2096).

cachingOrder2(_2074, trawlSpeed(_2074)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2074),vesselType(_2074,fishing).

cachingOrder2(_2052, sarSpeed(_2052)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2052),vesselType(_2052,sar).

cachingOrder2(_3232, sarMovement(_3232)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3232),vesselType(_3232,sar).

cachingOrder2(_3232, sarMovement(_3232)=false) :- % level in dependency graph: 4, processing order in component: 2
     vessel(_3232),vesselType(_3232,sar).

cachingOrder2(_3210, underWay(_3210)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3210).

cachingOrder2(_3188, anchoredOrMoored(_3188)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3188).

cachingOrder2(_3164, tugging(_3164,_3166)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3164,_3166).

cachingOrder2(_3140, rendezVous(_3140,_3142)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3140,_3142).

cachingOrder2(_3118, trawling(_3118)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3118).

cachingOrder2(_3094, pilotOps(_3094,_3096)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3094,_3096).

cachingOrder2(_4000, drifting(_4000)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4000).

cachingOrder2(_3978, inSAR(_3978)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_3978).

cachingOrder2(_3956, loitering(_3956)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_3956).

collectGrounds([entersArea(_680,_694), gap_start(_680), stop_start(_680), slow_motion_start(_680), change_in_speed_start(_680), velocity(_680,_694,_696,_698), change_in_heading(_680), leavesArea(_680,_694), gap_end(_680), stop_end(_680), slow_motion_end(_680), change_in_speed_end(_680), coord(_680,_694,_696)],vessel(_680)).

collectGrounds([proximity(_668,_670)=true],vpair(_668,_670)).

dgrounded(withinArea(_1756,_1758)=true, vessel(_1756)).
dgrounded(gap(_1714)=nearPorts, vessel(_1714)).
dgrounded(gap(_1672)=farFromPorts, vessel(_1672)).
dgrounded(stopped(_1630)=nearPorts, vessel(_1630)).
dgrounded(stopped(_1588)=farFromPorts, vessel(_1588)).
dgrounded(lowSpeed(_1556)=true, vessel(_1556)).
dgrounded(changingSpeed(_1524)=true, vessel(_1524)).
dgrounded(highSpeedNearCoast(_1492)=true, vessel(_1492)).
dgrounded(movingSpeed(_1450)=below, vessel(_1450)).
dgrounded(movingSpeed(_1408)=normal, vessel(_1408)).
dgrounded(movingSpeed(_1366)=above, vessel(_1366)).
dgrounded(drifting(_1334)=true, vessel(_1334)).
dgrounded(tuggingSpeed(_1302)=true, vessel(_1302)).
dgrounded(trawlSpeed(_1258)=true, vessel(_1258)).
dgrounded(trawlingMovement(_1214)=true, vessel(_1214)).
dgrounded(sarSpeed(_1170)=true, vessel(_1170)).
dgrounded(sarMovement(_1126)=true, vessel(_1126)).
dgrounded(trawlingMovement(_1082)=false, vessel(_1082)).
dgrounded(sarMovement(_1038)=false, vessel(_1038)).
dgrounded(underWay(_1006)=true, vessel(_1006)).
dgrounded(anchoredOrMoored(_974)=true, vessel(_974)).
dgrounded(tugging(_938,_940)=true, vpair(_938,_940)).
dgrounded(rendezVous(_902,_904)=true, vpair(_902,_904)).
dgrounded(trawling(_870)=true, vessel(_870)).
dgrounded(inSAR(_838)=true, vessel(_838)).
dgrounded(loitering(_806)=true, vessel(_806)).
dgrounded(pilotOps(_770,_772)=true, vpair(_770,_772)).
