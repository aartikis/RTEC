:- dynamic vessel/1, vpair/2.

initiatedAt(withinArea(_2006,_2008)=true, _2038, _1976, _2044) :-
     happensAtIE(entersArea(_2006,_2014),_1976),_2038=<_1976,_1976<_2044,
     areaType(_2014,_2008).

initiatedAt(gap(_2006)=nearPorts, _2046, _1976, _2052) :-
     happensAtIE(gap_start(_2006),_1976),_2046=<_1976,_1976<_2052,
     holdsAtProcessedSimpleFluent(_2006,withinArea(_2006,nearPorts)=true,_1976).

initiatedAt(gap(_2006)=farFromPorts, _2050, _1976, _2056) :-
     happensAtIE(gap_start(_2006),_1976),_2050=<_1976,_1976<_2056,
     \+holdsAtProcessedSimpleFluent(_2006,withinArea(_2006,nearPorts)=true,_1976).

initiatedAt(stopped(_2006)=nearPorts, _2046, _1976, _2052) :-
     happensAtIE(stop_start(_2006),_1976),_2046=<_1976,_1976<_2052,
     holdsAtProcessedSimpleFluent(_2006,withinArea(_2006,nearPorts)=true,_1976).

initiatedAt(stopped(_2006)=farFromPorts, _2050, _1976, _2056) :-
     happensAtIE(stop_start(_2006),_1976),_2050=<_1976,_1976<_2056,
     \+holdsAtProcessedSimpleFluent(_2006,withinArea(_2006,nearPorts)=true,_1976).

initiatedAt(lowSpeed(_2006)=true, _2022, _1976, _2028) :-
     happensAtIE(slow_motion_start(_2006),_1976),
     _2022=<_1976,
     _1976<_2028.

initiatedAt(changingSpeed(_2006)=true, _2022, _1976, _2028) :-
     happensAtIE(change_in_speed_start(_2006),_1976),
     _2022=<_1976,
     _1976<_2028.

initiatedAt(highSpeedNearCoast(_2006)=true, _2082, _1976, _2088) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2082=<_1976,_1976<_2088,
     thresholds(hcNearCoastMax,_2028),
     \+inRange(_2012,0,_2028),
     holdsAtProcessedSimpleFluent(_2006,withinArea(_2006,nearCoast)=true,_1976).

initiatedAt(movingSpeed(_2006)=below, _2082, _1976, _2088) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2082=<_1976,_1976<_2088,
     vesselType(_2006,_2028),
     typeSpeed(_2028,_2034,_2036,_2038),
     thresholds(movingMin,_2044),
     inRange(_2012,_2044,_2034).

initiatedAt(movingSpeed(_2006)=normal, _2070, _1976, _2076) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2070=<_1976,_1976<_2076,
     vesselType(_2006,_2028),
     typeSpeed(_2028,_2034,_2036,_2038),
     inRange(_2012,_2034,_2036).

initiatedAt(movingSpeed(_2006)=above, _2070, _1976, _2076) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2070=<_1976,_1976<_2076,
     vesselType(_2006,_2028),
     typeSpeed(_2028,_2034,_2036,_2038),
     inRange(_2012,_2036,inf).

initiatedAt(drifting(_2006)=true, _2106, _1976, _2112) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2106=<_1976,_1976<_2112,
     _2016=\=511.0,
     absoluteAngleDiff(_2014,_2016,_2042),
     thresholds(adriftAngThr,_2048),
     _2042>_2048,
     holdsAtProcessedSDFluent(_2006,underWay(_2006)=true,_1976).

initiatedAt(tuggingSpeed(_2006)=true, _2066, _1976, _2072) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2066=<_1976,_1976<_2072,
     thresholds(tuggingMin,_2028),
     thresholds(tuggingMax,_2034),
     inRange(_2012,_2028,_2034).

initiatedAt(trawlSpeed(_2006)=true, _2090, _1976, _2096) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2090=<_1976,_1976<_2096,
     thresholds(trawlspeedMin,_2028),
     thresholds(trawlspeedMax,_2034),
     inRange(_2012,_2028,_2034),
     holdsAtProcessedSimpleFluent(_2006,withinArea(_2006,fishing)=true,_1976).

initiatedAt(trawlingMovement(_2006)=true, _2046, _1976, _2052) :-
     happensAtIE(change_in_heading(_2006),_1976),_2046=<_1976,_1976<_2052,
     holdsAtProcessedSimpleFluent(_2006,withinArea(_2006,fishing)=true,_1976).

initiatedAt(sarSpeed(_2006)=true, _2054, _1976, _2060) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2054=<_1976,_1976<_2060,
     thresholds(sarMinSpeed,_2028),
     inRange(_2012,_2028,inf).

initiatedAt(sarMovement(_2006)=true, _2022, _1976, _2028) :-
     happensAtIE(change_in_heading(_2006),_1976),
     _2022=<_1976,
     _1976<_2028.

initiatedAt(sarMovement(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(changingSpeed(_2006)=true),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(withinArea(_2006,_2008)=true, _2038, _1976, _2044) :-
     happensAtIE(leavesArea(_2006,_2014),_1976),_2038=<_1976,_1976<_2044,
     areaType(_2014,_2008).

terminatedAt(withinArea(_2006,_2008)=true, _2024, _1976, _2030) :-
     happensAtIE(gap_start(_2006),_1976),
     _2024=<_1976,
     _1976<_2030.

terminatedAt(gap(_2006)=_1982, _2022, _1976, _2028) :-
     happensAtIE(gap_end(_2006),_1976),
     _2022=<_1976,
     _1976<_2028.

terminatedAt(stopped(_2006)=_1982, _2022, _1976, _2028) :-
     happensAtIE(stop_end(_2006),_1976),
     _2022=<_1976,
     _1976<_2028.

terminatedAt(stopped(_2006)=_1982, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(lowSpeed(_2006)=true, _2022, _1976, _2028) :-
     happensAtIE(slow_motion_end(_2006),_1976),
     _2022=<_1976,
     _1976<_2028.

terminatedAt(lowSpeed(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(changingSpeed(_2006)=true, _2022, _1976, _2028) :-
     happensAtIE(change_in_speed_end(_2006),_1976),
     _2022=<_1976,
     _1976<_2028.

terminatedAt(changingSpeed(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(highSpeedNearCoast(_2006)=true, _2054, _1976, _2060) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2054=<_1976,_1976<_2060,
     thresholds(hcNearCoastMax,_2028),
     inRange(_2012,0,_2028).

terminatedAt(highSpeedNearCoast(_2006)=true, _2034, _1976, _2040) :-
     happensAtProcessedSimpleFluent(_2006,end(withinArea(_2006,nearCoast)=true),_1976),
     _2034=<_1976,
     _1976<_2040.

terminatedAt(movingSpeed(_2006)=_1982, _2058, _1976, _2064) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2058=<_1976,_1976<_2064,
     thresholds(movingMin,_2028),
     \+inRange(_2012,_2028,inf).

terminatedAt(movingSpeed(_2006)=_1982, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(drifting(_2006)=true, _2066, _1976, _2072) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2066=<_1976,_1976<_2072,
     absoluteAngleDiff(_2014,_2016,_2030),
     thresholds(adriftAngThr,_2036),
     _2030=<_2036.

terminatedAt(drifting(_2006)=true, _2034, _1976, _2040) :-
     happensAtIE(velocity(_2006,_2012,_2014,511.0),_1976),
     _2034=<_1976,
     _1976<_2040.

terminatedAt(drifting(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSDFluent(_2006,end(underWay(_2006)=true),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(tuggingSpeed(_2006)=true, _2070, _1976, _2076) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2070=<_1976,_1976<_2076,
     thresholds(tuggingMin,_2028),
     thresholds(tuggingMax,_2034),
     \+inRange(_2012,_2028,_2034).

terminatedAt(tuggingSpeed(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(trawlSpeed(_2006)=true, _2070, _1976, _2076) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2070=<_1976,_1976<_2076,
     thresholds(trawlspeedMin,_2028),
     thresholds(trawlspeedMax,_2034),
     \+inRange(_2012,_2028,_2034).

terminatedAt(trawlSpeed(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(trawlSpeed(_2006)=true, _2034, _1976, _2040) :-
     happensAtProcessedSimpleFluent(_2006,end(withinArea(_2006,fishing)=true),_1976),
     _2034=<_1976,
     _1976<_2040.

terminatedAt(trawlingMovement(_2006)=true, _2034, _1976, _2040) :-
     happensAtProcessedSimpleFluent(_2006,end(withinArea(_2006,fishing)=true),_1976),
     _2034=<_1976,
     _1976<_2040.

terminatedAt(sarSpeed(_2006)=true, _2054, _1976, _2060) :-
     happensAtIE(velocity(_2006,_2012,_2014,_2016),_1976),_2054=<_1976,_1976<_2060,
     thresholds(sarMinSpeed,_2028),
     inRange(_2012,0,_2028).

terminatedAt(sarSpeed(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

terminatedAt(sarMovement(_2006)=true, _2032, _1976, _2038) :-
     happensAtProcessedSimpleFluent(_2006,start(gap(_2006)=_2016),_1976),
     _2032=<_1976,
     _1976<_2038.

holdsForSDFluent(underWay(_2006)=true,_1976) :-
     holdsForProcessedSimpleFluent(_2006,movingSpeed(_2006)=below,_2022),
     holdsForProcessedSimpleFluent(_2006,movingSpeed(_2006)=normal,_2038),
     holdsForProcessedSimpleFluent(_2006,movingSpeed(_2006)=above,_2054),
     union_all([_2022,_2038,_2054],_1976).

holdsForSDFluent(anchoredOrMoored(_2006)=true,_1976) :-
     holdsForProcessedSimpleFluent(_2006,stopped(_2006)=farFromPorts,_2022),
     holdsForProcessedSimpleFluent(_2006,withinArea(_2006,anchorage)=true,_2040),
     intersect_all([_2022,_2040],_2058),
     holdsForProcessedSimpleFluent(_2006,stopped(_2006)=nearPorts,_2074),
     union_all([_2058,_2074],_2092),
     thresholds(aOrMTime,_2098),
     intDurGreater(_2092,_2098,_1976).

holdsForSDFluent(tugging(_2006,_2008)=true,_1976) :-
     holdsForProcessedIE(_2006,proximity(_2006,_2008)=true,_2026),
     oneIsTug(_2006,_2008),
     \+oneIsPilot(_2006,_2008),
     \+twoAreTugs(_2006,_2008),
     holdsForProcessedSimpleFluent(_2006,tuggingSpeed(_2006)=true,_2068),
     holdsForProcessedSimpleFluent(_2008,tuggingSpeed(_2008)=true,_2084),
     intersect_all([_2026,_2068,_2084],_2108),
     thresholds(tuggingTime,_2114),
     intDurGreater(_2108,_2114,_1976).

holdsForSDFluent(rendezVous(_2006,_2008)=true,_1976) :-
     holdsForProcessedIE(_2006,proximity(_2006,_2008)=true,_2026),
     \+oneIsTug(_2006,_2008),
     \+oneIsPilot(_2006,_2008),
     holdsForProcessedSimpleFluent(_2006,lowSpeed(_2006)=true,_2062),
     holdsForProcessedSimpleFluent(_2008,lowSpeed(_2008)=true,_2078),
     holdsForProcessedSimpleFluent(_2006,stopped(_2006)=farFromPorts,_2094),
     holdsForProcessedSimpleFluent(_2008,stopped(_2008)=farFromPorts,_2110),
     union_all([_2062,_2094],_2128),
     union_all([_2078,_2110],_2146),
     intersect_all([_2128,_2146,_2026],_2170),
     _2170\=[],
     holdsForProcessedSimpleFluent(_2006,withinArea(_2006,nearPorts)=true,_2194),
     holdsForProcessedSimpleFluent(_2008,withinArea(_2008,nearPorts)=true,_2212),
     holdsForProcessedSimpleFluent(_2006,withinArea(_2006,nearCoast)=true,_2230),
     holdsForProcessedSimpleFluent(_2008,withinArea(_2008,nearCoast)=true,_2248),
     relative_complement_all(_2170,[_2194,_2212,_2230,_2248],_2280),
     thresholds(rendezvousTime,_2286),
     intDurGreater(_2280,_2286,_1976).

holdsForSDFluent(trawling(_2006)=true,_1976) :-
     holdsForProcessedSimpleFluent(_2006,trawlSpeed(_2006)=true,_2022),
     holdsForProcessedSimpleFluent(_2006,trawlingMovement(_2006)=true,_2038),
     intersect_all([_2022,_2038],_2056),
     thresholds(trawlingTime,_2062),
     intDurGreater(_2056,_2062,_1976).

holdsForSDFluent(inSAR(_2006)=true,_1976) :-
     holdsForProcessedSimpleFluent(_2006,sarSpeed(_2006)=true,_2022),
     holdsForProcessedSimpleFluent(_2006,sarMovement(_2006)=true,_2038),
     intersect_all([_2022,_2038],_2056),
     intDurGreater(_2056,3600,_1976).

holdsForSDFluent(loitering(_2006)=true,_1976) :-
     holdsForProcessedSimpleFluent(_2006,lowSpeed(_2006)=true,_2022),
     holdsForProcessedSimpleFluent(_2006,stopped(_2006)=farFromPorts,_2038),
     union_all([_2022,_2038],_2056),
     holdsForProcessedSimpleFluent(_2006,withinArea(_2006,nearCoast)=true,_2074),
     holdsForProcessedSDFluent(_2006,anchoredOrMoored(_2006)=true,_2090),
     relative_complement_all(_2056,[_2074,_2090],_2110),
     thresholds(loiteringTime,_2116),
     intDurGreater(_2110,_2116,_1976).

holdsForSDFluent(pilotOps(_2006,_2008)=true,_1976) :-
     holdsForProcessedIE(_2006,proximity(_2006,_2008)=true,_2026),
     oneIsPilot(_2006,_2008),
     holdsForProcessedSimpleFluent(_2006,lowSpeed(_2006)=true,_2048),
     holdsForProcessedSimpleFluent(_2008,lowSpeed(_2008)=true,_2064),
     holdsForProcessedSimpleFluent(_2006,stopped(_2006)=farFromPorts,_2080),
     holdsForProcessedSimpleFluent(_2008,stopped(_2008)=farFromPorts,_2096),
     union_all([_2048,_2080],_2114),
     union_all([_2064,_2096],_2132),
     intersect_all([_2114,_2132,_2026],_2156),
     _2156\=[],
     holdsForProcessedSimpleFluent(_2006,withinArea(_2006,nearCoast)=true,_2180),
     holdsForProcessedSimpleFluent(_2008,withinArea(_2008,nearCoast)=true,_2198),
     relative_complement_all(_2156,[_2180,_2198],_1976).

maxDurationUE(trawlingMovement(_2016)=true,trawlingMovement(_2016)=false,_1978):-
     thresholds(trawlingCrs,_1978),
     grounding(trawlingMovement(_2016)=true),
     grounding(trawlingMovement(_2016)=false).

maxDurationUE(sarMovement(_2010)=true,sarMovement(_2010)=false,1800):-
     grounding(sarMovement(_2010)=true),
     grounding(sarMovement(_2010)=false).

collectIntervals2(_1980, proximity(_1980,_1982)=true) :-
     vpair(_1980,_1982).

needsGrounding(_2194,_2196,_2198) :- 
     fail.

grounding(change_in_speed_start(_2360)) :- 
     vessel(_2360).

grounding(change_in_speed_end(_2360)) :- 
     vessel(_2360).

grounding(change_in_heading(_2360)) :- 
     vessel(_2360).

grounding(stop_start(_2360)) :- 
     vessel(_2360).

grounding(stop_end(_2360)) :- 
     vessel(_2360).

grounding(slow_motion_start(_2360)) :- 
     vessel(_2360).

grounding(slow_motion_end(_2360)) :- 
     vessel(_2360).

grounding(gap_start(_2360)) :- 
     vessel(_2360).

grounding(gap_end(_2360)) :- 
     vessel(_2360).

grounding(entersArea(_2360,_2362)) :- 
     vessel(_2360),areaType(_2362).

grounding(leavesArea(_2360,_2362)) :- 
     vessel(_2360),areaType(_2362).

grounding(coord(_2360,_2362,_2364)) :- 
     vessel(_2360).

grounding(velocity(_2360,_2362,_2364,_2366)) :- 
     vessel(_2360).

grounding(proximity(_2366,_2368)=true) :- 
     vpair(_2366,_2368).

grounding(gap(_2366)=_2362) :- 
     vessel(_2366),portStatus(_2362).

grounding(stopped(_2366)=_2362) :- 
     vessel(_2366),portStatus(_2362).

grounding(lowSpeed(_2366)=true) :- 
     vessel(_2366).

grounding(changingSpeed(_2366)=true) :- 
     vessel(_2366).

grounding(withinArea(_2366,_2368)=true) :- 
     vessel(_2366),areaType(_2368).

grounding(underWay(_2366)=true) :- 
     vessel(_2366).

grounding(sarSpeed(_2366)=true) :- 
     vessel(_2366),vesselType(_2366,sar).

grounding(sarMovement(_2366)=true) :- 
     vessel(_2366),vesselType(_2366,sar).

grounding(sarMovement(_2366)=false) :- 
     vessel(_2366),vesselType(_2366,sar).

grounding(inSAR(_2366)=true) :- 
     vessel(_2366).

grounding(highSpeedNearCoast(_2366)=true) :- 
     vessel(_2366).

grounding(drifting(_2366)=true) :- 
     vessel(_2366).

grounding(anchoredOrMoored(_2366)=true) :- 
     vessel(_2366).

grounding(trawlSpeed(_2366)=true) :- 
     vessel(_2366),vesselType(_2366,fishing).

grounding(movingSpeed(_2366)=_2362) :- 
     vessel(_2366),movingStatus(_2362).

grounding(pilotOps(_2366,_2368)=true) :- 
     vpair(_2366,_2368).

grounding(tuggingSpeed(_2366)=true) :- 
     vessel(_2366).

grounding(tugging(_2366,_2368)=true) :- 
     vpair(_2366,_2368).

grounding(rendezVous(_2366,_2368)=true) :- 
     vpair(_2366,_2368).

grounding(trawlingMovement(_2366)=true) :- 
     vessel(_2366),vesselType(_2366,fishing).

grounding(trawlingMovement(_2366)=false) :- 
     vessel(_2366),vesselType(_2366,fishing).

grounding(trawling(_2366)=true) :- 
     vessel(_2366).

grounding(loitering(_2366)=true) :- 
     vessel(_2366).

inputEntity(entersArea(_2030,_2032)).
inputEntity(gap_start(_2030)).
inputEntity(stop_start(_2030)).
inputEntity(slow_motion_start(_2030)).
inputEntity(change_in_speed_start(_2030)).
inputEntity(velocity(_2030,_2032,_2034,_2036)).
inputEntity(change_in_heading(_2030)).
inputEntity(leavesArea(_2030,_2032)).
inputEntity(gap_end(_2030)).
inputEntity(stop_end(_2030)).
inputEntity(slow_motion_end(_2030)).
inputEntity(change_in_speed_end(_2030)).
inputEntity(proximity(_2036,_2038)=true).
inputEntity(coord(_2030,_2032,_2034)).

outputEntity(withinArea(_2176,_2178)=true).
outputEntity(gap(_2176)=nearPorts).
outputEntity(gap(_2176)=farFromPorts).
outputEntity(stopped(_2176)=nearPorts).
outputEntity(stopped(_2176)=farFromPorts).
outputEntity(lowSpeed(_2176)=true).
outputEntity(changingSpeed(_2176)=true).
outputEntity(highSpeedNearCoast(_2176)=true).
outputEntity(movingSpeed(_2176)=below).
outputEntity(movingSpeed(_2176)=normal).
outputEntity(movingSpeed(_2176)=above).
outputEntity(drifting(_2176)=true).
outputEntity(tuggingSpeed(_2176)=true).
outputEntity(trawlSpeed(_2176)=true).
outputEntity(trawlingMovement(_2176)=true).
outputEntity(sarSpeed(_2176)=true).
outputEntity(sarMovement(_2176)=true).
outputEntity(trawlingMovement(_2176)=false).
outputEntity(sarMovement(_2176)=false).
outputEntity(underWay(_2176)=true).
outputEntity(anchoredOrMoored(_2176)=true).
outputEntity(tugging(_2176,_2178)=true).
outputEntity(rendezVous(_2176,_2178)=true).
outputEntity(trawling(_2176)=true).
outputEntity(inSAR(_2176)=true).
outputEntity(loitering(_2176)=true).
outputEntity(pilotOps(_2176,_2178)=true).

event(entersArea(_2388,_2390)).
event(gap_start(_2388)).
event(stop_start(_2388)).
event(slow_motion_start(_2388)).
event(change_in_speed_start(_2388)).
event(velocity(_2388,_2390,_2392,_2394)).
event(change_in_heading(_2388)).
event(leavesArea(_2388,_2390)).
event(gap_end(_2388)).
event(stop_end(_2388)).
event(slow_motion_end(_2388)).
event(change_in_speed_end(_2388)).
event(coord(_2388,_2390,_2392)).

simpleFluent(withinArea(_2528,_2530)=true).
simpleFluent(gap(_2528)=nearPorts).
simpleFluent(gap(_2528)=farFromPorts).
simpleFluent(stopped(_2528)=nearPorts).
simpleFluent(stopped(_2528)=farFromPorts).
simpleFluent(lowSpeed(_2528)=true).
simpleFluent(changingSpeed(_2528)=true).
simpleFluent(highSpeedNearCoast(_2528)=true).
simpleFluent(movingSpeed(_2528)=below).
simpleFluent(movingSpeed(_2528)=normal).
simpleFluent(movingSpeed(_2528)=above).
simpleFluent(drifting(_2528)=true).
simpleFluent(tuggingSpeed(_2528)=true).
simpleFluent(trawlSpeed(_2528)=true).
simpleFluent(trawlingMovement(_2528)=true).
simpleFluent(sarSpeed(_2528)=true).
simpleFluent(sarMovement(_2528)=true).
simpleFluent(trawlingMovement(_2528)=false).
simpleFluent(sarMovement(_2528)=false).

sDFluent(underWay(_2698)=true).
sDFluent(anchoredOrMoored(_2698)=true).
sDFluent(tugging(_2698,_2700)=true).
sDFluent(rendezVous(_2698,_2700)=true).
sDFluent(trawling(_2698)=true).
sDFluent(inSAR(_2698)=true).
sDFluent(loitering(_2698)=true).
sDFluent(pilotOps(_2698,_2700)=true).
sDFluent(proximity(_2698,_2700)=true).

index(entersArea(_2754,_2808),_2754).
index(gap_start(_2754),_2754).
index(stop_start(_2754),_2754).
index(slow_motion_start(_2754),_2754).
index(change_in_speed_start(_2754),_2754).
index(velocity(_2754,_2808,_2810,_2812),_2754).
index(change_in_heading(_2754),_2754).
index(leavesArea(_2754,_2808),_2754).
index(gap_end(_2754),_2754).
index(stop_end(_2754),_2754).
index(slow_motion_end(_2754),_2754).
index(change_in_speed_end(_2754),_2754).
index(coord(_2754,_2808,_2810),_2754).
index(withinArea(_2754,_2814)=true,_2754).
index(gap(_2754)=nearPorts,_2754).
index(gap(_2754)=farFromPorts,_2754).
index(stopped(_2754)=nearPorts,_2754).
index(stopped(_2754)=farFromPorts,_2754).
index(lowSpeed(_2754)=true,_2754).
index(changingSpeed(_2754)=true,_2754).
index(highSpeedNearCoast(_2754)=true,_2754).
index(movingSpeed(_2754)=below,_2754).
index(movingSpeed(_2754)=normal,_2754).
index(movingSpeed(_2754)=above,_2754).
index(drifting(_2754)=true,_2754).
index(tuggingSpeed(_2754)=true,_2754).
index(trawlSpeed(_2754)=true,_2754).
index(trawlingMovement(_2754)=true,_2754).
index(sarSpeed(_2754)=true,_2754).
index(sarMovement(_2754)=true,_2754).
index(trawlingMovement(_2754)=false,_2754).
index(sarMovement(_2754)=false,_2754).
index(underWay(_2754)=true,_2754).
index(anchoredOrMoored(_2754)=true,_2754).
index(tugging(_2754,_2814)=true,_2754).
index(rendezVous(_2754,_2814)=true,_2754).
index(trawling(_2754)=true,_2754).
index(inSAR(_2754)=true,_2754).
index(loitering(_2754)=true,_2754).
index(pilotOps(_2754,_2814)=true,_2754).
index(proximity(_2754,_2814)=true,_2754).


cachingOrder2(_3228, withinArea(_3228,_3230)=true) :- % level: 1
     vessel(_3228),areaType(_3230).

cachingOrder2(_3386, gap(_3386)=nearPorts) :- % level: 2
     vessel(_3386),portStatus(nearPorts).

cachingOrder2(_3370, gap(_3370)=farFromPorts) :- % level: 2
     vessel(_3370),portStatus(farFromPorts).

cachingOrder2(_3354, highSpeedNearCoast(_3354)=true) :- % level: 2
     vessel(_3354).

cachingOrder2(_3338, trawlingMovement(_3338)=true) :- % level: 2
     vessel(_3338),vesselType(_3338,fishing).

cachingOrder2(_3754, stopped(_3754)=nearPorts) :- % level: 3
     vessel(_3754),portStatus(nearPorts).

cachingOrder2(_3738, stopped(_3738)=farFromPorts) :- % level: 3
     vessel(_3738),portStatus(farFromPorts).

cachingOrder2(_3722, lowSpeed(_3722)=true) :- % level: 3
     vessel(_3722).

cachingOrder2(_3706, changingSpeed(_3706)=true) :- % level: 3
     vessel(_3706).

cachingOrder2(_3690, movingSpeed(_3690)=below) :- % level: 3
     vessel(_3690),movingStatus(below).

cachingOrder2(_3674, movingSpeed(_3674)=normal) :- % level: 3
     vessel(_3674),movingStatus(normal).

cachingOrder2(_3658, movingSpeed(_3658)=above) :- % level: 3
     vessel(_3658),movingStatus(above).

cachingOrder2(_3642, tuggingSpeed(_3642)=true) :- % level: 3
     vessel(_3642).

cachingOrder2(_3626, trawlSpeed(_3626)=true) :- % level: 3
     vessel(_3626),vesselType(_3626,fishing).

cachingOrder2(_3610, sarSpeed(_3610)=true) :- % level: 3
     vessel(_3610),vesselType(_3610,sar).

cachingOrder2(_4314, sarMovement(_4314)=true) :- % level: 4
     vessel(_4314),vesselType(_4314,sar).

cachingOrder2(_4298, underWay(_4298)=true) :- % level: 4
     vessel(_4298).

cachingOrder2(_4282, anchoredOrMoored(_4282)=true) :- % level: 4
     vessel(_4282).

cachingOrder2(_4264, tugging(_4264,_4266)=true) :- % level: 4
     vpair(_4264,_4266).

cachingOrder2(_4246, rendezVous(_4246,_4248)=true) :- % level: 4
     vpair(_4246,_4248).

cachingOrder2(_4230, trawling(_4230)=true) :- % level: 4
     vessel(_4230).

cachingOrder2(_4212, pilotOps(_4212,_4214)=true) :- % level: 4
     vpair(_4212,_4214).

cachingOrder2(_4674, drifting(_4674)=true) :- % level: 5
     vessel(_4674).

cachingOrder2(_4658, sarMovement(_4658)=false) :- % level: 5
     vessel(_4658),vesselType(_4658,sar).

cachingOrder2(_4642, inSAR(_4642)=true) :- % level: 5
     vessel(_4642).

cachingOrder2(_4626, loitering(_4626)=true) :- % level: 5
     vessel(_4626).

collectGrounds([entersArea(_2576,_2590), gap_start(_2576), stop_start(_2576), slow_motion_start(_2576), change_in_speed_start(_2576), velocity(_2576,_2590,_2592,_2594), change_in_heading(_2576), leavesArea(_2576,_2590), gap_end(_2576), stop_end(_2576), slow_motion_end(_2576), change_in_speed_end(_2576), coord(_2576,_2590,_2592)],vessel(_2576)).

collectGrounds([proximity(_2564,_2566)=true],vpair(_2564,_2566)).

dgrounded(withinArea(_3652,_3654)=true, vessel(_3652)).
dgrounded(gap(_3610)=nearPorts, vessel(_3610)).
dgrounded(gap(_3568)=farFromPorts, vessel(_3568)).
dgrounded(stopped(_3526)=nearPorts, vessel(_3526)).
dgrounded(stopped(_3484)=farFromPorts, vessel(_3484)).
dgrounded(lowSpeed(_3452)=true, vessel(_3452)).
dgrounded(changingSpeed(_3420)=true, vessel(_3420)).
dgrounded(highSpeedNearCoast(_3388)=true, vessel(_3388)).
dgrounded(movingSpeed(_3346)=below, vessel(_3346)).
dgrounded(movingSpeed(_3304)=normal, vessel(_3304)).
dgrounded(movingSpeed(_3262)=above, vessel(_3262)).
dgrounded(drifting(_3230)=true, vessel(_3230)).
dgrounded(tuggingSpeed(_3198)=true, vessel(_3198)).
dgrounded(trawlSpeed(_3154)=true, vessel(_3154)).
dgrounded(trawlingMovement(_3110)=true, vessel(_3110)).
dgrounded(sarSpeed(_3066)=true, vessel(_3066)).
dgrounded(sarMovement(_3022)=true, vessel(_3022)).
dgrounded(trawlingMovement(_2978)=false, vessel(_2978)).
dgrounded(sarMovement(_2934)=false, vessel(_2934)).
dgrounded(underWay(_2902)=true, vessel(_2902)).
dgrounded(anchoredOrMoored(_2870)=true, vessel(_2870)).
dgrounded(tugging(_2834,_2836)=true, vpair(_2834,_2836)).
dgrounded(rendezVous(_2798,_2800)=true, vpair(_2798,_2800)).
dgrounded(trawling(_2766)=true, vessel(_2766)).
dgrounded(inSAR(_2734)=true, vessel(_2734)).
dgrounded(loitering(_2702)=true, vessel(_2702)).
dgrounded(pilotOps(_2666,_2668)=true, vpair(_2666,_2668)).
