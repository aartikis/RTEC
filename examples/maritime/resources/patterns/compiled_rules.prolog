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

needsGrounding(_270,_272,_274) :- 
     fail.

grounding(change_in_speed_start(_436)) :- 
     vessel(_436).

grounding(change_in_speed_end(_436)) :- 
     vessel(_436).

grounding(change_in_heading(_436)) :- 
     vessel(_436).

grounding(stop_start(_436)) :- 
     vessel(_436).

grounding(stop_end(_436)) :- 
     vessel(_436).

grounding(slow_motion_start(_436)) :- 
     vessel(_436).

grounding(slow_motion_end(_436)) :- 
     vessel(_436).

grounding(gap_start(_436)) :- 
     vessel(_436).

grounding(gap_end(_436)) :- 
     vessel(_436).

grounding(entersArea(_436,_438)) :- 
     vessel(_436),areaType(_438).

grounding(leavesArea(_436,_438)) :- 
     vessel(_436),areaType(_438).

grounding(coord(_436,_438,_440)) :- 
     vessel(_436).

grounding(velocity(_436,_438,_440,_442)) :- 
     vessel(_436).

grounding(proximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(gap(_442)=_438) :- 
     vessel(_442),portStatus(_438).

grounding(stopped(_442)=_438) :- 
     vessel(_442),portStatus(_438).

grounding(lowSpeed(_442)=true) :- 
     vessel(_442).

grounding(changingSpeed(_442)=true) :- 
     vessel(_442).

grounding(withinArea(_442,_444)=true) :- 
     vessel(_442),areaType(_444).

grounding(underWay(_442)=true) :- 
     vessel(_442).

grounding(sarSpeed(_442)=true) :- 
     vessel(_442),vesselType(_442,sar).

grounding(sarMovement(_442)=true) :- 
     vessel(_442),vesselType(_442,sar).

grounding(sarMovement(_442)=false) :- 
     vessel(_442),vesselType(_442,sar).

grounding(inSAR(_442)=true) :- 
     vessel(_442).

grounding(highSpeedNearCoast(_442)=true) :- 
     vessel(_442).

grounding(drifting(_442)=true) :- 
     vessel(_442).

grounding(anchoredOrMoored(_442)=true) :- 
     vessel(_442).

grounding(trawlSpeed(_442)=true) :- 
     vessel(_442),vesselType(_442,fishing).

grounding(movingSpeed(_442)=_438) :- 
     vessel(_442),movingStatus(_438).

grounding(pilotOps(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(tuggingSpeed(_442)=true) :- 
     vessel(_442).

grounding(tugging(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(rendezVous(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(trawlingMovement(_442)=true) :- 
     vessel(_442),vesselType(_442,fishing).

grounding(trawlingMovement(_442)=false) :- 
     vessel(_442),vesselType(_442,fishing).

grounding(trawling(_442)=true) :- 
     vessel(_442).

grounding(loitering(_442)=true) :- 
     vessel(_442).

inputEntity(entersArea(_140,_142)).
inputEntity(gap_start(_140)).
inputEntity(stop_start(_140)).
inputEntity(slow_motion_start(_140)).
inputEntity(change_in_speed_start(_140)).
inputEntity(velocity(_140,_142,_144,_146)).
inputEntity(change_in_heading(_140)).
inputEntity(leavesArea(_140,_142)).
inputEntity(gap_end(_140)).
inputEntity(stop_end(_140)).
inputEntity(slow_motion_end(_140)).
inputEntity(change_in_speed_end(_140)).
inputEntity(proximity(_146,_148)=true).
inputEntity(coord(_140,_142,_144)).

outputEntity(withinArea(_292,_294)=true).
outputEntity(gap(_292)=nearPorts).
outputEntity(gap(_292)=farFromPorts).
outputEntity(stopped(_292)=nearPorts).
outputEntity(stopped(_292)=farFromPorts).
outputEntity(lowSpeed(_292)=true).
outputEntity(changingSpeed(_292)=true).
outputEntity(highSpeedNearCoast(_292)=true).
outputEntity(movingSpeed(_292)=below).
outputEntity(movingSpeed(_292)=normal).
outputEntity(movingSpeed(_292)=above).
outputEntity(drifting(_292)=true).
outputEntity(tuggingSpeed(_292)=true).
outputEntity(trawlSpeed(_292)=true).
outputEntity(trawlingMovement(_292)=true).
outputEntity(sarSpeed(_292)=true).
outputEntity(sarMovement(_292)=true).
outputEntity(trawlingMovement(_292)=false).
outputEntity(sarMovement(_292)=false).
outputEntity(underWay(_292)=true).
outputEntity(anchoredOrMoored(_292)=true).
outputEntity(tugging(_292,_294)=true).
outputEntity(rendezVous(_292,_294)=true).
outputEntity(trawling(_292)=true).
outputEntity(inSAR(_292)=true).
outputEntity(loitering(_292)=true).
outputEntity(pilotOps(_292,_294)=true).

event(entersArea(_510,_512)).
event(gap_start(_510)).
event(stop_start(_510)).
event(slow_motion_start(_510)).
event(change_in_speed_start(_510)).
event(velocity(_510,_512,_514,_516)).
event(change_in_heading(_510)).
event(leavesArea(_510,_512)).
event(gap_end(_510)).
event(stop_end(_510)).
event(slow_motion_end(_510)).
event(change_in_speed_end(_510)).
event(coord(_510,_512,_514)).

simpleFluent(withinArea(_656,_658)=true).
simpleFluent(gap(_656)=nearPorts).
simpleFluent(gap(_656)=farFromPorts).
simpleFluent(stopped(_656)=nearPorts).
simpleFluent(stopped(_656)=farFromPorts).
simpleFluent(lowSpeed(_656)=true).
simpleFluent(changingSpeed(_656)=true).
simpleFluent(highSpeedNearCoast(_656)=true).
simpleFluent(movingSpeed(_656)=below).
simpleFluent(movingSpeed(_656)=normal).
simpleFluent(movingSpeed(_656)=above).
simpleFluent(drifting(_656)=true).
simpleFluent(tuggingSpeed(_656)=true).
simpleFluent(trawlSpeed(_656)=true).
simpleFluent(trawlingMovement(_656)=true).
simpleFluent(sarSpeed(_656)=true).
simpleFluent(sarMovement(_656)=true).
simpleFluent(trawlingMovement(_656)=false).
simpleFluent(sarMovement(_656)=false).

sDFluent(underWay(_832)=true).
sDFluent(anchoredOrMoored(_832)=true).
sDFluent(tugging(_832,_834)=true).
sDFluent(rendezVous(_832,_834)=true).
sDFluent(trawling(_832)=true).
sDFluent(inSAR(_832)=true).
sDFluent(loitering(_832)=true).
sDFluent(pilotOps(_832,_834)=true).
sDFluent(proximity(_832,_834)=true).

index(entersArea(_888,_948),_888).
index(gap_start(_888),_888).
index(stop_start(_888),_888).
index(slow_motion_start(_888),_888).
index(change_in_speed_start(_888),_888).
index(velocity(_888,_948,_950,_952),_888).
index(change_in_heading(_888),_888).
index(leavesArea(_888,_948),_888).
index(gap_end(_888),_888).
index(stop_end(_888),_888).
index(slow_motion_end(_888),_888).
index(change_in_speed_end(_888),_888).
index(coord(_888,_948,_950),_888).
index(withinArea(_888,_954)=true,_888).
index(gap(_888)=nearPorts,_888).
index(gap(_888)=farFromPorts,_888).
index(stopped(_888)=nearPorts,_888).
index(stopped(_888)=farFromPorts,_888).
index(lowSpeed(_888)=true,_888).
index(changingSpeed(_888)=true,_888).
index(highSpeedNearCoast(_888)=true,_888).
index(movingSpeed(_888)=below,_888).
index(movingSpeed(_888)=normal,_888).
index(movingSpeed(_888)=above,_888).
index(drifting(_888)=true,_888).
index(tuggingSpeed(_888)=true,_888).
index(trawlSpeed(_888)=true,_888).
index(trawlingMovement(_888)=true,_888).
index(sarSpeed(_888)=true,_888).
index(sarMovement(_888)=true,_888).
index(trawlingMovement(_888)=false,_888).
index(sarMovement(_888)=false,_888).
index(underWay(_888)=true,_888).
index(anchoredOrMoored(_888)=true,_888).
index(tugging(_888,_954)=true,_888).
index(rendezVous(_888,_954)=true,_888).
index(trawling(_888)=true,_888).
index(inSAR(_888)=true,_888).
index(loitering(_888)=true,_888).
index(pilotOps(_888,_954)=true,_888).
index(proximity(_888,_954)=true,_888).


cachingOrder2(_1380, withinArea(_1380,_1382)=true) :- % level: 1
     vessel(_1380),areaType(_1382).

cachingOrder2(_1712, gap(_1712)=nearPorts) :- % level: 2
     vessel(_1712),portStatus(nearPorts).

cachingOrder2(_1696, gap(_1696)=farFromPorts) :- % level: 2
     vessel(_1696),portStatus(farFromPorts).

cachingOrder2(_1680, highSpeedNearCoast(_1680)=true) :- % level: 2
     vessel(_1680).

cachingOrder2(_1664, trawlingMovement(_1664)=true) :- % level: 2
     vessel(_1664),vesselType(_1664,fishing).

cachingOrder2(_2766, stopped(_2766)=nearPorts) :- % level: 3
     vessel(_2766),portStatus(nearPorts).

cachingOrder2(_2750, stopped(_2750)=farFromPorts) :- % level: 3
     vessel(_2750),portStatus(farFromPorts).

cachingOrder2(_2734, lowSpeed(_2734)=true) :- % level: 3
     vessel(_2734).

cachingOrder2(_2718, changingSpeed(_2718)=true) :- % level: 3
     vessel(_2718).

cachingOrder2(_2702, movingSpeed(_2702)=below) :- % level: 3
     vessel(_2702),movingStatus(below).

cachingOrder2(_2686, movingSpeed(_2686)=normal) :- % level: 3
     vessel(_2686),movingStatus(normal).

cachingOrder2(_2670, movingSpeed(_2670)=above) :- % level: 3
     vessel(_2670),movingStatus(above).

cachingOrder2(_2654, tuggingSpeed(_2654)=true) :- % level: 3
     vessel(_2654).

cachingOrder2(_2638, trawlSpeed(_2638)=true) :- % level: 3
     vessel(_2638),vesselType(_2638,fishing).

cachingOrder2(_2622, sarSpeed(_2622)=true) :- % level: 3
     vessel(_2622),vesselType(_2622,sar).

cachingOrder2(_5038, sarMovement(_5038)=true) :- % level: 4
     vessel(_5038),vesselType(_5038,sar).

cachingOrder2(_5022, underWay(_5022)=true) :- % level: 4
     vessel(_5022).

cachingOrder2(_5006, anchoredOrMoored(_5006)=true) :- % level: 4
     vessel(_5006).

cachingOrder2(_4988, tugging(_4988,_4990)=true) :- % level: 4
     vpair(_4988,_4990).

cachingOrder2(_4970, rendezVous(_4970,_4972)=true) :- % level: 4
     vpair(_4970,_4972).

cachingOrder2(_4954, trawling(_4954)=true) :- % level: 4
     vessel(_4954).

cachingOrder2(_4936, pilotOps(_4936,_4938)=true) :- % level: 4
     vpair(_4936,_4938).

cachingOrder2(_6632, drifting(_6632)=true) :- % level: 5
     vessel(_6632).

cachingOrder2(_6616, sarMovement(_6616)=false) :- % level: 5
     vessel(_6616),vesselType(_6616,sar).

cachingOrder2(_6600, inSAR(_6600)=true) :- % level: 5
     vessel(_6600).

cachingOrder2(_6584, loitering(_6584)=true) :- % level: 5
     vessel(_6584).

collectGrounds([entersArea(_692,_706), gap_start(_692), stop_start(_692), slow_motion_start(_692), change_in_speed_start(_692), velocity(_692,_706,_708,_710), change_in_heading(_692), leavesArea(_692,_706), gap_end(_692), stop_end(_692), slow_motion_end(_692), change_in_speed_end(_692), coord(_692,_706,_708)],vessel(_692)).

collectGrounds([proximity(_680,_682)=true],vpair(_680,_682)).

dgrounded(withinArea(_1774,_1776)=true, vessel(_1774)).
dgrounded(gap(_1732)=nearPorts, vessel(_1732)).
dgrounded(gap(_1690)=farFromPorts, vessel(_1690)).
dgrounded(stopped(_1648)=nearPorts, vessel(_1648)).
dgrounded(stopped(_1606)=farFromPorts, vessel(_1606)).
dgrounded(lowSpeed(_1574)=true, vessel(_1574)).
dgrounded(changingSpeed(_1542)=true, vessel(_1542)).
dgrounded(highSpeedNearCoast(_1510)=true, vessel(_1510)).
dgrounded(movingSpeed(_1468)=below, vessel(_1468)).
dgrounded(movingSpeed(_1426)=normal, vessel(_1426)).
dgrounded(movingSpeed(_1384)=above, vessel(_1384)).
dgrounded(drifting(_1352)=true, vessel(_1352)).
dgrounded(tuggingSpeed(_1320)=true, vessel(_1320)).
dgrounded(trawlSpeed(_1276)=true, vessel(_1276)).
dgrounded(trawlingMovement(_1232)=true, vessel(_1232)).
dgrounded(sarSpeed(_1188)=true, vessel(_1188)).
dgrounded(sarMovement(_1144)=true, vessel(_1144)).
dgrounded(trawlingMovement(_1100)=false, vessel(_1100)).
dgrounded(sarMovement(_1056)=false, vessel(_1056)).
dgrounded(underWay(_1024)=true, vessel(_1024)).
dgrounded(anchoredOrMoored(_992)=true, vessel(_992)).
dgrounded(tugging(_956,_958)=true, vpair(_956,_958)).
dgrounded(rendezVous(_920,_922)=true, vpair(_920,_922)).
dgrounded(trawling(_888)=true, vessel(_888)).
dgrounded(inSAR(_856)=true, vessel(_856)).
dgrounded(loitering(_824)=true, vessel(_824)).
dgrounded(pilotOps(_788,_790)=true, vpair(_788,_790)).
