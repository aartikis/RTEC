
%----------------within area -----------------%

initiatedAt(withinArea(Vessel, AreaType)=true, T) :-
    happensAt(entersArea(Vessel, Area), T),
    areaType(Area, AreaType).

terminatedAt(withinArea(Vessel, AreaType)=true, T) :-
    happensAt(leavesArea(Vessel, Area), T),
    areaType(Area, AreaType).


%-------------- stopped-----------------------%

initiatedAt(stopped(Vessel)=nearPorts, T) :-
    happensAt(stop_start(Vessel), T),
    holdsAt(withinArea(Vessel, nearPorts)=true, T).

initiatedAt(stopped(Vessel)=farFromPorts, T) :-
    happensAt(stop_start(Vessel), T),
    \+holdsAt(withinArea(Vessel, nearPorts)=true, T).

terminatedAt(stopped(Vessel)=_Status, T) :-
    happensAt(stop_end(Vessel), T).


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

%---------- stopped2below ---------------------%
holdsFor(stopped2below(Vessel)=true, I):-
    holdsFor(stopped(Vessel)=nearPorts, Is),
    holdsFor(movingSpeed(Vessel)=below, Imn),
    seq(Is, Imn, I).
 
%---------- high2stopped ---------------------%
holdsFor(high2stopped(Vessel)=true, I):-
    holdsFor(movingSpeed(Vessel)=above, Imn),
    holdsFor(stopped(Vessel)=farFromPorts, Is),
    seq(Imn, Is, I).
 
%---------- stopped2high2stopped ---------------------%
holdsFor(stopped2below2high2stopped(Vessel)=true, I):-
    holdsFor(stopped2below(Vessel)=true, Isn),
    holdsFor(high2stopped(Vessel)=true, Ihs),
    seq(Isn, Ihs, I).

% The elements of these domains are derived from the ground arguments of input entitites
dynamicDomain(vessel(_Vessel)).

% Groundings of input entities
grounding(stop_start(V)):- vessel(V).
grounding(stop_end(V)):- vessel(V).
grounding(entersArea(V,nearPorts)):- vessel(V).
grounding(leavesArea(V,nearPorts)):- vessel(V).
grounding(coord(V,_,_)):- vessel(V).
grounding(velocity(V,_,_,_)):- vessel(V).


% Groundings of output entities
grounding(stopped(Vessel)=PortStatus):-
	vessel(Vessel), portStatus(PortStatus).
grounding(withinArea(Vessel, AreaType)=true):-
	vessel(Vessel), areaType(AreaType).
grounding(movingSpeed(Vessel)=Status):-
	vessel(Vessel), movingStatus(Status).
grounding(stopped2below(Vessel)=true):-
	vessel(Vessel).
grounding(high2stopped(Vessel)=true):-
	vessel(Vessel).
grounding(stopped2below2high2stopped(Vessel)=true):-
	vessel(Vessel).

needsGrounding(_, _, _) :-
	fail.
buildFromPoints(_) :-
	fail.
