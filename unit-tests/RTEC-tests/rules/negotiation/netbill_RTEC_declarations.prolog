
/**************************************************************
 *                                                            *
 * Voting Protocol declarations				*
 *                                                            *
 * Implemented in RTEC						*
 * Alexander Artikis						*
 *								*
 **************************************************************/


/********************************************************************** DECLARATIONS ******************************************************
 -Declare the entities of the event description: events, simple and statically determined fluents.
 -For each entity state if it is input or output (simple fluents are by definition output entities).
 -For each input/output entity state its index.
 -For input entities/statically determined fluents state whether the intervals will be collected into a list or built from time-points.
 -Declare the groundings of the fluents and output entities/events.
 -Declare the order of caching of output entities.
 ******************************************************************************************************************************************/

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

% for input entities/statically determined fluents state whether 
% the intervals will be collected into a list or built from given time-points

cyclic(suspended(_,_)=true).	
cyclic(suspended(_,_)=false).	
cyclic(contract(_,_,_)=true).	
cyclic(contract(_,_,_)=false).	
cyclic(obl(send_EPO(_,_,_))=true).	
cyclic(obl(send_EPO(_,_,_))=false).  
cyclic(obl(send_goods(_,_,_))=true).	
cyclic(obl(send_goods(_,_,_))=false).  

% define the groundings of the fluents and output entities/events

grounding(suspended(Ag,Role)=true)		:- role_of(Ag,Role).
grounding(quote(M,C,GD)=true)			:- role_of(M,merchant), role_of(C,consumer), \+ M=C, queryGoodsDescription(GD).
grounding(contract(M,C,GD)=true)		:- role_of(M,merchant), role_of(C,consumer), \+ M=C, queryGoodsDescription(GD).
grounding(pow(accept_quote(C,M,GD))=true)	:- role_of(M,merchant), role_of(C,consumer), \+ C=M, queryGoodsDescription(GD).
grounding(per(present_quote(M,C))=false)	:- role_of(M,merchant), role_of(C,consumer), \+ C=M.
grounding(obl(send_EPO(C,iServer,GD))=true)	:- role_of(C,consumer), queryGoodsDescription(GD).
grounding(obl(send_goods(M,iServer,GD))=true)	:- role_of(M,merchant), queryGoodsDescription(GD).

% cachingOrder should be defined for all output entities

cachingOrder(quote(_,_,_)=true).		
cachingOrder(per(present_quote(_,_))=false).	  
% =================== cycle ================== % 
cachingOrder(contract(_,_,_)=true).		% depends on quote and suspended
cachingOrder(obl(send_EPO(_,_,_))=true).	% depends on contract  
cachingOrder(obl(send_goods(_,_,_))=true).	% depends on contract  
cachingOrder(suspended(_,_)=true). 		% depends on contract, obl and per(present_quote(..))  
% =================== cycle ================== %
cachingOrder(pow(accept_quote(_,_,_))=true).	% depends on quote and suspended

 
