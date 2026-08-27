/************************************************
 * 						*
 * Compiler unit test: Voting protocol		* 
 *                                              *
 ************************************************/

% Some extra declarations have been added in the rules and declarations to allow for unit testing
:- discontiguous fi/3, p/1, initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

:- dynamic person/1.

/*********************
      status(M)
 *********************/

% deadlines on status:
fi(status(M)=proposed, status(M)=null, 10) :-
     grounding(status(M)=proposed),
     grounding(status(M)=null).

fi(status(M)=voting, status(M)=voted, 10) :-
     grounding(status(M)=voting),
     grounding(status(M)=voted).

fi(status(M)=voted, status(M)=null, 10) :-
	grounding(status(M)=voted),
	grounding(status(M)=null).


initiatedAt(status(_M)=null, T1, -1, T2) :- T1=<(-1), -1<T2.

% in the 2 rules below we do not have a constraint on the role of the agents
% ie anyone may propose or second a motion
initiatedAt(status(M)=proposed, T1, T, T2) :-
	happensAtIE(propose(_P,M), T), 
	T1 =< T, T< T2,
	holdsAtCyclic(M, status(M)=null, T).
initiatedAt(status(M)=voting, T1, T, T2) :-
	happensAtIE(second(_S,M), T),
	T1 =< T, T< T2,
	holdsAtCyclic(M, status(M)=proposed, T).
initiatedAt(status(M)=voted, T1, T, T2) :-
	happensAtIE(close_ballot(C,M), T), 
	T1 =< T, T< T2,
	role_of(C,chair),
	holdsAtCyclic(M, status(M)=voting, T).
initiatedAt(status(M)=null, T1, T, T2) :-
	happensAtIE(declare(C,M,_), T), 
	T1 =< T, T< T2,
	role_of(C,chair),
	holdsAtCyclic(M, status(M)=voted, T).

/*********************
    voted(V,M)=Vote
 *********************/

% a voter may vote several times during status(M)=voting
% only the last vote counts
% retracting a vote is achieved by means of vote=null
% the vote actions of non-voters are ignored

initiatedAt(voted(V,M)=Vote, T1, T, T2) :-
	happensAtIE(vote(V,M,Vote), T), 
	T1 =< T, T< T2,
	holdsAtProcessedSimpleFluent(M, status(M)=voting, T).	
initiatedAt(voted(_V,M)=null, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, start(status(M)=null), T),
	T1 =< T, T< T2.

/*****************************
      outcome(M)=Outcome
 *****************************/

initiatedAt(outcome(M)=Outcome, T1, T, T2) :-
	happensAtIE(declare(C,M,Outcome), T), 
	T1 =< T, T< T2,
	holdsAtProcessedSimpleFluent(M, status(M)=voted, T),	
	role_of(C,chair).
terminatedAt(outcome(M)=_O, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, start(status(M)=proposed), T),
	T1 =< T, T< T2.

/*********************
  INSTITUTIONAL POWER
 *********************/

holdsForSDFluent(pow(propose(_P,M))=true, I) :-
	holdsForProcessedSimpleFluent(M, status(M)=null, I).
holdsForSDFluent(pow(second(_S,M))=true, I) :-
	holdsForProcessedSimpleFluent(M, status(M)=proposed, I).
% a voter is empowered to vote many times until the ballot is closed;
% only the most recent vote counts
% the fluent below is ground only for voters
holdsForSDFluent(pow(vote(_V,M))=true, I) :-
	holdsForProcessedSimpleFluent(M, status(M)=voting, I).
% the fluent below is ground only for chairs
holdsForSDFluent(pow(close_ballot(_C,M))=true, I) :-
	holdsForProcessedSimpleFluent(M, status(M)=voting, I).
% the chair is empowered to declare the outcome of the result either way
% the fluent below is ground only for chairs
holdsForSDFluent(pow(declare(_C,M))=true, I) :-
	holdsForProcessedSimpleFluent(M, status(M)=voted, I).

/*************
  PERMISSION
 *************/

% we define permission only for actions that we want to sanction

% auxPerCloseBallot is an auxiliary predicate used in the definition of 
% the permission to close the ballot

% deadline of auxPerCloseBallot 
fi(auxPerCloseBallot(M)=true, auxPerCloseBallot(M)=false, 8) :-
     grounding(auxPerCloseBallot(M)=true),
     grounding(auxPerCloseBallot(M)=false).

initiatedAt(auxPerCloseBallot(M)=true, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, start(status(M)=voting), T),
	T1 =< T, T< T2.
initiatedAt(auxPerCloseBallot(M)=false, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, start(status(M)=proposed), T),
	T1 =< T, T< T2.

% the chair is not permitted to close the ballot too early
% the fluent below is ground only for chairs
initiatedAt(per(close_ballot(_C,M))=true, T1, T, T2) :-
        happensAtProcessedSimpleFluent(M, end(auxPerCloseBallot(M)=true), T),
	T1 =< T, T< T2,
	holdsAtProcessedSimpleFluent(M, status(M)=voting, T).
initiatedAt(per(close_ballot(_C,M))=false, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, start(status(M)=voted), T),
	T1 =< T, T< T2.


/*****************
  OBLIGATION
 *****************/

% obligations are associated only with the declare action

% for efficiency, we do not define an obligation for the not_carried option
% instead, we rely on negation by failure---see the definition of sanction below
% the fluent below is ground only for chairs
initiatedAt(obl(declare(_C,M,carried))=true, T1, T, T2) :-
     happensAtProcessed(M,auxMotionOutcomeEvent(M,carried),T),
     T1=<T,
     T<T2.
initiatedAt(obl(declare(_C,M,carried))=false, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, start(status(M)=null), T),
	T1 =< T, T< T2.

/**********
  SANCTION 
 **********/

% in this example, we are only interested in sanctioned chairs
fi(sanctioned(C)=true, sanctioned(C)=false, 4) :-
	grounding(sanctioned(C)=true),
	grounding(sanctioned(C)=false).

% the sanction could be financial penalty, for example

% the chair is sanctioned if it closes the ballot when forbidden to do so
% ie closing the ballot earlier is sanctioned
initiatedAt(sanctioned(C)=true, T1, T, T2) :-
	happensAtIE(close_ballot(C,M), T), 
	T1 =< T, T< T2,
	\+ holdsAtProcessedSimpleFluent(C, per(close_ballot(C,M))=true, T).

% the chair is sanctioned if it does not comply with its obligation to declare the 
% correct outcome of the voting procedure
initiatedAt(sanctioned(C)=true, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, end(status(M)=voted), T), 
	T1 =< T, T< T2,
	\+ happensAtIE(declare(C,M,carried), T),
	holdsAtProcessedSimpleFluent(C, obl(declare(C,M,carried))=true, T).
initiatedAt(sanctioned(C)=true, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, end(status(M)=voted), T), 
	T1 =< T, T< T2,
	\+ happensAtIE(declare(C,M,not_carried), T),
	\+ holdsAtProcessedSimpleFluent(C, obl(declare(C,M,carried))=true, T).

grounding(propose(Ag,M)) :- 
     person(Ag),motion(M).

grounding(second(Ag,M)) :- 
     person(Ag),motion(M).

grounding(vote(Ag,M,_5350)) :- 
     person(Ag),motion(M).

grounding(close_ballot(Ag,M)) :- 
     person(Ag),motion(M).

grounding(declare(Ag,M,_5350)) :- 
     person(Ag),motion(M).

grounding(status(M)=null) :- 
     queryMotion(M).

grounding(status(M)=proposed) :- 
     queryMotion(M).

grounding(status(M)=voting) :- 
     queryMotion(M).

grounding(status(M)=voted) :- 
     queryMotion(M).

grounding(voted(Ag,M)=aye) :- 
     person(Ag),role_of(Ag,voter),queryMotion(M).

grounding(voted(Ag,M)=nay) :- 
     person(Ag),role_of(Ag,voter),queryMotion(M).

grounding(auxMotionOutcomeEvent(M,_5348)) :- 
     queryMotion(M).

grounding(outcome(M)=carried) :- 
     queryMotion(M).

grounding(outcome(M)=not_carried) :- 
     queryMotion(M).

grounding(auxPerCloseBallot(M)=true) :- 
     queryMotion(M).

grounding(per(close_ballot(Ag,M))=true) :- 
     person(Ag),role_of(Ag,chair),queryMotion(M).

grounding(obl(declare(Ag,M,carried))=true) :- 
     person(Ag),role_of(Ag,chair),queryMotion(M).

grounding(sanctioned(Ag)=true) :- 
     person(Ag),role_of(Ag,chair).

grounding(auxPerCloseBallot(M)=false) :- 
     queryMotion(M).

grounding(per(close_ballot(Ag,M))=false) :- 
     person(Ag),role_of(Ag,chair),queryMotion(M).

grounding(obl(declare(Ag,M,carried))=false) :- 
     person(Ag),role_of(Ag,chair),queryMotion(M).

grounding(sanctioned(Ag)=false) :- 
     person(Ag),role_of(Ag,chair).

grounding(pow(propose(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

grounding(pow(second(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

grounding(pow(vote(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

grounding(pow(close_ballot(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

grounding(pow(declare(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

inputEntity(propose(_Ag,_M)).
inputEntity(second(_Ag,_M)).
inputEntity(close_ballot(_Ag,_M)).
inputEntity(declare(_Ag,_M,_5038)).
inputEntity(vote(_Ag,_M,_5038)).

outputEntity(status(_M)=proposed).
outputEntity(status(_M)=voting).
outputEntity(status(_M)=voted).
outputEntity(status(_M)=null).
outputEntity(voted(_Ag,_M)=aye).
outputEntity(voted(_Ag,_M)=nay).
outputEntity(voted(_Ag,_M)=null).
outputEntity(outcome(_M)=carried).
outputEntity(outcome(_M)=not_carried).
outputEntity(auxPerCloseBallot(_M)=true).
outputEntity(auxPerCloseBallot(_M)=false).
outputEntity(per(close_ballot(_Ag,_M))=true).
outputEntity(per(close_ballot(_Ag,_M))=false).
outputEntity(obl(declare(_Ag,_M,_5134))=true).
outputEntity(obl(declare(_Ag,_M,_5134))=false).
outputEntity(sanctioned(_Ag)=true).
outputEntity(sanctioned(_Ag)=false).
outputEntity(pow(propose(_Ag,_M))=true).
outputEntity(pow(second(_Ag,_M))=true).
outputEntity(pow(vote(_Ag,_M))=true).
outputEntity(pow(close_ballot(_Ag,_M))=true).
outputEntity(pow(declare(_Ag,_M))=true).
outputEntity(auxMotionOutcomeEvent(_M,_5122)).

event(auxMotionOutcomeEvent(_M,_5316)).
event(propose(_Ag,_M)).
event(second(_Ag,_M)).
event(close_ballot(_Ag,_M)).
event(declare(_Ag,_M,_5318)).
event(vote(_Ag,_M,_5318)).

simpleFluent(status(_M)=proposed).
simpleFluent(status(_M)=voting).
simpleFluent(status(_M)=voted).
simpleFluent(status(_M)=null).
simpleFluent(voted(_Ag,_M)=aye).
simpleFluent(voted(_Ag,_M)=nay).
simpleFluent(voted(_Ag,_M)=null).
simpleFluent(outcome(_M)=carried).
simpleFluent(outcome(_M)=not_carried).
simpleFluent(auxPerCloseBallot(_M)=true).
simpleFluent(auxPerCloseBallot(_M)=false).
simpleFluent(per(close_ballot(_Ag,_M))=true).
simpleFluent(per(close_ballot(_Ag,_M))=false).
simpleFluent(obl(declare(_Ag,_M,_5420))=true).
simpleFluent(obl(declare(_Ag,_M,_5420))=false).
simpleFluent(sanctioned(_M)=true).
simpleFluent(sanctioned(_M)=false).

sDFluent(pow(propose(_Ag,_M))=true).
sDFluent(pow(second(_Ag,_M))=true).
sDFluent(pow(vote(_Ag,_M))=true).
sDFluent(pow(close_ballot(_Ag,_M))=true).
sDFluent(pow(declare(_Ag,_M))=true).

index(auxMotionOutcomeEvent(M,_5656),M).
index(propose(Ag,_M),Ag).
index(second(Ag,_M),Ag).
index(close_ballot(Ag,_M),Ag).
index(declare(Ag,_M,_5658),Ag).
index(vote(Ag,_M,_5658),Ag).
index(status(M)=proposed,M).
index(status(M)=voting,M).
index(status(M)=voted,M).
index(status(M)=null,M).
index(voted(Ag,_M)=aye,Ag).
index(voted(Ag,_M)=nay,Ag).
index(voted(Ag,_M)=null,Ag).
index(outcome(M)=carried,M).
index(outcome(M)=not_carried,M).
index(auxPerCloseBallot(M)=true,M).
index(auxPerCloseBallot(M)=false,M).
index(per(close_ballot(Ag,_M))=true,Ag).
index(per(close_ballot(Ag,_M))=false,Ag).
index(obl(declare(Ag,_M,_5668))=true,Ag).
index(obl(declare(Ag,_M,_5668))=false,Ag).
index(sanctioned(Ag)=true,Ag).
index(sanctioned(Ag)=false,Ag).
index(pow(propose(Ag,_M))=true,Ag).
index(pow(second(Ag,_M))=true,Ag).
index(pow(vote(Ag,_M))=true,Ag).
index(pow(close_ballot(Ag,_M))=true,Ag).
index(pow(declare(Ag,_M))=true,Ag).

cyclic(status(_M)=proposed).
cyclic(status(_M)=voting).
cyclic(status(_M)=voted).
cyclic(status(_M)=null).

cachingOrder2(M, status(M)=null) :-
     queryMotion(M).

cachingOrder2(M, status(M)=proposed) :-
     queryMotion(M).

cachingOrder2(M, status(M)=voting) :-
     queryMotion(M).

cachingOrder2(M, status(M)=voted) :-
     queryMotion(M).

cachingOrder2(Ag, voted(Ag,M)=aye) :-
     person(Ag), role_of(Ag,voter),queryMotion(M).

cachingOrder2(Ag, voted(Ag,M)=nay) :-
     person(Ag), role_of(Ag,voter),queryMotion(M).

cachingOrder2(M, outcome(M)=carried) :-
     queryMotion(M).

cachingOrder2(M, outcome(M)=not_carried) :-
     queryMotion(M).

cachingOrder2(M, auxPerCloseBallot(M)=true) :-
     queryMotion(M).

cachingOrder2(M, auxPerCloseBallot(M)=false) :-
     queryMotion(M).

cachingOrder2(Ag, per(close_ballot(Ag,M))=false) :- 
     person(Ag),role_of(Ag,chair),queryMotion(M).

cachingOrder2(Ag, obl(declare(Ag,M,_Carried))=false) :- 
     person(Ag),role_of(Ag,chair),queryMotion(M).

cachingOrder2(Ag, pow(propose(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

cachingOrder2(Ag, pow(second(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

cachingOrder2(Ag, pow(vote(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

cachingOrder2(Ag, pow(close_ballot(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

cachingOrder2(Ag, pow(declare(Ag,M))=true) :- 
     person(Ag),queryMotion(M).

cachingOrder2(Ag, per(close_ballot(Ag,M))=true) :-
     person(Ag), role_of(Ag,chair),queryMotion(M).

cachingOrder2(M, auxMotionOutcomeEvent(M,_Outcome)) :- 
     queryMotion(M).

cachingOrder2(Ag, obl(declare(Ag,M,_Carried))=true) :-
     person(Ag), role_of(Ag,chair),queryMotion(M).

cachingOrder2(Ag, sanctioned(Ag)=true) :-
     person(Ag), role_of(Ag,chair).

cachingOrder2(Ag, sanctioned(Ag)=false) :-
     person(Ag), role_of(Ag,chair).

collectGrounds([propose(_396,_410), second(_396,_410), close_ballot(_396,_410), declare(_396,_410,_412), vote(_396,_410,_412)],person(_396)).

dgrounded(voted(_1030,_1032)=aye, person(_1030)).
dgrounded(voted(_974,_976)=nay, person(_974)).
dgrounded(per(close_ballot(_790,_792))=true, person(_790)).
dgrounded(per(close_ballot(_730,_732))=false, person(_730)).
dgrounded(obl(declare(_668,_670,carried))=true, person(_668)).
dgrounded(obl(declare(_606,_608,carried))=false, person(_606)).
dgrounded(sanctioned(_558)=true, person(_558)).
dgrounded(sanctioned(_514)=false, person(_514)).
dgrounded(pow(propose(_710,_712))=true, person(_710)).
dgrounded(pow(second(_662,_664))=true, person(_662)).
dgrounded(pow(vote(_614,_616))=true, person(_614)).
dgrounded(pow(close_ballot(_566,_568))=true, person(_566)).
dgrounded(pow(declare(_518,_520))=true, person(_518)).
