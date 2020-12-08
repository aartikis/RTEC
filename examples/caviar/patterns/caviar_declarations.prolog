/****************************************************************
 *                                                              *
 * Event Recognition for Public Space Surveillance (PSS/CAVIAR)	* 
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


event(appear(_)).					inputEntity(appear(_)).				index(appear(Id), 			Id).
event(disappear(_)).					inputEntity(disappear(_)).			index(disappear(Id), 			Id).
	
simpleFluent(person(_)=true).    			outputEntity(person(_)=true).			index(person(Id)=true, 			Id).
simpleFluent(leaving_object(_,_)=true).			outputEntity(leaving_object(_,_)=true).		index(leaving_object(Id,_)=true,	Id).
simpleFluent(meeting(_,_)=true).			outputEntity(meeting(_,_)=true).		index(meeting(Id,_)=true, 		Id).

sDFluent(walking(_)=true).				inputEntity(walking(_)=true).			index(walking(Id)=true, 		Id).
sDFluent(active(_)=true).				inputEntity(active(_)=true).			index(active(Id)=true, 			Id).
sDFluent(inactive(_)=true).				inputEntity(inactive(_)=true).			index(inactive(Id)=true, 		Id).
sDFluent(running(_)=true).				inputEntity(running(_)=true).			index(running(Id)=true, 		Id).
sDFluent(abrupt(_)=true).				inputEntity(abrupt(_)=true).			index(abrupt(Id)=true, 			Id).
sDFluent(distance(_,_,_)=true).				internalEntity(distance(_,_,_)=true).		index(distance(Id,_,_)=true, 		Id).
sDFluent(close(_,_,_)=true).				outputEntity(close(_,_,_)=true).		index(close(Id,_,_)=true,		Id).
sDFluent(close(_,_,_)=false).				outputEntity(close(_,_,_)=false).		index(close(Id,_,_)=false,		Id).
sDFluent(closeSymmetric(_,_,_)=true). 			outputEntity(closeSymmetric(_,_,_)=true).	index(closeSymmetric(Id,_,_)=true, 	Id).
sDFluent(activeOrInactivePerson(_)=true).		outputEntity(activeOrInactivePerson(_)=true).	index(activeOrInactivePerson(Id)=true,	Id).  		
sDFluent(greeting1(_,_)=true).	  			outputEntity(greeting1(_,_)=true).		index(greeting1(Id,_)=true, 		Id).	
sDFluent(greeting2(_,_)=true).  			outputEntity(greeting2(_,_)=true).		index(greeting2(Id,_)=true, 		Id).
sDFluent(moving(_,_)=true).				outputEntity(moving(_,_)=true).			index(moving(Id,_)=true, 		Id). 
sDFluent(fighting(_,_)=true). 				outputEntity(fighting(_,_)=true).		index(fighting(Id,_)=true, 		Id). 


% for input entities/statically determined fluents state whether 
% the intervals will be collected into a list or built from given time-points

buildFromPoints(walking(_)=true).
buildFromPoints(active(_)=true).
buildFromPoints(inactive(_)=true).
buildFromPoints(running(_)=true).
buildFromPoints(abrupt(_)=true).

% define the groundings of the fluents and output entities/events

grounding(close(P1,P2,24)=true) :-			id_pair(P1, P2).
grounding(close(P1,P2,25)=true) :-			id_pair(P1, P2).
grounding(close(P1,P2,30)=true) :-			id_pair(P1, P2).
grounding(close(P1,P2,34)=true) :-			id_pair(P1, P2).
% we are only interesting in caching close=false with respect to the 34 threshold
% we don't need any other thresholds for this fluent in the CAVIAR event description
grounding(close(P1,P2,34)=false) :-			id_pair(P1, P2).
% similarly we are only interesting in caching closeSymmetric=true with respect to the 30 threshold
grounding(closeSymmetric(P1,P2,30)=true) :-		id_pair(P1, P2).
grounding(walking(P)=true) :- 				list_of_ids(P). 
grounding(active(P)=true) :- 				list_of_ids(P). 
grounding(inactive(P)=true) :- 				list_of_ids(P). 
grounding(abrupt(P)=true) :- 				list_of_ids(P). 
grounding(running(P)=true) :- 				list_of_ids(P). 
grounding(person(P)=true) :- 				list_of_ids(P). 
grounding(activeOrInactivePerson(P)=true) :- 		list_of_ids(P). 
grounding(greeting1(P1,P2)=true) :- 			id_pair(P1, P2).
grounding(greeting2(P1,P2)=true) :- 			id_pair(P1, P2).
grounding(leaving_object(Person,Object)=true) :- 	id_pair(Person, Object).
grounding(leaving_object(Person,Object)=true) :- 	symmetric_id_pair(Person, Object). 
grounding(meeting(P1,P2)=true) :- 			id_pair(P1, P2).
grounding(moving(P1,P2)=true) :- 			id_pair(P1, P2).
grounding(fighting(P1,P2)=true) :- 			id_pair(P1, P2).

% cachingOrder should be defined for all output entities

cachingOrder(close(_,_,_)=true).
cachingOrder(close(_,_,_)=false).
cachingOrder(closeSymmetric(_,_,_)=true).
cachingOrder(person(_)=true). 
cachingOrder(activeOrInactivePerson(_)=true). 
cachingOrder(greeting1(_,_)=true).
cachingOrder(greeting2(_,_)=true).
cachingOrder(leaving_object(_,_)=true). 
cachingOrder(meeting(_,_)=true).	
cachingOrder(moving(_,_)=true).
cachingOrder(fighting(_,_)=true).


