initiatedAt(stopped(Vessel)=true, T) :-
	happensAt(stop_start(Vessel), T),
	happensAt(coord(Vessel,Lon,Lat), T),
	nearPorts(Lon,Lat,[]).

terminatedAt(stopped(Vessel)=true, T) :-
	happensAt(stop_end(Vessel), T).

initiatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(slow_motion_start(Vessel), T),
	happensAt(coord(Vessel,Lon,Lat), T),
	nearPorts(Lon,Lat,[]).

terminatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(slow_motion_end(Vessel), T).

terminatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(start(stopped(Vessel)=true), T).

initiatedAt(withinArea(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T).

terminatedAt(withinArea(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

initiatedAt(sailing(Vessel)=true, T) :-
	happensAt(velocity(Vessel,Speed,Heading), T),
	Speed > 2.0.

terminatedAt(sailing(Vessel)=true, T) :-
	happensAt(velocity(Vessel,Speed,Heading), T),
	Speed < 2.0.

terminatedAt(sailing(Vessel)=true, T) :-
	happensAt(gap_start(Vessel), T).

initiatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T),
	speedArea(AreaName,SpeedArea),
	Speed > SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T),
	speedArea(AreaName,SpeedArea),
	Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

holdsFor(loitering(Vessel)=true, I) :-
	holdsFor(lowSpeed(Vessel)=true,I127),
	holdsFor(stopped(Vessel)=true,I130),
	union_all([I127,I130],I131),
	holdsFor(withinArea(Vessel,AreaName)=true,I134),
	intersect_all([I131,I134],I135),
	findall((S,E),(member((S,E),I135),Diff is E-S,Diff>600),I).

holdsFor(rendezVouz(Vessel1,Vessel2)=true, I) :-
	holdsFor(proximity(Vessel1,Vessel2)=true,I241),
	holdsFor(lowSpeed(Vessel1)=true,I243),
	holdsFor(stopped(Vessel1)=true,I246),
	union_all([I243,I246],I247),
	holdsFor(lowSpeed(Vessel2)=true,I263),
	holdsFor(stopped(Vessel2)=true,I266),
	union_all([I263,I266],I267),
	intersect_all([I241,I247,I267],I269),
	findall((S,E),(member((S,E),I269),Diff is E-S,Diff>600),I).

