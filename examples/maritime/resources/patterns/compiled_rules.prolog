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

holdsForSDFluent(disappearedInArea(_110,_112)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,withinArea(_110,_112)=true,_130),
     holdsForProcessedSimpleFluent(_110,gap(_110)=farFromPorts,_146),
     meets(disappearedInArea(_110,_112)=true,0,_130,_146,union,true,_80).

holdsForSDFluent(stoppedWithinArea(_110,_112)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,withinArea(_110,_112)=true,_130),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_146),
     during(stoppedWithinArea(_110,_112)=true,0,_146,_130,source,true,_80).

holdsForSDFluent(stoppedMeetsGap(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_126),
     holdsForProcessedSimpleFluent(_110,gap(_110)=farFromPorts,_142),
     meets(stoppedMeetsGap(_110)=true,0,_126,_142,union,true,_80).

holdsForSDFluent(highSpeedNCBeforeDrifting(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,highSpeedNearCoast(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,drifting(_110)=true,_142),
     before(highSpeedNCBeforeDrifting(_110)=true,0,_126,_142,union,true,_80).

holdsForSDFluent(dangerNearCoast(_110)=true,_80) :-
     holdsForProcessedSimpleFluent(_110,highSpeedNearCoast(_110)=true,_126),
     holdsForProcessedSimpleFluent(_110,drifting(_110)=true,_142),
     overlaps(dangerNearCoast(_110)=true,0,_126,_142,union,true,_80).

holdsForSDFluent(gainingSpeed(_110)=true,_80) :-
     holdsFor(_110,movingSpeed(_110)=below,_128),
     holdsFor(_110,movingSpeed(_110)=normal,_146),
     meets(gainingSpeed(_110)=true,0,_128,_146,union,true,_80).

holdsForSDFluent(speedChangeAbove(_110)=true,_80) :-
     holdsFor(_110,changingSpeed(_110)=true,_128),
     holdsFor(_110,movingSpeed(_110)=above,_146),
     starts(speedChangeAbove(_110)=true,0,_128,_146,relative_complement_inverse,true,_80).

holdsForSDFluent(collisionDanger(_110,_112)=true,_80) :-
     holdsFor(_110,proximity(_110,_112)=true,_132),
     holdsFor(_110,movingSpeed(_110)=above,_150),
     holdsFor(_112,movingSpeed(_112)=above,_168),
     union_all([_150,_168],_186),
     overlaps(collisionDanger(_110,_112)=true,0,_186,_132,intersection,true,_80).

holdsForSDFluent(suspiciousRendezVous(_110,_112)=true,_80) :-
     holdsFor(_110,proximity(_110,_112)=true,_132),
     holdsFor(_110,gap(_110)=_138,_150),
     holdsFor(_112,gap(_112)=_156,_168),
     union_all([_150,_168],_186),
     during(suspiciousRendezVous(_110,_112)=true,0,_186,_132,lhs,true,_80).

holdsForSDFluent(anchoredFarFromPorts(_110)=true,_80) :-
     holdsFor(_110,anchoredOrMoored(_110)=true,_128),
     holdsFor(_110,stopped(_110)=farFromPorts,_146),
     holdsFor(_110,withinArea(_110,anchorage)=true,_166),
     intersect_all([_146,_166],_184),
     equal(anchoredFarFromPorts(_110)=true,0,_128,_184,lhs,true,_80).

holdsForSDFluent(anchoredNearPorts(_110)=true,_80) :-
     holdsFor(_110,anchoredOrMoored(_110)=true,_128),
     holdsFor(_110,stopped(_110)=nearPorts,_146),
     equal(anchoredNearPorts(_110)=true,0,_128,_146,lhs,true,_80).

holdsForSDFluent(tuggingStartsProximity(_110,_112)=true,_80) :-
     holdsFor(_110,tugging(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     starts(tuggingStartsProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(tuggingFinishesProximity(_110,_112)=true,_80) :-
     holdsFor(_110,tugging(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     finishes(tuggingFinishesProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(tuggingEqualProximity(_110,_112)=true,_80) :-
     holdsFor(_110,tugging(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     equal(tuggingEqualProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(rendezVousStartsProximity(_110,_112)=true,_80) :-
     holdsFor(_110,rendezVous(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     starts(rendezVousStartsProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(rendezVousFinishesProximity(_110,_112)=true,_80) :-
     holdsFor(_110,rendezVous(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     finishes(rendezVousFinishesProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(rendezVousEqualProximity(_110,_112)=true,_80) :-
     holdsFor(_110,rendezVous(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     equal(rendezVousEqualProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(pilotOpsStartsProximity(_110,_112)=true,_80) :-
     holdsFor(_110,pilotOps(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     starts(pilotOpsStartsProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(pilotOpsFinishesProximity(_110,_112)=true,_80) :-
     holdsFor(_110,pilotOps(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     finishes(pilotOpsFinishesProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(pilotOpsEqualProximity(_110,_112)=true,_80) :-
     holdsFor(_110,pilotOps(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     equal(pilotOpsEqualProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(movingSpeedStartsUnderway(_110)=_86,_80) :-
     holdsFor(_110,underWay(_110)=true,_128),
     holdsFor(_110,movingSpeed(_110)=_86,_146),
     starts(movingSpeedStartsUnderway(_110)=_86,0,_146,_128,lhs,true,_80).

holdsForSDFluent(movingSpeedFinishesUnderway(_110)=_86,_80) :-
     holdsFor(_110,underWay(_110)=true,_128),
     holdsFor(_110,movingSpeed(_110)=_86,_146),
     finishes(movingSpeedFinishesUnderway(_110)=_86,0,_146,_128,lhs,true,_80).

holdsForSDFluent(movingSpeedEqualUnderway(_110)=_86,_80) :-
     holdsFor(_110,underWay(_110)=true,_128),
     holdsFor(_110,movingSpeed(_110)=_86,_146),
     equal(movingSpeedEqualUnderway(_110)=_86,0,_146,_128,lhs,true,_80).

holdsForSDFluent(pilotOpsEqualProximity(_110,_112)=true,_80) :-
     holdsFor(_110,pilotOps(_110,_112)=true,_132),
     holdsFor(_110,proximity(_110,_112)=true,_152),
     equal(pilotOpsEqualProximity(_110,_112)=true,0,_132,_152,lhs,true,_80).

holdsForSDFluent(driftingWhileTugging(_110,_112)=true,_80) :-
     holdsFor(_110,tugging(_110,_112)=true,_132),
     holdsFor(_110,drifting(_110)=true,_150),
     holdsFor(_112,drifting(_112)=true,_168),
     union_all([_150,_168],_186),
     during(driftingWhileTugging(_110,_112)=true,0,_132,_186,union,true,_80).

holdsForSDFluent(fishingTripInArea(_110)=true,_80) :-
     holdsFor(_110,withinArea(_110,nearPorts)=true,_130),
     holdsFor(_110,withinArea(_110,fishing)=true,_150),
     before(fishingTripInArea(_110)=true,0,_130,_150,union,true,_160),
     before(fishingTripInArea(_110)=true,1,_160,_130,union,true,_80).

holdsForSDFluent(fishingTripTrawling(_110)=true,_80) :-
     holdsFor(_110,withinArea(_110,nearPorts)=true,_130),
     holdsFor(_110,trawling(_110)=true,_148),
     before(fishingTripTrawling(_110)=true,0,_130,_148,union,true,_158),
     before(fishingTripTrawling(_110)=true,1,_158,_130,union,true,_80).

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

grounding(disappearedInArea(_442,_444)=true) :- 
     vessel(_442),areaType(_444).

grounding(stoppedWithinArea(_442,_444)=true) :- 
     vessel(_442),areaType(_444).

grounding(stoppedMeetsGap(_442)=true) :- 
     vessel(_442).

grounding(highSpeedNCBeforeDrifting(_442)=true) :- 
     vessel(_442).

grounding(dangerNearCoast(_442)=true) :- 
     vessel(_442).

grounding(gainingSpeed(_442)=true) :- 
     vessel(_442).

grounding(speedChangeAbove(_442)=true) :- 
     vessel(_442).

grounding(anchoredFarFromPorts(_442)=true) :- 
     vessel(_442).

grounding(anchoredNearPorts(_442)=true) :- 
     vessel(_442).

grounding(tuggingStartsProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(tuggingFinishesProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(tuggingEqualProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(rendezVousStartsProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(rendezVousFinishesProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(rendezVousEqualProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(pilotOpsStartsProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(pilotOpsFinishesProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(pilotOpsEqualProximity(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(movingSpeedStartsUnderway(_442)=below) :- 
     vessel(_442).

grounding(movingSpeedFinishesUnderway(_442)=below) :- 
     vessel(_442).

grounding(movingSpeedEqualUnderway(_442)=below) :- 
     vessel(_442).

grounding(collisionDanger(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(suspiciousRendezVous(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(driftingWhileTugging(_442,_444)=true) :- 
     vpair(_442,_444).

grounding(fishingTripInArea(_442)=true) :- 
     vessel(_442).

grounding(fishingTripTrawling(_442)=true) :- 
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
outputEntity(disappearedInArea(_292,_294)=true).
outputEntity(stoppedWithinArea(_292,_294)=true).
outputEntity(stoppedMeetsGap(_292)=true).
outputEntity(highSpeedNCBeforeDrifting(_292)=true).
outputEntity(dangerNearCoast(_292)=true).
outputEntity(gainingSpeed(_292)=true).
outputEntity(speedChangeAbove(_292)=true).
outputEntity(collisionDanger(_292,_294)=true).
outputEntity(suspiciousRendezVous(_292,_294)=true).
outputEntity(anchoredFarFromPorts(_292)=true).
outputEntity(anchoredNearPorts(_292)=true).
outputEntity(tuggingStartsProximity(_292,_294)=true).
outputEntity(tuggingFinishesProximity(_292,_294)=true).
outputEntity(tuggingEqualProximity(_292,_294)=true).
outputEntity(rendezVousStartsProximity(_292,_294)=true).
outputEntity(rendezVousFinishesProximity(_292,_294)=true).
outputEntity(rendezVousEqualProximity(_292,_294)=true).
outputEntity(pilotOpsStartsProximity(_292,_294)=true).
outputEntity(pilotOpsFinishesProximity(_292,_294)=true).
outputEntity(pilotOpsEqualProximity(_292,_294)=true).
outputEntity(movingSpeedStartsUnderway(_292)=below).
outputEntity(movingSpeedFinishesUnderway(_292)=below).
outputEntity(movingSpeedEqualUnderway(_292)=below).
outputEntity(driftingWhileTugging(_292,_294)=true).
outputEntity(fishingTripInArea(_292)=true).
outputEntity(fishingTripTrawling(_292)=true).

event(entersArea(_666,_668)).
event(gap_start(_666)).
event(stop_start(_666)).
event(slow_motion_start(_666)).
event(change_in_speed_start(_666)).
event(velocity(_666,_668,_670,_672)).
event(change_in_heading(_666)).
event(leavesArea(_666,_668)).
event(gap_end(_666)).
event(stop_end(_666)).
event(slow_motion_end(_666)).
event(change_in_speed_end(_666)).
event(coord(_666,_668,_670)).

simpleFluent(withinArea(_812,_814)=true).
simpleFluent(gap(_812)=nearPorts).
simpleFluent(gap(_812)=farFromPorts).
simpleFluent(stopped(_812)=nearPorts).
simpleFluent(stopped(_812)=farFromPorts).
simpleFluent(lowSpeed(_812)=true).
simpleFluent(changingSpeed(_812)=true).
simpleFluent(highSpeedNearCoast(_812)=true).
simpleFluent(movingSpeed(_812)=below).
simpleFluent(movingSpeed(_812)=normal).
simpleFluent(movingSpeed(_812)=above).
simpleFluent(drifting(_812)=true).
simpleFluent(tuggingSpeed(_812)=true).
simpleFluent(trawlSpeed(_812)=true).
simpleFluent(trawlingMovement(_812)=true).
simpleFluent(sarSpeed(_812)=true).
simpleFluent(sarMovement(_812)=true).
simpleFluent(trawlingMovement(_812)=false).
simpleFluent(sarMovement(_812)=false).

sDFluent(underWay(_988)=true).
sDFluent(anchoredOrMoored(_988)=true).
sDFluent(tugging(_988,_990)=true).
sDFluent(rendezVous(_988,_990)=true).
sDFluent(trawling(_988)=true).
sDFluent(inSAR(_988)=true).
sDFluent(loitering(_988)=true).
sDFluent(pilotOps(_988,_990)=true).
sDFluent(disappearedInArea(_988,_990)=true).
sDFluent(stoppedWithinArea(_988,_990)=true).
sDFluent(stoppedMeetsGap(_988)=true).
sDFluent(highSpeedNCBeforeDrifting(_988)=true).
sDFluent(dangerNearCoast(_988)=true).
sDFluent(gainingSpeed(_988)=true).
sDFluent(speedChangeAbove(_988)=true).
sDFluent(collisionDanger(_988,_990)=true).
sDFluent(suspiciousRendezVous(_988,_990)=true).
sDFluent(anchoredFarFromPorts(_988)=true).
sDFluent(anchoredNearPorts(_988)=true).
sDFluent(tuggingStartsProximity(_988,_990)=true).
sDFluent(tuggingFinishesProximity(_988,_990)=true).
sDFluent(tuggingEqualProximity(_988,_990)=true).
sDFluent(rendezVousStartsProximity(_988,_990)=true).
sDFluent(rendezVousFinishesProximity(_988,_990)=true).
sDFluent(rendezVousEqualProximity(_988,_990)=true).
sDFluent(pilotOpsStartsProximity(_988,_990)=true).
sDFluent(pilotOpsFinishesProximity(_988,_990)=true).
sDFluent(pilotOpsEqualProximity(_988,_990)=true).
sDFluent(movingSpeedStartsUnderway(_988)=below).
sDFluent(movingSpeedFinishesUnderway(_988)=below).
sDFluent(movingSpeedEqualUnderway(_988)=below).
sDFluent(driftingWhileTugging(_988,_990)=true).
sDFluent(fishingTripInArea(_988)=true).
sDFluent(fishingTripTrawling(_988)=true).
sDFluent(proximity(_988,_990)=true).

index(entersArea(_1200,_1260),_1200).
index(gap_start(_1200),_1200).
index(stop_start(_1200),_1200).
index(slow_motion_start(_1200),_1200).
index(change_in_speed_start(_1200),_1200).
index(velocity(_1200,_1260,_1262,_1264),_1200).
index(change_in_heading(_1200),_1200).
index(leavesArea(_1200,_1260),_1200).
index(gap_end(_1200),_1200).
index(stop_end(_1200),_1200).
index(slow_motion_end(_1200),_1200).
index(change_in_speed_end(_1200),_1200).
index(coord(_1200,_1260,_1262),_1200).
index(withinArea(_1200,_1266)=true,_1200).
index(gap(_1200)=nearPorts,_1200).
index(gap(_1200)=farFromPorts,_1200).
index(stopped(_1200)=nearPorts,_1200).
index(stopped(_1200)=farFromPorts,_1200).
index(lowSpeed(_1200)=true,_1200).
index(changingSpeed(_1200)=true,_1200).
index(highSpeedNearCoast(_1200)=true,_1200).
index(movingSpeed(_1200)=below,_1200).
index(movingSpeed(_1200)=normal,_1200).
index(movingSpeed(_1200)=above,_1200).
index(drifting(_1200)=true,_1200).
index(tuggingSpeed(_1200)=true,_1200).
index(trawlSpeed(_1200)=true,_1200).
index(trawlingMovement(_1200)=true,_1200).
index(sarSpeed(_1200)=true,_1200).
index(sarMovement(_1200)=true,_1200).
index(trawlingMovement(_1200)=false,_1200).
index(sarMovement(_1200)=false,_1200).
index(underWay(_1200)=true,_1200).
index(anchoredOrMoored(_1200)=true,_1200).
index(tugging(_1200,_1266)=true,_1200).
index(rendezVous(_1200,_1266)=true,_1200).
index(trawling(_1200)=true,_1200).
index(inSAR(_1200)=true,_1200).
index(loitering(_1200)=true,_1200).
index(pilotOps(_1200,_1266)=true,_1200).
index(disappearedInArea(_1200,_1266)=true,_1200).
index(stoppedWithinArea(_1200,_1266)=true,_1200).
index(stoppedMeetsGap(_1200)=true,_1200).
index(highSpeedNCBeforeDrifting(_1200)=true,_1200).
index(dangerNearCoast(_1200)=true,_1200).
index(gainingSpeed(_1200)=true,_1200).
index(speedChangeAbove(_1200)=true,_1200).
index(collisionDanger(_1200,_1266)=true,_1200).
index(suspiciousRendezVous(_1200,_1266)=true,_1200).
index(anchoredFarFromPorts(_1200)=true,_1200).
index(anchoredNearPorts(_1200)=true,_1200).
index(tuggingStartsProximity(_1200,_1266)=true,_1200).
index(tuggingFinishesProximity(_1200,_1266)=true,_1200).
index(tuggingEqualProximity(_1200,_1266)=true,_1200).
index(rendezVousStartsProximity(_1200,_1266)=true,_1200).
index(rendezVousFinishesProximity(_1200,_1266)=true,_1200).
index(rendezVousEqualProximity(_1200,_1266)=true,_1200).
index(pilotOpsStartsProximity(_1200,_1266)=true,_1200).
index(pilotOpsFinishesProximity(_1200,_1266)=true,_1200).
index(pilotOpsEqualProximity(_1200,_1266)=true,_1200).
index(movingSpeedStartsUnderway(_1200)=below,_1200).
index(movingSpeedFinishesUnderway(_1200)=below,_1200).
index(movingSpeedEqualUnderway(_1200)=below,_1200).
index(driftingWhileTugging(_1200,_1266)=true,_1200).
index(fishingTripInArea(_1200)=true,_1200).
index(fishingTripTrawling(_1200)=true,_1200).
index(proximity(_1200,_1266)=true,_1200).


cachingOrder2(_1848, withinArea(_1848,_1850)=true) :- % level: 1
     vessel(_1848),areaType(_1850).

cachingOrder2(_2180, gap(_2180)=nearPorts) :- % level: 2
     vessel(_2180),portStatus(nearPorts).

cachingOrder2(_2164, gap(_2164)=farFromPorts) :- % level: 2
     vessel(_2164),portStatus(farFromPorts).

cachingOrder2(_2148, highSpeedNearCoast(_2148)=true) :- % level: 2
     vessel(_2148).

cachingOrder2(_2132, trawlingMovement(_2132)=true) :- % level: 2
     vessel(_2132),vesselType(_2132,fishing).

cachingOrder2(_3252, stopped(_3252)=nearPorts) :- % level: 3
     vessel(_3252),portStatus(nearPorts).

cachingOrder2(_3236, stopped(_3236)=farFromPorts) :- % level: 3
     vessel(_3236),portStatus(farFromPorts).

cachingOrder2(_3220, lowSpeed(_3220)=true) :- % level: 3
     vessel(_3220).

cachingOrder2(_3204, changingSpeed(_3204)=true) :- % level: 3
     vessel(_3204).

cachingOrder2(_3188, movingSpeed(_3188)=below) :- % level: 3
     vessel(_3188),movingStatus(below).

cachingOrder2(_3172, movingSpeed(_3172)=normal) :- % level: 3
     vessel(_3172),movingStatus(normal).

cachingOrder2(_3156, movingSpeed(_3156)=above) :- % level: 3
     vessel(_3156),movingStatus(above).

cachingOrder2(_3140, tuggingSpeed(_3140)=true) :- % level: 3
     vessel(_3140).

cachingOrder2(_3124, trawlSpeed(_3124)=true) :- % level: 3
     vessel(_3124),vesselType(_3124,fishing).

cachingOrder2(_3108, sarSpeed(_3108)=true) :- % level: 3
     vessel(_3108),vesselType(_3108,sar).

cachingOrder2(_3090, disappearedInArea(_3090,_3092)=true) :- % level: 3
     vessel(_3090),areaType(_3092).

cachingOrder2(_5770, sarMovement(_5770)=true) :- % level: 4
     vessel(_5770),vesselType(_5770,sar).

cachingOrder2(_5754, underWay(_5754)=true) :- % level: 4
     vessel(_5754).

cachingOrder2(_5738, anchoredOrMoored(_5738)=true) :- % level: 4
     vessel(_5738).

cachingOrder2(_5720, tugging(_5720,_5722)=true) :- % level: 4
     vpair(_5720,_5722).

cachingOrder2(_5702, rendezVous(_5702,_5704)=true) :- % level: 4
     vpair(_5702,_5704).

cachingOrder2(_5686, trawling(_5686)=true) :- % level: 4
     vessel(_5686).

cachingOrder2(_5668, pilotOps(_5668,_5670)=true) :- % level: 4
     vpair(_5668,_5670).

cachingOrder2(_5650, stoppedWithinArea(_5650,_5652)=true) :- % level: 4
     vessel(_5650),areaType(_5652).

cachingOrder2(_5634, stoppedMeetsGap(_5634)=true) :- % level: 4
     vessel(_5634).

cachingOrder2(_7786, drifting(_7786)=true) :- % level: 5
     vessel(_7786).

cachingOrder2(_7770, sarMovement(_7770)=false) :- % level: 5
     vessel(_7770),vesselType(_7770,sar).

cachingOrder2(_7754, inSAR(_7754)=true) :- % level: 5
     vessel(_7754).

cachingOrder2(_7738, loitering(_7738)=true) :- % level: 5
     vessel(_7738).

cachingOrder2(_8712, highSpeedNCBeforeDrifting(_8712)=true) :- % level: 6
     vessel(_8712).

cachingOrder2(_8696, dangerNearCoast(_8696)=true) :- % level: 6
     vessel(_8696).

collectGrounds([entersArea(_692,_706), gap_start(_692), stop_start(_692), slow_motion_start(_692), change_in_speed_start(_692), velocity(_692,_706,_708,_710), change_in_heading(_692), leavesArea(_692,_706), gap_end(_692), stop_end(_692), slow_motion_end(_692), change_in_speed_end(_692), coord(_692,_706,_708)],vessel(_692)).

collectGrounds([proximity(_680,_682)=true],vpair(_680,_682)).

dgrounded(withinArea(_2678,_2680)=true, vessel(_2678)).
dgrounded(gap(_2636)=nearPorts, vessel(_2636)).
dgrounded(gap(_2594)=farFromPorts, vessel(_2594)).
dgrounded(stopped(_2552)=nearPorts, vessel(_2552)).
dgrounded(stopped(_2510)=farFromPorts, vessel(_2510)).
dgrounded(lowSpeed(_2478)=true, vessel(_2478)).
dgrounded(changingSpeed(_2446)=true, vessel(_2446)).
dgrounded(highSpeedNearCoast(_2414)=true, vessel(_2414)).
dgrounded(movingSpeed(_2372)=below, vessel(_2372)).
dgrounded(movingSpeed(_2330)=normal, vessel(_2330)).
dgrounded(movingSpeed(_2288)=above, vessel(_2288)).
dgrounded(drifting(_2256)=true, vessel(_2256)).
dgrounded(tuggingSpeed(_2224)=true, vessel(_2224)).
dgrounded(trawlSpeed(_2180)=true, vessel(_2180)).
dgrounded(trawlingMovement(_2136)=true, vessel(_2136)).
dgrounded(sarSpeed(_2092)=true, vessel(_2092)).
dgrounded(sarMovement(_2048)=true, vessel(_2048)).
dgrounded(trawlingMovement(_2004)=false, vessel(_2004)).
dgrounded(sarMovement(_1960)=false, vessel(_1960)).
dgrounded(underWay(_1928)=true, vessel(_1928)).
dgrounded(anchoredOrMoored(_1896)=true, vessel(_1896)).
dgrounded(tugging(_1860,_1862)=true, vpair(_1860,_1862)).
dgrounded(rendezVous(_1824,_1826)=true, vpair(_1824,_1826)).
dgrounded(trawling(_1792)=true, vessel(_1792)).
dgrounded(inSAR(_1760)=true, vessel(_1760)).
dgrounded(loitering(_1728)=true, vessel(_1728)).
dgrounded(pilotOps(_1692,_1694)=true, vpair(_1692,_1694)).
dgrounded(disappearedInArea(_1648,_1650)=true, vessel(_1648)).
dgrounded(stoppedWithinArea(_1604,_1606)=true, vessel(_1604)).
dgrounded(stoppedMeetsGap(_1572)=true, vessel(_1572)).
dgrounded(highSpeedNCBeforeDrifting(_1540)=true, vessel(_1540)).
dgrounded(dangerNearCoast(_1508)=true, vessel(_1508)).
dgrounded(gainingSpeed(_1476)=true, vessel(_1476)).
dgrounded(speedChangeAbove(_1444)=true, vessel(_1444)).
dgrounded(collisionDanger(_1408,_1410)=true, vpair(_1408,_1410)).
dgrounded(suspiciousRendezVous(_1372,_1374)=true, vpair(_1372,_1374)).
dgrounded(anchoredFarFromPorts(_1340)=true, vessel(_1340)).
dgrounded(anchoredNearPorts(_1308)=true, vessel(_1308)).
dgrounded(tuggingStartsProximity(_1272,_1274)=true, vpair(_1272,_1274)).
dgrounded(tuggingFinishesProximity(_1236,_1238)=true, vpair(_1236,_1238)).
dgrounded(tuggingEqualProximity(_1200,_1202)=true, vpair(_1200,_1202)).
dgrounded(rendezVousStartsProximity(_1164,_1166)=true, vpair(_1164,_1166)).
dgrounded(rendezVousFinishesProximity(_1128,_1130)=true, vpair(_1128,_1130)).
dgrounded(rendezVousEqualProximity(_1092,_1094)=true, vpair(_1092,_1094)).
dgrounded(pilotOpsStartsProximity(_1056,_1058)=true, vpair(_1056,_1058)).
dgrounded(pilotOpsFinishesProximity(_1020,_1022)=true, vpair(_1020,_1022)).
dgrounded(pilotOpsEqualProximity(_984,_986)=true, vpair(_984,_986)).
dgrounded(movingSpeedStartsUnderway(_952)=below, vessel(_952)).
dgrounded(movingSpeedFinishesUnderway(_920)=below, vessel(_920)).
dgrounded(movingSpeedEqualUnderway(_888)=below, vessel(_888)).
dgrounded(driftingWhileTugging(_852,_854)=true, vpair(_852,_854)).
dgrounded(fishingTripInArea(_820)=true, vessel(_820)).
dgrounded(fishingTripTrawling(_788)=true, vessel(_788)).
