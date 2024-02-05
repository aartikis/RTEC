/****************************************************************
 *                                                              *
 * A Voting Protocol (VoPr) in RTEC				*
 * Alexander Artikis						*
 *								*
 * Based on the specification of Jeremy Pitt		 	* 
 *                                                              *
 ****************************************************************/

/*
In this example, institutional power is best expressed by statically determined
fluents. Power is NOT used as a condition in the rules expressing the effects 
of actions because cycles cannot include statically determined fluents. 
Power however is defined to answer queries. 
*/

/****************************************
  AGENT ACTIONS 	                                             
  propose(Agent, Motion)           
  second(Agent, Motion)           
  vote(Agent, Motion, aye)      	
  vote(Agent, Motion, nay)      			
  close_ballot(Agent, Motion)          
  declare(Agent, Motion, carried/not_carried)	
 ****************************************/                          

/********************************
  PROTOCOL FLOW 
  propose(Ag,M), second(Ag,M), vote(V1,M,Vote),...,vote(Vn,M,Vote),
  close_ballot(C,M), declare(C, M, Outcome)

  agents start voting as soon as there is a secondment, ie there is no open_ballot
 ********************************/

/*********************
      status(M)
 *********************/

% deadlines on status:
fi(status(M)=proposed, status(M)=null, 10).
fi(status(M)=voting, status(M)=voted, 10).
fi(status(M)=voted, status(M)=null, 10).

initially(status(_M)=null).
initiatedAt(status(M)=proposed, T) :-
	happensAt(propose(_P,M), T), 
	holdsAt(status(M)=null, T).
initiatedAt(status(M)=voting, T) :-
	happensAt(second(_S,M), T),
	holdsAt(status(M)=proposed, T).
initiatedAt(status(M)=voted, T) :-
	happensAt(close_ballot(C,M), T), 
	role_of(C,chair),
	holdsAt(status(M)=voting, T).
initiatedAt(status(M)=null, T) :-
	happensAt(declare(C,M,_), T), 
	role_of(C,chair),
	holdsAt(status(M)=voted, T).

/*********************
    voted(V,M)=Vote
 *********************/

initiatedAt(voted(V,M)=Vote, T) :-
	happensAt(vote(V,M,Vote), T), 
	holdsAt(status(M)=voting, T).	
initiatedAt(voted(_V,M)=null, T) :-
	happensAt(start(status(M)=null), T).

/*****************************
      outcome(M)=Outcome
 *****************************/

initiatedAt(outcome(M)=Outcome, T) :-
	happensAt(declare(C,M,Outcome), T), 
	holdsAt(status(M)=voted, T),	
	role_of(C,chair).
terminatedAt(outcome(M)=_O, T) :-
	happensAt(start(status(M)=proposed), T).

/*********************
  INSTITUTIONAL POWER
 *********************/

holdsFor(pow(propose(_P,M))=true, I) :-
	holdsFor(status(M)=null, I).
holdsFor(pow(second(_S,M))=true, I) :-
	holdsFor(status(M)=proposed, I).
holdsFor(pow(vote(_V,M))=true, I) :-
	holdsFor(status(M)=voting, I).
holdsFor(pow(close_ballot(_C,M))=true, I) :-
	holdsFor(status(M)=voting, I).
holdsFor(pow(declare(_C,M))=true, I) :-
	holdsFor(status(M)=voted, I).

/*************
  PERMISSION
 *************/

fi(auxPerCloseBallot(M)=true, auxPerCloseBallot(M)=false, 8).

initiatedAt(auxPerCloseBallot(M)=true, T) :-
	happensAt(start(status(M)=voting), T).
initiatedAt(auxPerCloseBallot(M)=false, T) :-
	happensAt(start(status(M)=proposed), T).
initiatedAt(per(close_ballot(_C,M))=true, T) :-
    happensAt(end(auxPerCloseBallot(M)=true), T),
	holdsAt(status(M)=voting, T).
initiatedAt(per(close_ballot(_C,M))=false, T) :-
	happensAt(start(status(M)=voted), T).

happensAt(auxMotionOutcomeEvent(M,carried), T) :-
	happensAt(start(status(M)=voted), T),
    findall(V, holdsAt(voted(V,M)=aye, T), AyeList), length(AyeList, AL), 
    findall(V, holdsAt(voted(V,M)=nay, T), NayList), length(NayList, NL),
    % standing rules: simple majority
    AL>=NL.

/*****************
  OBLIGATION
 *****************/

 initiatedAt(obl(declare(_C,M,carried))=true, T):-
     happensAt(auxMotionOutcomeEvent(M,carried), T).
initiatedAt(obl(declare(_C,M,carried))=false, T) :-
	happensAt(start(status(M)=null), T).

/**********
  SANCTION 
 **********/

fi(sanctioned(C)=true, sanctioned(C)=false, 4).

initiatedAt(sanctioned(C)=true, T) :-
	happensAt(close_ballot(C,M), T), 
	\+ holdsAt(per(close_ballot(C,M))=true, T).
initiatedAt(sanctioned(C)=true, T) :-
	happensAt(end(status(M)=voted), T), 
	\+ happensAt(declare(C,M,carried), T),
	holdsAt(obl(declare(C,M,carried))=true, T).
initiatedAt(sanctioned(C)=true, T) :-
	happensAt(end(status(M)=voted), T), 
	\+ happensAt(declare(C,M,not_carried), T),
	\+ holdsAt(obl(declare(C,M,carried))=true, T).

% The elements of these domains are derived from the ground arguments of input entitites
dynamicDomain(person(_P)).

% Grounding of input entities

grounding(propose(Ag, M)) :- person(Ag), motion(M).
grounding(second(Ag, M)) :- person(Ag), motion(M).
grounding(vote(Ag, M, _)) :- person(Ag), motion(M).
grounding(close_ballot(Ag, M)) :- person(Ag), motion(M).
grounding(declare(Ag, M, _)) :- person(Ag), motion(M).

% Grounding of output entities 

grounding(status(M)=null):- queryMotion(M).
grounding(status(M)=proposed)			:- queryMotion(M).
grounding(status(M)=voting)			:- queryMotion(M).
grounding(status(M)=voted)			:- queryMotion(M).

%grounding(voted(Ag,M)=null)			:- person(Ag),role_of(Ag,voter), queryMotion(M).
grounding(voted(Ag,M)=aye)			:- person(Ag),role_of(Ag,voter), queryMotion(M).
grounding(voted(Ag,M)=nay)			:- person(Ag),role_of(Ag,voter), queryMotion(M).

grounding(auxMotionOutcomeEvent(M,_Outcome)) :- queryMotion(M).

grounding(outcome(M)=carried)			:- queryMotion(M).
grounding(outcome(M)=not_carried)		:- queryMotion(M).

grounding(auxPerCloseBallot(M)=true)		:- queryMotion(M).

grounding(per(close_ballot(C,M))=true)		:- person(C), role_of(C,chair), queryMotion(M).

grounding(obl(declare(C,M,carried))=true)	:- person(C), role_of(C,chair), queryMotion(M).

grounding(sanctioned(C)=true)			:- person(C), role_of(C,chair).

grounding(auxPerCloseBallot(M)=false)		:- queryMotion(M).

grounding(per(close_ballot(C,M))=false)		:- person(C), role_of(C,chair), queryMotion(M).

grounding(obl(declare(C,M,carried))=false)	:- person(C), role_of(C,chair), queryMotion(M).

grounding(sanctioned(C)=false)			:- person(C), role_of(C,chair).

