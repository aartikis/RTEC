
/****************************************************************
 *                                                              *
 * Event Recognition for City Transport Management (CTM)	* 
 *                                                              *
 *                                                              *
 * Implemented in YAP						*
 * Alexander Artikis						*
 *								*
 ****************************************************************/


/********************************************************************** DECLARATIONS *******************************************************************************
 -Declare the entities of the event description: events, simple and statically determined fluents.
 -For each entity state if it is input or output (simple fluents are by definition output entities).
 -For each input/output entity state its index.
 -For input entities/statically determined fluents state whether the intervals will be collected into a list or built from time-points.
 -Declare the groundings of the fluents and output entities/events.
 -Declare the order of caching of output entities.
 *******************************************************************************************************************************************************************/
 
event(stop_enter(_,_,_,_)).				inputEntity(stop_enter(_,_,_,_)).			index(stop_enter(Id,_,_,_), 			Id).
event(stop_leave(_,_,_,_)).				inputEntity(stop_leave(_,_,_,_)).			index(stop_leave(Id,_,_,_), 			Id).
event(internal_temperature_change(_,_,_)).		inputEntity(internal_temperature_change(_,_,_)).	index(internal_temperature_change(Id,_,_), 	Id).
event(noise_level_change(_,_,_)).			inputEntity(noise_level_change(_,_,_)).			index(noise_level_change(Id,_,_), 		Id).
event(passenger_density_change(_,_,_)).			inputEntity(passenger_density_change(_,_,_)).		index(passenger_density_change(Id,_,_), 	Id).
event(punctuality_change(_,_,punctual)).		outputEntity(punctuality_change(_,_,punctual)).		index(punctuality_change(Id,_,punctual),	Id).
event(punctuality_change(_,_,non_punctual)).		outputEntity(punctuality_change(_,_,non_punctual)).	index(punctuality_change(Id,_,non_punctual),	Id).

simpleFluent(punctuality(_,_)=punctual).    		outputEntity(punctuality(_,_)=punctual).    		index(punctuality(Id,_)=punctual, 		Id).
simpleFluent(passenger_density(_,_)=high).		outputEntity(passenger_density(_,_)=high).		index(passenger_density(Id,_)=high, 		Id).
simpleFluent(noise_level(_,_)=high).			outputEntity(noise_level(_,_)=high).			index(noise_level(Id,_)=high, 			Id).
simpleFluent(internal_temperature(_,_)=very_warm).	outputEntity(internal_temperature(_,_)=very_warm).	index(internal_temperature(Id,_)=very_warm, 	Id).
simpleFluent(internal_temperature(_,_)=very_cold).	outputEntity(internal_temperature(_,_)=very_cold).	index(internal_temperature(Id,_)=very_cold, 	Id).

sDFluent(abrupt_acceleration(_,_)=abrupt).		inputEntity(abrupt_acceleration(_,_)=abrupt).		index(abrupt_acceleration(Id,_)=abrupt, 	Id).
sDFluent(abrupt_acceleration(_,_)=very_abrupt).		inputEntity(abrupt_acceleration(_,_)=very_abrupt).	index(abrupt_acceleration(Id,_)=very_abrupt, 	Id).
sDFluent(abrupt_deceleration(_,_)=abrupt).		inputEntity(abrupt_deceleration(_,_)=abrupt).		index(abrupt_deceleration(Id,_)=abrupt, 	Id).
sDFluent(abrupt_deceleration(_,_)=very_abrupt).		inputEntity(abrupt_deceleration(_,_)=very_abrupt).	index(abrupt_deceleration(Id,_)=very_abrupt, 	Id).
sDFluent(sharp_turn(_,_)=sharp).			inputEntity(sharp_turn(_,_)=sharp).			index(sharp_turn(Id,_)=sharp, 			Id).
sDFluent(sharp_turn(_,_)=very_sharp).			inputEntity(sharp_turn(_,_)=very_sharp).		index(sharp_turn(Id,_)=very_sharp, 		Id).
sDFluent(punctuality(_,_)=non_punctual). 	   	outputEntity(punctuality(_,_)=non_punctual).    	index(punctuality(Id,_)=non_punctual, 		Id).    
sDFluent(driving_style(_,_)=unsafe). 			outputEntity(driving_style(_,_)=unsafe). 		index(driving_style(Id,_)=unsafe, 		Id). 
sDFluent(driving_style(_,_)=uncomfortable). 		outputEntity(driving_style(_,_)=uncomfortable). 	index(driving_style(Id,_)=uncomfortable, 	Id).
sDFluent(driving_quality(_,_)=high). 			outputEntity(driving_quality(_,_)=high). 		index(driving_quality(Id,_)=high, 		Id).
sDFluent(driving_quality(_,_)=medium). 			outputEntity(driving_quality(_,_)=medium). 		index(driving_quality(Id,_)=medium, 		Id).
sDFluent(driving_quality(_,_)=low). 			outputEntity(driving_quality(_,_)=low). 		index(driving_quality(Id,_)=low, 		Id).
sDFluent(passenger_comfort(_,_)=reducing). 		outputEntity(passenger_comfort(_,_)=reducing). 		index(passenger_comfort(Id,_)=reducing, 	Id). 
sDFluent(driver_comfort(_,_)=reducing). 		outputEntity(driver_comfort(_,_)=reducing). 		index(driver_comfort(Id,_)=reducing, 		Id).
sDFluent(passenger_satisfaction(_,_)=reducing). 	outputEntity(passenger_satisfaction(_,_)=reducing). 	index(passenger_satisfaction(Id,_)=reducing, 	Id). 

% for input entities/statically determined fluents state whether 
% the intervals will be collected into a list or built from given time-points

collectIntervals(abrupt_acceleration(_,_)=abrupt).
collectIntervals(abrupt_acceleration(_,_)=very_abrupt).
collectIntervals(abrupt_deceleration(_,_)=abrupt).
collectIntervals(abrupt_deceleration(_,_)=very_abrupt).
collectIntervals(sharp_turn(_,_)=sharp).
collectIntervals(sharp_turn(_,_)=very_sharp).

% if reading input events from a csv file, in SEF format,
% define the arguments that need to be grounded

needsGrounding(stop_enter, 3, vehicle).
needsGrounding(stop_enter, 4, vtype).
needsGrounding(stop_leave, 3, vehicle).
needsGrounding(stop_leave, 4, vtype).

% define the groundings of the fluents and output entities/events

grounding(abrupt_acceleration(Id,VehicleType)=abrupt) 		:- vehicle(Id, VehicleType). 
grounding(abrupt_acceleration(Id,VehicleType)=very_abrupt) 	:- vehicle(Id, VehicleType). 
grounding(abrupt_deceleration(Id,VehicleType)=abrupt) 		:- vehicle(Id, VehicleType). 
grounding(abrupt_deceleration(Id,VehicleType)=very_abrupt) 	:- vehicle(Id, VehicleType). 
grounding(sharp_turn(Id,VehicleType)=sharp) 			:- vehicle(Id, VehicleType). 
grounding(sharp_turn(Id,VehicleType)=very_sharp) 		:- vehicle(Id, VehicleType).
grounding(punctuality(Id,VehicleType)=punctual) 		:- vehicle(Id, VehicleType).   
grounding(punctuality(Id,VehicleType)=non_punctual) 		:- vehicle(Id, VehicleType).
grounding(punctuality_change(Id,VehicleType,punctual)) 		:- vehicle(Id, VehicleType).
grounding(punctuality_change(Id,VehicleType,non_punctual)) 	:- vehicle(Id, VehicleType).
grounding(passenger_density(Id,VehicleType)=high) 		:- vehicle(Id, VehicleType).
grounding(noise_level(Id,VehicleType)=high) 			:- vehicle(Id, VehicleType).
grounding(internal_temperature(Id,VehicleType)=very_warm) 	:- vehicle(Id, VehicleType).
grounding(internal_temperature(Id,VehicleType)=very_cold) 	:- vehicle(Id, VehicleType).
grounding(driving_style(Id,VehicleType)=unsafe) 		:- vehicle(Id, VehicleType).
grounding(driving_style(Id,VehicleType)=uncomfortable) 		:- vehicle(Id, VehicleType).
grounding(driving_quality(Id,VehicleType)=high) 		:- vehicle(Id, VehicleType).
grounding(driving_quality(Id,VehicleType)=medium) 		:- vehicle(Id, VehicleType).
grounding(driving_quality(Id,VehicleType)=low) 			:- vehicle(Id, VehicleType). 
grounding(passenger_comfort(Id,VehicleType)=reducing) 		:- vehicle(Id, VehicleType).
grounding(driver_comfort(Id,VehicleType)=reducing) 		:- vehicle(Id, VehicleType).
grounding(passenger_satisfaction(Id,VehicleType)=reducing) 	:- vehicle(Id, VehicleType).

% cachingOrder should be defined for all output entities

cachingOrder(punctuality(_,_)=punctual).    
cachingOrder(punctuality(_,_)=non_punctual).
cachingOrder(punctuality_change(_,_,punctual)).    
cachingOrder(punctuality_change(_,_,non_punctual)).    
cachingOrder(passenger_density(_,_)=high).
cachingOrder(noise_level(_,_)=high).
cachingOrder(internal_temperature(_,_)=very_warm).
cachingOrder(internal_temperature(_,_)=very_cold).
cachingOrder(driving_style(_,_)=unsafe). 
cachingOrder(driving_style(_,_)=uncomfortable). 
cachingOrder(driving_quality(_,_)=high).
cachingOrder(driving_quality(_,_)=medium).
cachingOrder(driving_quality(_,_)=low).
cachingOrder(passenger_comfort(_,_)=reducing). 
cachingOrder(driver_comfort(_,_)=reducing).
cachingOrder(passenger_satisfaction(_,_)=reducing). 


