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

initiatedAt(highSpeedNearCoast(_108)=true, _184, _78, _190) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_184=<_78,_78<_190,
     thresholds(hcNearCoastMax,_130),
     \+inRange(_114,0,_130),
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_78).

initiatedAt(movingSpeed(_108)=below, _184, _78, _190) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_184=<_78,_78<_190,
     vesselType(_108,_130),
     typeSpeed(_130,_136,_138,_140),
     thresholds(movingMin,_146),
     inRange(_114,_146,_136).

initiatedAt(movingSpeed(_108)=normal, _172, _78, _178) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_172=<_78,_78<_178,
     vesselType(_108,_130),
     typeSpeed(_130,_136,_138,_140),
     inRange(_114,_136,_138).

initiatedAt(movingSpeed(_108)=above, _172, _78, _178) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_172=<_78,_78<_178,
     vesselType(_108,_130),
     typeSpeed(_130,_136,_138,_140),
     inRange(_114,_138,inf).

initiatedAt(drifting(_108)=true, _208, _78, _214) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_208=<_78,_78<_214,
     _118=\=511.0,
     absoluteAngleDiff(_116,_118,_144),
     thresholds(adriftAngThr,_150),
     _144>_150,
     holdsAtProcessedSDFluent(_108,underWay(_108)=true,_78).

initiatedAt(tuggingSpeed(_108)=true, _168, _78, _174) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_168=<_78,_78<_174,
     thresholds(tuggingMin,_130),
     thresholds(tuggingMax,_136),
     inRange(_114,_130,_136).

initiatedAt(trawlSpeed(_108)=true, _192, _78, _198) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_192=<_78,_78<_198,
     thresholds(trawlspeedMin,_130),
     thresholds(trawlspeedMax,_136),
     inRange(_114,_130,_136),
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,fishing)=true,_78).

initiatedAt(trawlingMovement(_108)=true, _148, _78, _154) :-
     happensAtIE(change_in_heading(_108),_78),_148=<_78,_78<_154,
     holdsAtProcessedSimpleFluent(_108,withinArea(_108,fishing)=true,_78).

initiatedAt(sarSpeed(_108)=true, _156, _78, _162) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_156=<_78,_78<_162,
     thresholds(sarMinSpeed,_130),
     inRange(_114,_130,inf).

initiatedAt(sarMovement(_108)=true, _124, _78, _130) :-
     happensAtIE(change_in_heading(_108),_78),
     _124=<_78,
     _78<_130.

initiatedAt(sarMovement(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(changingSpeed(_108)=true),_78),
     _134=<_78,
     _78<_140.

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

terminatedAt(lowSpeed(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

terminatedAt(changingSpeed(_108)=true, _124, _78, _130) :-
     happensAtIE(change_in_speed_end(_108),_78),
     _124=<_78,
     _78<_130.

terminatedAt(changingSpeed(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

terminatedAt(highSpeedNearCoast(_108)=true, _156, _78, _162) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_156=<_78,_78<_162,
     thresholds(hcNearCoastMax,_130),
     inRange(_114,0,_130).

terminatedAt(highSpeedNearCoast(_108)=true, _136, _78, _142) :-
     happensAtProcessedSimpleFluent(_108,end(withinArea(_108,nearCoast)=true),_78),
     _136=<_78,
     _78<_142.

terminatedAt(movingSpeed(_108)=_84, _160, _78, _166) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_160=<_78,_78<_166,
     thresholds(movingMin,_130),
     \+inRange(_114,_130,inf).

terminatedAt(movingSpeed(_108)=_84, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

terminatedAt(drifting(_108)=true, _168, _78, _174) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_168=<_78,_78<_174,
     absoluteAngleDiff(_116,_118,_132),
     thresholds(adriftAngThr,_138),
     _132=<_138.

terminatedAt(drifting(_108)=true, _136, _78, _142) :-
     happensAtIE(velocity(_108,_114,_116,511.0),_78),
     _136=<_78,
     _78<_142.

terminatedAt(drifting(_108)=true, _134, _78, _140) :-
     happensAtProcessedSDFluent(_108,end(underWay(_108)=true),_78),
     _134=<_78,
     _78<_140.

terminatedAt(tuggingSpeed(_108)=true, _172, _78, _178) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_172=<_78,_78<_178,
     thresholds(tuggingMin,_130),
     thresholds(tuggingMax,_136),
     \+inRange(_114,_130,_136).

terminatedAt(tuggingSpeed(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

terminatedAt(trawlSpeed(_108)=true, _172, _78, _178) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_172=<_78,_78<_178,
     thresholds(trawlspeedMin,_130),
     thresholds(trawlspeedMax,_136),
     \+inRange(_114,_130,_136).

terminatedAt(trawlSpeed(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

terminatedAt(trawlSpeed(_108)=true, _136, _78, _142) :-
     happensAtProcessedSimpleFluent(_108,end(withinArea(_108,fishing)=true),_78),
     _136=<_78,
     _78<_142.

terminatedAt(trawlingMovement(_108)=true, _136, _78, _142) :-
     happensAtProcessedSimpleFluent(_108,end(withinArea(_108,fishing)=true),_78),
     _136=<_78,
     _78<_142.

terminatedAt(sarSpeed(_108)=true, _156, _78, _162) :-
     happensAtIE(velocity(_108,_114,_116,_118),_78),_156=<_78,_78<_162,
     thresholds(sarMinSpeed,_130),
     inRange(_114,0,_130).

terminatedAt(sarSpeed(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

terminatedAt(sarMovement(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(gap(_108)=_118),_78),
     _134=<_78,
     _78<_140.

holdsForSDFluent(underWay(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=below,_124),
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=normal,_140),
     holdsForProcessedSimpleFluent(_108,movingSpeed(_108)=above,_156),
     union_all([_124,_140,_156],_78).

holdsForSDFluent(anchoredOrMoored(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_124),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,anchorage)=true,_142),
     intersect_all([_124,_142],_160),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=nearPorts,_176),
     union_all([_160,_176],_194),
     thresholds(aOrMTime,_200),
     intDurGreater(_194,_200,_78).

holdsForSDFluent(tugging(_108,_110)=true,_78) :-
     holdsForProcessedIE(_108,proximity(_108,_110)=true,_128),
     oneIsTug(_108,_110),
     \+oneIsPilot(_108,_110),
     \+twoAreTugs(_108,_110),
     holdsForProcessedSimpleFluent(_108,tuggingSpeed(_108)=true,_170),
     holdsForProcessedSimpleFluent(_110,tuggingSpeed(_110)=true,_186),
     intersect_all([_128,_170,_186],_210),
     thresholds(tuggingTime,_216),
     intDurGreater(_210,_216,_78).

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

holdsForSDFluent(trawling(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,trawlSpeed(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,trawlingMovement(_108)=true,_140),
     intersect_all([_124,_140],_158),
     thresholds(trawlingTime,_164),
     intDurGreater(_158,_164,_78).

holdsForSDFluent(inSAR(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,sarSpeed(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,sarMovement(_108)=true,_140),
     intersect_all([_124,_140],_158),
     intDurGreater(_158,3600,_78).

holdsForSDFluent(loitering(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,lowSpeed(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_140),
     union_all([_124,_140],_158),
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_176),
     holdsForProcessedSDFluent(_108,anchoredOrMoored(_108)=true,_192),
     relative_complement_all(_158,[_176,_192],_212),
     thresholds(loiteringTime,_218),
     intDurGreater(_212,_218,_78).

holdsForSDFluent(pilotOps(_108,_110)=true,_78) :-
     holdsForProcessedIE(_108,proximity(_108,_110)=true,_128),
     oneIsPilot(_108,_110),
     holdsForProcessedSimpleFluent(_108,lowSpeed(_108)=true,_150),
     holdsForProcessedSimpleFluent(_110,lowSpeed(_110)=true,_166),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_182),
     holdsForProcessedSimpleFluent(_110,stopped(_110)=farFromPorts,_198),
     union_all([_150,_182],_216),
     union_all([_166,_198],_234),
     intersect_all([_216,_234,_128],_258),
     _258\=[],
     holdsForProcessedSimpleFluent(_108,withinArea(_108,nearCoast)=true,_282),
     holdsForProcessedSimpleFluent(_110,withinArea(_110,nearCoast)=true,_300),
     relative_complement_all(_258,[_282,_300],_78).

holdsForSDFluent(disappearedInArea(_108,_110)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,withinArea(_108,_110)=true,_128),
     holdsForProcessedSimpleFluent(_108,gap(_108)=farFromPorts,_144),
     meets(disappearedInArea(_108,_110)=true,0,_128,_144,union,true,_78).

holdsForSDFluent(stoppedWithinArea(_108,_110)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,withinArea(_108,_110)=true,_128),
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_144),
     during(stoppedWithinArea(_108,_110)=true,0,_144,_128,source,true,_78).

holdsForSDFluent(stoppedMeetsGap(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,stopped(_108)=farFromPorts,_124),
     holdsForProcessedSimpleFluent(_108,gap(_108)=farFromPorts,_140),
     meets(stoppedMeetsGap(_108)=true,0,_124,_140,union,true,_78).

holdsForSDFluent(highSpeedNCBeforeDrifting(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,highSpeedNearCoast(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,drifting(_108)=true,_140),
     before(highSpeedNCBeforeDrifting(_108)=true,0,_124,_140,union,true,_78).

holdsForSDFluent(dangerNearCoast(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,highSpeedNearCoast(_108)=true,_124),
     holdsForProcessedSimpleFluent(_108,drifting(_108)=true,_140),
     overlaps(dangerNearCoast(_108)=true,0,_124,_140,union,true,_78).

holdsForSDFluent(gainingSpeed(_108)=true,_78) :-
     holdsFor(_108,movingSpeed(_108)=below,_126),
     holdsFor(_108,movingSpeed(_108)=normal,_144),
     meets(gainingSpeed(_108)=true,0,_126,_144,union,true,_78).

holdsForSDFluent(speedChangeAbove(_108)=true,_78) :-
     holdsFor(_108,changingSpeed(_108)=true,_126),
     holdsFor(_108,movingSpeed(_108)=above,_144),
     starts(speedChangeAbove(_108)=true,0,_126,_144,relative_complement_inverse,true,_78).

holdsForSDFluent(collisionDanger(_108,_110)=true,_78) :-
     holdsFor(_108,proximity(_108,_110)=true,_130),
     holdsFor(_108,movingSpeed(_108)=above,_148),
     holdsFor(_110,movingSpeed(_110)=above,_166),
     union_all([_148,_166],_184),
     overlaps(collisionDanger(_108,_110)=true,0,_184,_130,intersection,true,_78).

holdsForSDFluent(suspiciousRendezVous(_108,_110)=true,_78) :-
     holdsFor(_108,proximity(_108,_110)=true,_130),
     holdsFor(_108,gap(_108)=_136,_148),
     holdsFor(_110,gap(_110)=_154,_166),
     union_all([_148,_166],_184),
     during(suspiciousRendezVous(_108,_110)=true,0,_184,_130,lhs,true,_78).

holdsForSDFluent(anchoredFarFromPorts(_108)=true,_78) :-
     holdsFor(_108,anchoredOrMoored(_108)=true,_126),
     holdsFor(_108,stopped(_108)=farFromPorts,_144),
     holdsFor(_108,withinArea(_108,anchorage)=true,_164),
     intersect_all([_144,_164],_182),
     equal(anchoredFarFromPorts(_108)=true,0,_126,_182,lhs,true,_78).

holdsForSDFluent(anchoredNearPorts(_108)=true,_78) :-
     holdsFor(_108,anchoredOrMoored(_108)=true,_126),
     holdsFor(_108,stopped(_108)=nearPorts,_144),
     equal(anchoredNearPorts(_108)=true,0,_126,_144,lhs,true,_78).

holdsForSDFluent(tuggingStartsProximity(_108,_110)=true,_78) :-
     holdsFor(_108,tugging(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     starts(tuggingStartsProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(tuggingFinishesProximity(_108,_110)=true,_78) :-
     holdsFor(_108,tugging(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     finishes(tuggingFinishesProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(tuggingEqualProximity(_108,_110)=true,_78) :-
     holdsFor(_108,tugging(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     equal(tuggingEqualProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(rendezVousStartsProximity(_108,_110)=true,_78) :-
     holdsFor(_108,rendezVous(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     starts(rendezVousStartsProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(rendezVousFinishesProximity(_108,_110)=true,_78) :-
     holdsFor(_108,rendezVous(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     finishes(rendezVousFinishesProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(rendezVousEqualProximity(_108,_110)=true,_78) :-
     holdsFor(_108,rendezVous(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     equal(rendezVousEqualProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(pilotOpsStartsProximity(_108,_110)=true,_78) :-
     holdsFor(_108,pilotOps(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     starts(pilotOpsStartsProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(pilotOpsFinishesProximity(_108,_110)=true,_78) :-
     holdsFor(_108,pilotOps(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     finishes(pilotOpsFinishesProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(pilotOpsEqualProximity(_108,_110)=true,_78) :-
     holdsFor(_108,pilotOps(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     equal(pilotOpsEqualProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(movingSpeedStartsUnderway(_108)=_84,_78) :-
     holdsFor(_108,underWay(_108)=true,_126),
     holdsFor(_108,movingSpeed(_108)=_84,_144),
     starts(movingSpeedStartsUnderway(_108)=_84,0,_144,_126,lhs,true,_78).

holdsForSDFluent(movingSpeedFinishesUnderway(_108)=_84,_78) :-
     holdsFor(_108,underWay(_108)=true,_126),
     holdsFor(_108,movingSpeed(_108)=_84,_144),
     finishes(movingSpeedFinishesUnderway(_108)=_84,0,_144,_126,lhs,true,_78).

holdsForSDFluent(movingSpeedEqualUnderway(_108)=_84,_78) :-
     holdsFor(_108,underWay(_108)=true,_126),
     holdsFor(_108,movingSpeed(_108)=_84,_144),
     equal(movingSpeedEqualUnderway(_108)=_84,0,_144,_126,lhs,true,_78).

holdsForSDFluent(pilotOpsEqualProximity(_108,_110)=true,_78) :-
     holdsFor(_108,pilotOps(_108,_110)=true,_130),
     holdsFor(_108,proximity(_108,_110)=true,_150),
     equal(pilotOpsEqualProximity(_108,_110)=true,0,_130,_150,lhs,true,_78).

holdsForSDFluent(driftingWhileTugging(_108,_110)=true,_78) :-
     holdsFor(_108,tugging(_108,_110)=true,_130),
     holdsFor(_108,drifting(_108)=true,_148),
     holdsFor(_110,drifting(_110)=true,_166),
     union_all([_148,_166],_184),
     during(driftingWhileTugging(_108,_110)=true,0,_130,_184,union,true,_78).

holdsForSDFluent(fishingTripInArea(_108)=true,_78) :-
     holdsFor(_108,withinArea(_108,nearPorts)=true,_128),
     holdsFor(_108,withinArea(_108,fishing)=true,_148),
     before(fishingTripInArea(_108)=true,0,_128,_148,union,true,_158),
     before(fishingTripInArea(_108)=true,1,_158,_128,union,true,_78).

holdsForSDFluent(fishingTripTrawling(_108)=true,_78) :-
     holdsFor(_108,withinArea(_108,nearPorts)=true,_128),
     holdsFor(_108,trawling(_108)=true,_146),
     before(fishingTripTrawling(_108)=true,0,_128,_146,union,true,_156),
     before(fishingTripTrawling(_108)=true,1,_156,_128,union,true,_78).

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

grounding(disappearedInArea(_484,_486)=true) :- 
     vessel(_484),areaType(_486).

grounding(stoppedWithinArea(_484,_486)=true) :- 
     vessel(_484),areaType(_486).

grounding(stoppedMeetsGap(_484)=true) :- 
     vessel(_484).

grounding(highSpeedNCBeforeDrifting(_484)=true) :- 
     vessel(_484).

grounding(dangerNearCoast(_484)=true) :- 
     vessel(_484).

grounding(gainingSpeed(_484)=true) :- 
     vessel(_484).

grounding(speedChangeAbove(_484)=true) :- 
     vessel(_484).

grounding(anchoredFarFromPorts(_484)=true) :- 
     vessel(_484).

grounding(anchoredNearPorts(_484)=true) :- 
     vessel(_484).

grounding(tuggingStartsProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(tuggingFinishesProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(tuggingEqualProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(rendezVousStartsProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(rendezVousFinishesProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(rendezVousEqualProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(pilotOpsStartsProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(pilotOpsFinishesProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(pilotOpsEqualProximity(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(movingSpeedStartsUnderway(_484)=below) :- 
     vessel(_484).

grounding(movingSpeedFinishesUnderway(_484)=below) :- 
     vessel(_484).

grounding(movingSpeedEqualUnderway(_484)=below) :- 
     vessel(_484).

grounding(collisionDanger(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(suspiciousRendezVous(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(driftingWhileTugging(_484,_486)=true) :- 
     vpair(_484,_486).

grounding(fishingTripInArea(_484)=true) :- 
     vessel(_484).

grounding(fishingTripTrawling(_484)=true) :- 
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
outputEntity(movingSpeed(_278)=below).
outputEntity(movingSpeed(_278)=normal).
outputEntity(movingSpeed(_278)=above).
outputEntity(drifting(_278)=true).
outputEntity(tuggingSpeed(_278)=true).
outputEntity(trawlSpeed(_278)=true).
outputEntity(trawlingMovement(_278)=true).
outputEntity(sarSpeed(_278)=true).
outputEntity(sarMovement(_278)=true).
outputEntity(trawlingMovement(_278)=false).
outputEntity(sarMovement(_278)=false).
outputEntity(underWay(_278)=true).
outputEntity(anchoredOrMoored(_278)=true).
outputEntity(tugging(_278,_280)=true).
outputEntity(rendezVous(_278,_280)=true).
outputEntity(trawling(_278)=true).
outputEntity(inSAR(_278)=true).
outputEntity(loitering(_278)=true).
outputEntity(pilotOps(_278,_280)=true).
outputEntity(disappearedInArea(_278,_280)=true).
outputEntity(stoppedWithinArea(_278,_280)=true).
outputEntity(stoppedMeetsGap(_278)=true).
outputEntity(highSpeedNCBeforeDrifting(_278)=true).
outputEntity(dangerNearCoast(_278)=true).
outputEntity(gainingSpeed(_278)=true).
outputEntity(speedChangeAbove(_278)=true).
outputEntity(collisionDanger(_278,_280)=true).
outputEntity(suspiciousRendezVous(_278,_280)=true).
outputEntity(anchoredFarFromPorts(_278)=true).
outputEntity(anchoredNearPorts(_278)=true).
outputEntity(tuggingStartsProximity(_278,_280)=true).
outputEntity(tuggingFinishesProximity(_278,_280)=true).
outputEntity(tuggingEqualProximity(_278,_280)=true).
outputEntity(rendezVousStartsProximity(_278,_280)=true).
outputEntity(rendezVousFinishesProximity(_278,_280)=true).
outputEntity(rendezVousEqualProximity(_278,_280)=true).
outputEntity(pilotOpsStartsProximity(_278,_280)=true).
outputEntity(pilotOpsFinishesProximity(_278,_280)=true).
outputEntity(pilotOpsEqualProximity(_278,_280)=true).
outputEntity(movingSpeedStartsUnderway(_278)=below).
outputEntity(movingSpeedFinishesUnderway(_278)=below).
outputEntity(movingSpeedEqualUnderway(_278)=below).
outputEntity(driftingWhileTugging(_278,_280)=true).
outputEntity(fishingTripInArea(_278)=true).
outputEntity(fishingTripTrawling(_278)=true).

event(entersArea(_646,_648)).
event(gap_start(_646)).
event(stop_start(_646)).
event(slow_motion_start(_646)).
event(change_in_speed_start(_646)).
event(velocity(_646,_648,_650,_652)).
event(change_in_heading(_646)).
event(leavesArea(_646,_648)).
event(gap_end(_646)).
event(stop_end(_646)).
event(slow_motion_end(_646)).
event(change_in_speed_end(_646)).
event(coord(_646,_648,_650)).

simpleFluent(withinArea(_786,_788)=true).
simpleFluent(gap(_786)=nearPorts).
simpleFluent(gap(_786)=farFromPorts).
simpleFluent(stopped(_786)=nearPorts).
simpleFluent(stopped(_786)=farFromPorts).
simpleFluent(lowSpeed(_786)=true).
simpleFluent(changingSpeed(_786)=true).
simpleFluent(highSpeedNearCoast(_786)=true).
simpleFluent(movingSpeed(_786)=below).
simpleFluent(movingSpeed(_786)=normal).
simpleFluent(movingSpeed(_786)=above).
simpleFluent(drifting(_786)=true).
simpleFluent(tuggingSpeed(_786)=true).
simpleFluent(trawlSpeed(_786)=true).
simpleFluent(trawlingMovement(_786)=true).
simpleFluent(sarSpeed(_786)=true).
simpleFluent(sarMovement(_786)=true).
simpleFluent(trawlingMovement(_786)=false).
simpleFluent(sarMovement(_786)=false).

sDFluent(underWay(_956)=true).
sDFluent(anchoredOrMoored(_956)=true).
sDFluent(tugging(_956,_958)=true).
sDFluent(rendezVous(_956,_958)=true).
sDFluent(trawling(_956)=true).
sDFluent(inSAR(_956)=true).
sDFluent(loitering(_956)=true).
sDFluent(pilotOps(_956,_958)=true).
sDFluent(disappearedInArea(_956,_958)=true).
sDFluent(stoppedWithinArea(_956,_958)=true).
sDFluent(stoppedMeetsGap(_956)=true).
sDFluent(highSpeedNCBeforeDrifting(_956)=true).
sDFluent(dangerNearCoast(_956)=true).
sDFluent(gainingSpeed(_956)=true).
sDFluent(speedChangeAbove(_956)=true).
sDFluent(collisionDanger(_956,_958)=true).
sDFluent(suspiciousRendezVous(_956,_958)=true).
sDFluent(anchoredFarFromPorts(_956)=true).
sDFluent(anchoredNearPorts(_956)=true).
sDFluent(tuggingStartsProximity(_956,_958)=true).
sDFluent(tuggingFinishesProximity(_956,_958)=true).
sDFluent(tuggingEqualProximity(_956,_958)=true).
sDFluent(rendezVousStartsProximity(_956,_958)=true).
sDFluent(rendezVousFinishesProximity(_956,_958)=true).
sDFluent(rendezVousEqualProximity(_956,_958)=true).
sDFluent(pilotOpsStartsProximity(_956,_958)=true).
sDFluent(pilotOpsFinishesProximity(_956,_958)=true).
sDFluent(pilotOpsEqualProximity(_956,_958)=true).
sDFluent(movingSpeedStartsUnderway(_956)=below).
sDFluent(movingSpeedFinishesUnderway(_956)=below).
sDFluent(movingSpeedEqualUnderway(_956)=below).
sDFluent(driftingWhileTugging(_956,_958)=true).
sDFluent(fishingTripInArea(_956)=true).
sDFluent(fishingTripTrawling(_956)=true).
sDFluent(proximity(_956,_958)=true).

index(entersArea(_1168,_1222),_1168).
index(gap_start(_1168),_1168).
index(stop_start(_1168),_1168).
index(slow_motion_start(_1168),_1168).
index(change_in_speed_start(_1168),_1168).
index(velocity(_1168,_1222,_1224,_1226),_1168).
index(change_in_heading(_1168),_1168).
index(leavesArea(_1168,_1222),_1168).
index(gap_end(_1168),_1168).
index(stop_end(_1168),_1168).
index(slow_motion_end(_1168),_1168).
index(change_in_speed_end(_1168),_1168).
index(coord(_1168,_1222,_1224),_1168).
index(withinArea(_1168,_1228)=true,_1168).
index(gap(_1168)=nearPorts,_1168).
index(gap(_1168)=farFromPorts,_1168).
index(stopped(_1168)=nearPorts,_1168).
index(stopped(_1168)=farFromPorts,_1168).
index(lowSpeed(_1168)=true,_1168).
index(changingSpeed(_1168)=true,_1168).
index(highSpeedNearCoast(_1168)=true,_1168).
index(movingSpeed(_1168)=below,_1168).
index(movingSpeed(_1168)=normal,_1168).
index(movingSpeed(_1168)=above,_1168).
index(drifting(_1168)=true,_1168).
index(tuggingSpeed(_1168)=true,_1168).
index(trawlSpeed(_1168)=true,_1168).
index(trawlingMovement(_1168)=true,_1168).
index(sarSpeed(_1168)=true,_1168).
index(sarMovement(_1168)=true,_1168).
index(trawlingMovement(_1168)=false,_1168).
index(sarMovement(_1168)=false,_1168).
index(underWay(_1168)=true,_1168).
index(anchoredOrMoored(_1168)=true,_1168).
index(tugging(_1168,_1228)=true,_1168).
index(rendezVous(_1168,_1228)=true,_1168).
index(trawling(_1168)=true,_1168).
index(inSAR(_1168)=true,_1168).
index(loitering(_1168)=true,_1168).
index(pilotOps(_1168,_1228)=true,_1168).
index(disappearedInArea(_1168,_1228)=true,_1168).
index(stoppedWithinArea(_1168,_1228)=true,_1168).
index(stoppedMeetsGap(_1168)=true,_1168).
index(highSpeedNCBeforeDrifting(_1168)=true,_1168).
index(dangerNearCoast(_1168)=true,_1168).
index(gainingSpeed(_1168)=true,_1168).
index(speedChangeAbove(_1168)=true,_1168).
index(collisionDanger(_1168,_1228)=true,_1168).
index(suspiciousRendezVous(_1168,_1228)=true,_1168).
index(anchoredFarFromPorts(_1168)=true,_1168).
index(anchoredNearPorts(_1168)=true,_1168).
index(tuggingStartsProximity(_1168,_1228)=true,_1168).
index(tuggingFinishesProximity(_1168,_1228)=true,_1168).
index(tuggingEqualProximity(_1168,_1228)=true,_1168).
index(rendezVousStartsProximity(_1168,_1228)=true,_1168).
index(rendezVousFinishesProximity(_1168,_1228)=true,_1168).
index(rendezVousEqualProximity(_1168,_1228)=true,_1168).
index(pilotOpsStartsProximity(_1168,_1228)=true,_1168).
index(pilotOpsFinishesProximity(_1168,_1228)=true,_1168).
index(pilotOpsEqualProximity(_1168,_1228)=true,_1168).
index(movingSpeedStartsUnderway(_1168)=below,_1168).
index(movingSpeedFinishesUnderway(_1168)=below,_1168).
index(movingSpeedEqualUnderway(_1168)=below,_1168).
index(driftingWhileTugging(_1168,_1228)=true,_1168).
index(fishingTripInArea(_1168)=true,_1168).
index(fishingTripTrawling(_1168)=true,_1168).
index(proximity(_1168,_1228)=true,_1168).


cachingOrder2(_1804, withinArea(_1804,_1806)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1804),areaType(_1806).

cachingOrder2(_2054, gap(_2054)=nearPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2054),portStatus(nearPorts).

cachingOrder2(_2032, gap(_2032)=farFromPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2032),portStatus(farFromPorts).

cachingOrder2(_2010, highSpeedNearCoast(_2010)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2010).

cachingOrder2(_1972, trawlingMovement(_1972)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1972),vesselType(_1972,fishing).

cachingOrder2(_1972, trawlingMovement(_1972)=false) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_1972),vesselType(_1972,fishing).

cachingOrder2(_2740, stopped(_2740)=nearPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2740),portStatus(nearPorts).

cachingOrder2(_2718, stopped(_2718)=farFromPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2718),portStatus(farFromPorts).

cachingOrder2(_2696, lowSpeed(_2696)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2696).

cachingOrder2(_2674, changingSpeed(_2674)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2674).

cachingOrder2(_2652, movingSpeed(_2652)=below) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2652),movingStatus(below).

cachingOrder2(_2630, movingSpeed(_2630)=normal) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2630),movingStatus(normal).

cachingOrder2(_2608, movingSpeed(_2608)=above) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2608),movingStatus(above).

cachingOrder2(_2586, tuggingSpeed(_2586)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2586).

cachingOrder2(_2564, trawlSpeed(_2564)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2564),vesselType(_2564,fishing).

cachingOrder2(_2542, sarSpeed(_2542)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2542),vesselType(_2542,sar).

cachingOrder2(_2518, disappearedInArea(_2518,_2520)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2518),areaType(_2520).

cachingOrder2(_3864, sarMovement(_3864)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3864),vesselType(_3864,sar).

cachingOrder2(_3864, sarMovement(_3864)=false) :- % level in dependency graph: 4, processing order in component: 2
     vessel(_3864),vesselType(_3864,sar).

cachingOrder2(_3842, underWay(_3842)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3842).

cachingOrder2(_3820, anchoredOrMoored(_3820)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3820).

cachingOrder2(_3796, tugging(_3796,_3798)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3796,_3798).

cachingOrder2(_3772, rendezVous(_3772,_3774)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3772,_3774).

cachingOrder2(_3750, trawling(_3750)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3750).

cachingOrder2(_3726, pilotOps(_3726,_3728)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3726,_3728).

cachingOrder2(_3702, stoppedWithinArea(_3702,_3704)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3702),areaType(_3704).

cachingOrder2(_3680, stoppedMeetsGap(_3680)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3680).

cachingOrder2(_4798, drifting(_4798)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4798).

cachingOrder2(_4776, inSAR(_4776)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4776).

cachingOrder2(_4754, loitering(_4754)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4754).

cachingOrder2(_5100, highSpeedNCBeforeDrifting(_5100)=true) :- % level in dependency graph: 6, processing order in component: 1
     vessel(_5100).

cachingOrder2(_5078, dangerNearCoast(_5078)=true) :- % level in dependency graph: 6, processing order in component: 1
     vessel(_5078).

collectGrounds([entersArea(_678,_692), gap_start(_678), stop_start(_678), slow_motion_start(_678), change_in_speed_start(_678), velocity(_678,_692,_694,_696), change_in_heading(_678), leavesArea(_678,_692), gap_end(_678), stop_end(_678), slow_motion_end(_678), change_in_speed_end(_678), coord(_678,_692,_694)],vessel(_678)).

collectGrounds([proximity(_666,_668)=true],vpair(_666,_668)).

dgrounded(withinArea(_2658,_2660)=true, vessel(_2658)).
dgrounded(gap(_2616)=nearPorts, vessel(_2616)).
dgrounded(gap(_2574)=farFromPorts, vessel(_2574)).
dgrounded(stopped(_2532)=nearPorts, vessel(_2532)).
dgrounded(stopped(_2490)=farFromPorts, vessel(_2490)).
dgrounded(lowSpeed(_2458)=true, vessel(_2458)).
dgrounded(changingSpeed(_2426)=true, vessel(_2426)).
dgrounded(highSpeedNearCoast(_2394)=true, vessel(_2394)).
dgrounded(movingSpeed(_2352)=below, vessel(_2352)).
dgrounded(movingSpeed(_2310)=normal, vessel(_2310)).
dgrounded(movingSpeed(_2268)=above, vessel(_2268)).
dgrounded(drifting(_2236)=true, vessel(_2236)).
dgrounded(tuggingSpeed(_2204)=true, vessel(_2204)).
dgrounded(trawlSpeed(_2160)=true, vessel(_2160)).
dgrounded(trawlingMovement(_2116)=true, vessel(_2116)).
dgrounded(sarSpeed(_2072)=true, vessel(_2072)).
dgrounded(sarMovement(_2028)=true, vessel(_2028)).
dgrounded(trawlingMovement(_1984)=false, vessel(_1984)).
dgrounded(sarMovement(_1940)=false, vessel(_1940)).
dgrounded(underWay(_1908)=true, vessel(_1908)).
dgrounded(anchoredOrMoored(_1876)=true, vessel(_1876)).
dgrounded(tugging(_1840,_1842)=true, vpair(_1840,_1842)).
dgrounded(rendezVous(_1804,_1806)=true, vpair(_1804,_1806)).
dgrounded(trawling(_1772)=true, vessel(_1772)).
dgrounded(inSAR(_1740)=true, vessel(_1740)).
dgrounded(loitering(_1708)=true, vessel(_1708)).
dgrounded(pilotOps(_1672,_1674)=true, vpair(_1672,_1674)).
dgrounded(disappearedInArea(_1628,_1630)=true, vessel(_1628)).
dgrounded(stoppedWithinArea(_1584,_1586)=true, vessel(_1584)).
dgrounded(stoppedMeetsGap(_1552)=true, vessel(_1552)).
dgrounded(highSpeedNCBeforeDrifting(_1520)=true, vessel(_1520)).
dgrounded(dangerNearCoast(_1488)=true, vessel(_1488)).
dgrounded(gainingSpeed(_1456)=true, vessel(_1456)).
dgrounded(speedChangeAbove(_1424)=true, vessel(_1424)).
dgrounded(collisionDanger(_1388,_1390)=true, vpair(_1388,_1390)).
dgrounded(suspiciousRendezVous(_1352,_1354)=true, vpair(_1352,_1354)).
dgrounded(anchoredFarFromPorts(_1320)=true, vessel(_1320)).
dgrounded(anchoredNearPorts(_1288)=true, vessel(_1288)).
dgrounded(tuggingStartsProximity(_1252,_1254)=true, vpair(_1252,_1254)).
dgrounded(tuggingFinishesProximity(_1216,_1218)=true, vpair(_1216,_1218)).
dgrounded(tuggingEqualProximity(_1180,_1182)=true, vpair(_1180,_1182)).
dgrounded(rendezVousStartsProximity(_1144,_1146)=true, vpair(_1144,_1146)).
dgrounded(rendezVousFinishesProximity(_1108,_1110)=true, vpair(_1108,_1110)).
dgrounded(rendezVousEqualProximity(_1072,_1074)=true, vpair(_1072,_1074)).
dgrounded(pilotOpsStartsProximity(_1036,_1038)=true, vpair(_1036,_1038)).
dgrounded(pilotOpsFinishesProximity(_1000,_1002)=true, vpair(_1000,_1002)).
dgrounded(pilotOpsEqualProximity(_964,_966)=true, vpair(_964,_966)).
dgrounded(movingSpeedStartsUnderway(_932)=below, vessel(_932)).
dgrounded(movingSpeedFinishesUnderway(_900)=below, vessel(_900)).
dgrounded(movingSpeedEqualUnderway(_868)=below, vessel(_868)).
dgrounded(driftingWhileTugging(_832,_834)=true, vpair(_832,_834)).
dgrounded(fishingTripInArea(_800)=true, vessel(_800)).
dgrounded(fishingTripTrawling(_768)=true, vessel(_768)).
