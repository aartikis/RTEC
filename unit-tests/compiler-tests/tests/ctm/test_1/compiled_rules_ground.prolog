
/********************************************************
 * 							*
 * Compiler unit test: City Transport Management (CTM)	*
 *		                                        *
 ********************************************************/

:- discontiguous initially/1, initiatedAt/4, initiates/3, terminatedAt/4, terminates/3, holdsFor/2, happensAt/2, holdsForSDFluent/2.

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

terminatedAt(punctuality(Id, VehicleType)=punctual, T1, T, T2) :-
	happensAtIE(stop_enter(Id, VehicleType, _StopCode, late), T),
	T1 =< T, T < T2.

terminatedAt(punctuality(Id, VehicleType)=punctual, T1, T, T2) :-
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


inputEntity(stop_enter(_130,_132,_134,_136)).
inputEntity(internal_temperature_change(_130,_132,_134)).
inputEntity(stop_leave(_130,_132,_134,_136)).
inputEntity(sharp_turn(_136,_138)=very_sharp).
inputEntity(abrupt_acceleration(_136,_138)=very_abrupt).
inputEntity(abrupt_deceleration(_136,_138)=very_abrupt).
inputEntity(sharp_turn(_136,_138)=sharp).
inputEntity(abrupt_acceleration(_136,_138)=abrupt).
inputEntity(abrupt_deceleration(_136,_138)=abrupt).
inputEntity(noise_level_change(_130,_132,_134)).
inputEntity(passenger_density_change(_130,_132,_134)).

outputEntity(punctuality(_258,_260)=punctual).
outputEntity(internal_temperature(_258,_260)=very_warm).
outputEntity(internal_temperature(_258,_260)=very_cold).
outputEntity(passenger_density(_258,_260)=high).
outputEntity(noise_level(_258,_260)=high).
outputEntity(passenger_density(_258,_260)=low).
outputEntity(noise_level(_258,_260)=low).
outputEntity(internal_temperature(_258,_260)=normal).
outputEntity(punctuality(_258,_260)=non_punctual).
outputEntity(driving_style(_258,_260)=unsafe).
outputEntity(driving_style(_258,_260)=uncomfortable).
outputEntity(driving_quality(_258,_260)=high).
outputEntity(driving_quality(_258,_260)=medium).
outputEntity(driving_quality(_258,_260)=low).
outputEntity(passenger_comfort(_258,_260)=reducing).
outputEntity(driver_comfort(_258,_260)=reducing).
outputEntity(passenger_satisfaction(_258,_260)=reducing).
outputEntity(punctuality_change(_252,_254,_256)).

event(punctuality_change(_416,_418,_420)).
event(stop_enter(_416,_418,_420,_422)).
event(internal_temperature_change(_416,_418,_420)).
event(stop_leave(_416,_418,_420,_422)).
event(noise_level_change(_416,_418,_420)).
event(passenger_density_change(_416,_418,_420)).

simpleFluent(punctuality(_514,_516)=punctual).
simpleFluent(internal_temperature(_514,_516)=very_warm).
simpleFluent(internal_temperature(_514,_516)=very_cold).
simpleFluent(passenger_density(_514,_516)=high).
simpleFluent(noise_level(_514,_516)=high).
simpleFluent(passenger_density(_514,_516)=low).
simpleFluent(noise_level(_514,_516)=low).
simpleFluent(internal_temperature(_514,_516)=normal).

sDFluent(punctuality(_618,_620)=non_punctual).
sDFluent(driving_style(_618,_620)=unsafe).
sDFluent(driving_style(_618,_620)=uncomfortable).
sDFluent(driving_quality(_618,_620)=high).
sDFluent(driving_quality(_618,_620)=medium).
sDFluent(driving_quality(_618,_620)=low).
sDFluent(passenger_comfort(_618,_620)=reducing).
sDFluent(driver_comfort(_618,_620)=reducing).
sDFluent(passenger_satisfaction(_618,_620)=reducing).
sDFluent(sharp_turn(_618,_620)=very_sharp).
sDFluent(abrupt_acceleration(_618,_620)=very_abrupt).
sDFluent(abrupt_deceleration(_618,_620)=very_abrupt).
sDFluent(sharp_turn(_618,_620)=sharp).
sDFluent(abrupt_acceleration(_618,_620)=abrupt).
sDFluent(abrupt_deceleration(_618,_620)=abrupt).

index(punctuality_change(_710,_764,_766),_710).
index(stop_enter(_710,_764,_766,_768),_710).
index(internal_temperature_change(_710,_764,_766),_710).
index(stop_leave(_710,_764,_766,_768),_710).
index(noise_level_change(_710,_764,_766),_710).
index(passenger_density_change(_710,_764,_766),_710).
index(punctuality(_710,_770)=punctual,_710).
index(internal_temperature(_710,_770)=very_warm,_710).
index(internal_temperature(_710,_770)=very_cold,_710).
index(passenger_density(_710,_770)=high,_710).
index(noise_level(_710,_770)=high,_710).
index(passenger_density(_710,_770)=low,_710).
index(noise_level(_710,_770)=low,_710).
index(internal_temperature(_710,_770)=normal,_710).
index(punctuality(_710,_770)=non_punctual,_710).
index(driving_style(_710,_770)=unsafe,_710).
index(driving_style(_710,_770)=uncomfortable,_710).
index(driving_quality(_710,_770)=high,_710).
index(driving_quality(_710,_770)=medium,_710).
index(driving_quality(_710,_770)=low,_710).
index(passenger_comfort(_710,_770)=reducing,_710).
index(driver_comfort(_710,_770)=reducing,_710).
index(passenger_satisfaction(_710,_770)=reducing,_710).
index(sharp_turn(_710,_770)=very_sharp,_710).
index(abrupt_acceleration(_710,_770)=very_abrupt,_710).
index(abrupt_deceleration(_710,_770)=very_abrupt,_710).
index(sharp_turn(_710,_770)=sharp,_710).
index(abrupt_acceleration(_710,_770)=abrupt,_710).
index(abrupt_deceleration(_710,_770)=abrupt,_710).


cachingOrder2(_131123, punctuality(_131123,_131124)=punctual) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, punctuality(_131123,_131124)=non_punctual) :-
     vehicle(_131123,_131124).

cachingOrder2(_131120, punctuality_change(_131120,_131121, _Punctuality)) :-
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

collectGrounds([stop_enter(_618,_620,_636,_638), internal_temperature_change(_618,_620,_636), stop_leave(_618,_620,_636,_638), sharp_turn(_618,_620)=very_sharp, abrupt_acceleration(_618,_620)=very_abrupt, abrupt_deceleration(_618,_620)=very_abrupt, sharp_turn(_618,_620)=sharp, abrupt_acceleration(_618,_620)=abrupt, abrupt_deceleration(_618,_620)=abrupt, noise_level_change(_618,_620,_636), passenger_density_change(_618,_620,_636)],vehicle(_618,_620)).

dgrounded(punctuality(_1210,_1212)=punctual, vehicle(_1210,_1212)).
dgrounded(internal_temperature(_1174,_1176)=very_warm, vehicle(_1174,_1176)).
dgrounded(internal_temperature(_1138,_1140)=very_cold, vehicle(_1138,_1140)).
dgrounded(passenger_density(_1102,_1104)=high, vehicle(_1102,_1104)).
dgrounded(noise_level(_1066,_1068)=high, vehicle(_1066,_1068)).
dgrounded(punctuality(_1030,_1032)=non_punctual, vehicle(_1030,_1032)).
dgrounded(driving_style(_994,_996)=unsafe, vehicle(_994,_996)).
dgrounded(driving_style(_958,_960)=uncomfortable, vehicle(_958,_960)).
dgrounded(driving_quality(_922,_924)=high, vehicle(_922,_924)).
dgrounded(driving_quality(_886,_888)=medium, vehicle(_886,_888)).
dgrounded(driving_quality(_850,_852)=low, vehicle(_850,_852)).
dgrounded(passenger_comfort(_814,_816)=reducing, vehicle(_814,_816)).
dgrounded(driver_comfort(_778,_780)=reducing, vehicle(_778,_780)).
dgrounded(passenger_satisfaction(_742,_744)=reducing, vehicle(_742,_744)).
dgrounded(punctuality_change(_704,_706,_708), vehicle(_704,_706)).
