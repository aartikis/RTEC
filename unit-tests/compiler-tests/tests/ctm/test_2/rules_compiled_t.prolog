
/********************************************************
 * 							*
 * Compiler unit test: City Transport Management (CTM)	*
 *		                                        *
 ********************************************************/

% Some extra declarations have been added in the rules and declarations to allow for unit testing
:- dynamic maxDuration/3, maxDurationUE/3.
:- dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

:- discontiguous initially/1, initiatedAt/4, initiates/3, holdsFor/2, happensAt/2, holdsForSDFluent/2.
:- multifile happensAt/2.

/*********************************** CTM CE DEFINITIONS *************************************/


/****************************************************************
 *		     PUNCTUALITY (CHANGE)			*
 ****************************************************************/

initiatedAt(punctuality(_, _)=punctual, T1, -1, T2) :- T1=<(-1), -1<T2.

initiatedAt(punctuality(Id, VehicleType)=punctual, T1, T, T2) :-
	happensAtIE(stop_enter(Id, VehicleType, _StopCode, scheduled), T),
	T1 =< T, T < T2.	

initiatedAt(punctuality(Id, VehicleType)=punctual, T1, T, T2) :-
	happensAtIE(stop_enter(Id, VehicleType, _StopCode, early), T),
	T1 =< T, T < T2.	

initiatedAt(punctuality(Id, VehicleType)=non_punctual, T1, T, T2) :-
	happensAtIE(stop_enter(Id, VehicleType, _StopCode, late), T),
	T1 =< T, T < T2.

initiatedAt(punctuality(Id, VehicleType)=non_punctual, T1, T, T2) :-
	happensAtIE(stop_leave(Id, VehicleType, _StopCode, early), T),
	T1 =< T, T < T2.

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
holdsForSDFluent(punctuality(Id, VehicleType)=non_punctual, NPI) :-
	holdsForProcessedSimpleFluent(Id, punctuality(Id, VehicleType)=punctual, PI),
	complement_all([PI], NPI).


happensAtEv(punctuality_change(Id, VehicleType, punctual), T) :-
	happensAtProcessedSDFluent(Id, end(punctuality(Id, VehicleType)=non_punctual), T).	

happensAtEv(punctuality_change(Id, VehicleType, non_punctual), T) :-
	happensAtProcessedSimpleFluent(Id, end(punctuality(Id, VehicleType)=punctual), T).	


/****************************************************************
*		     DRIVING STYLE				*
****************************************************************/

holdsForSDFluent(driving_style(Id, VehicleType)=unsafe, UDI) :-
	holdsForProcessedIE(Id, sharp_turn(Id, VehicleType)=very_sharp, VSTI),
	holdsForProcessedIE(Id, abrupt_acceleration(Id, VehicleType)=very_abrupt, VAAI),
	holdsForProcessedIE(Id, abrupt_deceleration(Id, VehicleType)=very_abrupt, VADI),
	union_all([VSTI, VAAI, VADI], UDI).

holdsForSDFluent(driving_style(Id, VehicleType)=uncomfortable, UDI) :-
	holdsForProcessedIE(Id, sharp_turn(Id, VehicleType)=sharp, STI),
	% The three conditions below consider the possibility that very abrupt acceleration 
	% or very abrupt deceleration may take place during a sharp turn.
	% In this case we should remove, as we do in the three lines below, the intervals 
	% in which a very abrupt acceleration/deceleration takes place from the intervals
	% in which a sharp turn takes place. Remember: very abrupt acceleration/deceleration
	% should lead to unsafe_driving not uncomfortable driving.
	% 'uncomfortable_driving' should be read as uncomfortable but safe driving
	holdsForProcessedIE(Id, abrupt_acceleration(Id, VehicleType)=very_abrupt, VAAI),
	holdsForProcessedIE(Id, abrupt_deceleration(Id, VehicleType)=very_abrupt, VADI),  
	relative_complement_all(STI, [VAAI, VADI], PureSharpTurn),
	holdsForProcessedIE(Id, abrupt_acceleration(Id, VehicleType)=abrupt, AAI),
	holdsForProcessedIE(Id, abrupt_deceleration(Id, VehicleType)=abrupt, ADI),
	union_all([PureSharpTurn, AAI, ADI], UDI).


/****************************************************************
*		     DRIVING QUALITY				*
****************************************************************/

holdsForSDFluent(driving_quality(Id, VehicleType)=high, HQDI) :- 
	holdsForProcessedSimpleFluent(Id, punctuality(Id, VehicleType)=punctual, PunctualI),
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=unsafe, USI),
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=uncomfortable, UCI),
	relative_complement_all(PunctualI, [USI, UCI], HQDI).

holdsForSDFluent(driving_quality(Id, VehicleType)=medium, MQDI) :- 
	holdsForProcessedSimpleFluent(Id, punctuality(Id, VehicleType)=punctual, PunctualI),
	% optional optimisation check
	\+ PunctualI=[], !,
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=uncomfortable, UCI), 
	intersect_all([PunctualI, UCI], MQDI).

% the rule below is the result of the above optimisation check
holdsForSDFluent(driving_quality(_Id, _VehicleType)=medium, []).

holdsForSDFluent(driving_quality(Id, VehicleType)=low, LQDI) :- 
	holdsForProcessedSDFluent(Id, punctuality(Id, VehicleType)=non_punctual, NPI),
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=unsafe, USI),  
	union_all([NPI, USI], LQDI).

/****************************************************************
*		     PASSENGER COMFORT				*
****************************************************************/

holdsForSDFluent(passenger_comfort(Id, VehicleType)=reducing, RPCI) :- 
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=uncomfortable, UCI),
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=unsafe, USI),
	holdsForProcessedSimpleFluent(Id, passenger_density(Id, VehicleType)=high, HPDI),
	holdsForProcessedSimpleFluent(Id, noise_level(Id, VehicleType)=high, HNLI),
	holdsForProcessedSimpleFluent(Id, internal_temperature(Id, VehicleType)=very_warm, VWITI),
	holdsForProcessedSimpleFluent(Id, internal_temperature(Id, VehicleType)=very_cold, VCITI),
	union_all([UCI, USI, HPDI, HNLI, VWITI, VCITI], RPCI).


initiatedAt(passenger_density(_, _)=low, T1, -1, T2) :- T1=<(-1), -1<T2.
initiatedAt(passenger_density(Id, VehicleType)=Value, T1, T, T2) :-
	happensAtIE(passenger_density_change(Id, VehicleType, Value), T),
	T1 =< T, T < T2.

initiatedAt(noise_level(_, _)=low, T1, -1, T2) :- T1=<(-1), -1<T2.
initiatedAt(noise_level(Id, VehicleType)=Value, T1, T, T2) :-
	happensAtIE(noise_level_change(Id, VehicleType, Value), T),
	T1 =< T, T < T2.


initiatedAt(internal_temperature(_, _)=normal, T1, -1, T2) :- T1=<(-1), -1<T2.
initiatedAt(internal_temperature(Id, VehicleType)=Value, T1, T, T2) :-
	happensAtIE(internal_temperature_change(Id, VehicleType, Value), T),
	T1 =< T, T < T2.


/****************************************************************
*		     DRIVER COMFORT				*
****************************************************************/

holdsForSDFluent(driver_comfort(Id, VehicleType)=reducing, RPCI) :- 
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=uncomfortable, UCI),
	holdsForProcessedSDFluent(Id, driving_style(Id, VehicleType)=unsafe, USI),
	holdsForProcessedSimpleFluent(Id, noise_level(Id, VehicleType)=high, HNLI),
	holdsForProcessedSimpleFluent(Id, internal_temperature(Id, VehicleType)=very_warm, VWITI),
	holdsForProcessedSimpleFluent(Id, internal_temperature(Id, VehicleType)=very_cold, VCITI),
	union_all([UCI, USI, HNLI, VWITI, VCITI], RPCI).

/****************************************************************
*		     PASSENGER SATISFACTION			*
****************************************************************/

holdsForSDFluent(passenger_satisfaction(Id, VehicleType)=reducing, RPSI) :-
	holdsForProcessedSDFluent(Id, punctuality(Id, VehicleType)=non_punctual, NPI),
	holdsForProcessedSDFluent(Id, passenger_comfort(Id, VehicleType)=reducing, RPCI),
	union_all([NPI, RPCI], RPSI).


cachingOrder2(_131123, punctuality(_131123,_131124)=punctual) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, punctuality(_131123,_131124)=non_punctual) :-
     vehicle(_131123,_131124).

cachingOrder2(_131120, punctuality_change(_131120,_131121,punctual)) :-
     vehicle(_131120,_131121).

cachingOrder2(_131120, punctuality_change(_131120,_131121,non_punctual)) :-
     vehicle(_131120,_131121).

cachingOrder2(_131123, passenger_density(_131123,_131124)=high) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, noise_level(_131123,_131124)=high) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, internal_temperature(_131123,_131124)=very_warm) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, internal_temperature(_131123,_131124)=very_cold) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_style(_131123,_131124)=unsafe) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_style(_131123,_131124)=uncomfortable) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_quality(_131123,_131124)=high) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_quality(_131123,_131124)=medium) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_quality(_131123,_131124)=low) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, passenger_comfort(_131123,_131124)=reducing) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driver_comfort(_131123,_131124)=reducing) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, passenger_satisfaction(_131123,_131124)=reducing) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_acceleration(_131123,_131124)=abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_acceleration(_131123,_131124)=very_abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_deceleration(_131123,_131124)=abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_deceleration(_131123,_131124)=very_abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, sharp_turn(_131123,_131124)=sharp) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, sharp_turn(_131123,_131124)=very_sharp) :-
     vehicle(_131123,_131124).

