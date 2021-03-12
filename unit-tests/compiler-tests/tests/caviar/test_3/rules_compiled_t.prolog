
/************************************************
 * 						*
 * Compiler unit test: Activity recognition	*
 * in CAVIAR					* 
 *                                              *
 ************************************************/

% This file has been produced by a working version of the compiler

% Some extra declarations have been added in the rules and declarations to allow for unit testing
:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2, maxDuration/3, maxDurationUE/3, cyclic/1.

:- discontiguous initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

/*********************************** CAVIAR CE DEFINITIONS *************************************/

/****************************************
 *		  CLOSE 		*
 ****************************************/

holdsForSDFluent(close(Id1,Id2,24)=true, I) :-
	holdsForProcessedIE(Id1, distance(Id1,Id2,24)=true, I).

holdsForSDFluent(close(Id1,Id2,25)=true, I) :-
	holdsForProcessedSDFluent(Id1, close(Id1,Id2,24)=true, I1),
	holdsForProcessedIE(Id1, distance(Id1,Id2,25)=true, I2),
	union_all([I1,I2], I).

holdsForSDFluent(close(Id1,Id2,30)=true, I) :-
	holdsForProcessedSDFluent(Id1, close(Id1,Id2,25)=true, I1),
	holdsForProcessedIE(Id1, distance(Id1,Id2,30)=true, I2),
	union_all([I1,I2], I).

holdsForSDFluent(close(Id1,Id2,34)=true, I) :-
	holdsForProcessedSDFluent(Id1, close(Id1,Id2,30)=true, I1),
	holdsForProcessedIE(Id1, distance(Id1,Id2,34)=true, I2),
	union_all([I1,I2], I).

holdsForSDFluent(close(Id1,Id2,Threshold)=false, I) :-
	holdsForProcessedSDFluent(Id1, close(Id1,Id2,Threshold)=true, I1),
	complement_all([I1], I).

% this is a variation of close 

holdsForSDFluent(closeSymmetric(Id1,Id2,Threshold)=true, I) :-
	holdsForProcessedSDFluent(Id1, close(Id1,Id2,Threshold)=true, I1),
	holdsForProcessedSDFluent(Id2, close(Id2,Id1,Threshold)=true, I2),
	union_all([I1,I2], I).


/****************************************************************
 *		     PERSON					*
 ****************************************************************/

initiatedAt(person(Id)=true, T1, T, T2) :-
	happensAtProcessedIE(Id, startI(walking(Id)=true), T),
	T1 =< T, T < T2, 
	\+ happensAtIE(disappear(Id), T).

initiatedAt(person(Id)=true, T1, T, T2) :-
	happensAtProcessedIE(Id, startI(running(Id)=true), T),
	T1 =< T, T < T2,
	\+ happensAtIE(disappear(Id), T).

initiatedAt(person(Id)=true, T1, T, T2) :-
	happensAtProcessedIE(Id, startI(active(Id)=true), T),
	T1 =< T, T < T2,
	\+ happensAtIE(disappear(Id), T).

initiatedAt(person(Id)=true, T1, T, T2) :-
	happensAtProcessedIE(Id, startI(abrupt(Id)=true), T),
	T1 =< T, T < T2,
	\+ happensAtIE(disappear(Id), T).

initiatedAt(person(Id)=false, T1, T, T2) :-
	happensAtIE(disappear(Id), T),
	T1 =< T, T < T2.


/****************************************************************
 *		     LEAVING OBJECT				*
 ****************************************************************/

% ----- initiate leaving_object

initiatedAt(leaving_object(Person,Object)=true, T1, T, T2) :-
	happensAtIE(appear(Object), T), 
	T1 =< T, T < T2,
	holdsAtProcessedIE(Object, inactive(Object)=true, T),
	holdsAtProcessedSimpleFluent(Person, person(Person)=true, T),
	% leaving_object is not symmetric in the pair of ids
	% and thus we need closeSymmetric here as opposed to close 
	holdsAtProcessedSDFluent(Person, closeSymmetric(Person,Object,30)=true, T).

% ----- terminate leaving_object: pick up object

initiatedAt(leaving_object(_Person,Object)=false, T1, T, T2) :-
	happensAtIE(disappear(Object), T),
	T1 =< T, T < T2.


/****************************************************************
 *		     MEETING					*
 ****************************************************************/

% ----- initiate meeting

initiatedAt(meeting(P1,P2)=true, T1, T, T2) :-
	happensAtProcessedSDFluent(P1, startI(greeting1(P1,P2)=true), T),
	T1 =< T, T < T2,	
	\+ happensAtIE(disappear(P1), T),
	\+ happensAtIE(disappear(P2), T).

initiatedAt(meeting(P1,P2)=true, T1, T, T2) :-
	happensAtProcessedSDFluent(P1, startI(greeting2(P1,P2)=true), T),	
	T1 =< T, T < T2,
	\+ happensAtIE(disappear(P1), T),
	\+ happensAtIE(disappear(P2), T).

% greeting1 

holdsForSDFluent(greeting1(P1,P2)=true, I) :-
	holdsForProcessedSDFluent(P1, activeOrInactivePerson(P1)=true, IAI),
	% optional optimisation check
	\+ IAI=[],
	holdsForProcessedSimpleFluent(P2, person(P2)=true, IP2),
	% optional optimisation check	
	\+ IP2=[],
	holdsForProcessedSDFluent(P1, close(P1,P2,25)=true, IC),
	% optional optimisation check
	\+ IC=[],  
	intersect_all([IAI, IC, IP2], ITemp),
	% optional optimisation check
	\+ ITemp=[], !,
	holdsForProcessedIE(P2, running(P2)=true, IR2),
	holdsForProcessedIE(P2, abrupt(P2)=true, IA2),
	relative_complement_all(ITemp, [IR2,IA2], I).

% the rule below is the result of the above optimisation checks
holdsForSDFluent(greeting1(_P1,_P2)=true, []).

% greeting2

holdsForSDFluent(greeting2(P1,P2)=true, I) :-
	% if P1 were active or inactive 
	% then meeting would have been initiated by greeting1	
	holdsForProcessedIE(P1, walking(P1)=true, IW1),
	% optional optimisation check
	\+ IW1=[],
	holdsForProcessedSDFluent(P2, activeOrInactivePerson(P2)=true, IAI2),
	% optional optimisation check
	\+ IAI2=[],
	holdsForProcessedSDFluent(P2, close(P2,P1,25)=true, IC),
	% optional optimisation check	
	\+ IC=[], !,
	intersect_all([IW1, IAI2, IC], I).

% the rule below is the result of the above optimisation checks
holdsForSDFluent(greeting2(_P1,_P2)=true, []).

% activeOrInactivePersion 

holdsForSDFluent(activeOrInactivePerson(P)=true, I) :-
	holdsForProcessedIE(P, active(P)=true, IA),
	holdsForProcessedIE(P, inactive(P)=true, In),
	holdsForProcessedSimpleFluent(P, person(P)=true, IP),
	intersect_all([In,IP], InP),
	union_all([IA,InP], I).


% ----- terminate meeting

% run
initiatedAt(meeting(P1,_P2)=false, T1, T, T2) :-
	happensAtProcessedIE(P1, startI(running(P1)=true), T),
	T1 =< T, T < T2.

initiatedAt(meeting(_P1,P2)=false, T1, T, T2) :-
	happensAtProcessedIE(P2, startI(running(P2)=true), T),
	T1 =< T, T < T2.

% move abruptly
initiatedAt(meeting(P1,_P2)=false, T1, T, T2) :-
	happensAtProcessedIE(P1, startI(abrupt(P1)=true), T),
	T1 =< T, T < T2.

initiatedAt(meeting(_P1,P2)=false, T1, T, T2) :-
	happensAtProcessedIE(P2, startI(abrupt(P2)=true), T),
	T1 =< T, T < T2.

% move away from each other
initiatedAt(meeting(P1,P2)=false, T1, T, T2) :-
	happensAtProcessedSDFluent(P1, startI(close(P1,P2,34)=false), T),
	T1 =< T, T < T2.


/****************************************************************
 *		     MOVING					*
 ****************************************************************/

holdsForSDFluent(moving(P1,P2)=true, MI) :-
	holdsForProcessedIE(P1, walking(P1)=true, WP1),
	holdsForProcessedIE(P2, walking(P2)=true, WP2),
	intersect_all([WP1,WP2], WI),
	% optional optimisation check
	\+ WI=[], 
	holdsForProcessedSDFluent(P1, close(P1,P2,34)=true, CI),
	% optional optimisation check
	\+ CI=[], !,
	intersect_all([WI,CI], MI).

% the rule below is the result of the above optimisation checks
holdsForSDFluent(moving(_P1,_P2)=true, []).


/****************************************************************
 *		     FIGHTING					*
 ****************************************************************/

holdsForSDFluent(fighting(P1,P2)=true, FightingI) :-
	holdsForProcessedIE(P1, abrupt(P1)=true, AbruptP1I),
	holdsForProcessedIE(P2, abrupt(P2)=true, AbruptP2I),
	union_all([AbruptP1I,AbruptP2I], AbruptI),
	% optional optimisation check
	\+ AbruptI=[],
	holdsForProcessedSDFluent(P1, close(P1,P2,24)=true, CloseI),
	% optional optimisation check
	\+ CloseI=[],
	intersect_all([AbruptI,CloseI], AbruptCloseI),
	% optional optimisation check	
	\+ AbruptCloseI=[], !,
	holdsForProcessedIE(P1, inactive(P1)=true, InactiveP1I),
	holdsForProcessedIE(P2, inactive(P2)=true, InactiveP2I),
	union_all([InactiveP1I,InactiveP2I], InactiveI),
	relative_complement_all(AbruptCloseI, [InactiveI], FightingI).

% the rule below is the result of the above optimisation checks
holdsForSDFluent(fighting(_P1,_P2)=true, []).


cachingOrder2(_131123, close(_131123,_131124,24)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,25)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,30)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,34)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,34)=false) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, closeSymmetric(_131123,_131124,30)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, person(_131123)=true) :-
     list_of_ids(_131123).

cachingOrder2(_131123, activeOrInactivePerson(_131123)=true) :-
     list_of_ids(_131123).

cachingOrder2(_131123, greeting1(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, greeting2(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, leaving_object(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, leaving_object(_131123,_131124)=true) :-
     symmetric_id_pair(_131123,_131124).

cachingOrder2(_131123, meeting(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, moving(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, fighting(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

buildFromPoints2(_131123, walking(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, active(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, inactive(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, running(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, abrupt(_131123)=true) :-
     list_of_ids(_131123).


