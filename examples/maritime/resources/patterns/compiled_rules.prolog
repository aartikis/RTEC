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
     union_all([_162,_178],_196),
     thresholds(aOrMTime,_202),
     intDurGreater(_196,_202,_80).

holdsForSDFluent(tugging(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,proximity(_110,_112)=true,_130),
     oneIsTug(_110,_112),
     \+oneIsPilot(_110,_112),
     \+twoAreTugs(_110,_112),
     holdsForProcessedSimpleFluent(_110,tuggingSpeed(_110)=true,_172),
     holdsForProcessedSimpleFluent(_112,tuggingSpeed(_112)=true,_188),
     intersect_all([_130,_172,_188],_212),
     thresholds(tuggingTime,_218),
     intDurGreater(_212,_218,_80).

holdsForSDFluent(rendezVous(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,proximity(_110,_112)=true,_130),
     \+oneIsTug(_110,_112),
     \+oneIsPilot(_110,_112),
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_166),
     holdsForProcessedSimpleFluent(_112,lowSpeed(_112)=true,_182),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_198),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_214),
     union_all([_166,_198],_232),
     union_all([_182,_214],_250),
     intersect_all([_232,_250,_130],_274),
     _274\=[],
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearPorts)=true,_298),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_316),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_334),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_352),
     relative_complement_all(_274,[_298,_316,_334,_352],_384),
     thresholds(rendezvousTime,_390),
     intDurGreater(_384,_390,_80).

holdsForSDFluent(trawling(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,trawlSpeed(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,trawlingMovement(_110)=true,_142),
     intersect_all([_126,_142],_160),
     thresholds(trawlingTime,_166),
     intDurGreater(_160,_166,_80).

holdsForSDFluent(inSAR(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,sarSpeed(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,sarMovement(_110)=true,_142),
     intersect_all([_126,_142],_160),
     intDurGreater(_160,3600,_80).

holdsForSDFluent(loitering(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_142),
     union_all([_126,_142],_160),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_178),
     holdsForProcessedSDFluent(_110,anchoredOrMoored(_110)=true,_194),
     relative_complement_all(_160,[_178,_194],_214),
     thresholds(loiteringTime,_220),
     intDurGreater(_214,_220,_80).

holdsForSDFluent(pilotOps(_110,_112)=true,_80) :-
     holdsForProcessedIE(_110,proximity(_110,_112)=true,_130),
     oneIsPilot(_110,_112),
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_152),
     holdsForProcessedSimpleFluent(_112,lowSpeed(_112)=true,_168),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_184),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_200),
     union_all([_152,_184],_218),
     union_all([_168,_200],_236),
     intersect_all([_218,_236,_130],_260),
     _260\=[],
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_284),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_302),
     relative_complement_all(_260,[_284,_302],_80).

maxDurationUE(trawlingMovement(_120)=true,trawlingMovement(_120)=false,_82):-
     thresholds(trawlingCrs,_82),
     grounding(trawlingMovement(_120)=true),
     grounding(trawlingMovement(_120)=false).

maxDurationUE(sarMovement(_114)=true,sarMovement(_114)=false,1800):-
     grounding(sarMovement(_114)=true),
     grounding(sarMovement(_114)=false).

collectIntervals2(_84, proximity(_84,_86)=true) :-
     vpair(_84,_86).

needsGrounding(_298,_300,_302) :- 
     fail.

grounding(change_in_speed_start(_464)) :- 
     vessel(_464).

grounding(change_in_speed_end(_464)) :- 
     vessel(_464).

grounding(change_in_heading(_464)) :- 
     vessel(_464).

grounding(stop_start(_464)) :- 
     vessel(_464).

grounding(stop_end(_464)) :- 
     vessel(_464).

grounding(slow_motion_start(_464)) :- 
     vessel(_464).

grounding(slow_motion_end(_464)) :- 
     vessel(_464).

grounding(gap_start(_464)) :- 
     vessel(_464).

grounding(gap_end(_464)) :- 
     vessel(_464).

grounding(entersArea(_464,_466)) :- 
     vessel(_464),areaType(_466).

grounding(leavesArea(_464,_466)) :- 
     vessel(_464),areaType(_466).

grounding(coord(_464,_466,_468)) :- 
     vessel(_464).

grounding(velocity(_464,_466,_468,_470)) :- 
     vessel(_464).

grounding(proximity(_470,_472)=true) :- 
     vpair(_470,_472).

grounding(gap(_470)=_466) :- 
     vessel(_470),portStatus(_466).

grounding(stopped(_470)=_466) :- 
     vessel(_470),portStatus(_466).

grounding(lowSpeed(_470)=true) :- 
     vessel(_470).

grounding(changingSpeed(_470)=true) :- 
     vessel(_470).

grounding(withinArea(_470,_472)=true) :- 
     vessel(_470),areaType(_472).

grounding(underWay(_470)=true) :- 
     vessel(_470).

grounding(sarSpeed(_470)=true) :- 
     vessel(_470),vesselType(_470,sar).

grounding(sarMovement(_470)=true) :- 
     vessel(_470),vesselType(_470,sar).

grounding(sarMovement(_470)=false) :- 
     vessel(_470),vesselType(_470,sar).

grounding(inSAR(_470)=true) :- 
     vessel(_470).

grounding(highSpeedNearCoast(_470)=true) :- 
     vessel(_470).

grounding(drifting(_470)=true) :- 
     vessel(_470).

grounding(anchoredOrMoored(_470)=true) :- 
     vessel(_470).

grounding(trawlSpeed(_470)=true) :- 
     vessel(_470),vesselType(_470,fishing).

grounding(movingSpeed(_470)=_466) :- 
     vessel(_470),movingStatus(_466).

grounding(pilotOps(_470,_472)=true) :- 
     vpair(_470,_472).

grounding(tuggingSpeed(_470)=true) :- 
     vessel(_470).

grounding(tugging(_470,_472)=true) :- 
     vpair(_470,_472).

grounding(rendezVous(_470,_472)=true) :- 
     vpair(_470,_472).

grounding(trawlingMovement(_470)=true) :- 
     vessel(_470),vesselType(_470,fishing).

grounding(trawlingMovement(_470)=false) :- 
     vessel(_470),vesselType(_470,fishing).

grounding(trawling(_470)=true) :- 
     vessel(_470).

grounding(loitering(_470)=true) :- 
     vessel(_470).

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


cachingOrder2(_1332, withinArea(_1332,_1334)=true) :- % level: 1
     vessel(_1332),areaType(_1334).

cachingOrder2(_1490, gap(_1490)=nearPorts) :- % level: 2
     vessel(_1490),portStatus(nearPorts).

cachingOrder2(_1474, gap(_1474)=farFromPorts) :- % level: 2
     vessel(_1474),portStatus(farFromPorts).

cachingOrder2(_1458, highSpeedNearCoast(_1458)=true) :- % level: 2
     vessel(_1458).

cachingOrder2(_1442, trawlingMovement(_1442)=true) :- % level: 2
     vessel(_1442),vesselType(_1442,fishing).

cachingOrder2(_1858, stopped(_1858)=nearPorts) :- % level: 3
     vessel(_1858),portStatus(nearPorts).

cachingOrder2(_1842, stopped(_1842)=farFromPorts) :- % level: 3
     vessel(_1842),portStatus(farFromPorts).

cachingOrder2(_1826, lowSpeed(_1826)=true) :- % level: 3
     vessel(_1826).

cachingOrder2(_1810, changingSpeed(_1810)=true) :- % level: 3
     vessel(_1810).

cachingOrder2(_1794, movingSpeed(_1794)=below) :- % level: 3
     vessel(_1794),movingStatus(below).

cachingOrder2(_1778, movingSpeed(_1778)=normal) :- % level: 3
     vessel(_1778),movingStatus(normal).

cachingOrder2(_1762, movingSpeed(_1762)=above) :- % level: 3
     vessel(_1762),movingStatus(above).

cachingOrder2(_1746, tuggingSpeed(_1746)=true) :- % level: 3
     vessel(_1746).

cachingOrder2(_1730, trawlSpeed(_1730)=true) :- % level: 3
     vessel(_1730),vesselType(_1730,fishing).

cachingOrder2(_1714, sarSpeed(_1714)=true) :- % level: 3
     vessel(_1714),vesselType(_1714,sar).

cachingOrder2(_2418, sarMovement(_2418)=true) :- % level: 4
     vessel(_2418),vesselType(_2418,sar).

cachingOrder2(_2402, underWay(_2402)=true) :- % level: 4
     vessel(_2402).

cachingOrder2(_2386, anchoredOrMoored(_2386)=true) :- % level: 4
     vessel(_2386).

cachingOrder2(_2368, tugging(_2368,_2370)=true) :- % level: 4
     vpair(_2368,_2370).

cachingOrder2(_2350, rendezVous(_2350,_2352)=true) :- % level: 4
     vpair(_2350,_2352).

cachingOrder2(_2334, trawling(_2334)=true) :- % level: 4
     vessel(_2334).

cachingOrder2(_2316, pilotOps(_2316,_2318)=true) :- % level: 4
     vpair(_2316,_2318).

cachingOrder2(_2778, drifting(_2778)=true) :- % level: 5
     vessel(_2778).

cachingOrder2(_2762, sarMovement(_2762)=false) :- % level: 5
     vessel(_2762),vesselType(_2762,sar).

cachingOrder2(_2746, inSAR(_2746)=true) :- % level: 5
     vessel(_2746).

cachingOrder2(_2730, loitering(_2730)=true) :- % level: 5
     vessel(_2730).

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
