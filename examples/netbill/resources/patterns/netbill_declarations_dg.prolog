
/**************************************************************
 *                                                            *
 * Voting Protocol declarations				*
 *                                                            *
 * Implemented in RTEC						*
 * Alexander Artikis						*
 *								*
 **************************************************************/


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


event(request_quote(_,_,_)).			inputEntity(request_quote(_,_,_)).		index(request_quote(Ag,_,_), Ag). 
event(present_quote(_,_,_,_)).			inputEntity(present_quote(_,_,_,_)).		index(present_quote(Ag,_,_,_), Ag). 
event(accept_quote(_,_,_)).			inputEntity(accept_quote(_,_,_)).		index(accept_quote(Ag,_,_), Ag). 
event(send_EPO(_,_,_,_)).			inputEntity(send_EPO(_,_,_,_)).			index(send_EPO(Ag,_,_,_), Ag). 
event(send_goods(_,_,_,_,_)).			inputEntity(send_goods(_,_,_,_,_)).		index(send_goods(Ag,_,_,_,_), Ag). 



% all values of a simple fluent must be declared
simpleFluent(quote(_,_,_)=true).		outputEntity(quote(_,_,_)=true).		index(quote(Ag,_,_)=true, Ag).
simpleFluent(quote(_,_,_)=false).		outputEntity(quote(_,_,_)=false).		index(quote(Ag,_,_)=false, Ag).
simpleFluent(contract(_,_,_)=true).		outputEntity(contract(_,_,_)=true).		index(contract(Ag,_,_)=true, Ag).
simpleFluent(contract(_,_,_)=false).		outputEntity(contract(_,_,_)=false).		index(contract(Ag,_,_)=false, Ag).
simpleFluent(per(present_quote(_,_))=true).	outputEntity(per(present_quote(_,_))=true).	index(per(present_quote(Ag,_))=true, Ag).
simpleFluent(per(present_quote(_,_))=false).	outputEntity(per(present_quote(_,_))=false).	index(per(present_quote(Ag,_))=false, Ag).
simpleFluent(obl(send_EPO(_,_,_))=true).	outputEntity(obl(send_EPO(_,_,_))=true).	index(obl(send_EPO(Ag,_,_))=true, Ag).
simpleFluent(obl(send_EPO(_,_,_))=false).	outputEntity(obl(send_EPO(_,_,_))=false).	index(obl(send_EPO(Ag,_,_))=false, Ag).
simpleFluent(obl(send_goods(_,_,_))=true).	outputEntity(obl(send_goods(_,_,_))=true).	index(obl(send_goods(Ag,_,_))=true, Ag).
simpleFluent(obl(send_goods(_,_,_))=false).	outputEntity(obl(send_goods(_,_,_))=false).	index(obl(send_goods(Ag,_,_))=false, Ag).
simpleFluent(suspended(_,_)=true).		outputEntity(suspended(_,_)=true).		index(suspended(Ag,_)=true, Ag).
simpleFluent(suspended(_,_)=false).		outputEntity(suspended(_,_)=false).		index(suspended(Ag,_)=false, Ag).

sDFluent(pow(accept_quote(_,_,_))=true).	outputEntity(pow(accept_quote(_,_,_))=true).	index(pow(accept_quote(Ag,_,_))=true, Ag).

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


cyclic(suspended(_,_)=true).	
cyclic(suspended(_,_)=false).	
cyclic(contract(_,_,_)=true).	
cyclic(contract(_,_,_)=false).	
cyclic(obl(send_EPO(_,_,_))=true).	
cyclic(obl(send_EPO(_,_,_))=false).  
cyclic(obl(send_goods(_,_,_))=true).	
cyclic(obl(send_goods(_,_,_))=false).  

% Define the groundings of the fluents and output entities/events:

% the declaration below is necessary for SWI Prolog and YAP 6.3:
% This is probably due to dynamic grounding
:- dynamic person/1, person_pair/2.

grounding(suspended(Ag,Role)=true)		:- person(Ag),role_of(Ag,Role).
dgrounded(suspended(Ag,_Role)=true, person(Ag)).

grounding(quote(M,C,GD)=true)			:- person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ M=C, queryGoodsDescription(GD).
dgrounded(quote(M,C,_GD)=true, person_pair(M,C)).

grounding(contract(M,C,GD)=true)		:- person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ M=C, queryGoodsDescription(GD).
dgrounded(contract(M,C,_GD)=true, person_pair(M,C)).

grounding(pow(accept_quote(C,M,GD))=true)	:- person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ C=M, queryGoodsDescription(GD).
dgrounded(pow(accept_quote(C,M,_GD))=true, person_pair(M,C)).

grounding(per(present_quote(M,C))=false)	:- person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ C=M.
dgrounded(per(present_quote(M,C))=false, person_pair(M,C)).

grounding(obl(send_EPO(C,iServer,GD))=true)	:- person(C),role_of(C,consumer), queryGoodsDescription(GD).
dgrounded(obl(send_EPO(C,iServer,_GD))=true, person(C)).

grounding(obl(send_goods(M,iServer,GD))=true)	:- person(M),role_of(M,merchant), queryGoodsDescription(GD).
dgrounded(obl(send_goods(M,iServer,_GD))=true, person(M)).

collectGrounds([request_quote(P,_,_), present_quote(P,_,_,_), accept_quote(P,_,_),send_EPO(P,_,_,_),send_goods(P,_,_,_,_),
                request_quote(_,P,_), present_quote(_,P,_,_), accept_quote(_,P,_)], person(P)).

collectGrounds([request_quote(P1,P2,_), present_quote(P1,P2,_,_), accept_quote(P1,P2,_)], person_pair(P1,P2)).

% Declare the order of caching of output entities.

cachingOrder(quote(_,_,_)=true).		
cachingOrder(per(present_quote(_,_))=false).	  
% =================== cycle ================== % 
cachingOrder(contract(_,_,_)=true).		% depends on quote and suspended
cachingOrder(obl(send_EPO(_,_,_))=true).	% depends on contract  
cachingOrder(obl(send_goods(_,_,_))=true).	% depends on contract  
cachingOrder(suspended(_,_)=true). 		% depends on contract, obl and per(present_quote(..))  
% =================== cycle ================== %
cachingOrder(pow(accept_quote(_,_,_))=true).	% depends on quote and suspended

 
