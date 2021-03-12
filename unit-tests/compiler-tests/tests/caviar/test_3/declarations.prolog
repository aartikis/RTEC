/************************************************
 * 						*
 * Compiler unit test: Activity recognition	*
 * in CAVIAR					* 
 *                                              *
 ************************************************/


event(appear(_)).					inputEntity(appear(_)).				index(appear(Id), 			Id).
event(disappear(_)).					inputEntity(disappear(_)).			index(disappear(Id), 			Id).
	
simpleFluent(person(_)=true).    			outputEntity(person(_)=true).			index(person(Id)=true, 			Id).
simpleFluent(person(_)=false).    			outputEntity(person(_)=false).			index(person(Id)=false,			Id).
simpleFluent(leaving_object(_,_)=true).			outputEntity(leaving_object(_,_)=true).		index(leaving_object(Id,_)=true,	Id).
simpleFluent(leaving_object(_,_)=false).		outputEntity(leaving_object(_,_)=false).	index(leaving_object(Id,_)=false,	Id).
simpleFluent(meeting(_,_)=true).			outputEntity(meeting(_,_)=true).		index(meeting(Id,_)=true, 		Id).
simpleFluent(meeting(_,_)=false).			outputEntity(meeting(_,_)=false).		index(meeting(Id,_)=false, 		Id).


sDFluent(orientation(_)=_).				inputEntity(orientation(_)=_).			index(orientation(Id)=_, 		Id).
sDFluent(appearance(_)=_).				inputEntity(appearance(_)=_).			index(appearance(Id)=_, 		Id).
sDFluent(coord(_,_,_)=true).				inputEntity(coord(_,_,_)=true).			index(coord(Id,_,_)=true, 		Id).

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


% For input entities expressed as statically determined fluents, state whether 
% the fluent instances will be reported as time-points (points/1) or intervals.
% By default, RTEC assumes that fluent instances are reported as intervals
% (in this case no declarations are necessary).
% This part of the declarations is used by the data loader.

points(orientation(_)=_).
points(appearance(_)=_).
points(coord(_,_,_)=true).
points(walking(_)=true).
points(active(_)=true).
points(inactive(_)=true).
points(running(_)=true).
points(abrupt(_)=true).


% For input entities expressed as statically determined fluents, state whether 
% the list of intervals of the input entity will be constructed by 
% collecting individual intervals (collectIntervals/1), or built from 
% time-points (buildFromPoints/1). If no declarations are provided for some,
% input entity, then the input entity may not participate in the specification of 
% output entities expressed as statically determined fluents. 	 

buildFromPoints(walking(_)=true).
buildFromPoints(active(_)=true).
buildFromPoints(inactive(_)=true).
buildFromPoints(running(_)=true).
buildFromPoints(abrupt(_)=true).


% Define the groundings of the fluents and output entities/events:

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


% Declare the order of caching of output entities.

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


