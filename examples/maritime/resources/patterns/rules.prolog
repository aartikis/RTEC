
%----------------within area -----------------%

initiatedAt(withinArea(Vessel, AreaType)=true, T) :-
    happensAt(entersArea(Vessel, Area), T),
    areaType(Area, AreaType).

terminatedAt(withinArea(Vessel, AreaType)=true, T) :-
    happensAt(leavesArea(Vessel, Area), T),
    areaType(Area, AreaType).

terminatedAt(withinArea(Vessel, _AreaType)=true, T) :-
    happensAt(gap_start(Vessel), T).


%--------------- communication gap -----------%

initiatedAt(gap(Vessel)=nearPorts, T) :-
    happensAt(gap_start(Vessel), T),
    holdsAt(withinArea(Vessel, nearPorts)=true, T).

initiatedAt(gap(Vessel)=farFromPorts, T) :-
    happensAt(gap_start(Vessel), T),
    \+holdsAt(withinArea(Vessel, nearPorts)=true, T).

terminatedAt(gap(Vessel)=_PortStatus, T) :-
    happensAt(gap_end(Vessel), T).


%-------------- stopped-----------------------%

initiatedAt(stopped(Vessel)=nearPorts, T) :-
    happensAt(stop_start(Vessel), T),
    holdsAt(withinArea(Vessel, nearPorts)=true, T).

initiatedAt(stopped(Vessel)=farFromPorts, T) :-
    happensAt(stop_start(Vessel), T),
    \+holdsAt(withinArea(Vessel, nearPorts)=true, T).

terminatedAt(stopped(Vessel)=_Status, T) :-
    happensAt(stop_end(Vessel), T).

terminatedAt(stopped(Vessel)=_Status, T) :-
    happensAt(start(gap(Vessel)=_GapStatus), T).


%-------------- lowspeed----------------------%

initiatedAt(lowSpeed(Vessel)=true, T) :-  
    happensAt(slow_motion_start(Vessel), T).

terminatedAt(lowSpeed(Vessel)=true, T) :-
    happensAt(slow_motion_end(Vessel), T).

terminatedAt(lowSpeed(Vessel)=true, T) :-
    happensAt(start(gap(Vessel)=_Status), T).


%-------------- changingSpeed ----------------%

initiatedAt(changingSpeed(Vessel)=true, T) :-  
    happensAt(change_in_speed_start(Vessel), T).

terminatedAt(changingSpeed(Vessel)=true, T) :-
    happensAt(change_in_speed_end(Vessel), T).

terminatedAt(changingSpeed(Vessel)=true, T) :-
    happensAt(start(gap(Vessel)=_Status), T).


%------------ highSpeedNearCoast -------------%

initiatedAt(highSpeedNearCoast(Vessel)=true, T):-
    happensAt(velocity(Vessel, Speed, _, _), T),
    thresholds(hcNearCoastMax, HcNearCoastMax),
    \+ inRange(Speed, 0, HcNearCoastMax),
    holdsAt(withinArea(Vessel, nearCoast)=true, T).

terminatedAt(highSpeedNearCoast(Vessel)=true, T):-
    happensAt(velocity(Vessel, Speed, _, _), T),
    thresholds(hcNearCoastMax, HcNearCoastMax),
    inRange(Speed, 0, HcNearCoastMax).

terminatedAt(highSpeedNearCoast(Vessel)=true, T):-
    happensAt(end(withinArea(Vessel, nearCoast)=true), T).


%--------------- movingSpeed -----------------%

initiatedAt(movingSpeed(Vessel)=below, T) :-
    happensAt(velocity(Vessel, Speed, _, _), T),
    vesselType(Vessel, Type),
    typeSpeed(Type, Min, _Max, _Avg),
    thresholds(movingMin, MovingMin),
    inRange(Speed, MovingMin, Min).

initiatedAt(movingSpeed(Vessel)=normal, T) :-
    happensAt(velocity(Vessel, Speed, _, _), T),
    vesselType(Vessel, Type),
    typeSpeed(Type, Min, Max, _Avg),
    inRange(Speed, Min, Max).

initiatedAt(movingSpeed(Vessel)=above, T) :-
    happensAt(velocity(Vessel, Speed, _,_), T),
    vesselType(Vessel, Type),
    typeSpeed(Type, _Min, Max,_Avg),
    inRange(Speed, Max, inf).

terminatedAt(movingSpeed(Vessel)=_Status, T) :-
    happensAt(velocity(Vessel, Speed, _,_), T),
    thresholds(movingMin,MovingMin),
    \+inRange(Speed, MovingMin, inf).

terminatedAt(movingSpeed(Vessel)=_Status, T) :-
    happensAt(start(gap(Vessel)=_GapStatus), T).


%----------------- underWay ------------------% 

holdsFor(underWay(Vessel)=true, I) :-
	holdsFor(movingSpeed(Vessel)=below, I1),
	holdsFor(movingSpeed(Vessel)=normal, I2),
	holdsFor(movingSpeed(Vessel)=above, I3),
	union_all([I1,I2,I3], I).

%----------------- drifitng ------------------%

initiatedAt(drifting(Vessel)=true, T) :-
    happensAt(velocity(Vessel,_Speed, CourseOverGround, TrueHeading), T),
    TrueHeading =\= 511.0,
    absoluteAngleDiff(CourseOverGround, TrueHeading, AngleDiff),
    thresholds(adriftAngThr, AdriftAngThr),
    AngleDiff > AdriftAngThr,
    holdsAt(underWay(Vessel)=true, T).

terminatedAt(drifting(Vessel)=true, T) :-
    happensAt(velocity(Vessel,_Speed, CourseOverGround, TrueHeading), T),
    absoluteAngleDiff(CourseOverGround, TrueHeading, AngleDiff),
    thresholds(adriftAngThr, AdriftAngThr),
    AngleDiff =< AdriftAngThr.

terminatedAt(drifting(Vessel)=true, T) :-
    happensAt(velocity(Vessel,_Speed, _CourseOverGround, 511.0), T).

terminatedAt(drifting(Vessel)=true, T) :-
    happensAt(end(underWay(Vessel)=true), T).


%-------------- anchoredOrMoored ---------------%

holdsFor(anchoredOrMoored(Vessel)=true, I) :-
    holdsFor(stopped(Vessel)=farFromPorts, Istfp),
    holdsFor(withinArea(Vessel, anchorage)=true, Ia),
    intersect_all([Istfp, Ia], Ista),
    holdsFor(stopped(Vessel)=nearPorts, Istnp),
    union_all([Ista, Istnp], Ii),
    thresholds(aOrMTime, AOrMTime),
    intDurGreater(Ii, AOrMTime, I).


%---------------- tugging (B) ----------------%

initiatedAt(tuggingSpeed(Vessel)=true , T) :-
    happensAt(velocity(Vessel, Speed, _, _), T),
    thresholds(tuggingMin, TuggingMin),
    thresholds(tuggingMax, TuggingMax),
    inRange(Speed, TuggingMin, TuggingMax).

terminatedAt(tuggingSpeed(Vessel)=true , T) :-
    happensAt(velocity(Vessel, Speed, _, _), T),
    thresholds(tuggingMin, TuggingMin),
    thresholds(tuggingMax, TuggingMax),
    \+inRange(Speed, TuggingMin, TuggingMax).

terminatedAt(tuggingSpeed(Vessel)=true , T) :-
    happensAt(start(gap(Vessel)=_Status), T).

holdsFor(tugging(Vessel1, Vessel2)=true, I) :-
    holdsFor(proximity(Vessel1, Vessel2)=true, Ip),
    oneIsTug(Vessel1, Vessel2),
    \+oneIsPilot(Vessel1, Vessel2),
    \+twoAreTugs(Vessel1, Vessel2),
    holdsFor(tuggingSpeed(Vessel1)=true, Its1),
    holdsFor(tuggingSpeed(Vessel2)=true, Its2),
    intersect_all([Ip, Its1, Its2], Ii),
    thresholds(tuggingTime, TuggingTime),
    intDurGreater(Ii, TuggingTime, I).   


%---------------- rendezVous -----------------%

holdsFor(rendezVous(Vessel1, Vessel2)=true, I) :-
    holdsFor(proximity(Vessel1, Vessel2)=true, Ip),
    \+oneIsTug(Vessel1, Vessel2),
    \+oneIsPilot(Vessel1, Vessel2),
    holdsFor(lowSpeed(Vessel1)=true, Il1),
    holdsFor(lowSpeed(Vessel2)=true, Il2),
    holdsFor(stopped(Vessel1)=farFromPorts, Is1),
    holdsFor(stopped(Vessel2)=farFromPorts, Is2),
    union_all([Il1, Is1], I1b),
    union_all([Il2, Is2], I2b),
    intersect_all([I1b, I2b, Ip], If), If\=[],
    holdsFor(withinArea(Vessel1, nearPorts)=true, Iw1),
    holdsFor(withinArea(Vessel2, nearPorts)=true, Iw2),
    holdsFor(withinArea(Vessel1, nearCoast)=true, Iw3),
    holdsFor(withinArea(Vessel2, nearCoast)=true, Iw4),
    relative_complement_all(If,[Iw1, Iw2, Iw3, Iw4], Ii),
    thresholds(rendezvousTime, RendezvousTime),
    intDurGreater(Ii, RendezvousTime, I).

%---------------- trawlSpeed -----------------%

initiatedAt(trawlSpeed(Vessel)=true, T):-
    %vesselType(Vessel, fishing),
    happensAt(velocity(Vessel, Speed, _Heading,_), T),
    thresholds(trawlspeedMin, TrawlspeedMin),
    thresholds(trawlspeedMax, TrawlspeedMax),
    inRange(Speed, TrawlspeedMin, TrawlspeedMax),
    holdsAt(withinArea(Vessel, fishing)=true, T).

terminatedAt(trawlSpeed(Vessel)=true, T):-
    %vesselType(Vessel, fishing),
    happensAt(velocity(Vessel, Speed, _Heading,_), T),
    thresholds(trawlspeedMin, TrawlspeedMin),
    thresholds(trawlspeedMax, TrawlspeedMax),
    \+inRange(Speed, TrawlspeedMin, TrawlspeedMax).

terminatedAt(trawlSpeed(Vessel)=true, T):-
    happensAt(start(gap(Vessel)=_Status), T).

terminatedAt(trawlSpeed(Vessel)=true, T):-
    happensAt(end(withinArea(Vessel, fishing)=true), T).


%--------------- trawling --------------------%

initiatedAt(trawlingMovement(Vessel)=true , T):-
    %vesselType(Vessel, fishing),
    happensAt(change_in_heading(Vessel), T),
    holdsAt(withinArea(Vessel, fishing)=true, T).

terminatedAt(trawlingMovement(Vessel)=true, T):-
    happensAt(end(withinArea(Vessel, fishing)=true), T).

fi(trawlingMovement(Vessel)=true, trawlingMovement(Vessel)=false, TrawlingCrs):-
	thresholds(trawlingCrs, TrawlingCrs).
p(trawlingMovement(_Vessel)=true).

holdsFor(trawling(Vessel)=true, I):-
    holdsFor(trawlSpeed(Vessel)=true, It),
    holdsFor(trawlingMovement(Vessel)=true, Itc),
    intersect_all([It, Itc], Ii),
    thresholds(trawlingTime, TrawlingTime),
    intDurGreater(Ii, TrawlingTime, I).

%-------------------------- SAR --------------%

initiatedAt(sarSpeed(Vessel)=true , T):-
    %vesselType(Vessel, sar),
    happensAt(velocity(Vessel, Speed, _, _), T),
    thresholds(sarMinSpeed, SarMinSpeed),
    inRange(Speed,SarMinSpeed,inf).

terminatedAt(sarSpeed(Vessel)=true, T):-
    %vesselType(Vessel, sar),
    happensAt(velocity(Vessel, Speed, _, _), T),
    thresholds(sarMinSpeed, SarMinSpeed),
    inRange(Speed,0,SarMinSpeed).

terminatedAt(sarSpeed(Vessel)=true, T):-
    happensAt(start(gap(Vessel)=_Status), T).

initiatedAt(sarMovement(Vessel)=true, T):-
    %vesselType(Vessel, sar),
    happensAt(change_in_heading(Vessel), T).

initiatedAt(sarMovement(Vessel)=true , T):-
    %vesselType(Vessel, sar),
    happensAt(start(changingSpeed(Vessel)=true), T).

terminatedAt(sarMovement(Vessel)=true, T):-
    %vesselType(Vessel, sar),
    happensAt(start(gap(Vessel)=_Status), T).

fi(sarMovement(Vessel)=true, sarMovement(Vessel)=false, 1800).
p(sarMovement(_Vessel)=true).

holdsFor(inSAR(Vessel)=true, I):-
    holdsFor(sarSpeed(Vessel)=true, Iss),
    holdsFor(sarMovement(Vessel)=true, Isc),
    intersect_all([Iss, Isc], Ii),
    intDurGreater(Ii, 3600, I).

%-------- loitering --------------------------%

holdsFor(loitering(Vessel)=true, I) :-
    holdsFor(lowSpeed(Vessel)=true, Il),
    holdsFor(stopped(Vessel)=farFromPorts, Is),
    union_all([Il, Is], Ils),
    holdsFor(withinArea(Vessel, nearCoast)=true, Inc),
    holdsFor(anchoredOrMoored(Vessel)=true, Iam),
    relative_complement_all(Ils, [Inc,Iam], Ii),
    thresholds(loiteringTime, LoiteringTime),
    intDurGreater(Ii, LoiteringTime, I).


%-------- pilotOps ---------------------------%

holdsFor(pilotOps(Vessel1, Vessel2)=true, I) :-
    holdsFor(proximity(Vessel1, Vessel2)=true, Ip),
    oneIsPilot(Vessel1, Vessel2),
    holdsFor(lowSpeed(Vessel1)=true, Il1),
    holdsFor(lowSpeed(Vessel2)=true, Il2),
    holdsFor(stopped(Vessel1)=farFromPorts, Is1),
    holdsFor(stopped(Vessel2)=farFromPorts, Is2),
    union_all([Il1, Is1], I1b),
    union_all([Il2, Is2], I2b),
    intersect_all([I1b, I2b, Ip], Ii), Ii\=[],
    holdsFor(withinArea(Vessel1, nearCoast)=true, Iw1),
    holdsFor(withinArea(Vessel2, nearCoast)=true, Iw2),
    relative_complement_all(Ii,[Iw1, Iw2], I).

% proximity is an input statically determined fluent.
% its instances arrive in the form of intervals.
collectIntervals(proximity(_,_)=true).

% The elements of these domains are derived from the ground arguments of input entitites
dynamicDomain(vessel(_Vessel)).
dynamicDomain(vpair(_Vessel1,_Vessel2)).

% Groundings of input entities
grounding(change_in_speed_start(V)):- vessel(V).
grounding(change_in_speed_end(V)):- vessel(V).
grounding(change_in_heading(V)):- vessel(V).
grounding(stop_start(V)):- vessel(V).
grounding(stop_end(V)):- vessel(V).
grounding(slow_motion_start(V)):- vessel(V).
grounding(slow_motion_end(V)):- vessel(V).
grounding(gap_start(V)):- vessel(V).
grounding(gap_end(V)):- vessel(V).
grounding(entersArea(V,Area)):- vessel(V), areaType(Area).
grounding(leavesArea(V,Area)):- vessel(V), areaType(Area).
grounding(coord(V,_,_)):- vessel(V).
grounding(velocity(V,_,_,_)):- vessel(V).
grounding(proximity(Vessel1, Vessel2)=true):- vpair(Vessel1, Vessel2).

% Groundings of output entities
grounding(gap(Vessel)=PortStatus):-
	vessel(Vessel), portStatus(PortStatus).
grounding(stopped(Vessel)=PortStatus):-
	vessel(Vessel), portStatus(PortStatus).
grounding(lowSpeed(Vessel)=true):-
	vessel(Vessel).
grounding(changingSpeed(Vessel)=true):-
	vessel(Vessel).
grounding(withinArea(Vessel, AreaType)=true):-
	vessel(Vessel), areaType(AreaType).
grounding(underWay(Vessel)=true):-
	vessel(Vessel).
grounding(sarSpeed(Vessel)=true):-
	vessel(Vessel), vesselType(Vessel,sar).
grounding(sarMovement(Vessel)=true):-
	vessel(Vessel), vesselType(Vessel,sar).
grounding(sarMovement(Vessel)=false):-
	vessel(Vessel), vesselType(Vessel,sar).
grounding(inSAR(Vessel)=true):-
	vessel(Vessel).
grounding(highSpeedNearCoast(Vessel)=true):-
	vessel(Vessel).
grounding(drifting(Vessel)=true):-
	vessel(Vessel).
grounding(anchoredOrMoored(Vessel)=true):-
	vessel(Vessel).
grounding(trawlSpeed(Vessel)=true):-
	vessel(Vessel), vesselType(Vessel,fishing).
grounding(movingSpeed(Vessel)=Status):-
	vessel(Vessel), movingStatus(Status).
grounding(pilotOps(Vessel1, Vessel2)=true):-
	vpair(Vessel1, Vessel2).
grounding(tuggingSpeed(Vessel)=true):-
	vessel(Vessel).
grounding(tugging(Vessel1, Vessel2)=true):-
	vpair(Vessel1, Vessel2).
grounding(rendezVous(Vessel1, Vessel2)=true):-
	vpair(Vessel1, Vessel2).
grounding(trawlingMovement(Vessel)=true):-
	vessel(Vessel), vesselType(Vessel,fishing).
grounding(trawlingMovement(Vessel)=false):-
	vessel(Vessel), vesselType(Vessel,fishing).
grounding(trawling(Vessel)=true):-
	vessel(Vessel).
grounding(loitering(Vessel)=true):-
	vessel(Vessel).

needsGrounding(_, _, _) :-
	fail.
buildFromPoints(_) :-
	fail.
