:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(withinArea(_3162,_3164)=true, _3192, _3134, _3198) :-
     happensAtIE(entersArea(_3162,_3170),_3134),_3192=<_3134,_3134<_3198,
     areaType(_3170,_3164).

initiatedAt(gap(_3162)=nearPorts, _3200, _3134, _3206) :-
     happensAtIE(gap_start(_3162),_3134),_3200=<_3134,_3134<_3206,
     holdsAtProcessedSimpleFluent(_3162,withinArea(_3162,nearPorts)=true,_3134).

initiatedAt(gap(_3162)=farFromPorts, _3204, _3134, _3210) :-
     happensAtIE(gap_start(_3162),_3134),_3204=<_3134,_3134<_3210,
     \+holdsAtProcessedSimpleFluent(_3162,withinArea(_3162,nearPorts)=true,_3134).

initiatedAt(stopped(_3162)=nearPorts, _3200, _3134, _3206) :-
     happensAtIE(stop_start(_3162),_3134),_3200=<_3134,_3134<_3206,
     holdsAtProcessedSimpleFluent(_3162,withinArea(_3162,nearPorts)=true,_3134).

initiatedAt(stopped(_3162)=farFromPorts, _3204, _3134, _3210) :-
     happensAtIE(stop_start(_3162),_3134),_3204=<_3134,_3134<_3210,
     \+holdsAtProcessedSimpleFluent(_3162,withinArea(_3162,nearPorts)=true,_3134).

initiatedAt(lowSpeed(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(slow_motion_start(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

initiatedAt(changingSpeed(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(change_in_speed_start(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

initiatedAt(highSpeedNearCoast(_3162)=true, _3236, _3134, _3242) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3236=<_3134,_3134<_3242,
     thresholds(hcNearCoastMax,_3184),
     \+inRange(_3168,0,_3184),
     holdsAtProcessedSimpleFluent(_3162,withinArea(_3162,nearCoast)=true,_3134).

initiatedAt(movingSpeed(_3162)=below, _3236, _3134, _3242) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3236=<_3134,_3134<_3242,
     vesselType(_3162,_3184),
     typeSpeed(_3184,_3190,_3192,_3194),
     thresholds(movingMin,_3200),
     inRange(_3168,_3200,_3190).

initiatedAt(movingSpeed(_3162)=normal, _3224, _3134, _3230) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3224=<_3134,_3134<_3230,
     vesselType(_3162,_3184),
     typeSpeed(_3184,_3190,_3192,_3194),
     inRange(_3168,_3190,_3192).

initiatedAt(movingSpeed(_3162)=above, _3224, _3134, _3230) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3224=<_3134,_3134<_3230,
     vesselType(_3162,_3184),
     typeSpeed(_3184,_3190,_3192,_3194),
     inRange(_3168,_3192,inf).

initiatedAt(drifting(_3162)=true, _3260, _3134, _3266) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3260=<_3134,_3134<_3266,
     _3172=\=511.0,
     absoluteAngleDiff(_3170,_3172,_3198),
     thresholds(adriftAngThr,_3204),
     _3198>_3204,
     holdsAtProcessedSDFluent(_3162,underWay(_3162)=true,_3134).

initiatedAt(tuggingSpeed(_3162)=true, _3220, _3134, _3226) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3220=<_3134,_3134<_3226,
     thresholds(tuggingMin,_3184),
     thresholds(tuggingMax,_3190),
     inRange(_3168,_3184,_3190).

initiatedAt(trawlSpeed(_3162)=true, _3244, _3134, _3250) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3244=<_3134,_3134<_3250,
     thresholds(trawlspeedMin,_3184),
     thresholds(trawlspeedMax,_3190),
     inRange(_3168,_3184,_3190),
     holdsAtProcessedSimpleFluent(_3162,withinArea(_3162,fishing)=true,_3134).

initiatedAt(trawlingMovement(_3162)=true, _3200, _3134, _3206) :-
     happensAtIE(change_in_heading(_3162),_3134),_3200=<_3134,_3134<_3206,
     holdsAtProcessedSimpleFluent(_3162,withinArea(_3162,fishing)=true,_3134).

initiatedAt(sarSpeed(_3162)=true, _3208, _3134, _3214) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3208=<_3134,_3134<_3214,
     thresholds(sarMinSpeed,_3184),
     inRange(_3168,_3184,inf).

initiatedAt(sarMovement(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(change_in_heading(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

initiatedAt(sarMovement(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(changingSpeed(_3162)=true),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(withinArea(_3162,_3164)=true, _3192, _3134, _3198) :-
     happensAtIE(leavesArea(_3162,_3170),_3134),_3192=<_3134,_3134<_3198,
     areaType(_3170,_3164).

terminatedAt(withinArea(_3162,_3164)=true, _3178, _3134, _3184) :-
     happensAtIE(gap_start(_3162),_3134),
     _3178=<_3134,
     _3134<_3184.

terminatedAt(gap(_3162)=_3140, _3176, _3134, _3182) :-
     happensAtIE(gap_end(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

terminatedAt(stopped(_3162)=_3140, _3176, _3134, _3182) :-
     happensAtIE(stop_end(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

terminatedAt(stopped(_3162)=_3140, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(lowSpeed(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(slow_motion_end(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

terminatedAt(lowSpeed(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(changingSpeed(_3162)=true, _3176, _3134, _3182) :-
     happensAtIE(change_in_speed_end(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

terminatedAt(changingSpeed(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(highSpeedNearCoast(_3162)=true, _3208, _3134, _3214) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3208=<_3134,_3134<_3214,
     thresholds(hcNearCoastMax,_3184),
     inRange(_3168,0,_3184).

terminatedAt(highSpeedNearCoast(_3162)=true, _3188, _3134, _3194) :-
     happensAtProcessedSimpleFluent(_3162,end(withinArea(_3162,nearCoast)=true),_3134),
     _3188=<_3134,
     _3134<_3194.

terminatedAt(movingSpeed(_3162)=_3140, _3212, _3134, _3218) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3212=<_3134,_3134<_3218,
     thresholds(movingMin,_3184),
     \+inRange(_3168,_3184,inf).

terminatedAt(movingSpeed(_3162)=_3140, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(drifting(_3162)=true, _3220, _3134, _3226) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3220=<_3134,_3134<_3226,
     absoluteAngleDiff(_3170,_3172,_3186),
     thresholds(adriftAngThr,_3192),
     _3186=<_3192.

terminatedAt(drifting(_3162)=true, _3188, _3134, _3194) :-
     happensAtIE(velocity(_3162,_3168,_3170,511.0),_3134),
     _3188=<_3134,
     _3134<_3194.

terminatedAt(drifting(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSDFluent(_3162,end(underWay(_3162)=true),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(tuggingSpeed(_3162)=true, _3224, _3134, _3230) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3224=<_3134,_3134<_3230,
     thresholds(tuggingMin,_3184),
     thresholds(tuggingMax,_3190),
     \+inRange(_3168,_3184,_3190).

terminatedAt(tuggingSpeed(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(trawlSpeed(_3162)=true, _3224, _3134, _3230) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3224=<_3134,_3134<_3230,
     thresholds(trawlspeedMin,_3184),
     thresholds(trawlspeedMax,_3190),
     \+inRange(_3168,_3184,_3190).

terminatedAt(trawlSpeed(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(trawlSpeed(_3162)=true, _3188, _3134, _3194) :-
     happensAtProcessedSimpleFluent(_3162,end(withinArea(_3162,fishing)=true),_3134),
     _3188=<_3134,
     _3134<_3194.

terminatedAt(trawlingMovement(_3162)=true, _3188, _3134, _3194) :-
     happensAtProcessedSimpleFluent(_3162,end(withinArea(_3162,fishing)=true),_3134),
     _3188=<_3134,
     _3134<_3194.

terminatedAt(sarSpeed(_3162)=true, _3208, _3134, _3214) :-
     happensAtIE(velocity(_3162,_3168,_3170,_3172),_3134),_3208=<_3134,_3134<_3214,
     thresholds(sarMinSpeed,_3184),
     inRange(_3168,0,_3184).

terminatedAt(sarSpeed(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

terminatedAt(sarMovement(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(gap(_3162)=_3172),_3134),
     _3186=<_3134,
     _3134<_3192.

holdsForSDFluent(underWay(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,movingSpeed(_3162)=below,_3178),
     holdsForProcessedSimpleFluent(_3162,movingSpeed(_3162)=normal,_3194),
     holdsForProcessedSimpleFluent(_3162,movingSpeed(_3162)=above,_3210),
     union_all([_3178,_3194,_3210],_3134).

holdsForSDFluent(anchoredOrMoored(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,stopped(_3162)=farFromPorts,_3178),
     holdsForProcessedSimpleFluent(_3162,withinArea(_3162,anchorage)=true,_3196),
     intersect_all([_3178,_3196],_3214),
     holdsForProcessedSimpleFluent(_3162,stopped(_3162)=nearPorts,_3230),
     union_all([_3214,_3230],_3248),
     thresholds(aOrMTime,_3254),
     intDurGreater(_3248,_3254,_3134).

holdsForSDFluent(tugging(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,proximity(_3162,_3164)=true,_3182),
     oneIsTug(_3162,_3164),
     \+oneIsPilot(_3162,_3164),
     \+twoAreTugs(_3162,_3164),
     holdsForProcessedSimpleFluent(_3162,tuggingSpeed(_3162)=true,_3224),
     holdsForProcessedSimpleFluent(_3164,tuggingSpeed(_3164)=true,_3240),
     intersect_all([_3182,_3224,_3240],_3264),
     thresholds(tuggingTime,_3270),
     intDurGreater(_3264,_3270,_3134).

holdsForSDFluent(rendezVous(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,proximity(_3162,_3164)=true,_3182),
     \+oneIsTug(_3162,_3164),
     \+oneIsPilot(_3162,_3164),
     holdsForProcessedSimpleFluent(_3162,lowSpeed(_3162)=true,_3218),
     holdsForProcessedSimpleFluent(_3164,lowSpeed(_3164)=true,_3234),
     holdsForProcessedSimpleFluent(_3162,stopped(_3162)=farFromPorts,_3250),
     holdsForProcessedSimpleFluent(_3164,stopped(_3164)=farFromPorts,_3266),
     union_all([_3218,_3250],_3284),
     union_all([_3234,_3266],_3302),
     intersect_all([_3284,_3302,_3182],_3326),
     _3326\=[],
     holdsForProcessedSimpleFluent(_3162,withinArea(_3162,nearPorts)=true,_3350),
     holdsForProcessedSimpleFluent(_3164,withinArea(_3164,nearPorts)=true,_3368),
     holdsForProcessedSimpleFluent(_3162,withinArea(_3162,nearCoast)=true,_3386),
     holdsForProcessedSimpleFluent(_3164,withinArea(_3164,nearCoast)=true,_3404),
     relative_complement_all(_3326,[_3350,_3368,_3386,_3404],_3436),
     thresholds(rendezvousTime,_3442),
     intDurGreater(_3436,_3442,_3134).

holdsForSDFluent(trawling(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,trawlSpeed(_3162)=true,_3178),
     holdsForProcessedSimpleFluent(_3162,trawlingMovement(_3162)=true,_3194),
     intersect_all([_3178,_3194],_3212),
     thresholds(trawlingTime,_3218),
     intDurGreater(_3212,_3218,_3134).

holdsForSDFluent(inSAR(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,sarSpeed(_3162)=true,_3178),
     holdsForProcessedSimpleFluent(_3162,sarMovement(_3162)=true,_3194),
     intersect_all([_3178,_3194],_3212),
     intDurGreater(_3212,3600,_3134).

holdsForSDFluent(loitering(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,lowSpeed(_3162)=true,_3178),
     holdsForProcessedSimpleFluent(_3162,stopped(_3162)=farFromPorts,_3194),
     union_all([_3178,_3194],_3212),
     holdsForProcessedSimpleFluent(_3162,withinArea(_3162,nearCoast)=true,_3230),
     holdsForProcessedSDFluent(_3162,anchoredOrMoored(_3162)=true,_3246),
     relative_complement_all(_3212,[_3230,_3246],_3266),
     thresholds(loiteringTime,_3272),
     intDurGreater(_3266,_3272,_3134).

holdsForSDFluent(pilotOps(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,proximity(_3162,_3164)=true,_3182),
     oneIsPilot(_3162,_3164),
     holdsForProcessedSimpleFluent(_3162,lowSpeed(_3162)=true,_3204),
     holdsForProcessedSimpleFluent(_3164,lowSpeed(_3164)=true,_3220),
     holdsForProcessedSimpleFluent(_3162,stopped(_3162)=farFromPorts,_3236),
     holdsForProcessedSimpleFluent(_3164,stopped(_3164)=farFromPorts,_3252),
     union_all([_3204,_3236],_3270),
     union_all([_3220,_3252],_3288),
     intersect_all([_3270,_3288,_3182],_3312),
     _3312\=[],
     holdsForProcessedSimpleFluent(_3162,withinArea(_3162,nearCoast)=true,_3336),
     holdsForProcessedSimpleFluent(_3164,withinArea(_3164,nearCoast)=true,_3354),
     relative_complement_all(_3312,[_3336,_3354],_3134).

cachingOrder2(_3138, withinArea(_3138,_3140)=true) :-
     vessel(_3138),areaType(_3140).

cachingOrder2(_3138, gap(_3138)=nearPorts) :-
     vessel(_3138),portStatus(nearPorts).

cachingOrder2(_3138, gap(_3138)=farFromPorts) :-
     vessel(_3138),portStatus(farFromPorts).

cachingOrder2(_3138, stopped(_3138)=nearPorts) :-
     vessel(_3138),portStatus(nearPorts).

cachingOrder2(_3138, stopped(_3138)=farFromPorts) :-
     vessel(_3138),portStatus(farFromPorts).

cachingOrder2(_3138, lowSpeed(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, changingSpeed(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, movingSpeed(_3138)=below) :-
     vessel(_3138),movingStatus(below).

cachingOrder2(_3138, movingSpeed(_3138)=above) :-
     vessel(_3138),movingStatus(above).

cachingOrder2(_3138, movingSpeed(_3138)=normal) :-
     vessel(_3138),movingStatus(normal).

cachingOrder2(_3138, underWay(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, highSpeedNearCoast(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, drifting(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, sarSpeed(_3138)=true) :-
     vessel(_3138),vesselType(_3138,sar).

cachingOrder2(_3138, sarMovement(_3138)=true) :-
     vessel(_3138),vesselType(_3138,sar).

cachingOrder2(_3138, inSAR(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, anchoredOrMoored(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, tuggingSpeed(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, tugging(_3138,_3140)=true) :-
     vpair(_3138,_3140).

cachingOrder2(_3138, rendezVous(_3138,_3140)=true) :-
     vpair(_3138,_3140).

cachingOrder2(_3138, pilotOps(_3138,_3140)=true) :-
     vpair(_3138,_3140).

cachingOrder2(_3138, trawlSpeed(_3138)=true) :-
     vessel(_3138),vesselType(_3138,fishing).

cachingOrder2(_3138, trawlingMovement(_3138)=true) :-
     vessel(_3138),vesselType(_3138,fishing).

cachingOrder2(_3138, trawling(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, loitering(_3138)=true) :-
     vessel(_3138).

collectIntervals2(_3138, proximity(_3138,_3140)=true) :-
     vpair(_3138,_3140).

maxDurationUE(trawlingMovement(_3378)=true,trawlingMovement(_3378)=false,_3264) :- 
     thresholds(trawlingCrs,_3264),grounding(trawlingMovement(_3378)=true).

maxDurationUE(sarMovement(_3378)=true,sarMovement(_3378)=false,1800) :- 
     grounding(sarMovement(_3378)=true).
