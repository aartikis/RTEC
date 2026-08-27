:- dynamic vessel/1, vpair/2.

initiatedAt(withinArea(_122,_124)=true, _154, _92, _160) :-
     happensAtIE(entersArea(_122,_130),_92),_154=<_92,_92<_160,
     areaType(_130,_124).

initiatedAt(gap(_122)=nearPorts, _162, _92, _168) :-
     happensAtIE(gap_start(_122),_92),_162=<_92,_92<_168,
     holdsAtProcessedSimpleFluent(_122,withinArea(_122,nearPorts)=true,_92).

initiatedAt(gap(_122)=farFromPorts, _166, _92, _172) :-
     happensAtIE(gap_start(_122),_92),_166=<_92,_92<_172,
     \+holdsAtProcessedSimpleFluent(_122,withinArea(_122,nearPorts)=true,_92).

initiatedAt(stopped(_122)=nearPorts, _162, _92, _168) :-
     happensAtIE(stop_start(_122),_92),_162=<_92,_92<_168,
     holdsAtProcessedSimpleFluent(_122,withinArea(_122,nearPorts)=true,_92).

initiatedAt(stopped(_122)=farFromPorts, _166, _92, _172) :-
     happensAtIE(stop_start(_122),_92),_166=<_92,_92<_172,
     \+holdsAtProcessedSimpleFluent(_122,withinArea(_122,nearPorts)=true,_92).

initiatedAt(lowSpeed(_122)=true, _138, _92, _144) :-
     happensAtIE(slow_motion_start(_122),_92),
     _138=<_92,
     _92<_144.

initiatedAt(changingSpeed(_122)=true, _138, _92, _144) :-
     happensAtIE(change_in_speed_start(_122),_92),
     _138=<_92,
     _92<_144.

initiatedAt(highSpeedNearCoast(_122)=true, _198, _92, _204) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_198=<_92,_92<_204,
     thresholds(hcNearCoastMax,_144),
     \+inRange(_128,0,_144),
     holdsAtProcessedSimpleFluent(_122,withinArea(_122,nearCoast)=true,_92).

initiatedAt(movingSpeed(_122)=below, _198, _92, _204) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_198=<_92,_92<_204,
     vesselType(_122,_144),
     typeSpeed(_144,_150,_152,_154),
     thresholds(movingMin,_160),
     inRange(_128,_160,_150).

initiatedAt(movingSpeed(_122)=normal, _186, _92, _192) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_186=<_92,_92<_192,
     vesselType(_122,_144),
     typeSpeed(_144,_150,_152,_154),
     inRange(_128,_150,_152).

initiatedAt(movingSpeed(_122)=above, _186, _92, _192) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_186=<_92,_92<_192,
     vesselType(_122,_144),
     typeSpeed(_144,_150,_152,_154),
     inRange(_128,_152,inf).

initiatedAt(drifting(_122)=true, _222, _92, _228) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_222=<_92,_92<_228,
     _132=\=511.0,
     absoluteAngleDiff(_130,_132,_158),
     thresholds(adriftAngThr,_164),
     _158>_164,
     holdsAtProcessedSDFluent(_122,underWay(_122)=true,_92).

initiatedAt(tuggingSpeed(_122)=true, _182, _92, _188) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_182=<_92,_92<_188,
     thresholds(tuggingMin,_144),
     thresholds(tuggingMax,_150),
     inRange(_128,_144,_150).

initiatedAt(trawlSpeed(_122)=true, _206, _92, _212) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_206=<_92,_92<_212,
     thresholds(trawlspeedMin,_144),
     thresholds(trawlspeedMax,_150),
     inRange(_128,_144,_150),
     holdsAtProcessedSimpleFluent(_122,withinArea(_122,fishing)=true,_92).

initiatedAt(trawlingMovement(_122)=true, _162, _92, _168) :-
     happensAtIE(change_in_heading(_122),_92),_162=<_92,_92<_168,
     holdsAtProcessedSimpleFluent(_122,withinArea(_122,fishing)=true,_92).

initiatedAt(sarSpeed(_122)=true, _170, _92, _176) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_170=<_92,_92<_176,
     thresholds(sarMinSpeed,_144),
     inRange(_128,_144,inf).

initiatedAt(sarMovement(_122)=true, _138, _92, _144) :-
     happensAtIE(change_in_heading(_122),_92),
     _138=<_92,
     _92<_144.

initiatedAt(sarMovement(_122)=true, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(changingSpeed(_122)=true),_92),
     _148=<_92,
     _92<_154.

terminatedAt(withinArea(_122,_124)=true, _154, _92, _160) :-
     happensAtIE(leavesArea(_122,_130),_92),_154=<_92,_92<_160,
     areaType(_130,_124).

terminatedAt(withinArea(_122,_124)=true, _140, _92, _146) :-
     happensAtIE(gap_start(_122),_92),
     _140=<_92,
     _92<_146.

terminatedAt(gap(_122)=_98, _138, _92, _144) :-
     happensAtIE(gap_end(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(stopped(_122)=_98, _138, _92, _144) :-
     happensAtIE(stop_end(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(stopped(_122)=_98, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

terminatedAt(lowSpeed(_122)=true, _138, _92, _144) :-
     happensAtIE(slow_motion_end(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(lowSpeed(_122)=true, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

terminatedAt(changingSpeed(_122)=true, _138, _92, _144) :-
     happensAtIE(change_in_speed_end(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(changingSpeed(_122)=true, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

terminatedAt(highSpeedNearCoast(_122)=true, _170, _92, _176) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_170=<_92,_92<_176,
     thresholds(hcNearCoastMax,_144),
     inRange(_128,0,_144).

terminatedAt(highSpeedNearCoast(_122)=true, _150, _92, _156) :-
     happensAtProcessedSimpleFluent(_122,end(withinArea(_122,nearCoast)=true),_92),
     _150=<_92,
     _92<_156.

terminatedAt(movingSpeed(_122)=_98, _174, _92, _180) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_174=<_92,_92<_180,
     thresholds(movingMin,_144),
     \+inRange(_128,_144,inf).

terminatedAt(movingSpeed(_122)=_98, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

terminatedAt(drifting(_122)=true, _182, _92, _188) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_182=<_92,_92<_188,
     absoluteAngleDiff(_130,_132,_146),
     thresholds(adriftAngThr,_152),
     _146=<_152.

terminatedAt(drifting(_122)=true, _150, _92, _156) :-
     happensAtIE(velocity(_122,_128,_130,511.0),_92),
     _150=<_92,
     _92<_156.

terminatedAt(drifting(_122)=true, _148, _92, _154) :-
     happensAtProcessedSDFluent(_122,end(underWay(_122)=true),_92),
     _148=<_92,
     _92<_154.

terminatedAt(tuggingSpeed(_122)=true, _186, _92, _192) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_186=<_92,_92<_192,
     thresholds(tuggingMin,_144),
     thresholds(tuggingMax,_150),
     \+inRange(_128,_144,_150).

terminatedAt(tuggingSpeed(_122)=true, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

terminatedAt(trawlSpeed(_122)=true, _186, _92, _192) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_186=<_92,_92<_192,
     thresholds(trawlspeedMin,_144),
     thresholds(trawlspeedMax,_150),
     \+inRange(_128,_144,_150).

terminatedAt(trawlSpeed(_122)=true, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

terminatedAt(trawlSpeed(_122)=true, _150, _92, _156) :-
     happensAtProcessedSimpleFluent(_122,end(withinArea(_122,fishing)=true),_92),
     _150=<_92,
     _92<_156.

terminatedAt(trawlingMovement(_122)=true, _150, _92, _156) :-
     happensAtProcessedSimpleFluent(_122,end(withinArea(_122,fishing)=true),_92),
     _150=<_92,
     _92<_156.

terminatedAt(sarSpeed(_122)=true, _170, _92, _176) :-
     happensAtIE(velocity(_122,_128,_130,_132),_92),_170=<_92,_92<_176,
     thresholds(sarMinSpeed,_144),
     inRange(_128,0,_144).

terminatedAt(sarSpeed(_122)=true, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

terminatedAt(sarMovement(_122)=true, _148, _92, _154) :-
     happensAtProcessedSimpleFluent(_122,start(gap(_122)=_132),_92),
     _148=<_92,
     _92<_154.

holdsForSDFluent(stopped2high(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,stopped(_122)=nearPorts,_138),
     holdsForProcessedSimpleFluent(_122,movingSpeed(_122)=above,_154),
     rct_computation_formula(seq,1,stopped2high(_122)=true,[stopped(_122)=nearPorts,movingSpeed(_122)=above],[_138,_154],_92).

holdsForSDFluent(stopped2high2stopped(_122)=true,_92) :-
     holdsForProcessedSDFluent(_122,stopped2high(_122)=true,_138),
     holdsForProcessedSimpleFluent(_122,stopped(_122)=farFromPorts,_154),
     rct_computation_formula(seq,2,stopped2high2stopped(_122)=true,[stopped2high(_122)=true,stopped(_122)=farFromPorts],[_138,_154],_92).

holdsForSDFluent(underWay(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,movingSpeed(_122)=below,_138),
     holdsForProcessedSimpleFluent(_122,movingSpeed(_122)=normal,_154),
     holdsForProcessedSimpleFluent(_122,movingSpeed(_122)=above,_170),
     union_all([_138,_154,_170],_92).

holdsForSDFluent(anchoredOrMoored(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,stopped(_122)=farFromPorts,_138),
     holdsForProcessedSimpleFluent(_122,withinArea(_122,anchorage)=true,_156),
     intersect_all([_138,_156],_174),
     holdsForProcessedSimpleFluent(_122,stopped(_122)=nearPorts,_190),
     union_all([_174,_190],_208),
     thresholds(aOrMTime,_214),
     intDurGreater(_208,_214,_92).

holdsForSDFluent(tugging(_122,_124)=true,_92) :-
     holdsForProcessedIE(_122,proximity(_122,_124)=true,_142),
     oneIsTug(_122,_124),
     \+oneIsPilot(_122,_124),
     \+twoAreTugs(_122,_124),
     holdsForProcessedSimpleFluent(_122,tuggingSpeed(_122)=true,_184),
     holdsForProcessedSimpleFluent(_124,tuggingSpeed(_124)=true,_200),
     intersect_all([_142,_184,_200],_224),
     thresholds(tuggingTime,_230),
     intDurGreater(_224,_230,_92).

holdsForSDFluent(rendezVous(_122,_124)=true,_92) :-
     holdsForProcessedIE(_122,proximity(_122,_124)=true,_142),
     \+oneIsTug(_122,_124),
     \+oneIsPilot(_122,_124),
     holdsForProcessedSimpleFluent(_122,lowSpeed(_122)=true,_178),
     holdsForProcessedSimpleFluent(_124,lowSpeed(_124)=true,_194),
     holdsForProcessedSimpleFluent(_122,stopped(_122)=farFromPorts,_210),
     holdsForProcessedSimpleFluent(_124,stopped(_124)=farFromPorts,_226),
     union_all([_178,_210],_244),
     union_all([_194,_226],_262),
     intersect_all([_244,_262,_142],_286),
     _286\=[],
     holdsForProcessedSimpleFluent(_122,withinArea(_122,nearPorts)=true,_310),
     holdsForProcessedSimpleFluent(_124,withinArea(_124,nearPorts)=true,_328),
     holdsForProcessedSimpleFluent(_122,withinArea(_122,nearCoast)=true,_346),
     holdsForProcessedSimpleFluent(_124,withinArea(_124,nearCoast)=true,_364),
     relative_complement_all(_286,[_310,_328,_346,_364],_396),
     thresholds(rendezvousTime,_402),
     intDurGreater(_396,_402,_92).

holdsForSDFluent(trawling(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,trawlSpeed(_122)=true,_138),
     holdsForProcessedSimpleFluent(_122,trawlingMovement(_122)=true,_154),
     intersect_all([_138,_154],_172),
     thresholds(trawlingTime,_178),
     intDurGreater(_172,_178,_92).

holdsForSDFluent(inSAR(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,sarSpeed(_122)=true,_138),
     holdsForProcessedSimpleFluent(_122,sarMovement(_122)=true,_154),
     intersect_all([_138,_154],_172),
     intDurGreater(_172,3600,_92).

holdsForSDFluent(loitering(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,lowSpeed(_122)=true,_138),
     holdsForProcessedSimpleFluent(_122,stopped(_122)=farFromPorts,_154),
     union_all([_138,_154],_172),
     holdsForProcessedSimpleFluent(_122,withinArea(_122,nearCoast)=true,_190),
     holdsForProcessedSDFluent(_122,anchoredOrMoored(_122)=true,_206),
     relative_complement_all(_172,[_190,_206],_226),
     thresholds(loiteringTime,_232),
     intDurGreater(_226,_232,_92).

holdsForSDFluent(pilotOps(_122,_124)=true,_92) :-
     holdsForProcessedIE(_122,proximity(_122,_124)=true,_142),
     oneIsPilot(_122,_124),
     holdsForProcessedSimpleFluent(_122,lowSpeed(_122)=true,_164),
     holdsForProcessedSimpleFluent(_124,lowSpeed(_124)=true,_180),
     holdsForProcessedSimpleFluent(_122,stopped(_122)=farFromPorts,_196),
     holdsForProcessedSimpleFluent(_124,stopped(_124)=farFromPorts,_212),
     union_all([_164,_196],_230),
     union_all([_180,_212],_248),
     intersect_all([_230,_248,_142],_272),
     _272\=[],
     holdsForProcessedSimpleFluent(_122,withinArea(_122,nearCoast)=true,_296),
     holdsForProcessedSimpleFluent(_124,withinArea(_124,nearCoast)=true,_314),
     relative_complement_all(_272,[_296,_314],_92).

fi(trawlingMovement(_132)=true,trawlingMovement(_132)=false,_94):-
     thresholds(trawlingCrs,_94),
     grounding(trawlingMovement(_132)=true),
     grounding(trawlingMovement(_132)=false).

fi(sarMovement(_126)=true,sarMovement(_126)=false,1800):-
     grounding(sarMovement(_126)=true),
     grounding(sarMovement(_126)=false).

collectIntervals2(_96, proximity(_96,_98)=true) :-
     vpair(_96,_98).

needsGrounding(_282,_284,_286) :- 
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

grounding(stopped2high(_470)=true) :- 
     vessel(_470).

grounding(stopped2high2stopped(_470)=true) :- 
     vessel(_470).

grounding(transhipment(_470,_472)=true) :- 
     vpair(_470,_472).

p(trawlingMovement(_464)=true).

p(sarMovement(_464)=true).

inputEntity(entersArea(_152,_154)).
inputEntity(gap_start(_152)).
inputEntity(stop_start(_152)).
inputEntity(slow_motion_start(_152)).
inputEntity(change_in_speed_start(_152)).
inputEntity(velocity(_152,_154,_156,_158)).
inputEntity(change_in_heading(_152)).
inputEntity(leavesArea(_152,_154)).
inputEntity(gap_end(_152)).
inputEntity(stop_end(_152)).
inputEntity(slow_motion_end(_152)).
inputEntity(change_in_speed_end(_152)).
inputEntity(proximity(_158,_160)=true).
inputEntity(trawling(_152)).
inputEntity(rendezVous(_152,_154)).
inputEntity(coord(_152,_154,_156)).

outputEntity(withinArea(_316,_318)=true).
outputEntity(gap(_316)=nearPorts).
outputEntity(gap(_316)=farFromPorts).
outputEntity(stopped(_316)=nearPorts).
outputEntity(stopped(_316)=farFromPorts).
outputEntity(lowSpeed(_316)=true).
outputEntity(changingSpeed(_316)=true).
outputEntity(highSpeedNearCoast(_316)=true).
outputEntity(movingSpeed(_316)=below).
outputEntity(movingSpeed(_316)=normal).
outputEntity(movingSpeed(_316)=above).
outputEntity(drifting(_316)=true).
outputEntity(tuggingSpeed(_316)=true).
outputEntity(trawlSpeed(_316)=true).
outputEntity(trawlingMovement(_316)=true).
outputEntity(sarSpeed(_316)=true).
outputEntity(sarMovement(_316)=true).
outputEntity(trawlingMovement(_316)=false).
outputEntity(sarMovement(_316)=false).
outputEntity(underWay(_316)=true).
outputEntity(anchoredOrMoored(_316)=true).
outputEntity(tugging(_316,_318)=true).
outputEntity(rendezVous(_316,_318)=true).
outputEntity(trawling(_316)=true).
outputEntity(inSAR(_316)=true).
outputEntity(loitering(_316)=true).
outputEntity(pilotOps(_316,_318)=true).
outputEntity(transhipment(_316,_318)=true).
outputEntity(stopped2high(_316)=true).
outputEntity(stopped2high2stopped(_316)=true).

event(entersArea(_552,_554)).
event(gap_start(_552)).
event(stop_start(_552)).
event(slow_motion_start(_552)).
event(change_in_speed_start(_552)).
event(velocity(_552,_554,_556,_558)).
event(change_in_heading(_552)).
event(leavesArea(_552,_554)).
event(gap_end(_552)).
event(stop_end(_552)).
event(slow_motion_end(_552)).
event(change_in_speed_end(_552)).
event(coord(_552,_554,_556)).

simpleFluent(withinArea(_698,_700)=true).
simpleFluent(gap(_698)=nearPorts).
simpleFluent(gap(_698)=farFromPorts).
simpleFluent(stopped(_698)=nearPorts).
simpleFluent(stopped(_698)=farFromPorts).
simpleFluent(lowSpeed(_698)=true).
simpleFluent(changingSpeed(_698)=true).
simpleFluent(highSpeedNearCoast(_698)=true).
simpleFluent(movingSpeed(_698)=below).
simpleFluent(movingSpeed(_698)=normal).
simpleFluent(movingSpeed(_698)=above).
simpleFluent(drifting(_698)=true).
simpleFluent(tuggingSpeed(_698)=true).
simpleFluent(trawlSpeed(_698)=true).
simpleFluent(trawlingMovement(_698)=true).
simpleFluent(sarSpeed(_698)=true).
simpleFluent(sarMovement(_698)=true).
simpleFluent(trawlingMovement(_698)=false).
simpleFluent(sarMovement(_698)=false).


sDFluent(underWay(_936)=true).
sDFluent(anchoredOrMoored(_936)=true).
sDFluent(tugging(_936,_938)=true).
sDFluent(rendezVous(_936,_938)=true).
sDFluent(trawling(_936)=true).
sDFluent(inSAR(_936)=true).
sDFluent(loitering(_936)=true).
sDFluent(pilotOps(_936,_938)=true).
sDFluent(transhipment(_936,_938)=true).
sDFluent(stopped2high(_936)=true).
sDFluent(stopped2high2stopped(_936)=true).
sDFluent(proximity(_936,_938)=true).
sDFluent(trawling(_930)).
sDFluent(rendezVous(_930,_932)).

index(entersArea(_1022,_1082),_1022).
index(gap_start(_1022),_1022).
index(stop_start(_1022),_1022).
index(slow_motion_start(_1022),_1022).
index(change_in_speed_start(_1022),_1022).
index(velocity(_1022,_1082,_1084,_1086),_1022).
index(change_in_heading(_1022),_1022).
index(leavesArea(_1022,_1082),_1022).
index(gap_end(_1022),_1022).
index(stop_end(_1022),_1022).
index(slow_motion_end(_1022),_1022).
index(change_in_speed_end(_1022),_1022).
index(coord(_1022,_1082,_1084),_1022).
index(withinArea(_1022,_1088)=true,_1022).
index(gap(_1022)=nearPorts,_1022).
index(gap(_1022)=farFromPorts,_1022).
index(stopped(_1022)=nearPorts,_1022).
index(stopped(_1022)=farFromPorts,_1022).
index(lowSpeed(_1022)=true,_1022).
index(changingSpeed(_1022)=true,_1022).
index(highSpeedNearCoast(_1022)=true,_1022).
index(movingSpeed(_1022)=below,_1022).
index(movingSpeed(_1022)=normal,_1022).
index(movingSpeed(_1022)=above,_1022).
index(drifting(_1022)=true,_1022).
index(tuggingSpeed(_1022)=true,_1022).
index(trawlSpeed(_1022)=true,_1022).
index(trawlingMovement(_1022)=true,_1022).
index(sarSpeed(_1022)=true,_1022).
index(sarMovement(_1022)=true,_1022).
index(trawlingMovement(_1022)=false,_1022).
index(sarMovement(_1022)=false,_1022).
index(underWay(_1022)=true,_1022).
index(anchoredOrMoored(_1022)=true,_1022).
index(tugging(_1022,_1088)=true,_1022).
index(rendezVous(_1022,_1088)=true,_1022).
index(trawling(_1022)=true,_1022).
index(inSAR(_1022)=true,_1022).
index(loitering(_1022)=true,_1022).
index(pilotOps(_1022,_1088)=true,_1022).
index(transhipment(_1022,_1088)=true,_1022).
index(stopped2high(_1022)=true,_1022).
index(stopped2high2stopped(_1022)=true,_1022).
index(proximity(_1022,_1088)=true,_1022).


cachingOrder2(_1538, withinArea(_1538,_1540)=true) :- % level in dependency graph: 1, processing order in component: 1
     vessel(_1538),areaType(_1540).

processingLevel(1,_1538, withinArea(_1538,_1540)=true).
cachingOrder2(_1772, gap(_1772)=farFromPorts) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1772),portStatus(farFromPorts).

processingLevel(2,_1772, gap(_1772)=farFromPorts).
cachingOrder2(_1788, gap(_1788)=nearPorts) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_1788),portStatus(nearPorts).

processingLevel(2,_1788, gap(_1788)=nearPorts).
cachingOrder2(_1750, highSpeedNearCoast(_1750)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1750).

processingLevel(2,_1750, highSpeedNearCoast(_1750)=true).
cachingOrder2(_1712, trawlingMovement(_1712)=true) :- % level in dependency graph: 2, processing order in component: 1
     vessel(_1712),vesselType(_1712,fishing).

processingLevel(2,_1712, trawlingMovement(_1712)=true).
cachingOrder2(_1712, trawlingMovement(_1712)=false) :- % level in dependency graph: 2, processing order in component: 2
     vessel(_1712),vesselType(_1712,fishing).

processingLevel(2,_1712, trawlingMovement(_1712)=false).
cachingOrder2(_2422, stopped(_2422)=farFromPorts) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2422),portStatus(farFromPorts).

processingLevel(3,_2422, stopped(_2422)=farFromPorts).
cachingOrder2(_2438, stopped(_2438)=nearPorts) :- % level in dependency graph: 3, processing order in component: 2
     vessel(_2438),portStatus(nearPorts).

processingLevel(3,_2438, stopped(_2438)=nearPorts).
cachingOrder2(_2400, lowSpeed(_2400)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2400).

processingLevel(3,_2400, lowSpeed(_2400)=true).
cachingOrder2(_2378, changingSpeed(_2378)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2378).

processingLevel(3,_2378, changingSpeed(_2378)=true).
cachingOrder2(_2324, movingSpeed(_2324)=above) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2324),movingStatus(above).

processingLevel(3,_2324, movingSpeed(_2324)=above).
cachingOrder2(_2340, movingSpeed(_2340)=normal) :- % level in dependency graph: 3, processing order in component: 2
     vessel(_2340),movingStatus(normal).

processingLevel(3,_2340, movingSpeed(_2340)=normal).
cachingOrder2(_2356, movingSpeed(_2356)=below) :- % level in dependency graph: 3, processing order in component: 3
     vessel(_2356),movingStatus(below).

processingLevel(3,_2356, movingSpeed(_2356)=below).
cachingOrder2(_2302, tuggingSpeed(_2302)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2302).

processingLevel(3,_2302, tuggingSpeed(_2302)=true).
cachingOrder2(_2280, trawlSpeed(_2280)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2280),vesselType(_2280,fishing).

processingLevel(3,_2280, trawlSpeed(_2280)=true).
cachingOrder2(_2258, sarSpeed(_2258)=true) :- % level in dependency graph: 3, processing order in component: 1
     vessel(_2258),vesselType(_2258,sar).

processingLevel(3,_2258, sarSpeed(_2258)=true).
cachingOrder2(_3448, sarMovement(_3448)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3448),vesselType(_3448,sar).

processingLevel(4,_3448, sarMovement(_3448)=true).
cachingOrder2(_3448, sarMovement(_3448)=false) :- % level in dependency graph: 4, processing order in component: 2
     vessel(_3448),vesselType(_3448,sar).

processingLevel(4,_3448, sarMovement(_3448)=false).
cachingOrder2(_3426, underWay(_3426)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3426).

processingLevel(4,_3426, underWay(_3426)=true).
cachingOrder2(_3404, anchoredOrMoored(_3404)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3404).

processingLevel(4,_3404, anchoredOrMoored(_3404)=true).
cachingOrder2(_3380, tugging(_3380,_3382)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3380,_3382).

processingLevel(4,_3380, tugging(_3380,_3382)=true).
cachingOrder2(_3356, rendezVous(_3356,_3358)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3356,_3358).

processingLevel(4,_3356, rendezVous(_3356,_3358)=true).
cachingOrder2(_3334, trawling(_3334)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3334).

processingLevel(4,_3334, trawling(_3334)=true).
cachingOrder2(_3310, pilotOps(_3310,_3312)=true) :- % level in dependency graph: 4, processing order in component: 1
     vpair(_3310,_3312).

processingLevel(4,_3310, pilotOps(_3310,_3312)=true).
cachingOrder2(_3288, stopped2high(_3288)=true) :- % level in dependency graph: 4, processing order in component: 1
     vessel(_3288).

processingLevel(4,_3288, stopped2high(_3288)=true).
cachingOrder2(_4314, drifting(_4314)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4314).

processingLevel(5,_4314, drifting(_4314)=true).
cachingOrder2(_4292, inSAR(_4292)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4292).

processingLevel(5,_4292, inSAR(_4292)=true).
cachingOrder2(_4270, loitering(_4270)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4270).

processingLevel(5,_4270, loitering(_4270)=true).
cachingOrder2(_4248, stopped2high2stopped(_4248)=true) :- % level in dependency graph: 5, processing order in component: 1
     vessel(_4248).

processingLevel(5,_4248, stopped2high2stopped(_4248)=true).
collectGrounds([entersArea(_704,_718), gap_start(_704), stop_start(_704), slow_motion_start(_704), change_in_speed_start(_704), velocity(_704,_718,_720,_722), change_in_heading(_704), leavesArea(_704,_718), gap_end(_704), stop_end(_704), slow_motion_end(_704), change_in_speed_end(_704), coord(_704,_718,_720)],vessel(_704)).

collectGrounds([proximity(_692,_694)=true],vpair(_692,_694)).

dgrounded(withinArea(_1886,_1888)=true, vessel(_1886)).
dgrounded(gap(_1844)=nearPorts, vessel(_1844)).
dgrounded(gap(_1802)=farFromPorts, vessel(_1802)).
dgrounded(stopped(_1760)=nearPorts, vessel(_1760)).
dgrounded(stopped(_1718)=farFromPorts, vessel(_1718)).
dgrounded(lowSpeed(_1686)=true, vessel(_1686)).
dgrounded(changingSpeed(_1654)=true, vessel(_1654)).
dgrounded(highSpeedNearCoast(_1622)=true, vessel(_1622)).
dgrounded(movingSpeed(_1580)=below, vessel(_1580)).
dgrounded(movingSpeed(_1538)=normal, vessel(_1538)).
dgrounded(movingSpeed(_1496)=above, vessel(_1496)).
dgrounded(drifting(_1464)=true, vessel(_1464)).
dgrounded(tuggingSpeed(_1432)=true, vessel(_1432)).
dgrounded(trawlSpeed(_1388)=true, vessel(_1388)).
dgrounded(trawlingMovement(_1344)=true, vessel(_1344)).
dgrounded(sarSpeed(_1300)=true, vessel(_1300)).
dgrounded(sarMovement(_1256)=true, vessel(_1256)).
dgrounded(trawlingMovement(_1212)=false, vessel(_1212)).
dgrounded(sarMovement(_1168)=false, vessel(_1168)).
dgrounded(underWay(_1136)=true, vessel(_1136)).
dgrounded(anchoredOrMoored(_1104)=true, vessel(_1104)).
dgrounded(tugging(_1068,_1070)=true, vpair(_1068,_1070)).
dgrounded(rendezVous(_1032,_1034)=true, vpair(_1032,_1034)).
dgrounded(trawling(_1000)=true, vessel(_1000)).
dgrounded(inSAR(_968)=true, vessel(_968)).
dgrounded(loitering(_936)=true, vessel(_936)).
dgrounded(pilotOps(_900,_902)=true, vpair(_900,_902)).
dgrounded(transhipment(_864,_866)=true, vpair(_864,_866)).
dgrounded(stopped2high(_832)=true, vessel(_832)).
dgrounded(stopped2high2stopped(_800)=true, vessel(_800)).
