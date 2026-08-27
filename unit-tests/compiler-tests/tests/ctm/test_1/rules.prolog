
/********************************************************
 * 							*
 * Compiler unit test: City Transport Management (CTM)	*
 *		                                        *
 ********************************************************/

/*********************************** CTM CE DEFINITIONS *************************************/


/****************************************************************
 *		     PUNCTUALITY (CHANGE)			*
 ****************************************************************/

initially(punctuality(_, _)=punctual).

initiatedAt(punctuality(Id, VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id, VehicleType, _StopCode, scheduled), T).	

initiatedAt(punctuality(Id, VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id, VehicleType, _StopCode, early), T).	

terminatedAt(punctuality(Id, VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id, VehicleType, _StopCode, late), T).

terminatedAt(punctuality(Id, VehicleType)=punctual, T) :-
	happensAt(stop_leave(Id, VehicleType, _StopCode, early), T).

/*
% I have commented out this obsolete punctuality definition

initiatedAt(punctuality(Id, VehicleType)=punctual, DepartureT) :-
	happensAt(stop_enter(Id, VehicleType, StopCode, scheduled), ArrivalT),
	happensAt(stop_leave(Id, VehicleType, StopCode, scheduled), DepartureT),
	ArrivalT < DepartureT.	

initiatedAt(punctuality(Id, VehicleType)=punctual, DepartureT) :-
	happensAt(stop_enter(Id, VehicleType, StopCode, early), ArrivalT),
	happensAt(stop_leave(Id, VehicleType, StopCode, scheduled), DepartureT),
	ArrivalT < DepartureT.	

initiatedAt(punctuality(Id, VehicleType)=non_punctual, ArrivalT) :-
	happensAt(stop_enter(Id, VehicleType, _, late), ArrivalT).

initiatedAt(punctuality(Id, VehicleType)=non_punctual, DepartureT) :-
	happensAt(stop_leave(Id, VehicleType, _, early), DepartureT).

initiatedAt(punctuality(Id, VehicleType)=non_punctual, DepartureT) :-
	happensAt(stop_leave(Id, VehicleType, _, late), DepartureT).
*/

% it is more efficient to define punctuality=non_punctual as a statically determined fluent as below
holdsFor(punctuality(Id, VehicleType)=non_punctual, NPI) :-
	holdsFor(punctuality(Id, VehicleType)=punctual, PI),
	complement_all([PI], NPI).


happensAt(punctuality_change(Id, VehicleType, punctual), T) :-
	happensAt(end(punctuality(Id, VehicleType)=non_punctual), T).	

happensAt(punctuality_change(Id, VehicleType, non_punctual), T) :-
	happensAt(end(punctuality(Id, VehicleType)=punctual), T).	


/****************************************************************
*		     DRIVING STYLE				*
****************************************************************/

holdsFor(driving_style(Id, VehicleType)=unsafe, UDI) :-
	holdsFor(sharp_turn(Id, VehicleType)=very_sharp, VSTI),
	holdsFor(abrupt_acceleration(Id, VehicleType)=very_abrupt, VAAI),
	holdsFor(abrupt_deceleration(Id, VehicleType)=very_abrupt, VADI),
	union_all([VSTI, VAAI, VADI], UDI).

holdsFor(driving_style(Id, VehicleType)=uncomfortable, UDI) :-
	holdsFor(sharp_turn(Id, VehicleType)=sharp, STI),
	% The three conditions below consider the possibility that very abrupt acceleration 
	% or very abrupt deceleration may take place during a sharp turn.
	% In this case we should remove, as we do in the three lines below, the intervals 
	% in which a very abrupt acceleration/deceleration takes place from the intervals
	% in which a sharp turn takes place. Remember: very abrupt acceleration/deceleration
	% should lead to unsafe_driving not uncomfortable driving.
	% 'uncomfortable_driving' should be read as uncomfortable but safe driving
	holdsFor(abrupt_acceleration(Id, VehicleType)=very_abrupt, VAAI),
	holdsFor(abrupt_deceleration(Id, VehicleType)=very_abrupt, VADI),  
	relative_complement_all(STI, [VAAI, VADI], PureSharpTurn),
	holdsFor(abrupt_acceleration(Id, VehicleType)=abrupt, AAI),
	holdsFor(abrupt_deceleration(Id, VehicleType)=abrupt, ADI),
	union_all([PureSharpTurn, AAI, ADI], UDI).


/****************************************************************
*		     DRIVING QUALITY				*
****************************************************************/

holdsFor(driving_quality(Id, VehicleType)=high, HQDI) :- 
	holdsFor(punctuality(Id, VehicleType)=punctual, PunctualI),
	holdsFor(driving_style(Id, VehicleType)=unsafe, USI),
	holdsFor(driving_style(Id, VehicleType)=uncomfortable, UCI),
	relative_complement_all(PunctualI, [USI, UCI], HQDI).

holdsFor(driving_quality(Id, VehicleType)=medium, MQDI) :- 
	holdsFor(punctuality(Id, VehicleType)=punctual, PunctualI),
	% optional optimisation check
	\+ PunctualI=[], !,
	holdsFor(driving_style(Id, VehicleType)=uncomfortable, UCI), 
	intersect_all([PunctualI, UCI], MQDI).

% the rule below is the result of the above optimisation check
holdsFor(driving_quality(_Id, _VehicleType)=medium, []).

holdsFor(driving_quality(Id, VehicleType)=low, LQDI) :- 
	holdsFor(punctuality(Id, VehicleType)=non_punctual, NPI),
	holdsFor(driving_style(Id, VehicleType)=unsafe, USI),  
	union_all([NPI, USI], LQDI).

/****************************************************************
*		     PASSENGER COMFORT				*
****************************************************************/

holdsFor(passenger_comfort(Id, VehicleType)=reducing, RPCI) :- 
	holdsFor(driving_style(Id, VehicleType)=uncomfortable, UCI),
	holdsFor(driving_style(Id, VehicleType)=unsafe, USI),
	holdsFor(passenger_density(Id, VehicleType)=high, HPDI),
	holdsFor(noise_level(Id, VehicleType)=high, HNLI),
	holdsFor(internal_temperature(Id, VehicleType)=very_warm, VWITI),
	holdsFor(internal_temperature(Id, VehicleType)=very_cold, VCITI),
	union_all([UCI, USI, HPDI, HNLI, VWITI, VCITI], RPCI).


initially(passenger_density(_, _)=low).
initiates(passenger_density_change(Id, VehicleType, Value), passenger_density(Id, VehicleType)=Value, _T).

initially(noise_level(_, _)=low).
initiates(noise_level_change(Id, VehicleType, Value), noise_level(Id, VehicleType)=Value, _T).

initially(internal_temperature(_, _)=normal).
%initiates(internal_temperature_change(Id, VehicleType, Value), internal_temperature(Id, VehicleType)=Value, _T).
initiatedAt(internal_temperature(Id, VehicleType)=Value, T) :-
	happensAt(internal_temperature_change(Id, VehicleType, Value), T).


/****************************************************************
*		     DRIVER COMFORT				*
****************************************************************/

holdsFor(driver_comfort(Id, VehicleType)=reducing, RPCI) :- 
	holdsFor(driving_style(Id, VehicleType)=uncomfortable, UCI),
	holdsFor(driving_style(Id, VehicleType)=unsafe, USI),
	holdsFor(noise_level(Id, VehicleType)=high, HNLI),
	holdsFor(internal_temperature(Id, VehicleType)=very_warm, VWITI),
	holdsFor(internal_temperature(Id, VehicleType)=very_cold, VCITI),
	union_all([UCI, USI, HNLI, VWITI, VCITI], RPCI).

/****************************************************************
*		     PASSENGER SATISFACTION			*
****************************************************************/

holdsFor(passenger_satisfaction(Id, VehicleType)=reducing, RPSI) :-
	holdsFor(punctuality(Id, VehicleType)=non_punctual, NPI),
	holdsFor(passenger_comfort(Id, VehicleType)=reducing, RPCI),
	union_all([NPI, RPCI], RPSI).

% These input statically determined fluents arrive in the form of intervals in input streams.
collectIntervals(abrupt_acceleration(_,_)=abrupt).
collectIntervals(abrupt_acceleration(_,_)=very_abrupt).
collectIntervals(abrupt_deceleration(_,_)=abrupt).
collectIntervals(abrupt_deceleration(_,_)=very_abrupt).
collectIntervals(sharp_turn(_,_)=sharp).
collectIntervals(sharp_turn(_,_)=very_sharp).

% The elements of these domains are derived from the ground arguments of input entitites
dynamicDomain(vehicle(_,_)).

% Grounding for input entities:
grounding(stop_enter(Id, VehicleType,_,_)):-
	vehicle(Id, VehicleType).
grounding(stop_leave(Id, VehicleType,_,_)):-
	vehicle(Id, VehicleType).
grounding(internal_temperature_change(Id, VehicleType,_)):-
	vehicle(Id, VehicleType).
grounding(noise_level_change(Id, VehicleType,_)):-
	vehicle(Id, VehicleType).
grounding(passenger_density_change(Id, VehicleType,_)):-
	vehicle(Id, VehicleType).
grounding(punctuality_change(Id,VehicleType,_Punctuality)):-
	vehicle(Id, VehicleType).
grounding(abrupt_acceleration(Id,VehicleType)=abrupt):-
	vehicle(Id, VehicleType). 
grounding(abrupt_acceleration(Id,VehicleType)=very_abrupt):-
	vehicle(Id, VehicleType). 
grounding(abrupt_deceleration(Id,VehicleType)=abrupt):-
	vehicle(Id, VehicleType). 
grounding(abrupt_deceleration(Id,VehicleType)=very_abrupt):-
	vehicle(Id, VehicleType). 
grounding(sharp_turn(Id,VehicleType)=sharp):-
	vehicle(Id, VehicleType). 
grounding(sharp_turn(Id,VehicleType)=very_sharp):-
	vehicle(Id, VehicleType).

% Grounding for output entities:
grounding(punctuality(Id,VehicleType)=punctual):-
	vehicle(Id, VehicleType).   
grounding(punctuality(Id,VehicleType)=non_punctual):-
	vehicle(Id, VehicleType).
grounding(passenger_density(Id,VehicleType)=high):-
	vehicle(Id, VehicleType).
grounding(noise_level(Id,VehicleType)=high):-
	vehicle(Id, VehicleType).
grounding(internal_temperature(Id,VehicleType)=very_warm):-
	vehicle(Id, VehicleType).
grounding(internal_temperature(Id,VehicleType)=very_cold):-
	vehicle(Id, VehicleType).
grounding(driving_style(Id,VehicleType)=unsafe):-
	vehicle(Id, VehicleType).
grounding(driving_style(Id,VehicleType)=uncomfortable):-
	vehicle(Id, VehicleType).
grounding(driving_quality(Id,VehicleType)=high):-
	vehicle(Id, VehicleType).
grounding(driving_quality(Id,VehicleType)=medium):-
	vehicle(Id, VehicleType).
grounding(driving_quality(Id,VehicleType)=low):-
	vehicle(Id, VehicleType). 
grounding(passenger_comfort(Id,VehicleType)=reducing):-
	vehicle(Id, VehicleType).
grounding(driver_comfort(Id,VehicleType)=reducing):-
	vehicle(Id, VehicleType).
grounding(passenger_satisfaction(Id,VehicleType)=reducing):-
	vehicle(Id, VehicleType).

