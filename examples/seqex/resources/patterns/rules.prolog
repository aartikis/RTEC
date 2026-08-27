
%----------------powered On -----------------%
initiatedAt(poweredOn(Device)=true, T) :-
    happensAt(turnsOn(Device), T).

terminatedAt(poweredOn(Device)=true, T) :-
    happensAt(turnsOff(Device), T).
    
%--------------- placed food ----------------%
initiatedAt(placed(Food, Device)=true, T) :-
    happensAt(place(Food, Device), T).

terminatedAt(placed(Food, Device)=true, T) :-
    happensAt(remove(Food, Device), T).

%-------------- cooking ---------------------%
holdsFor(cooking(Device, Food) = true, I):-
    holdsFor(placed(Food, Device) = True, Ip),
    holdsFor(poweredOn(Device) = True, Id),
    intersect_all([Ip, Id], I).
    
%-------------- recipe ----------------------%
holdsFor(recipePreparation(Food) = true, I):-
    holdsFor(cooking(stove, Food) = true, Istove),
    holdsFor(cooking(oven, Food) = true, Ioven),
    seq(Istove, Ioven, I).

%--------------- dish preparation -----------%
holdsFor(dishPreparation(Food) = true, I):-
    holdsFor(recipePreparation(Food) = true, Im),
    holdsFor(placed(Food, plate) = true, Id),
    seq(Im, Id, I).
    
% The elements of these domains are derived from the ground arguments of input entitites
% dynamicDomain(vessel(_Vessel)).
% dynamicDomain(vpair(_Vessel1,_Vessel2)).

% Groundings of input entities
grounding(turnsOn(D)):- device(D).
grounding(turnsOff(D)):- device(D).
grounding(place(F, D)):- food(F), device(D).
grounding(remove(F, D)):- food(F), device(D).


% Groundings of output entities
grounding(poweredOn(Device)=true):-
	device(Device).
grounding(placed(Food, Device)=true):-
	food(Food), device(Device).
grounding(cooking(Device, Food)=true):-
	device(Device), food(Food).
grounding(recipePreparation(Food)=true):-
    food(Food).		
grounding(dishPreparation(Food) = true):-
    food(Food).    

needsGrounding(_, _, _) :-
	fail.
buildFromPoints(_) :-
	fail.
