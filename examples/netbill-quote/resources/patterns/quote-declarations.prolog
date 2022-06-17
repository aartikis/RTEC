/******************************************* DECLARATIONS ***************************
 1. Declare the entities of the event description: 
	-events (event/1), 
	-simple fluents (simpleFluent/1), and
	-statically determined fluents (sDFluent/1).
 2. For each entity, state if it is input (inputEntity/1) or output (outputEntity/1). 
	-Simple fluents are, by definition, output entities and must be declared so.
 3. For each entity, state its index (index/2). 
	-A fluent F must have the same index in all fluent-value pairs F=V.
 Note: All values V of a simple fluent F must be explicitly declared by means of:
	-simpleFluent/1
	-outputEntity/1
	-index/2.
 4. For input entities expressed as statically determined fluents, state whether:
	-The fluent instances will be reported as time-points (points/1) or intervals;
	 by default, RTEC assumes that fluent instances are reported as intervals
	 (in this case no declarations are necessary).
	-The list of intervals of the input entity will be constructed by 
	 collecting individual intervals (collectIntervals/1), or built from 
	 time-points (buildFromPoints/1). If no declarations are provided here,
	 then the input entity may not participate in the specification of 
	 output entities. 	 
 5. Specify the grounding of each fluent and output entity expressed as event.
 6. Declare the order of caching of output entities.
 *************************************************************************************/

event(present_quote(_,_,_)).			inputEntity(present_quote(_,_,_)).	index(present_quote(Ag,_,_), Ag). 	
event(accept_quote(_,_,_)).				inputEntity(accept_quote(_,_,_)).		index(accept_quote(Ag,_,_), Ag). 			

% all values of a simple fluent must be declared
simpleFluent(quote(_,_,_)=true).				outputEntity(quote(_,_,_)=true).				index(quote(Ag,_,_)=true, Ag).
simpleFluent(quote(_,_,_)=false).				outputEntity(quote(_,_,_)=false).				index(quote(Ag,_,_)=false, Ag).	

% For input entities expressed as statically determined fluents, state whether 
% the fluent instances will be reported as time-points (points/1) or intervals.
% By default, RTEC assumes that fluent instances are reported as intervals
% (in this case no declarations are necessary).
% This part of the declarations is used by the data loader.

% No points/1 declarations are necessary in this application.


% For input entities expressed as statically determined fluents, state whether 
% the list of intervals of the input entity will be constructed by 
% collecting individual intervals (collectIntervals/1), or built from 
% time-points (buildFromPoints/1). If no declarations are provided for some,
% input entity, then the input entity may not participate in the specification of 
% output entities. 

% No collectIntervals/1 or buildFromPoints/1 declarations are necessary in this application. 

% Define the groundings of the fluents and output entities/events:

% the declaration below is necessary for SWI Prolog and YAP 6.3:
:- dynamic person/1, person_pair/2.

grounding(quote(M,C,GD)=true)			:- person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ M=C, queryGoodsDescription(GD).
dgrounded(quote(M,C,_GD)=true, person_pair(M,C)).

collectGrounds([present_quote(P,_,_), accept_quote(P,_,_), present_quote(_,P,_), accept_quote(_,P,_)], person(P)).

collectGrounds([present_quote(P1,P2,_), accept_quote(P1,P2,_)], person_pair(P1,P2)).

% Declare the order of caching of output entities.

cachingOrder(quote(_,_,_)=true).		
