
/*********************
      status(M)
 *********************/

% deadlines on status:
fi(status(M)=proposed, status(M)=null, 10) :- motion(M).
fi(status(M)=voting, status(M)=voted, 10) :- motion(M).
fi(status(M)=voted, status(M)=null, 10) :- motion(M).


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
fi(auxPerCloseBallot(M)=true, auxPerCloseBallot(M)=false, 8) :- motion(M).

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
	happensAtProcessedSimpleFluent(M, start(status(M)=voted), T),
	T1 =< T, T< T2,
	findall(V, holdsAtProcessedSimpleFluent(V, voted(V,M)=aye, T), AyeList), length(AyeList, AL), 
	findall(V, holdsAtProcessedSimpleFluent(V, voted(V,M)=nay, T), NayList), length(NayList, NL),
	% standing rules: simple majority
	AL>=NL.
initiatedAt(obl(declare(_C,M,carried))=false, T1, T, T2) :-
	happensAtProcessedSimpleFluent(M, start(status(M)=null), T),
	T1 =< T, T< T2.

/**********
  SANCTION 
 **********/

% in this example, we are only interested in sanctioned chairs
fi(sanctioned(C)=true, sanctioned(C)=false, 4) :- role_of(C, chair).

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

cachingOrder2(_131248, status(_131248)=null) :-
     queryMotion(_131248).

cachingOrder2(_131248, status(_131248)=proposed) :-
     queryMotion(_131248).

cachingOrder2(_131248, status(_131248)=voting) :-
     queryMotion(_131248).

cachingOrder2(_131248, status(_131248)=voted) :-
     queryMotion(_131248).

cachingOrder2(_131248, voted(_131248,_131249)=aye) :-
     role_of(_131248,voter),queryMotion(_131249).

cachingOrder2(_131248, voted(_131248,_131249)=nay) :-
     role_of(_131248,voter),queryMotion(_131249).

cachingOrder2(_131248, outcome(_131248)=carried) :-
     queryMotion(_131248).

cachingOrder2(_131248, outcome(_131248)=not_carried) :-
     queryMotion(_131248).

cachingOrder2(_131248, auxPerCloseBallot(_131248)=true) :-
     queryMotion(_131248).

cachingOrder2(_131250, per(close_ballot(_131250,_131251))=true) :-
     role_of(_131250,chair),queryMotion(_131251).

cachingOrder2(_131250, obl(declare(_131250,_131251,carried))=true) :-
     role_of(_131250,chair),queryMotion(_131251).

cachingOrder2(_131248, sanctioned(_131248)=true) :-
     role_of(_131248,chair).

