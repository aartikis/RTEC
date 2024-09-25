:- dynamic vessel/1, vpair/2.

initiatedAt(withinArea(_112,_114)=true, _144, _82, _150) :-
     happensAtIE(entersArea(_112,_120),_82),_144=<_82,_82<_150,
     areaType(_120,_114).

initiatedAt(gap(_112)=nearPorts, _152, _82, _158) :-
     happensAtIE(gap_start(_112),_82),_152=<_82,_82<_158,
     holdsAtProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_82).

initiatedAt(gap(_112)=farFromPorts, _156, _82, _162) :-
     happensAtIE(gap_start(_112),_82),_156=<_82,_82<_162,
     \+holdsAtProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_82).

initiatedAt(stopped(_112)=nearPorts, _152, _82, _158) :-
     happensAtIE(stop_start(_112),_82),_152=<_82,_82<_158,
     holdsAtProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_82).

initiatedAt(stopped(_112)=farFromPorts, _156, _82, _162) :-
     happensAtIE(stop_start(_112),_82),_156=<_82,_82<_162,
     \+holdsAtProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_82).

initiatedAt(lowSpeed(_112)=true, _128, _82, _134) :-
     happensAtIE(slow_motion_start(_112),_82),
     _128=<_82,
     _82<_134.

initiatedAt(changingSpeed(_112)=true, _128, _82, _134) :-
     happensAtIE(change_in_speed_start(_112),_82),
     _128=<_82,
     _82<_134.

initiatedAt(highSpeedNearCoast(_112)=true, _188, _82, _194) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_188=<_82,_82<_194,
     thresholds(hcNearCoastMax,_134),
     \+inRange(_118,0,_134),
     holdsAtProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_82).

initiatedAt(movingSpeed(_112)=below, _188, _82, _194) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_188=<_82,_82<_194,
     vesselType(_112,_134),
     typeSpeed(_134,_140,_142,_144),
     thresholds(movingMin,_150),
     inRange(_118,_150,_140).

initiatedAt(movingSpeed(_112)=normal, _176, _82, _182) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_176=<_82,_82<_182,
     vesselType(_112,_134),
     typeSpeed(_134,_140,_142,_144),
     inRange(_118,_140,_142).

initiatedAt(movingSpeed(_112)=above, _176, _82, _182) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_176=<_82,_82<_182,
     vesselType(_112,_134),
     typeSpeed(_134,_140,_142,_144),
     inRange(_118,_142,inf).

initiatedAt(drifting(_112)=true, _212, _82, _218) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_212=<_82,_82<_218,
     _122=\=511.0,
     absoluteAngleDiff(_120,_122,_148),
     thresholds(adriftAngThr,_154),
     _148>_154,
     holdsAtProcessedSDFluent(_112,underWay(_112)=true,_82).

initiatedAt(tuggingSpeed(_112)=true, _172, _82, _178) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_172=<_82,_82<_178,
     thresholds(tuggingMin,_134),
     thresholds(tuggingMax,_140),
     inRange(_118,_134,_140).

initiatedAt(trawlSpeed(_112)=true, _196, _82, _202) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_196=<_82,_82<_202,
     thresholds(trawlspeedMin,_134),
     thresholds(trawlspeedMax,_140),
     inRange(_118,_134,_140),
     holdsAtProcessedSimpleFluent(_112,withinArea(_112,fishing)=true,_82).

initiatedAt(trawlingMovement(_112)=true, _152, _82, _158) :-
     happensAtIE(change_in_heading(_112),_82),_152=<_82,_82<_158,
     holdsAtProcessedSimpleFluent(_112,withinArea(_112,fishing)=true,_82).

initiatedAt(sarSpeed(_112)=true, _160, _82, _166) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_160=<_82,_82<_166,
     thresholds(sarMinSpeed,_134),
     inRange(_118,_134,inf).

initiatedAt(sarMovement(_112)=true, _128, _82, _134) :-
     happensAtIE(change_in_heading(_112),_82),
     _128=<_82,
     _82<_134.

initiatedAt(sarMovement(_112)=true, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(changingSpeed(_112)=true),_82),
     _138=<_82,
     _82<_144.

terminatedAt(withinArea(_112,_114)=true, _144, _82, _150) :-
     happensAtIE(leavesArea(_112,_120),_82),_144=<_82,_82<_150,
     areaType(_120,_114).

terminatedAt(withinArea(_112,_114)=true, _130, _82, _136) :-
     happensAtIE(gap_start(_112),_82),
     _130=<_82,
     _82<_136.

terminatedAt(gap(_112)=_88, _128, _82, _134) :-
     happensAtIE(gap_end(_112),_82),
     _128=<_82,
     _82<_134.

terminatedAt(stopped(_112)=_88, _128, _82, _134) :-
     happensAtIE(stop_end(_112),_82),
     _128=<_82,
     _82<_134.

terminatedAt(stopped(_112)=_88, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

terminatedAt(lowSpeed(_112)=true, _128, _82, _134) :-
     happensAtIE(slow_motion_end(_112),_82),
     _128=<_82,
     _82<_134.

terminatedAt(lowSpeed(_112)=true, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

terminatedAt(changingSpeed(_112)=true, _128, _82, _134) :-
     happensAtIE(change_in_speed_end(_112),_82),
     _128=<_82,
     _82<_134.

terminatedAt(changingSpeed(_112)=true, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

terminatedAt(highSpeedNearCoast(_112)=true, _160, _82, _166) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_160=<_82,_82<_166,
     thresholds(hcNearCoastMax,_134),
     inRange(_118,0,_134).

terminatedAt(highSpeedNearCoast(_112)=true, _140, _82, _146) :-
     happensAtProcessedSimpleFluent(_112,end(withinArea(_112,nearCoast)=true),_82),
     _140=<_82,
     _82<_146.

terminatedAt(movingSpeed(_112)=_88, _164, _82, _170) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_164=<_82,_82<_170,
     thresholds(movingMin,_134),
     \+inRange(_118,_134,inf).

terminatedAt(movingSpeed(_112)=_88, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

terminatedAt(drifting(_112)=true, _172, _82, _178) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_172=<_82,_82<_178,
     absoluteAngleDiff(_120,_122,_136),
     thresholds(adriftAngThr,_142),
     _136=<_142.

terminatedAt(drifting(_112)=true, _140, _82, _146) :-
     happensAtIE(velocity(_112,_118,_120,511.0),_82),
     _140=<_82,
     _82<_146.

terminatedAt(drifting(_112)=true, _138, _82, _144) :-
     happensAtProcessedSDFluent(_112,end(underWay(_112)=true),_82),
     _138=<_82,
     _82<_144.

terminatedAt(tuggingSpeed(_112)=true, _176, _82, _182) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_176=<_82,_82<_182,
     thresholds(tuggingMin,_134),
     thresholds(tuggingMax,_140),
     \+inRange(_118,_134,_140).

terminatedAt(tuggingSpeed(_112)=true, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

terminatedAt(trawlSpeed(_112)=true, _176, _82, _182) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_176=<_82,_82<_182,
     thresholds(trawlspeedMin,_134),
     thresholds(trawlspeedMax,_140),
     \+inRange(_118,_134,_140).

terminatedAt(trawlSpeed(_112)=true, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

terminatedAt(trawlSpeed(_112)=true, _140, _82, _146) :-
     happensAtProcessedSimpleFluent(_112,end(withinArea(_112,fishing)=true),_82),
     _140=<_82,
     _82<_146.

terminatedAt(trawlingMovement(_112)=true, _140, _82, _146) :-
     happensAtProcessedSimpleFluent(_112,end(withinArea(_112,fishing)=true),_82),
     _140=<_82,
     _82<_146.

terminatedAt(sarSpeed(_112)=true, _160, _82, _166) :-
     happensAtIE(velocity(_112,_118,_120,_122),_82),_160=<_82,_82<_166,
     thresholds(sarMinSpeed,_134),
     inRange(_118,0,_134).

terminatedAt(sarSpeed(_112)=true, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

terminatedAt(sarMovement(_112)=true, _138, _82, _144) :-
     happensAtProcessedSimpleFluent(_112,start(gap(_112)=_122),_82),
     _138=<_82,
     _82<_144.

holdsForSDFluent(underWay(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=below,_128),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=normal,_144),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=above,_160),
     union_all([_128,_144,_160],_82).

holdsForSDFluent(anchoredOrMoored(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_128),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,anchorage)=true,_146),
     intersect_all([_128,_146],_164),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=nearPorts,_180),
     union_all([_164,_180],_198),
     thresholds(aOrMTime,_204),
     intDurGreater(_198,_204,_82).

holdsForSDFluent(tugging(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_132),
     oneIsTug(_112,_114),
     \+oneIsPilot(_112,_114),
     \+twoAreTugs(_112,_114),
     holdsForProcessedSimpleFluent(_112,tuggingSpeed(_112)=true,_174),
     holdsForProcessedSimpleFluent(_114,tuggingSpeed(_114)=true,_190),
     intersect_all([_132,_174,_190],_214),
     thresholds(tuggingTime,_220),
     intDurGreater(_214,_220,_82).

holdsForSDFluent(rendezVous(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_132),
     \+oneIsTug(_112,_114),
     \+oneIsPilot(_112,_114),
     holdsForProcessedSimpleFluent(_112,lowSpeed(_112)=true,_168),
     holdsForProcessedSimpleFluent(_114,lowSpeed(_114)=true,_184),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_200),
     holdsForProcessedSimpleFluent(_114,stopped(_114)=farFromPorts,_216),
     union_all([_168,_200],_234),
     union_all([_184,_216],_252),
     intersect_all([_234,_252,_132],_276),
     _276\=[],
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_300),
     holdsForProcessedSimpleFluent(_114,withinArea(_114,nearPorts)=true,_318),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_336),
     holdsForProcessedSimpleFluent(_114,withinArea(_114,nearCoast)=true,_354),
     relative_complement_all(_276,[_300,_318,_336,_354],_386),
     thresholds(rendezvousTime,_392),
     intDurGreater(_386,_392,_82).

holdsForSDFluent(trawling(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,trawlSpeed(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,trawlingMovement(_112)=true,_144),
     intersect_all([_128,_144],_162),
     thresholds(trawlingTime,_168),
     intDurGreater(_162,_168,_82).

holdsForSDFluent(inSAR(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,sarSpeed(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,sarMovement(_112)=true,_144),
     intersect_all([_128,_144],_162),
     intDurGreater(_162,3600,_82).

holdsForSDFluent(loitering(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,lowSpeed(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_144),
     union_all([_128,_144],_162),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_180),
     holdsForProcessedSDFluent(_112,anchoredOrMoored(_112)=true,_196),
     relative_complement_all(_162,[_180,_196],_216),
     thresholds(loiteringTime,_222),
     intDurGreater(_216,_222,_82).

holdsForSDFluent(pilotOps(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_132),
     oneIsPilot(_112,_114),
     holdsForProcessedSimpleFluent(_112,lowSpeed(_112)=true,_154),
     holdsForProcessedSimpleFluent(_114,lowSpeed(_114)=true,_170),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_186),
     holdsForProcessedSimpleFluent(_114,stopped(_114)=farFromPorts,_202),
     union_all([_154,_186],_220),
     union_all([_170,_202],_238),
     intersect_all([_220,_238,_132],_262),
     _262\=[],
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearCoast)=true,_286),
     holdsForProcessedSimpleFluent(_114,withinArea(_114,nearCoast)=true,_304),
     relative_complement_all(_262,[_286,_304],_82).

holdsForSDFluent(disappearedInArea(_112,_114)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,withinArea(_112,_114)=true,_132),
     holdsForProcessedSimpleFluent(_112,gap(_112)=farFromPorts,_148),
     meets(disappearedInArea(_112,_114)=true,0,_132,_148,union,true,_82).

holdsForSDFluent(stoppedWithinArea(_112,_114)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,withinArea(_112,_114)=true,_132),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_148),
     during(stoppedWithinArea(_112,_114)=true,0,_148,_132,source,true,_82).

holdsForSDFluent(stoppedMeetsGap(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_128),
     holdsForProcessedSimpleFluent(_112,gap(_112)=farFromPorts,_144),
     meets(stoppedMeetsGap(_112)=true,0,_128,_144,union,true,_82).

holdsForSDFluent(highSpeedNCBeforeDrifting(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,highSpeedNearCoast(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,drifting(_112)=true,_144),
     before(highSpeedNCBeforeDrifting(_112)=true,0,_128,_144,union,true,_82).

holdsForSDFluent(dangerNearCoast(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,highSpeedNearCoast(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,drifting(_112)=true,_144),
     overlaps(dangerNearCoast(_112)=true,0,_128,_144,union,true,_82).

holdsForSDFluent(gainingSpeed(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=below,_128),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=normal,_144),
     meets(gainingSpeed(_112)=true,0,_128,_144,union,true,_82).

holdsForSDFluent(speedChangeAbove(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,changingSpeed(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=above,_144),
     starts(speedChangeAbove(_112)=true,0,_128,_144,relative_complement_inverse,true,_82).

holdsForSDFluent(collisionDanger(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_132),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=above,_148),
     holdsForProcessedSimpleFluent(_114,movingSpeed(_114)=above,_164),
     union_all([_148,_164],_182),
     overlaps(collisionDanger(_112,_114)=true,0,_182,_132,intersection,true,_82).

holdsForSDFluent(suspiciousRendezVous(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_132),
     holdsForProcessedSimpleFluent(_112,gap(_112)=_138,_148),
     holdsForProcessedSimpleFluent(_114,gap(_114)=_154,_164),
     union_all([_148,_164],_182),
     during(suspiciousRendezVous(_112,_114)=true,0,_182,_132,lhs,true,_82).

holdsForSDFluent(anchoredFarFromPorts(_112)=true,_82) :-
     holdsForProcessedSDFluent(_112,anchoredOrMoored(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=farFromPorts,_144),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,anchorage)=true,_162),
     intersect_all([_144,_162],_180),
     equal(anchoredFarFromPorts(_112)=true,0,_128,_180,lhs,true,_82).

holdsForSDFluent(anchoredNearPorts(_112)=true,_82) :-
     holdsForProcessedSDFluent(_112,anchoredOrMoored(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,stopped(_112)=nearPorts,_144),
     equal(anchoredNearPorts(_112)=true,0,_128,_144,lhs,true,_82).

holdsForSDFluent(tuggingStartsProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,tugging(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     starts(tuggingStartsProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(tuggingFinishesProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,tugging(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     finishes(tuggingFinishesProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(tuggingEqualProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,tugging(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     equal(tuggingEqualProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(rendezVousStartsProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,rendezVous(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     starts(rendezVousStartsProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(rendezVousFinishesProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,rendezVous(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     finishes(rendezVousFinishesProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(rendezVousEqualProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,rendezVous(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     equal(rendezVousEqualProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(pilotOpsStartsProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,pilotOps(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     starts(pilotOpsStartsProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(pilotOpsFinishesProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,pilotOps(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     finishes(pilotOpsFinishesProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(pilotOpsEqualProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,pilotOps(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     equal(pilotOpsEqualProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(movingSpeedStartsUnderway(_112)=_88,_82) :-
     holdsForProcessedSDFluent(_112,underWay(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=_88,_144),
     starts(movingSpeedStartsUnderway(_112)=_88,0,_144,_128,lhs,true,_82).

holdsForSDFluent(movingSpeedFinishesUnderway(_112)=_88,_82) :-
     holdsForProcessedSDFluent(_112,underWay(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=_88,_144),
     finishes(movingSpeedFinishesUnderway(_112)=_88,0,_144,_128,lhs,true,_82).

holdsForSDFluent(movingSpeedEqualUnderway(_112)=_88,_82) :-
     holdsForProcessedSDFluent(_112,underWay(_112)=true,_128),
     holdsForProcessedSimpleFluent(_112,movingSpeed(_112)=_88,_144),
     equal(movingSpeedEqualUnderway(_112)=_88,0,_144,_128,lhs,true,_82).

holdsForSDFluent(pilotOpsEqualProximity(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,pilotOps(_112,_114)=true,_132),
     holdsForProcessedIE(_112,proximity(_112,_114)=true,_150),
     equal(pilotOpsEqualProximity(_112,_114)=true,0,_132,_150,lhs,true,_82).

holdsForSDFluent(driftingWhileTugging(_112,_114)=true,_82) :-
     holdsForProcessedSDFluent(_112,tugging(_112,_114)=true,_132),
     holdsForProcessedSimpleFluent(_112,drifting(_112)=true,_148),
     holdsForProcessedSimpleFluent(_114,drifting(_114)=true,_164),
     union_all([_148,_164],_182),
     during(driftingWhileTugging(_112,_114)=true,0,_132,_182,union,true,_82).

holdsForSDFluent(fishingTripInArea(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_130),
     holdsForProcessedSimpleFluent(_112,withinArea(_112,fishing)=true,_148),
     before(fishingTripInArea(_112)=true,0,_130,_148,union,true,_158),
     before(fishingTripInArea(_112)=true,1,_158,_130,union,true,_82).

holdsForSDFluent(fishingTripTrawling(_112)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,withinArea(_112,nearPorts)=true,_130),
     holdsForProcessedSDFluent(_112,trawling(_112)=true,_146),
     before(fishingTripTrawling(_112)=true,0,_130,_146,union,true,_156),
     before(fishingTripTrawling(_112)=true,1,_156,_130,union,true,_82).

fi(trawlingMovement(_122)=true,trawlingMovement(_122)=false,_84):-
     thresholds(trawlingCrs,_84),
     grounding(trawlingMovement(_122)=true),
     grounding(trawlingMovement(_122)=false).

fi(sarMovement(_116)=true,sarMovement(_116)=false,1800):-
     grounding(sarMovement(_116)=true),
     grounding(sarMovement(_116)=false).

collectIntervals2(_86, proximity(_86,_88)=true) :-
     vpair(_86,_88).

needsGrounding(_300,_302,_304) :- 
     fail.

grounding(change_in_speed_start(_482)) :- 
     vessel(_482).

grounding(change_in_speed_end(_482)) :- 
     vessel(_482).

grounding(change_in_heading(_482)) :- 
     vessel(_482).

grounding(stop_start(_482)) :- 
     vessel(_482).

grounding(stop_end(_482)) :- 
     vessel(_482).

grounding(slow_motion_start(_482)) :- 
     vessel(_482).

grounding(slow_motion_end(_482)) :- 
     vessel(_482).

grounding(gap_start(_482)) :- 
     vessel(_482).

grounding(gap_end(_482)) :- 
     vessel(_482).

grounding(entersArea(_482,_484)) :- 
     vessel(_482),areaType(_484).

grounding(leavesArea(_482,_484)) :- 
     vessel(_482),areaType(_484).

grounding(coord(_482,_484,_486)) :- 
     vessel(_482).

grounding(velocity(_482,_484,_486,_488)) :- 
     vessel(_482).

grounding(proximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(gap(_488)=_484) :- 
     vessel(_488),portStatus(_484).

grounding(stopped(_488)=_484) :- 
     vessel(_488),portStatus(_484).

grounding(lowSpeed(_488)=true) :- 
     vessel(_488).

grounding(changingSpeed(_488)=true) :- 
     vessel(_488).

grounding(withinArea(_488,_490)=true) :- 
     vessel(_488),areaType(_490).

grounding(underWay(_488)=true) :- 
     vessel(_488).

grounding(sarSpeed(_488)=true) :- 
     vessel(_488),vesselType(_488,sar).

grounding(sarMovement(_488)=true) :- 
     vessel(_488),vesselType(_488,sar).

grounding(sarMovement(_488)=false) :- 
     vessel(_488),vesselType(_488,sar).

grounding(inSAR(_488)=true) :- 
     vessel(_488).

grounding(highSpeedNearCoast(_488)=true) :- 
     vessel(_488).

grounding(drifting(_488)=true) :- 
     vessel(_488).

grounding(anchoredOrMoored(_488)=true) :- 
     vessel(_488).

grounding(trawlSpeed(_488)=true) :- 
     vessel(_488),vesselType(_488,fishing).

grounding(movingSpeed(_488)=_484) :- 
     vessel(_488),movingStatus(_484).

grounding(pilotOps(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(tuggingSpeed(_488)=true) :- 
     vessel(_488).

grounding(tugging(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(rendezVous(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(trawlingMovement(_488)=true) :- 
     vessel(_488),vesselType(_488,fishing).

grounding(trawlingMovement(_488)=false) :- 
     vessel(_488),vesselType(_488,fishing).

grounding(trawling(_488)=true) :- 
     vessel(_488).

grounding(loitering(_488)=true) :- 
     vessel(_488).

grounding(disappearedInArea(_488,_490)=true) :- 
     vessel(_488),areaType(_490).

grounding(stoppedWithinArea(_488,_490)=true) :- 
     vessel(_488),areaType(_490).

grounding(stoppedMeetsGap(_488)=true) :- 
     vessel(_488).

grounding(highSpeedNCBeforeDrifting(_488)=true) :- 
     vessel(_488).

grounding(dangerNearCoast(_488)=true) :- 
     vessel(_488).

grounding(gainingSpeed(_488)=true) :- 
     vessel(_488).

grounding(speedChangeAbove(_488)=true) :- 
     vessel(_488).

grounding(anchoredFarFromPorts(_488)=true) :- 
     vessel(_488).

grounding(anchoredNearPorts(_488)=true) :- 
     vessel(_488).

grounding(tuggingStartsProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(tuggingFinishesProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(tuggingEqualProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(rendezVousStartsProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(rendezVousFinishesProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(rendezVousEqualProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(pilotOpsStartsProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(pilotOpsFinishesProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(pilotOpsEqualProximity(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(movingSpeedStartsUnderway(_488)=below) :- 
     vessel(_488).

grounding(movingSpeedFinishesUnderway(_488)=below) :- 
     vessel(_488).

grounding(movingSpeedEqualUnderway(_488)=below) :- 
     vessel(_488).

grounding(collisionDanger(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(suspiciousRendezVous(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(driftingWhileTugging(_488,_490)=true) :- 
     vpair(_488,_490).

grounding(fishingTripInArea(_488)=true) :- 
     vessel(_488).

grounding(fishingTripTrawling(_488)=true) :- 
     vessel(_488).

p(trawlingMovement(_482)=true).

p(sarMovement(_482)=true).

inputEntity(entersArea(_136,_138)).
inputEntity(gap_start(_136)).
inputEntity(stop_start(_136)).
inputEntity(slow_motion_start(_136)).
inputEntity(change_in_speed_start(_136)).
inputEntity(velocity(_136,_138,_140,_142)).
inputEntity(change_in_heading(_136)).
inputEntity(leavesArea(_136,_138)).
inputEntity(gap_end(_136)).
inputEntity(stop_end(_136)).
inputEntity(slow_motion_end(_136)).
inputEntity(change_in_speed_end(_136)).
inputEntity(proximity(_142,_144)=true).
inputEntity(coord(_136,_138,_140)).

outputEntity(withinArea(_282,_284)=true).
outputEntity(gap(_282)=nearPorts).
outputEntity(gap(_282)=farFromPorts).
outputEntity(stopped(_282)=nearPorts).
outputEntity(stopped(_282)=farFromPorts).
outputEntity(lowSpeed(_282)=true).
outputEntity(changingSpeed(_282)=true).
outputEntity(highSpeedNearCoast(_282)=true).
outputEntity(movingSpeed(_282)=below).
outputEntity(movingSpeed(_282)=normal).
outputEntity(movingSpeed(_282)=above).
outputEntity(drifting(_282)=true).
outputEntity(tuggingSpeed(_282)=true).
outputEntity(trawlSpeed(_282)=true).
outputEntity(trawlingMovement(_282)=true).
outputEntity(sarSpeed(_282)=true).
outputEntity(sarMovement(_282)=true).
outputEntity(trawlingMovement(_282)=false).
outputEntity(sarMovement(_282)=false).
outputEntity(underWay(_282)=true).
outputEntity(anchoredOrMoored(_282)=true).
outputEntity(tugging(_282,_284)=true).
outputEntity(rendezVous(_282,_284)=true).
outputEntity(trawling(_282)=true).
outputEntity(inSAR(_282)=true).
outputEntity(loitering(_282)=true).
outputEntity(pilotOps(_282,_284)=true).
outputEntity(disappearedInArea(_282,_284)=true).
outputEntity(stoppedWithinArea(_282,_284)=true).
outputEntity(stoppedMeetsGap(_282)=true).
outputEntity(highSpeedNCBeforeDrifting(_282)=true).
outputEntity(dangerNearCoast(_282)=true).
outputEntity(gainingSpeed(_282)=true).
outputEntity(speedChangeAbove(_282)=true).
outputEntity(collisionDanger(_282,_284)=true).
outputEntity(suspiciousRendezVous(_282,_284)=true).
outputEntity(anchoredFarFromPorts(_282)=true).
outputEntity(anchoredNearPorts(_282)=true).
outputEntity(tuggingStartsProximity(_282,_284)=true).
outputEntity(tuggingFinishesProximity(_282,_284)=true).
outputEntity(tuggingEqualProximity(_282,_284)=true).
outputEntity(rendezVousStartsProximity(_282,_284)=true).
outputEntity(rendezVousFinishesProximity(_282,_284)=true).
outputEntity(rendezVousEqualProximity(_282,_284)=true).
outputEntity(pilotOpsStartsProximity(_282,_284)=true).
outputEntity(pilotOpsFinishesProximity(_282,_284)=true).
outputEntity(pilotOpsEqualProximity(_282,_284)=true).
outputEntity(movingSpeedStartsUnderway(_282)=below).
outputEntity(movingSpeedFinishesUnderway(_282)=below).
outputEntity(movingSpeedEqualUnderway(_282)=below).
outputEntity(driftingWhileTugging(_282,_284)=true).
outputEntity(fishingTripInArea(_282)=true).
outputEntity(fishingTripTrawling(_282)=true).

event(entersArea(_650,_652)).
event(gap_start(_650)).
event(stop_start(_650)).
event(slow_motion_start(_650)).
event(change_in_speed_start(_650)).
event(velocity(_650,_652,_654,_656)).
event(change_in_heading(_650)).
event(leavesArea(_650,_652)).
event(gap_end(_650)).
event(stop_end(_650)).
event(slow_motion_end(_650)).
event(change_in_speed_end(_650)).
event(coord(_650,_652,_654)).

simpleFluent(withinArea(_790,_792)=true).
simpleFluent(gap(_790)=nearPorts).
simpleFluent(gap(_790)=farFromPorts).
simpleFluent(stopped(_790)=nearPorts).
simpleFluent(stopped(_790)=farFromPorts).
simpleFluent(lowSpeed(_790)=true).
simpleFluent(changingSpeed(_790)=true).
simpleFluent(highSpeedNearCoast(_790)=true).
simpleFluent(movingSpeed(_790)=below).
simpleFluent(movingSpeed(_790)=normal).
simpleFluent(movingSpeed(_790)=above).
simpleFluent(drifting(_790)=true).
simpleFluent(tuggingSpeed(_790)=true).
simpleFluent(trawlSpeed(_790)=true).
simpleFluent(trawlingMovement(_790)=true).
simpleFluent(sarSpeed(_790)=true).
simpleFluent(sarMovement(_790)=true).
simpleFluent(trawlingMovement(_790)=false).
simpleFluent(sarMovement(_790)=false).


sDFluent(underWay(_1016)=true).
sDFluent(anchoredOrMoored(_1016)=true).
sDFluent(tugging(_1016,_1018)=true).
sDFluent(rendezVous(_1016,_1018)=true).
sDFluent(trawling(_1016)=true).
sDFluent(inSAR(_1016)=true).
sDFluent(loitering(_1016)=true).
sDFluent(pilotOps(_1016,_1018)=true).
sDFluent(disappearedInArea(_1016,_1018)=true).
sDFluent(stoppedWithinArea(_1016,_1018)=true).
sDFluent(stoppedMeetsGap(_1016)=true).
sDFluent(highSpeedNCBeforeDrifting(_1016)=true).
sDFluent(dangerNearCoast(_1016)=true).
sDFluent(gainingSpeed(_1016)=true).
sDFluent(speedChangeAbove(_1016)=true).
sDFluent(collisionDanger(_1016,_1018)=true).
sDFluent(suspiciousRendezVous(_1016,_1018)=true).
sDFluent(anchoredFarFromPorts(_1016)=true).
sDFluent(anchoredNearPorts(_1016)=true).
sDFluent(tuggingStartsProximity(_1016,_1018)=true).
sDFluent(tuggingFinishesProximity(_1016,_1018)=true).
sDFluent(tuggingEqualProximity(_1016,_1018)=true).
sDFluent(rendezVousStartsProximity(_1016,_1018)=true).
sDFluent(rendezVousFinishesProximity(_1016,_1018)=true).
sDFluent(rendezVousEqualProximity(_1016,_1018)=true).
sDFluent(pilotOpsStartsProximity(_1016,_1018)=true).
sDFluent(pilotOpsFinishesProximity(_1016,_1018)=true).
sDFluent(pilotOpsEqualProximity(_1016,_1018)=true).
sDFluent(movingSpeedStartsUnderway(_1016)=below).
sDFluent(movingSpeedFinishesUnderway(_1016)=below).
sDFluent(movingSpeedEqualUnderway(_1016)=below).
sDFluent(driftingWhileTugging(_1016,_1018)=true).
sDFluent(fishingTripInArea(_1016)=true).
sDFluent(fishingTripTrawling(_1016)=true).
sDFluent(proximity(_1016,_1018)=true).

index(entersArea(_1228,_1282),_1228).
index(gap_start(_1228),_1228).
index(stop_start(_1228),_1228).
index(slow_motion_start(_1228),_1228).
index(change_in_speed_start(_1228),_1228).
index(velocity(_1228,_1282,_1284,_1286),_1228).
index(change_in_heading(_1228),_1228).
index(leavesArea(_1228,_1282),_1228).
index(gap_end(_1228),_1228).
index(stop_end(_1228),_1228).
index(slow_motion_end(_1228),_1228).
index(change_in_speed_end(_1228),_1228).
index(coord(_1228,_1282,_1284),_1228).
index(withinArea(_1228,_1288)=true,_1228).
index(gap(_1228)=nearPorts,_1228).
index(gap(_1228)=farFromPorts,_1228).
index(stopped(_1228)=nearPorts,_1228).
index(stopped(_1228)=farFromPorts,_1228).
index(lowSpeed(_1228)=true,_1228).
index(changingSpeed(_1228)=true,_1228).
index(highSpeedNearCoast(_1228)=true,_1228).
index(movingSpeed(_1228)=below,_1228).
index(movingSpeed(_1228)=normal,_1228).
index(movingSpeed(_1228)=above,_1228).
index(drifting(_1228)=true,_1228).
index(tuggingSpeed(_1228)=true,_1228).
index(trawlSpeed(_1228)=true,_1228).
index(trawlingMovement(_1228)=true,_1228).
index(sarSpeed(_1228)=true,_1228).
index(sarMovement(_1228)=true,_1228).
index(trawlingMovement(_1228)=false,_1228).
index(sarMovement(_1228)=false,_1228).
index(underWay(_1228)=true,_1228).
index(anchoredOrMoored(_1228)=true,_1228).
index(tugging(_1228,_1288)=true,_1228).
index(rendezVous(_1228,_1288)=true,_1228).
index(trawling(_1228)=true,_1228).
index(inSAR(_1228)=true,_1228).
index(loitering(_1228)=true,_1228).
index(pilotOps(_1228,_1288)=true,_1228).
index(disappearedInArea(_1228,_1288)=true,_1228).
index(stoppedWithinArea(_1228,_1288)=true,_1228).
index(stoppedMeetsGap(_1228)=true,_1228).
index(highSpeedNCBeforeDrifting(_1228)=true,_1228).
index(dangerNearCoast(_1228)=true,_1228).
index(gainingSpeed(_1228)=true,_1228).
index(speedChangeAbove(_1228)=true,_1228).
index(collisionDanger(_1228,_1288)=true,_1228).
index(suspiciousRendezVous(_1228,_1288)=true,_1228).
index(anchoredFarFromPorts(_1228)=true,_1228).
index(anchoredNearPorts(_1228)=true,_1228).
index(tuggingStartsProximity(_1228,_1288)=true,_1228).
index(tuggingFinishesProximity(_1228,_1288)=true,_1228).
index(tuggingEqualProximity(_1228,_1288)=true,_1228).
index(rendezVousStartsProximity(_1228,_1288)=true,_1228).
index(rendezVousFinishesProximity(_1228,_1288)=true,_1228).
index(rendezVousEqualProximity(_1228,_1288)=true,_1228).
index(pilotOpsStartsProximity(_1228,_1288)=true,_1228).
index(pilotOpsFinishesProximity(_1228,_1288)=true,_1228).
index(pilotOpsEqualProximity(_1228,_1288)=true,_1228).
index(movingSpeedStartsUnderway(_1228)=below,_1228).
index(movingSpeedFinishesUnderway(_1228)=below,_1228).
index(movingSpeedEqualUnderway(_1228)=below,_1228).
index(driftingWhileTugging(_1228,_1288)=true,_1228).
index(fishingTripInArea(_1228)=true,_1228).
index(fishingTripTrawling(_1228)=true,_1228).
index(proximity(_1228,_1288)=true,_1228).


cachingOrder2(_1864, withinArea(_1864,_1866)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1864),areaType(_1866).

cachingOrder2(_2114, gap(_2114)=farFromPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2114),portStatus(farFromPorts).

cachingOrder2(_2130, gap(_2130)=nearPorts) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_2130),portStatus(nearPorts).

cachingOrder2(_2092, highSpeedNearCoast(_2092)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2092).

cachingOrder2(_2054, trawlingMovement(_2054)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2054),vesselType(_2054,fishing).

cachingOrder2(_2054, trawlingMovement(_2054)=false) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_2054),vesselType(_2054,fishing).

cachingOrder2(_2032, fishingTripInArea(_2032)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_2032).

cachingOrder2(_2876, stopped(_2876)=farFromPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2876),portStatus(farFromPorts).

cachingOrder2(_2892, stopped(_2892)=nearPorts) :- % level in dependency graph: 3, processing order in component: 2
     vessel(_2892),portStatus(nearPorts).

cachingOrder2(_2854, lowSpeed(_2854)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2854).

cachingOrder2(_2832, changingSpeed(_2832)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2832).

cachingOrder2(_2778, movingSpeed(_2778)=above) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2778),movingStatus(above).

cachingOrder2(_2794, movingSpeed(_2794)=normal) :- % level in dependency graph: 3, processing order in component: 2
     vessel(_2794),movingStatus(normal).

cachingOrder2(_2810, movingSpeed(_2810)=below) :- % level in dependency graph: 3, processing order in component: 3
     vessel(_2810),movingStatus(below).

cachingOrder2(_2756, tuggingSpeed(_2756)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2756).

cachingOrder2(_2734, trawlSpeed(_2734)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2734),vesselType(_2734,fishing).

cachingOrder2(_2712, sarSpeed(_2712)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2712),vesselType(_2712,sar).

cachingOrder2(_2688, disappearedInArea(_2688,_2690)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2688),areaType(_2690).

cachingOrder2(_2664, suspiciousRendezVous(_2664,_2666)=true) :- % level in dependency graph: 3, processing order in component: 1
     vpair(_2664,_2666).

cachingOrder2(_4172, sarMovement(_4172)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_4172),vesselType(_4172,sar).

cachingOrder2(_4172, sarMovement(_4172)=false) :- % level in dependency graph: 4, processing order in component: 2
     vessel(_4172),vesselType(_4172,sar).

cachingOrder2(_4150, underWay(_4150)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_4150).

cachingOrder2(_4128, anchoredOrMoored(_4128)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_4128).

cachingOrder2(_4104, tugging(_4104,_4106)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_4104,_4106).

cachingOrder2(_4080, rendezVous(_4080,_4082)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_4080,_4082).

cachingOrder2(_4058, trawling(_4058)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_4058).

cachingOrder2(_4034, pilotOps(_4034,_4036)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_4034,_4036).

cachingOrder2(_4010, stoppedWithinArea(_4010,_4012)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_4010),areaType(_4012).

cachingOrder2(_3988, stoppedMeetsGap(_3988)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3988).

cachingOrder2(_3966, gainingSpeed(_3966)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3966).

cachingOrder2(_3944, speedChangeAbove(_3944)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3944).

cachingOrder2(_3920, collisionDanger(_3920,_3922)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3920,_3922).

cachingOrder2(_5682, drifting(_5682)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5682).

cachingOrder2(_5660, inSAR(_5660)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5660).

cachingOrder2(_5638, loitering(_5638)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5638).

cachingOrder2(_5616, anchoredFarFromPorts(_5616)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5616).

cachingOrder2(_5594, anchoredNearPorts(_5594)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5594).

cachingOrder2(_5570, tuggingStartsProximity(_5570,_5572)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5570,_5572).

cachingOrder2(_5546, tuggingFinishesProximity(_5546,_5548)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5546,_5548).

cachingOrder2(_5522, tuggingEqualProximity(_5522,_5524)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5522,_5524).

cachingOrder2(_5498, rendezVousStartsProximity(_5498,_5500)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5498,_5500).

cachingOrder2(_5474, rendezVousFinishesProximity(_5474,_5476)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5474,_5476).

cachingOrder2(_5450, rendezVousEqualProximity(_5450,_5452)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5450,_5452).

cachingOrder2(_5426, pilotOpsStartsProximity(_5426,_5428)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5426,_5428).

cachingOrder2(_5402, pilotOpsFinishesProximity(_5402,_5404)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5402,_5404).

cachingOrder2(_5378, pilotOpsEqualProximity(_5378,_5380)=true) :- % level in dependency graph: 5, processing order in component: 1
     vpair(_5378,_5380).

cachingOrder2(_5356, movingSpeedStartsUnderway(_5356)=below) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5356).

cachingOrder2(_5334, movingSpeedFinishesUnderway(_5334)=below) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5334).

cachingOrder2(_5312, movingSpeedEqualUnderway(_5312)=below) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5312).

cachingOrder2(_5290, fishingTripTrawling(_5290)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_5290).

cachingOrder2(_7220, highSpeedNCBeforeDrifting(_7220)=true) :- % level in dependency graph: 6, processing order in component: 1
     vessel(_7220).

cachingOrder2(_7198, dangerNearCoast(_7198)=true) :- % level in dependency graph: 6, processing order in component: 1
     vessel(_7198).

cachingOrder2(_7174, driftingWhileTugging(_7174,_7176)=true) :- % level in dependency graph: 6, processing order in component: 1
     vpair(_7174,_7176).

collectGrounds([entersArea(_682,_696), gap_start(_682), stop_start(_682), slow_motion_start(_682), change_in_speed_start(_682), velocity(_682,_696,_698,_700), change_in_heading(_682), leavesArea(_682,_696), gap_end(_682), stop_end(_682), slow_motion_end(_682), change_in_speed_end(_682), coord(_682,_696,_698)],vessel(_682)).

collectGrounds([proximity(_670,_672)=true],vpair(_670,_672)).

dgrounded(withinArea(_2662,_2664)=true, vessel(_2662)).
dgrounded(gap(_2620)=nearPorts, vessel(_2620)).
dgrounded(gap(_2578)=farFromPorts, vessel(_2578)).
dgrounded(stopped(_2536)=nearPorts, vessel(_2536)).
dgrounded(stopped(_2494)=farFromPorts, vessel(_2494)).
dgrounded(lowSpeed(_2462)=true, vessel(_2462)).
dgrounded(changingSpeed(_2430)=true, vessel(_2430)).
dgrounded(highSpeedNearCoast(_2398)=true, vessel(_2398)).
dgrounded(movingSpeed(_2356)=below, vessel(_2356)).
dgrounded(movingSpeed(_2314)=normal, vessel(_2314)).
dgrounded(movingSpeed(_2272)=above, vessel(_2272)).
dgrounded(drifting(_2240)=true, vessel(_2240)).
dgrounded(tuggingSpeed(_2208)=true, vessel(_2208)).
dgrounded(trawlSpeed(_2164)=true, vessel(_2164)).
dgrounded(trawlingMovement(_2120)=true, vessel(_2120)).
dgrounded(sarSpeed(_2076)=true, vessel(_2076)).
dgrounded(sarMovement(_2032)=true, vessel(_2032)).
dgrounded(trawlingMovement(_1988)=false, vessel(_1988)).
dgrounded(sarMovement(_1944)=false, vessel(_1944)).
dgrounded(underWay(_1912)=true, vessel(_1912)).
dgrounded(anchoredOrMoored(_1880)=true, vessel(_1880)).
dgrounded(tugging(_1844,_1846)=true, vpair(_1844,_1846)).
dgrounded(rendezVous(_1808,_1810)=true, vpair(_1808,_1810)).
dgrounded(trawling(_1776)=true, vessel(_1776)).
dgrounded(inSAR(_1744)=true, vessel(_1744)).
dgrounded(loitering(_1712)=true, vessel(_1712)).
dgrounded(pilotOps(_1676,_1678)=true, vpair(_1676,_1678)).
dgrounded(disappearedInArea(_1632,_1634)=true, vessel(_1632)).
dgrounded(stoppedWithinArea(_1588,_1590)=true, vessel(_1588)).
dgrounded(stoppedMeetsGap(_1556)=true, vessel(_1556)).
dgrounded(highSpeedNCBeforeDrifting(_1524)=true, vessel(_1524)).
dgrounded(dangerNearCoast(_1492)=true, vessel(_1492)).
dgrounded(gainingSpeed(_1460)=true, vessel(_1460)).
dgrounded(speedChangeAbove(_1428)=true, vessel(_1428)).
dgrounded(collisionDanger(_1392,_1394)=true, vpair(_1392,_1394)).
dgrounded(suspiciousRendezVous(_1356,_1358)=true, vpair(_1356,_1358)).
dgrounded(anchoredFarFromPorts(_1324)=true, vessel(_1324)).
dgrounded(anchoredNearPorts(_1292)=true, vessel(_1292)).
dgrounded(tuggingStartsProximity(_1256,_1258)=true, vpair(_1256,_1258)).
dgrounded(tuggingFinishesProximity(_1220,_1222)=true, vpair(_1220,_1222)).
dgrounded(tuggingEqualProximity(_1184,_1186)=true, vpair(_1184,_1186)).
dgrounded(rendezVousStartsProximity(_1148,_1150)=true, vpair(_1148,_1150)).
dgrounded(rendezVousFinishesProximity(_1112,_1114)=true, vpair(_1112,_1114)).
dgrounded(rendezVousEqualProximity(_1076,_1078)=true, vpair(_1076,_1078)).
dgrounded(pilotOpsStartsProximity(_1040,_1042)=true, vpair(_1040,_1042)).
dgrounded(pilotOpsFinishesProximity(_1004,_1006)=true, vpair(_1004,_1006)).
dgrounded(pilotOpsEqualProximity(_968,_970)=true, vpair(_968,_970)).
dgrounded(movingSpeedStartsUnderway(_936)=below, vessel(_936)).
dgrounded(movingSpeedFinishesUnderway(_904)=below, vessel(_904)).
dgrounded(movingSpeedEqualUnderway(_872)=below, vessel(_872)).
dgrounded(driftingWhileTugging(_836,_838)=true, vpair(_836,_838)).
dgrounded(fishingTripInArea(_804)=true, vessel(_804)).
dgrounded(fishingTripTrawling(_772)=true, vessel(_772)).
