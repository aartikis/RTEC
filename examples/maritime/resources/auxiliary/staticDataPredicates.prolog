
areaType(Area,Type):-bigAreaType(Area,Type).

vesselType(Vessel,Type):-     vesselStaticInfo(Vessel,Type,_Draft).
draft(Vessel,Draft):-         vesselStaticInfo(Vessel,_Type,Draft).
draught(Vessel,Draught):-     vesselStaticInfo(Vessel,_Type,Draught).

oneIsTug(Vessel1,_Vessel2):-vesselType(Vessel1,tug).
oneIsTug(_Vessel1,Vessel2):-vesselType(Vessel2,tug).

twoAreTugs(Vessel1,Vessel2):-vesselType(Vessel1,tug),vesselType(Vessel2,tug).

oneIsPilot(Vessel1,_Vessel2):-vesselType(Vessel1,pilotvessel).
oneIsPilot(_Vessel1,Vessel2):-vesselType(Vessel2,pilotvessel).

