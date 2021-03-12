
/********************************************************
 *							*
 * Voting Protocol declarations				*
 *							*
 * Implemented in RTEC					*
 * Alexander Artikis					*
 *							*
 ********************************************************/


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

event(propose(_,_)).				inputEntity(propose(_,_)).		index(propose(Ag,_), Ag). 
event(second(_,_)).				inputEntity(second(_,_)).		index(second(Ag,_), Ag). 
event(vote(_,_,_)).				inputEntity(vote(_,_,_)).		index(vote(Ag,_,_), Ag). 
event(close_ballot(_,_)).			inputEntity(close_ballot(_,_)).		index(close_ballot(Ag,_), Ag). 
event(declare(_,_,_)).				inputEntity(declare(_,_,_)).		index(declare(Ag,_,_), Ag). 

simpleFluent(status(_)=null).			outputEntity(status(_)=null).			index(status(M)=null, M).
simpleFluent(status(_)=proposed).		outputEntity(status(_)=proposed).		index(status(M)=proposed, M).
simpleFluent(status(_)=voting).			outputEntity(status(_)=voting).			index(status(M)=voting, M).
simpleFluent(status(_)=voted).			outputEntity(status(_)=voted).			index(status(M)=voted, M).
simpleFluent(voted(_,_)=null).			outputEntity(voted(_,_)=null).			index(voted(Ag,_)=null, Ag).
simpleFluent(voted(_,_)=aye).			outputEntity(voted(_,_)=aye).			index(voted(Ag,_)=aye, Ag).
simpleFluent(voted(_,_)=nay).			outputEntity(voted(_,_)=nay).			index(voted(Ag,_)=nay, Ag).
simpleFluent(outcome(_)=carried).		outputEntity(outcome(_)=carried).		index(outcome(M)=carried, M).
simpleFluent(outcome(_)=not_carried).		outputEntity(outcome(_)=not_carried).		index(outcome(M)=not_carried, M).
simpleFluent(auxPerCloseBallot(_)=true).	outputEntity(auxPerCloseBallot(_)=true).	index(auxPerCloseBallot(M)=true, M).
simpleFluent(auxPerCloseBallot(_)=false).	outputEntity(auxPerCloseBallot(_)=false).	index(auxPerCloseBallot(M)=false, M).
simpleFluent(per(close_ballot(_,_))=true).	outputEntity(per(close_ballot(_,_))=true).	index(per(close_ballot(Ag,_))=true, Ag).
simpleFluent(per(close_ballot(_,_))=false).	outputEntity(per(close_ballot(_,_))=false).	index(per(close_ballot(Ag,_))=false, Ag).
simpleFluent(obl(declare(_,_,_))=true).		outputEntity(obl(declare(_,_,_))=true).		index(obl(declare(Ag,_,_))=true, Ag).
simpleFluent(obl(declare(_,_,_))=false).	outputEntity(obl(declare(_,_,_))=false).	index(obl(declare(Ag,_,_))=false, Ag).
simpleFluent(sanctioned(_)=true).		outputEntity(sanctioned(_)=true).		index(sanctioned(Ag)=true, Ag).
simpleFluent(sanctioned(_)=false).		outputEntity(sanctioned(_)=false).		index(sanctioned(Ag)=false, Ag).

sDFluent(pow(propose(_,_))=true).		outputEntity(pow(propose(_,_))=true).		index(pow(propose(Ag,_))=true, Ag).
sDFluent(pow(propose(_,_))=false).		outputEntity(pow(propose(_,_))=false).		index(pow(propose(Ag,_))=false, Ag).
sDFluent(pow(second(_,_))=true).		outputEntity(pow(second(_,_))=true).		index(pow(second(Ag,_))=true, Ag).
sDFluent(pow(second(_,_))=false).		outputEntity(pow(second(_,_))=false).		index(pow(second(Ag,_))=false, Ag).
sDFluent(pow(vote(_,_))=true).			outputEntity(pow(vote(_,_))=true).		index(pow(vote(Ag,_))=true, Ag).
sDFluent(pow(vote(_,_))=false).			outputEntity(pow(vote(_,_))=false).		index(pow(vote(Ag,_))=false, Ag).
sDFluent(pow(close_ballot(_,_))=true).		outputEntity(pow(close_ballot(_,_))=true).	index(pow(close_ballot(Ag,_))=true, Ag).
sDFluent(pow(close_ballot(_,_))=false).		outputEntity(pow(close_ballot(_,_))=false).	index(pow(close_ballot(Ag,_))=false, Ag).
sDFluent(pow(declare(_,_))=true).		outputEntity(pow(declare(_,_))=true).		index(pow(declare(Ag,_))=true, Ag).
sDFluent(pow(declare(_,_))=false).		outputEntity(pow(declare(_,_))=false).		index(pow(declare(Ag,_))=false, Ag).


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


cyclic(status(_)=null).
cyclic(status(_)=proposed).
cyclic(status(_)=voting).
cyclic(status(_)=voted).


% Define the groundings of the fluents and output entities/events:

grounding(status(M)=null)			:- queryMotion(M).
grounding(status(M)=proposed)			:- queryMotion(M).
grounding(status(M)=voting)			:- queryMotion(M).
grounding(status(M)=voted)			:- queryMotion(M).
grounding(voted(Ag,M)=null)			:- role_of(Ag,voter), queryMotion(M).
grounding(voted(Ag,M)=aye)			:- role_of(Ag,voter), queryMotion(M).
grounding(voted(Ag,M)=nay)			:- role_of(Ag,voter), queryMotion(M).
grounding(outcome(M)=carried)			:- queryMotion(M).
grounding(outcome(M)=not_carried)		:- queryMotion(M).
%grounding(pow(propose(Ag,M))=true)		:- agent(Ag), queryMotion(M).
%grounding(pow(second(Ag,M))=true)		:- agent(Ag), queryMotion(M).
%grounding(pow(vote(V,M))=true)			:- role_of(V,voter), queryMotion(M).
%grounding(pow(close_ballot(C,M))=true)		:- role_of(C,chair), queryMotion(M).
%grounding(pow(declare(C,M))=true)		:- role_of(C,chair), queryMotion(M).
grounding(auxPerCloseBallot(M)=true)		:- queryMotion(M).
grounding(per(close_ballot(C,M))=true)		:- role_of(C,chair), queryMotion(M).
grounding(obl(declare(C,M,carried))=true)	:- role_of(C,chair), queryMotion(M).
% in this example, we are only interested in sanctioned chairs
grounding(sanctioned(C)=true)			:- role_of(C,chair).


% Declare the order of caching of output entities.

% =================== cycle ================== % 
cachingOrder(status(_)=null). 
cachingOrder(status(_)=proposed).
cachingOrder(status(_)=voting).
cachingOrder(status(_)=voted).
% =================== cycle ================== % 
cachingOrder(voted(_,_)=aye). 			% depends on status(M) 
cachingOrder(voted(_,_)=nay).			% depends on status(M); we do no cache voted(V,M)=null
cachingOrder(outcome(_)=carried).		% depends on status(M)
cachingOrder(outcome(_)=not_carried).		% depends on status(M)
cachingOrder(auxPerCloseBallot(_)=true).	% depends on status
%cachingOrder(pow(propose(_,_))=true).		% depends on status(M)
%cachingOrder(pow(second(_,_))=true).		% depends on status(M)
%cachingOrder(pow(vote(_,_))=true).		% depends on status(M)
%cachingOrder(pow(close_ballot(_,_))=true).	% depends on status(M)
%cachingOrder(pow(declare(_,_))=true).		% depends on status(M) 
cachingOrder(per(close_ballot(_,_))=true).	% depends on status and auxPerCloseBallot
cachingOrder(obl(declare(_,_,_))=true).		% depends on status(M) and voted(V,M)
cachingOrder(sanctioned(_)=true).		% depends on per(close_ballot, status(M) and obl(declare

