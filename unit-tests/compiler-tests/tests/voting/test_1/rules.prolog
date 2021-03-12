/************************************************
 * 						*
 * Compiler unit test: Voting protocol		* 
 *                                              *
 ************************************************/


/*********************
      status(M)
 *********************/

% deadlines on status:
maxDuration(status(M)=proposed, status(M)=null, 10) :- motion(M).
maxDuration(status(M)=voting, status(M)=voted, 10) :- motion(M).
maxDuration(status(M)=voted, status(M)=null, 10) :- motion(M).


% initiatedAt(status(M)=null, T1, -1, T2) :- T1=<(-1), -1<T2.
initially(status(_M)=null).
% in the 2 rules below we do not have a constraint on the role of the agents
% ie anyone may propose or second a motion
initiatedAt(status(M)=proposed, T) :-
	happensAt(propose(_P,M), T), 
	holdsAt(M, status(M)=null, T).
initiatedAt(status(M)=voting, T) :-
	happensAt(second(_S,M), T),
	holdsAt(M, status(M)=proposed, T).
initiatedAt(status(M)=voted, T) :-
	happensAt(close_ballot(C,M), T), 
	role_of(C,chair),
	holdsAt(M, status(M)=voting, T).
initiatedAt(status(M)=null, T) :-
	happensAt(declare(C,M,_), T), 
	role_of(C,chair),
	holdsAt(M, status(M)=voted, T).

/*********************
    voted(V,M)=Vote
 *********************/

% a voter may vote several times during status(M)=voting
% only the last vote counts
% retracting a vote is achieved by means of vote=null
% the vote actions of non-voters are ignored

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
% a voter is empowered to vote many times until the ballot is closed;
% only the most recent vote counts
% the fluent below is ground only for voters
holdsFor(pow(vote(_V,M))=true, I) :-
	holdsFor(status(M)=voting, I).
% the fluent below is ground only for chairs
holdsFor(pow(close_ballot(_C,M))=true, I) :-
	holdsFor(status(M)=voting, I).
% the chair is empowered to declare the outcome of the result either way
% the fluent below is ground only for chairs
holdsFor(pow(declare(_C,M))=true, I) :-
	holdsFor(status(M)=voted, I).

/*************
  PERMISSION
 *************/

% we define permission only for actions that we want to sanction

% auxPerCloseBallot is an auxiliary predicate used in the definition of 
% the permission to close the ballot

% deadline of auxPerCloseBallot 
maxDuration(auxPerCloseBallot(M)=true, auxPerCloseBallot(M)=false, 8) :- motion(M).

initiatedAt(auxPerCloseBallot(M)=true, T) :-
	happensAt(start(status(M)=voting), T).
initiatedAt(auxPerCloseBallot(M)=false, T) :-
	happensAt(start(status(M)=proposed), T).

% the chair is not permitted to close the ballot too early
% the fluent below is ground only for chairs
initiatedAt(per(close_ballot(_C,M))=true, T) :-
        happensAt(end(auxPerCloseBallot(M)=true), T),
	holdsAt(status(M)=voting, T).
initiatedAt(per(close_ballot(_C,M))=false, T) :-
	happensAt(start(status(M)=voted), T).


/*****************
  OBLIGATION
 *****************/

% obligations are associated only with the declare action

% for efficiency, we do not define an obligation for the not_carried option
% instead, we rely on negation by failure---see the definition of sanction below
% the fluent below is ground only for chairs
initiatedAt(obl(declare(_C,M,carried))=true, T) :-
	happensAt(start(status(M)=voted), T),
	findall(V, holdsAt(voted(V,M)=aye, T), AyeList), length(AyeList, AL), 
	findall(V, holdsAt(voted(V,M)=nay, T), NayList), length(NayList, NL),
	% standing rules: simple majority
	AL>=NL.
initiatedAt(obl(declare(_C,M,carried))=false, T) :-
	happensAt(start(status(M)=null), T).

/**********
  SANCTION 
 **********/

% in this example, we are only interested in sanctioned chairs
maxDuration(sanctioned(C)=true, sanctioned(C)=false, 4) :- role_of(C, chair).

% the sanction could be financial penalty, for example

% the chair is sanctioned if it closes the ballot when forbidden to do so
% ie closing the ballot earlier is sanctioned
initiatedAt(sanctioned(C)=true, T) :-
	happensAt(close_ballot(C,M), T), 
	\+ holdsAt(per(close_ballot(C,M))=true, T).

% the chair is sanctioned if it does not comply with its obligation to declare the 
% correct outcome of the voting procedure
initiatedAt(sanctioned(C)=true, T) :-
	happensAt(end(status(M)=voted), T), 
	\+ happensAt(declare(C,M,carried), T),
	holdsAt(obl(declare(C,M,carried))=true, T).
initiatedAt(sanctioned(C)=true, T) :-
	happensAt(end(status(M)=voted), T), 
	\+ happensAt(declare(C,M,not_carried), T),
	\+ holdsAt(obl(declare(C,M,carried))=true, T).


