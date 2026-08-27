
:- discontiguous terminatedAt/3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% stopped %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%On time

initiatedAt(stoppedState(Index)=true, T) :-
        happensAt(notMoving(Index), T).

initiatedAt(stoppedState(Index)=true, T) :-
        happensAt(stopped(Index), T).


%%%%%%% Termination all over points

terminatedAt(stoppedState(Index)=true, T) :-
	happensAt(moving(Index, _), T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% normalSpeed %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%On time

initiatedAt(normalSpeed(Index)=true, T) :-
	happensAt(moving(Index, Speed), T),
	vehicleType(Index, VT),
	vehicleSpeed(VT, VTS),
	Speed =< VTS.
     
terminatedAt(normalSpeed(Index)=true, T) :-
	happensAt(moving(Index, Speed), T),
	vehicleType(Index, VT),
	vehicleSpeed(VT, VTS),
	Speed > VTS.

terminatedAt(normalSpeed(Index)=true, T) :-
	happensAt(notMoving(Index), T).

terminatedAt(normalSpeed(Index)=true, T) :-
	happensAt(stopped(Index), T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% overSpeeding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%On time

initiatedAt(overSpeeding(Index)=true, T) :-
	happensAt(moving(Index, Speed), T),
	vehicleType(Index, VT),
	vehicleSpeed(VT, VTS),
	Speed > VTS.
     
terminatedAt(overSpeeding(Index)=true, T) :-
	happensAt(moving(Index, Speed), T),
	vehicleType(Index, VT),
	vehicleSpeed(VT, VTS),
	Speed =< VTS.

terminatedAt(overSpeeding(Index)=true, T) :-
	happensAt(notMoving(Index), T).

terminatedAt(overSpeeding(Index)=true, T) :-
	happensAt(stopped(Index), T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dangerousDriving %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%On time

initiatedAt(dangerousDriving(Index)=true, T) :-
	happensAt(acceleration(Index), T),
	holdsAt(overSpeeding(Index)=true, T).

initiatedAt(dangerousDriving(Index)=true, T) :-
	happensAt(braking(Index), T),
	holdsAt(overSpeeding(Index)=true, T).

initiatedAt(dangerousDriving(Index)=true, T) :-
	happensAt(cornering(Index), T),
	holdsAt(overSpeeding(Index)=true, T).

initiatedAt(dangerousDriving(Index)=true, T) :-
	happensAt(ice(Index), T),
	holdsAt(overSpeeding(Index)=true, T).


terminatedAt(dangerousDriving(Index)=true, T) :-
	happensAt(notMoving(Index), T).
	
terminatedAt(dangerousDriving(Index)=true, T) :-
	happensAt(stopped(Index), T).

%terminatedAt(dangerousDriving(Index)=true, T) :-
%	happensAt(end(overSpeeding(Index)=true), T).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% notEconomicDriving %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%On time

initiatedAt(notEconomicDriving(Index)=true, T) :-
	happensAt(fuelLevel(Index, Tank), T),
	holdsAt(overSpeeding(Index)=true, T),
	vehicleType(Index, VT),
	vehicleTank(VT, VTT), HT is VTT / 2,
	Tank < HT.

terminatedAt(notEconomicDriving(Index)=true, T) :-
	happensAt(fuelLevel(Index, Tank), T),
	\+ holdsAt(overSpeeding(Index)=true, T),
	vehicleType(Index, VT),
	vehicleTank(VT, VTT), HT is VTT / 2,
	Tank >= HT.
     
terminatedAt(notEconomicDriving(Index)=true, T) :-
	happensAt(notMoving(Index), T).

terminatedAt(notEconomicDriving(Index)=true, T) :-
	happensAt(stopped(Index), T).

%terminatedAt(notEconomicDriving(Index)=true, T) :-
%	happensAt(end(overSpeeding(Index)=true), T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Refuel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%On time

initiatedAt(reFuel(Index)=true, T) :-
	happensAt(closeToGas(Index), T),
	holdsAt(notEconomicDriving(Index)=true, T).

terminatedAt(reFuel(Index)=true, T) :-
	happensAt(fuelLevel(Index, Tank), T),
	vehicleType(Index, VT),
	vehicleTank(VT, VTT), HT is VTT / 2,
	Tank >= HT.

%%%%%%% Termination all over points

terminatedAt(reFuel(Index)=true, T) :-
        happensAt(fuelLevel(Index, Tank), T),
        vehicleType(Index, VT),
        vehicleTank(VT, VTT), HT is VTT / 2,
        Tank >= HT.

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% normal2dangerouDriving %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holdsFor(normal2dangerousDriving(V)=true, I):-
	holdsFor(normalSpeed(V)=true, Is),
	holdsFor(dangerousDriving(V)=true, Ir),
	seq(Is, Ir, I).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% normal2dangerouDriving %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holdsFor(normal2notEconomicDriving(V)=true, I):-
	holdsFor(normalSpeed(V)=true, Is),
	holdsFor(notEconomicDriving(V)=true, Ir),
	seq(Is, Ir, I).

%%%%%%% dynamic grounding
dynamicDomain(vehicle(_V)).

% grounding input entities
grounding(moving(V, _324)):-
	vehicle(V).
grounding(acceleration(V)):-
	vehicle(V).
grounding(braking(V)):-
	vehicle(V).
grounding(cornering(V)):-
	vehicle(V).
grounding(ice(V)):-
	vehicle(V).
grounding(fuelLevel(V, _324)):-
	vehicle(V).
grounding(closeToGas(V)):-
	vehicle(V).
grounding(notMoving(V)):-
	vehicle(V).
grounding(stopped(V)):-
	vehicle(V).

% grounding output entities
grounding(stoppedState(V)=true) :-
	vehicle(V).
grounding(normalSpeed(V)=true) :-
	vehicle(V).
grounding(overSpeeding(V)=true) :-
	vehicle(V).
grounding(dangerousDriving(V)=true) :- 
	vehicle(V).
grounding(notEconomicDriving(V)=true) :- 
	vehicle(V).
grounding(reFuel(V)=true) :- 
	vehicle(V).
grounding(notEconomicDriving(V)=true) :- 
	vehicle(V).
grounding(normal2dangerousDriving(V)=true) :- 
	vehicle(V).
grounding(normal2notEconomicDriving(V)=true) :- 
	vehicle(V).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
cachingOrder2(Index, overSpeeding(Index)=true) :-
     recorded(vehicle, Index, _).

cachingOrder2(Index, dangerousDriving(Index)=true) :-
     recorded(vehicle, Index, _).

cachingOrder2(Index, notEconomicDriving(Index)=true) :-
     recorded(vehicle, Index, _).

cachingOrder2(Index, reFuel(Index)=true) :-
     recorded(vehicle, Index, _).*/
