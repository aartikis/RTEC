%----------------within area -----------------%

initiatedAt(withinArea(Vessel, AreaType)=true, T1, T, T2) :-
    happensAtIE(entersArea(Vessel,AreaID),T),T1=<T,T<T2,
    areaType(AreaID,AreaType).

 terminatedAt(withinArea(Vessel,AreaType)=true,T1, T, T2) :-
    happensAtIE(leavesArea(Vessel,AreaID),T),T1=<T,T<T2,
    areaType(AreaID,AreaType).

terminatedAt(withinArea(Vessel,_)=true, T1, T, T2) :-
    happensAtIE(gap_start(Vessel),T),
    T1=<T,
    T<T2.

%--------------- communication gap -----------%

initiatedAt(gap(Vessel)=nearPorts, T1, T, T2) :-
    happensAtIE(gap_start(Vessel),T),T1=<T,T<T2,
    holdsAtProcessedSimpleFluent(Vessel,withinArea(Vessel,nearPorts)=true,T).

initiatedAt(gap(Vessel)=farFromPorts, T1, T, T2) :-
    happensAtIE(gap_start(Vessel),T),T1=<T,T<T2,
    \+holdsAtProcessedSimpleFluent(Vessel,withinArea(Vessel,nearPorts)=true,T).

terminatedAt(gap(Vessel)=_, T1, T, T2) :-
    happensAtIE(gap_end(Vessel),T),
    T1=<T, T<T2.

%-------------- stopped-----------------------%

initiatedAt(stopped(Vessel)=nearPorts, T1, T, T2) :-
    happensAtIE(stop_start(Vessel),T),T1=<T,T<T2,
    holdsAtProcessedSimpleFluent(Vessel,withinArea(Vessel,nearPorts)=true,T).

initiatedAt(stopped(Vessel)=farFromPorts, T1, T, T2) :-
    happensAtIE(stop_start(Vessel),T), T1=<T,T<T2,
    \+holdsAtProcessedSimpleFluent(Vessel,withinArea(Vessel,nearPorts)=true,T).

terminatedAt(stopped(Vessel)=_, T1, T, T2) :-
    happensAtIE(stop_end(Vessel),T),
    T1=<T, T<T2.

terminatedAt(stopped(Vessel)=_, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_),T),
    T1=<T, T<T2.

%-------------- lowspeed----------------------%

initiatedAt(lowSpeed(Vessel)=true, T1, T, T2) :-
    happensAtIE(slow_motion_start(Vessel),T),
    T1=<T, T<T2.

terminatedAt(lowSpeed(Vessel)=true, T1, T, T2) :-
    happensAtIE(slow_motion_end(Vessel),T),
    T1=<T, T<T2.

terminatedAt(lowSpeed(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_),T),
    T1=<T, T<T2.

%-------------- changingSpeed ----------------%

initiatedAt(changingSpeed(Vessel)=true, T1, T, T2) :-
    happensAtIE(change_in_speed_start(Vessel),T), T1=<T,
    T<T2.

terminatedAt(changingSpeed(Vessel)=true, T1, T, T2) :-
    happensAtIE(change_in_speed_end(Vessel),T), T1=<T,
    T<T2.

terminatedAt(changingSpeed(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_),T), T1=<T,
    T<T2.

%------------ highSpeedNearCoast -------------%

initiatedAt(highSpeedNearCoast(Vessel)=true, T1, T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(hcNearCoastMax,SpeedThr),
    \+inRange(Speed,0,SpeedThr),
    holdsAtProcessedSimpleFluent(Vessel,withinArea(Vessel,nearCoast)=true,T).

terminatedAt(highSpeedNearCoast(Vessel)=true, T1, T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(hcNearCoastMax,Max),
    inRange(Speed,0,Max).

terminatedAt(highSpeedNearCoast(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,end(withinArea(Vessel,nearCoast)=true),T),
    T1=<T,
    T<T2.

%--------------- movingSpeed -----------------%

initiatedAt(movingSpeed(Vessel)=below, T1 , T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    vesselType(Vessel,Type),
    typeSpeed(Type,ShipTypeMin,_,_),
    thresholds(movingMin,MinThr),
    inRange(Speed,MinThr,ShipTypeMin).

initiatedAt(movingSpeed(Vessel)=normal, T1, T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    vesselType(Vessel,Type),
    typeSpeed(Type,Min,Max,_),
    inRange(Speed,Min,Max).

initiatedAt(movingSpeed(Vessel)=above, T1, T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    vesselType(Vessel,Type),
    typeSpeed(Type,_,Max,_),
    inRange(Speed,Max,inf).

terminatedAt(movingSpeed(Vessel)=_, T1, T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(movingMin,Min),
    \+inRange(Speed,Min,inf).

terminatedAt(movingSpeed(Vessel)=_, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_),T),
    T1=<T, T<T2.

%----------------- underWay ------------------% 

holdsForSDFluent(underWay(Vessel)=true,I) :-
    holdsForProcessedSimpleFluent(Vessel,movingSpeed(Vessel)=below,I1),
    holdsForProcessedSimpleFluent(Vessel,movingSpeed(Vessel)=normal,I2),
    holdsForProcessedSimpleFluent(Vessel,movingSpeed(Vessel)=above,I3),
    union_all([I1,I2,I3],I).

%----------------- drifitng ------------------%

initiatedAt(drifting(Vessel)=true, T1, T, T2) :-
    happensAtIE(velocity(Vessel,_,CoG,TrH),T),T1=<T,T<T2,
    TrH=\=511.0,
    absoluteAngleDiff(CoG,TrH,Diff),
    thresholds(adriftAngThr,Thr),
    Diff>Thr,
    holdsAtProcessedSDFluent(Vessel,underWay(Vessel)=true,T).

terminatedAt(drifting(Vessel)=true, T1, T, T2) :-
    happensAtIE(velocity(Vessel,_,CoG,TrH),T),T1=<T,T<T2,
    absoluteAngleDiff(CoG,TrH,Diff),
    thresholds(adriftAngThr,Thr),
    Diff=<Thr.

terminatedAt(drifting(Vessel)=true, T1, T, T2) :-
    happensAtIE(velocity(Vessel,_,_,511.0),T),
    T1=<T, T<T2.

terminatedAt(drifting(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSDFluent(Vessel,end(underWay(Vessel)=true),T),
    T1=<T, T<T2.

%-------------- anchoredOrMoored ---------------%

holdsForSDFluent(anchoredOrMoored(Vessel)=true,I) :-
    holdsForProcessedSimpleFluent(Vessel,stopped(Vessel)=farFromPorts,Isf),
    holdsForProcessedSimpleFluent(Vessel,withinArea(Vessel,anchorage)=true,Ia),
    intersect_all([Isf,Ia],Isfa),
    holdsForProcessedSimpleFluent(Vessel,stopped(Vessel)=nearPorts,Isn),
    union_all([Isfa,Isn],Ii),
    thresholds(aOrMTime,Thr),
    intDurGreater(Ii,Thr,I).


%---------------- tugging (B) ----------------%

initiatedAt(tuggingSpeed(Vessel)=true, T1, T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(tuggingMin,Min),
    thresholds(tuggingMax,Max),
    inRange(Speed,Min,Max).

terminatedAt(tuggingSpeed(Vessel)=true, T1, T, T2) :-
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(tuggingMin,Min),
    thresholds(tuggingMax,Max),
    \+inRange(Speed,Min,Max).

terminatedAt(tuggingSpeed(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_132083),T),
    T1=<T, T<T2.

holdsForSDFluent(tugging(Vessel1,Vessel2)=true,I) :-
    holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true,Ipr),
    oneIsTug(Vessel1,Vessel2),
    \+oneIsPilot(Vessel1,Vessel2),
    \+twoAreTugs(Vessel1,Vessel2),
    holdsForProcessedSimpleFluent(Vessel1,tuggingSpeed(Vessel1)=true,Its1),
    holdsForProcessedSimpleFluent(Vessel2,tuggingSpeed(Vessel2)=true,Its2),
    intersect_all([Ipr,Its1,Its2],Ii),
    thresholds(tuggingTime,Thr),
    intDurGreater(Ii,Thr,I).


%---------------- rendezVous -----------------%

holdsForSDFluent(rendezVous(Vessel1,Vessel2)=true,I) :-
    holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true,Ipr),
    \+oneIsTug(Vessel1,Vessel2),
    \+oneIsPilot(Vessel1,Vessel2),
    holdsForProcessedSimpleFluent(Vessel1,lowSpeed(Vessel1)=true,Il1),
    holdsForProcessedSimpleFluent(Vessel2,lowSpeed(Vessel2)=true,Il2),
    holdsForProcessedSimpleFluent(Vessel1,stopped(Vessel1)=farFromPorts,If1),
    holdsForProcessedSimpleFluent(Vessel2,stopped(Vessel2)=farFromPorts,If2),
    union_all([Il1,If1],Ilf1),
    union_all([Il2,If2],Ilf2),
    intersect_all([Ilf1,Ilf2,Ipr],Iprlf),
    Iprlf\=[],
    holdsForProcessedSimpleFluent(Vessel1,withinArea(Vessel1,nearPorts)=true,Inp1),
    holdsForProcessedSimpleFluent(Vessel2,withinArea(Vessel2,nearPorts)=true,Inp2),
    holdsForProcessedSimpleFluent(Vessel1,withinArea(Vessel1,nearCoast)=true,Inc1),
    holdsForProcessedSimpleFluent(Vessel2,withinArea(Vessel2,nearCoast)=true,Inc2),
    relative_complement_all(Iprlf,[Inp1,Inp2,Inc1,Inc2],Ii),
    thresholds(rendezvousTime,Thr),
    intDurGreater(Ii,Thr,I).

%---------------- trawlSpeed -----------------%

initiatedAt(trawlSpeed(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,fishing),
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(trawlspeedMin,Min),
    thresholds(trawlspeedMax,Max),
    inRange(Speed,Min,Max),
    holdsAtProcessedSimpleFluent(Vessel,withinArea(Vessel,fishing)=true,T).

terminatedAt(trawlSpeed(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,fishing),
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(trawlspeedMin,Min),
    thresholds(trawlspeedMax,Max),
    \+inRange(Speed,Min,Max).

terminatedAt(trawlSpeed(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_),T),
    T1=<T, T<T2.

terminatedAt(trawlSpeed(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,end(withinArea(Vessel,fishing)=true),T),
    T1=<T, T<T2.


%--------------- trawling --------------------%

initiatedAt(trawlingMovement(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,fishing),
    happensAtIE(change_in_heading(Vessel),T),T1=<T,T<T2,
    holdsAtProcessedSimpleFluent(Vessel,withinArea(Vessel,fishing)=true,T).

terminatedAt(trawlingMovement(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,end(withinArea(Vessel,fishing)=true),T),
    T1=<T, T<T2.

maxDurationUE(trawlingMovement(Vessel)=true,trawlingMovement(Vessel)=false,Thr) :- 
    thresholds(trawlingCrs,Thr),grounding(trawlingMovement(Vessel)=true).

holdsForSDFluent(trawling(Vessel)=true,I) :-
    holdsForProcessedSimpleFluent(Vessel,trawlSpeed(Vessel)=true,Its),
    holdsForProcessedSimpleFluent(Vessel,trawlingMovement(Vessel)=true,Itm),
    intersect_all([Its,Itm],Ii),
    thresholds(trawlingTime,Thr),
    intDurGreater(Ii,Thr,I).


%-------------------------- SAR --------------%

initiatedAt(sarSpeed(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,sar),
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(sarMinSpeed,Min),
    inRange(Speed,Min,inf).

terminatedAt(sarSpeed(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,sar),
    happensAtIE(velocity(Vessel,Speed,_,_),T),T1=<T,T<T2,
    thresholds(sarMinSpeed,Min),
    inRange(Speed,0,Min).

terminatedAt(sarSpeed(Vessel)=true, T1, T, T2) :-
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_),T),
    T1=<T, T<T2.


initiatedAt(sarMovement(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,sar),
    happensAtIE(change_in_heading(Vessel),T),T1=<T,T<T2.

initiatedAt(sarMovement(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,sar),
    happensAtProcessedSimpleFluent(Vessel,start(changingSpeed(Vessel)=true),T),
    T1=<T,T<T2.

terminatedAt(sarMovement(Vessel)=true, T1, T, T2) :-
    %vesselType(Vessel,sar),
    happensAtProcessedSimpleFluent(Vessel,start(gap(Vessel)=_),T),T1=<T,T<T2.


maxDurationUE(sarMovement(Vessel)=true,sarMovement(Vessel)=false,1800) :- 
    grounding(sarMovement(Vessel)=true).

holdsForSDFluent(inSAR(Vessel)=true,I) :-
    holdsForProcessedSimpleFluent(Vessel,sarSpeed(Vessel)=true,Iss),
    holdsForProcessedSimpleFluent(Vessel,sarMovement(Vessel)=true,Ism),
    intersect_all([Iss,Ism],Ii),
    intDurGreater(Ii,3600,I).


%-------- loitering --------------------------%

holdsForSDFluent(loitering(Vessel)=true,I) :-
    holdsForProcessedSimpleFluent(Vessel,lowSpeed(Vessel)=true,Il),
    holdsForProcessedSimpleFluent(Vessel,stopped(Vessel)=farFromPorts,If),
    union_all([Il,If],Ilf),
    holdsForProcessedSimpleFluent(Vessel,withinArea(Vessel,nearCoast)=true,Inc),
    holdsForProcessedSDFluent(Vessel,anchoredOrMoored(Vessel)=true,Iam),
    relative_complement_all(Ilf,[Inc,Iam],Ii),
    thresholds(loiteringTime,Thr),
    intDurGreater(Ii,Thr,I).


%-------- pilotOps ---------------------------%

holdsForSDFluent(pilotOps(Vessel1,Vessel2)=true,I) :-
    holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true,Ipr),
    oneIsPilot(Vessel1,Vessel2),
    holdsForProcessedSimpleFluent(Vessel1,lowSpeed(Vessel1)=true,Il1),
    holdsForProcessedSimpleFluent(Vessel2,lowSpeed(Vessel2)=true,Il2),
    holdsForProcessedSimpleFluent(Vessel1,stopped(Vessel1)=farFromPorts,If1),
    holdsForProcessedSimpleFluent(Vessel2,stopped(Vessel2)=farFromPorts,If2),
    union_all([Il1,If1],Ilf1),
    union_all([Il2,If2],Ilf2),
    intersect_all([Ilf1,Ilf2,Ipr],Ii),
    Ii\=[],
    holdsForProcessedSimpleFluent(Vessel1,withinArea(Vessel1,nearCoast)=true,Inc1),
    holdsForProcessedSimpleFluent(Vessel2,withinArea(Vessel2,nearCoast)=true,Inc2),
    relative_complement_all(Ii,[Inc1,Inc2],I).


%%%%
% The compiler is currently agnostic to the allen predicate.
% I use the compiled version of allen directly. 
%
% Allen Relations as:
% - Interval operators:
%	Compute the interval pairs satisfying the selected relation and then apply the output operation.
% - Boolean conditions:
% 	The second to last argument of the allen predicate has the following meaning:
% 	- true -> at least one pair of intervals satisfies the relation.
% 	- false -> no pair of intervals satisfies the relation.
%   We could check whether the output list is empty or not to confirm this.
%
% The format of the allen predicate could be the following:
% 	relationName(Is, It, Op, Iout)
%
% The first two arguments of the compiled version can be derived by the compiler, and the second to last argument is probably not needed.
%%%% 

%-------- The following patterns include Allen relations -----------%

%-------- disappearedInArea ---------------------------%
holdsForSDFluent(disappearedInArea(Vessel, AreaType)=true, I):-
	holdsForProcessedSimpleFluent(Vessel, withinArea(Vessel, AreaType)=true, Iwa),
	holdsForProcessedSimpleFluent(Vessel, gap(Vessel)=farFromPorts, Ig),
	meets(disappearedInArea(Vessel, AreaType)=true, 1, Iwa, Ig, union, true, I).
	
%-------- stoppedWithinArea ---------------------------%
holdsForSDFluent(stoppedWithinArea(Vessel, AreaType)=true, I):-
	holdsForProcessedSimpleFluent(Vessel, withinArea(Vessel, AreaType)=true, Iwa),
	holdsForProcessedSimpleFluent(Vessel, stopped(Vessel)=farFromPorts, Is),
	during(stoppedWithinArea(Vessel, AreaType)=true, 1, Is, Iwa, lhs, true, I).

%-------- stoppedMeetsGap ---------------------------%
holdsForSDFluent(stoppedMeetsGap(Vessel)=true, I):-
	holdsForProcessedSimpleFluent(Vessel, stopped(Vessel)=farFromPorts, Is),
	holdsForProcessedSimpleFluent(Vessel, gap(Vessel)=farFromPorts, Ig),
	meets(stoppedMeetsGap(Vessel)=true, 1, Is, Ig, union, true, I).

%-------- highSpeedNCBeforeDrifting ---------------------------%
holdsForSDFluent(highSpeedNCBeforeDrifting(Vessel)=true, I):-
	holdsForProcessedSimpleFluent(Vessel, highSpeedNearCoast(Vessel)=true, Ih),
	holdsForProcessedSimpleFluent(Vessel, drifting(Vessel)=true, Id),
	before(highSpeedNCBeforeDrifting(Vessel)=true, 1, Ih, Id, union, true, I).

%-------- dangerNearCoast ---------------------------%
holdsForSDFluent(dangerNearCoast(Vessel)=true, I):-
	holdsForProcessedSimpleFluent(Vessel, highSpeedNearCoast(Vessel)=true, Ih),
	holdsForProcessedSimpleFluent(Vessel, drifting(Vessel)=true, Id),
	overlaps(dangerNearCoast(Vessel)=true, 1, Ih, Id, union, true, I).

%-------- gainingSpeed ---------------------------%
holdsForSDFluent(gainingSpeed(Vessel)=true, I):-
	holdsForProcessedSimpleFluent(Vessel, movingSpeed(Vessel)=below, Ib),
	holdsForProcessedSimpleFluent(Vessel, movingSpeed(Vessel)=normal, In),
	meets(gainingSpeed(Vessel)=true, 1, Ib, In, union, true, I).

%-------- speedChangeAbove ---------------------------%
holdsForSDFluent(speedChangeAbove(Vessel)=true, I):-
	holdsForProcessedSimpleFluent(Vessel, changingSpeed(Vessel)=true, Ic),
	holdsForProcessedSimpleFluent(Vessel, movingSpeed(Vessel)=above, Ia),
	starts(speedChangeAbove(Vessel)=true, 1, Ic, Ia, relative_complement_inverse, true, I).

%-------- collisionDanger ---------------------------%
holdsForSDFluent(collisionDanger(Vessel1, Vessel2)=true, I):- 
    holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true,Ip),
    holdsForProcessedSimpleFluent(Vessel1, movingSpeed(Vessel1)=above, Imsa1),
    holdsForProcessedSimpleFluent(Vessel2, movingSpeed(Vessel2)=above, Imsa2),
	union_all([Imsa1,Imsa2],Imsa),
    overlaps(collisionDanger(Vessel1, Vessel2)=true, 1, Imsa, Ip, intersection, true, I).

%-------- suspiciousRendezVous ---------------------------%
holdsForSDFluent(suspiciousRendezVous(Vessel1, Vessel2)=true, I):-
    holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true,Ip),
    holdsForProcessedSimpleFluent(Vessel1, gap(Vessel1)=_, Ig1),
    holdsForProcessedSimpleFluent(Vessel2, gap(Vessel2)=_, Ig2),
	union_all([Ig1,Ig2], Ig),
    during(suspiciousRendezVous(Vessel1, Vessel2)=true, 1, Ig, Ip, lhs, true, I).

%-------- anchoredFarFromPorts ---------------------------%
holdsForSDFluent(anchoredFarFromPorts(Vessel)=true,I) :-
	holdsForProcessedSDFluent(Vessel, anchoredOrMoored(Vessel)=true, Iaom),
    holdsForProcessedSimpleFluent(Vessel,stopped(Vessel)=farFromPorts,Isf),
    holdsForProcessedSimpleFluent(Vessel,withinArea(Vessel,anchorage)=true,Ia),
    intersect_all([Isf,Ia],Isfa),
	equal(anchoredFarFromPorts(Vessel)=true, 1, Iaom, Isfa, lhs, true, I).

%-------- anchoredNearPorts ---------------------------%
holdsForSDFluent(anchoredNearPorts(Vessel)=true,I) :-
	holdsForProcessedSDFluent(Vessel, anchoredOrMoored(Vessel)=true, Iaom),
    holdsForProcessedSimpleFluent(Vessel,stopped(Vessel)=nearPorts,Isn),
	equal(anchoredNearPorts(Vessel)=true, 1, Iaom, Isn, lhs, true, I).

%-------- tuggingStartsProximity ---------------------------%
holdsForSDFluent(tuggingStartsProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,tugging(Vessel1,Vessel2)=true, It),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	starts(tuggingStartsProximity(Vessel1,Vessel2)=true, 1, It, Ip, lhs, true, I).

%-------- tuggingFinishesProximity ---------------------------%
holdsForSDFluent(tuggingFinishesProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,tugging(Vessel1,Vessel2)=true, It),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	finishes(tuggingFinishesProximity(Vessel1,Vessel2)=true, 1, It, Ip, lhs, true, I).

%-------- tuggingEqualProximity ---------------------------%
holdsForSDFluent(tuggingEqualProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,tugging(Vessel1,Vessel2)=true, It),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	equal(tuggingEqualProximity(Vessel1,Vessel2)=true, 1, It, Ip, lhs, true, I).

%-------- rendezVousStartsProximity ---------------------------%
holdsForSDFluent(rendezVousStartsProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,rendezVous(Vessel1,Vessel2)=true, Ir),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	starts(rendezVousStartsProximity(Vessel1,Vessel2)=true, 1, Ir, Ip, lhs, true, I).

%-------- rendezVousFinishesProximity ---------------------------%
holdsForSDFluent(rendezVousFinishesProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,rendezVous(Vessel1,Vessel2)=true, Ir),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	finishes(rendezVousFinishesProximity(Vessel1,Vessel2)=true, 1, Ir, Ip, lhs, true, I).

%-------- rendezVousEqualProximity ---------------------------%
holdsForSDFluent(rendezVousEqualProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,rendezVous(Vessel1,Vessel2)=true, Ir),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	equal(rendezVousEqualProximity(Vessel1,Vessel2)=true, 1, Ir, Ip, lhs, true, I).

%-------- pilotOpsStartsProximity ---------------------------%
holdsForSDFluent(pilotOpsStartsProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,pilotOps(Vessel1,Vessel2)=true, Ipo),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	starts(pilotOpsStartsProximity(Vessel1,Vessel2)=true, 1, Ipo, Ip, lhs, true, I).

%-------- pilotOpsFinishesProximity ---------------------------%
holdsForSDFluent(pilotOpsFinishesProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,pilotOps(Vessel1,Vessel2)=true, Ipo),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	finishes(pilotOpsFinishesProximity(Vessel1,Vessel2)=true, 1, Ipo, Ip, lhs, true, I).

%-------- pilotOpsEqualProximity ---------------------------%
holdsForSDFluent(pilotOpsEqualProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,pilotOps(Vessel1,Vessel2)=true, Ipo),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	equal(pilotOpsEqualProximity(Vessel1,Vessel2)=true, 1, Ipo, Ip, lhs, true, I).

% movingSpeed rel underay patterns	
%-------- movingSpeedStartsUnderway---------------------------%
holdsForSDFluent(movingSpeedStartsUnderway(Vessel)=Speed,I):-
	holdsForProcessedSDFluent(Vessel,underWay(Vessel)=true, Iu),
	holdsForProcessedSimpleFluent(Vessel,movingSpeed(Vessel)=Speed, Ims),
	starts(movingSpeedStartsUnderway(Vessel)=Speed, 1, Ims, Iu, lhs, true, I).

%-------- movingSpeedFinishesUnderway ---------------------------%
holdsForSDFluent(movingSpeedFinishesUnderway(Vessel)=Speed,I):-
	holdsForProcessedSDFluent(Vessel,underWay(Vessel)=true, Iu),
	holdsForProcessedSimpleFluent(Vessel,movingSpeed(Vessel)=Speed, Ims),
	finishes(movingSpeedFinishesUnderway(Vessel)=Speed, 1, Ims, Iu, lhs, true, I).

%-------- movingSpeedEqualUnderway ---------------------------%
holdsForSDFluent(movingSpeedEqualUnderway(Vessel)=Speed,I):-
	holdsForProcessedSDFluent(Vessel,underWay(Vessel)=true, Iu),
	holdsForProcessedSimpleFluent(Vessel,movingSpeed(Vessel)=Speed, Ims),
	equal(movingSpeedEqualUnderway(Vessel)=Speed, 1, Ims, Iu, lhs, true, I).

%-------- pilotOpsEqualProximity ---------------------------%
holdsForSDFluent(pilotOpsEqualProximity(Vessel1,Vessel2)=true,I):-
	holdsForProcessedSDFluent(Vessel1,pilotOps(Vessel1,Vessel2)=true, Ipo),
	holdsForProcessedIE(Vessel1,proximity(Vessel1,Vessel2)=true, Ip),
	equal(pilotOpsEqualProximity(Vessel1,Vessel2)=true, 1, Ipo, Ip, lhs, true, I).

%-------- driftingWhileTugging ---------------------------%
holdsForSDFluent(driftingWhileTugging(Vessel1, Vessel2)=true, I):-
	holdsForProcessedSDFluent(Vessel1, tugging(Vessel1, Vessel2)=true, It),
	holdsForProcessedSimpleFluent(Vessel1, drifting(Vessel1)=true, Id1),
	holdsForProcessedSimpleFluent(Vessel2, drifting(Vessel2)=true, Id2),
	union_all([Id1,Id2], Id),
	during(driftingWhileTugging(Vessel1, Vessel2)=true, 1, It, Id, union, true, I).

%-------- fishingTripInArea ---------------------------%
holdsForSDFluent(fishingTripInArea(Vessel)=true, I):-
    holdsForProcessedSimpleFluent(Vessel, withinArea(Vessel, nearPorts)=true, Iwa), 
    holdsForProcessedSimpleFluent(Vessel, withinArea(Vessel, fishing)=true, Iwaf),
	before(fishingTripInArea(Vessel)=true, 1, Iwa, Iwaf, union, true, Ifishing1),
    before(fishingTripInArea(Vessel)=true, 2, Ifishing1, Iwa, union, true, I).

%-------- fishingTripTrawling ---------------------------%
holdsForSDFluent(fishingTripTrawling(Vessel)=true, I):-
    holdsForProcessedSimpleFluent(Vessel, withinArea(Vessel, nearPorts)=true, Iwa), 
    holdsForProcessedSDFluent(Vessel, trawling(Vessel)=true, It),
	before(fishingTripTrawling(Vessel)=true, 1, Iwa, It, union, true, Ifishing1),
    before(fishingTripTrawling(Vessel)=true, 2, Ifishing1, Iwa, union, true, I).

cachingOrder2(Vessel, withinArea(Vessel,AreaType)=true) :-
    vessel(Vessel),areaType(AreaType).

cachingOrder2(Vessel, gap(Vessel)=nearPorts) :-
    vessel(Vessel),portStatus(nearPorts).

cachingOrder2(Vessel, gap(Vessel)=farFromPorts) :-
    vessel(Vessel),portStatus(farFromPorts).

cachingOrder2(Vessel, stopped(Vessel)=nearPorts) :-
    vessel(Vessel),portStatus(nearPorts).

cachingOrder2(Vessel, stopped(Vessel)=farFromPorts) :-
    vessel(Vessel),portStatus(farFromPorts).

cachingOrder2(Vessel, lowSpeed(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, changingSpeed(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, movingSpeed(Vessel)=below) :-
    vessel(Vessel),movingStatus(below).

cachingOrder2(Vessel, movingSpeed(Vessel)=above) :-
    vessel(Vessel),movingStatus(above).

cachingOrder2(Vessel, movingSpeed(Vessel)=normal) :-
    vessel(Vessel),movingStatus(normal).

cachingOrder2(Vessel, underWay(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, highSpeedNearCoast(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, drifting(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, sarSpeed(Vessel)=true) :-
    vessel(Vessel), vesselType(Vessel, sar).

cachingOrder2(Vessel, sarMovement(Vessel)=true) :-
    vessel(Vessel), vesselType(Vessel, sar).

%cachingOrder2(Vessel, sarMovement(Vessel)=false) :-
%    vessel(Vessel).

cachingOrder2(Vessel, inSAR(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, anchoredOrMoored(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, tuggingSpeed(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, tugging(Vessel,Vessel2)=true) :-
    vpair(Vessel,Vessel2).

cachingOrder2(Vessel, rendezVous(Vessel,Vessel2)=true) :-
    vpair(Vessel,Vessel2).

cachingOrder2(Vessel, pilotOps(Vessel,Vessel2)=true) :-
    vpair(Vessel,Vessel2).

cachingOrder2(Vessel, trawlSpeed(Vessel)=true) :-
    vessel(Vessel), vesselType(Vessel,fishing).

cachingOrder2(Vessel, trawlingMovement(Vessel)=true) :-
    vessel(Vessel), vesselType(Vessel,fishing).

%cachingOrder2(Vessel, trawlingMovement(Vessel)=false) :-
%    vessel(Vessel).

cachingOrder2(Vessel, trawling(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, loitering(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, disappearedInArea(Vessel, AreaType)=true):-
	vessel(Vessel), areaType(AreaType).

cachingOrder2(Vessel, stoppedWithinArea(Vessel, AreaType)=true):-
	vessel(Vessel), areaType(AreaType).

cachingOrder2(Vessel, stoppedMeetsGap(Vessel)=true):-
	vessel(Vessel).

cachingOrder2(Vessel, highSpeedNCBeforeDrifting(Vessel)=true):-
	vessel(Vessel).

cachingOrder2(Vessel, dangerNearCoast(Vessel)=true):-
	vessel(Vessel).

cachingOrder2(Vessel, gainingSpeed(Vessel)=true):-
	vessel(Vessel).

cachingOrder2(Vessel, speedChangeAbove(Vessel)=true):-
	vessel(Vessel).

cachingOrder2(Vessel, anchoredFarFromPorts(Vessel)=true):-
	vessel(Vessel).

cachingOrder2(Vessel, anchoredNearPorts(Vessel)=true):-
	vessel(Vessel).

cachingOrder2(Vessel, tuggingStartsProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, tuggingFinishesProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, tuggingEqualProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, rendezVousStartsProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, rendezVousFinishesProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, rendezVousEqualProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, pilotOpsStartsProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, pilotOpsFinishesProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, pilotOpsEqualProximity(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, movingSpeedStartsUnderway(Vessel)=below):-
	vessel(Vessel).

cachingOrder2(Vessel, movingSpeedFinishesUnderway(Vessel)=below):-
	vessel(Vessel).

cachingOrder2(Vessel, movingSpeedEqualUnderway(Vessel)=below):-
	vessel(Vessel).

cachingOrder2(Vessel, collisionDanger(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, suspiciousRendezVous(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, driftingWhileTugging(Vessel, Vessel2)=true):-
    vpair(Vessel, Vessel2).

cachingOrder2(Vessel, fishingTripInArea(Vessel)=true):-
    vessel(Vessel).

cachingOrder2(Vessel, fishingTripTrawling(Vessel)=true):-
    vessel(Vessel).

collectIntervals2(Vessel, proximity(Vessel,Vessel2)=true) :-
    vpair(Vessel,Vessel2).

