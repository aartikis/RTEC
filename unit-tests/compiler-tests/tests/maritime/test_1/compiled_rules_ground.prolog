:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, fi/3, p/1.

:- discontiguous initiatedAt/4, terminatedAt/4, holdsForSDFluent/2, fi/3, p/1.

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

fi(trawlingMovement(Vessel)=true,trawlingMovement(Vessel)=false,Thr) :- 
    thresholds(trawlingCrs,Thr),grounding(trawlingMovement(Vessel)=true),grounding(trawlingMovement(Vessel)=false).
p(trawlingMovement(_Vessel)=true).

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


fi(sarMovement(Vessel)=true,sarMovement(Vessel)=false,1800) :- 
    grounding(sarMovement(Vessel)=true),grounding(sarMovement(Vessel)=false).
p(sarMovement(_Vessel)=true).

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

inputEntity(entersArea(_130,_132)).
inputEntity(gap_start(_130)).
inputEntity(stop_start(_130)).
inputEntity(slow_motion_start(_130)).
inputEntity(change_in_speed_start(_130)).
inputEntity(velocity(_130,_132,_134,_136)).
inputEntity(change_in_heading(_130)).
inputEntity(leavesArea(_130,_132)).
inputEntity(gap_end(_130)).
inputEntity(stop_end(_130)).
inputEntity(slow_motion_end(_130)).
inputEntity(change_in_speed_end(_130)).
inputEntity(proximity(_136,_138)=true).
inputEntity(coord(_130,_132,_134)).

outputEntity(withinArea(_276,_278)=true).
outputEntity(gap(_276)=nearPorts).
outputEntity(gap(_276)=farFromPorts).
outputEntity(stopped(_276)=nearPorts).
outputEntity(stopped(_276)=farFromPorts).
outputEntity(lowSpeed(_276)=true).
outputEntity(changingSpeed(_276)=true).
outputEntity(highSpeedNearCoast(_276)=true).
outputEntity(movingSpeed(_276)=below).
outputEntity(movingSpeed(_276)=normal).
outputEntity(movingSpeed(_276)=above).
outputEntity(drifting(_276)=true).
outputEntity(tuggingSpeed(_276)=true).
outputEntity(trawlSpeed(_276)=true).
outputEntity(trawlingMovement(_276)=true).
outputEntity(sarSpeed(_276)=true).
outputEntity(sarMovement(_276)=true).
outputEntity(trawlingMovement(_276)=false).
outputEntity(sarMovement(_276)=false).
outputEntity(underWay(_276)=true).
outputEntity(anchoredOrMoored(_276)=true).
outputEntity(tugging(_276,_278)=true).
outputEntity(rendezVous(_276,_278)=true).
outputEntity(trawling(_276)=true).
outputEntity(inSAR(_276)=true).
outputEntity(loitering(_276)=true).
outputEntity(pilotOps(_276,_278)=true).

event(entersArea(_488,_490)).
event(gap_start(_488)).
event(stop_start(_488)).
event(slow_motion_start(_488)).
event(change_in_speed_start(_488)).
event(velocity(_488,_490,_492,_494)).
event(change_in_heading(_488)).
event(leavesArea(_488,_490)).
event(gap_end(_488)).
event(stop_end(_488)).
event(slow_motion_end(_488)).
event(change_in_speed_end(_488)).
event(coord(_488,_490,_492)).

simpleFluent(withinArea(_628,_630)=true).
simpleFluent(gap(_628)=nearPorts).
simpleFluent(gap(_628)=farFromPorts).
simpleFluent(stopped(_628)=nearPorts).
simpleFluent(stopped(_628)=farFromPorts).
simpleFluent(lowSpeed(_628)=true).
simpleFluent(changingSpeed(_628)=true).
simpleFluent(highSpeedNearCoast(_628)=true).
simpleFluent(movingSpeed(_628)=below).
simpleFluent(movingSpeed(_628)=normal).
simpleFluent(movingSpeed(_628)=above).
simpleFluent(drifting(_628)=true).
simpleFluent(tuggingSpeed(_628)=true).
simpleFluent(trawlSpeed(_628)=true).
simpleFluent(trawlingMovement(_628)=true).
simpleFluent(sarSpeed(_628)=true).
simpleFluent(sarMovement(_628)=true).
simpleFluent(trawlingMovement(_628)=false).
simpleFluent(sarMovement(_628)=false).

sDFluent(underWay(_798)=true).
sDFluent(anchoredOrMoored(_798)=true).
sDFluent(tugging(_798,_800)=true).
sDFluent(rendezVous(_798,_800)=true).
sDFluent(trawling(_798)=true).
sDFluent(inSAR(_798)=true).
sDFluent(loitering(_798)=true).
sDFluent(pilotOps(_798,_800)=true).
sDFluent(proximity(_798,_800)=true).

index(entersArea(_854,_908),_854).
index(gap_start(_854),_854).
index(stop_start(_854),_854).
index(slow_motion_start(_854),_854).
index(change_in_speed_start(_854),_854).
index(velocity(_854,_908,_910,_912),_854).
index(change_in_heading(_854),_854).
index(leavesArea(_854,_908),_854).
index(gap_end(_854),_854).
index(stop_end(_854),_854).
index(slow_motion_end(_854),_854).
index(change_in_speed_end(_854),_854).
index(coord(_854,_908,_910),_854).
index(withinArea(_854,_914)=true,_854).
index(gap(_854)=nearPorts,_854).
index(gap(_854)=farFromPorts,_854).
index(stopped(_854)=nearPorts,_854).
index(stopped(_854)=farFromPorts,_854).
index(lowSpeed(_854)=true,_854).
index(changingSpeed(_854)=true,_854).
index(highSpeedNearCoast(_854)=true,_854).
index(movingSpeed(_854)=below,_854).
index(movingSpeed(_854)=normal,_854).
index(movingSpeed(_854)=above,_854).
index(drifting(_854)=true,_854).
index(tuggingSpeed(_854)=true,_854).
index(trawlSpeed(_854)=true,_854).
index(trawlingMovement(_854)=true,_854).
index(sarSpeed(_854)=true,_854).
index(sarMovement(_854)=true,_854).
index(trawlingMovement(_854)=false,_854).
index(sarMovement(_854)=false,_854).
index(underWay(_854)=true,_854).
index(anchoredOrMoored(_854)=true,_854).
index(tugging(_854,_914)=true,_854).
index(rendezVous(_854,_914)=true,_854).
index(trawling(_854)=true,_854).
index(inSAR(_854)=true,_854).
index(loitering(_854)=true,_854).
index(pilotOps(_854,_914)=true,_854).
index(proximity(_854,_914)=true,_854).

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

cachingOrder2(Vessel, sarMovement(Vessel)=false) :-
    vessel(Vessel), vesselType(Vessel, sar).

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

cachingOrder2(Vessel, trawlingMovement(Vessel)=false) :-
    vessel(Vessel), vesselType(Vessel,fishing).

cachingOrder2(Vessel, trawling(Vessel)=true) :-
    vessel(Vessel).

cachingOrder2(Vessel, loitering(Vessel)=true) :-
    vessel(Vessel).

collectIntervals2(Vessel, proximity(Vessel,Vessel2)=true) :-
    vpair(Vessel,Vessel2).

collectGrounds([entersArea(_676,_690), gap_start(_676), stop_start(_676), slow_motion_start(_676), change_in_speed_start(_676), velocity(_676,_690,_692,_694), change_in_heading(_676), leavesArea(_676,_690), gap_end(_676), stop_end(_676), slow_motion_end(_676), change_in_speed_end(_676), coord(_676,_690,_692)],vessel(_676)).

collectGrounds([proximity(_664,_666)=true],vpair(_664,_666)).

dgrounded(withinArea(_1752,_1754)=true, vessel(_1752)).
dgrounded(gap(_1710)=nearPorts, vessel(_1710)).
dgrounded(gap(_1668)=farFromPorts, vessel(_1668)).
dgrounded(stopped(_1626)=nearPorts, vessel(_1626)).
dgrounded(stopped(_1584)=farFromPorts, vessel(_1584)).
dgrounded(lowSpeed(_1552)=true, vessel(_1552)).
dgrounded(changingSpeed(_1520)=true, vessel(_1520)).
dgrounded(highSpeedNearCoast(_1488)=true, vessel(_1488)).
dgrounded(movingSpeed(_1446)=below, vessel(_1446)).
dgrounded(movingSpeed(_1404)=normal, vessel(_1404)).
dgrounded(movingSpeed(_1362)=above, vessel(_1362)).
dgrounded(drifting(_1330)=true, vessel(_1330)).
dgrounded(tuggingSpeed(_1298)=true, vessel(_1298)).
dgrounded(trawlSpeed(_1254)=true, vessel(_1254)).
dgrounded(trawlingMovement(_1210)=true, vessel(_1210)).
dgrounded(sarSpeed(_1166)=true, vessel(_1166)).
dgrounded(sarMovement(_1122)=true, vessel(_1122)).
dgrounded(trawlingMovement(_1078)=false, vessel(_1078)).
dgrounded(sarMovement(_1034)=false, vessel(_1034)).
dgrounded(underWay(_1002)=true, vessel(_1002)).
dgrounded(anchoredOrMoored(_970)=true, vessel(_970)).
dgrounded(tugging(_934,_936)=true, vpair(_934,_936)).
dgrounded(rendezVous(_898,_900)=true, vpair(_898,_900)).
dgrounded(trawling(_866)=true, vessel(_866)).
dgrounded(inSAR(_834)=true, vessel(_834)).
dgrounded(loitering(_802)=true, vessel(_802)).
dgrounded(pilotOps(_766,_768)=true, vpair(_766,_768)).

