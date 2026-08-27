
/************************************************
 * 						*
 * Compiler unit test: Activity recognition	*
 * in CAVIAR					* 
 *                                              *
 ************************************************/


/*********************************** CAVIAR CE DEFINITIONS *************************************/

/****************************************
 *		  CLOSE 		*
 ****************************************/

holdsFor(close(Id1,Id2,24)=true, I) :-
	holdsFor(distance(Id1,Id2,24)=true, I).

holdsFor(close(Id1,Id2,25)=true, I) :-
	holdsFor(close(Id1,Id2,24)=true, I1),
	holdsFor(distance(Id1,Id2,25)=true, I2),
	union_all([I1,I2], I).

holdsFor(close(Id1,Id2,30)=true, I) :-
	holdsFor(close(Id1,Id2,25)=true, I1),
	holdsFor(distance(Id1,Id2,30)=true, I2),
	union_all([I1,I2], I).

holdsFor(close(Id1,Id2,34)=true, I) :-
	holdsFor(close(Id1,Id2,30)=true, I1),
	holdsFor(distance(Id1,Id2,34)=true, I2),
	union_all([I1,I2], I).

holdsFor(close(Id1,Id2,Threshold)=false, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true, I1),
	complement_all([I1], I).

% this is a variation of close 

holdsFor(closeSymmetric(Id1,Id2,Threshold)=true, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true, I1),
	holdsFor(close(Id2,Id1,Threshold)=true, I2),
	union_all([I1,I2], I).


/****************************************************************
 *		     PERSON					*
 ****************************************************************/

initiatedAt(person(Id)=true, T) :-
	happensAt(startI(walking(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(startI(running(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(startI(active(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(startI(abrupt(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=false, T) :-
	happensAt(disappear(Id), T).


/****************************************************************
 *		     LEAVING OBJECT				*
 ****************************************************************/

% ----- initiate leaving_object

initiatedAt(leaving_object(Person,Object)=true, T) :-
	happensAt(appear(Object), T), 
	holdsAt(inactive(Object)=true, T),
	holdsAt(person(Person)=true, T),
	% leaving_object is not symmetric in the pair of ids
	% and thus we need closeSymmetric here as opposed to close 
	holdsAt(closeSymmetric(Person,Object,30)=true, T).

% ----- terminate leaving_object: pick up object

initiatedAt(leaving_object(_Person,Object)=false, T) :-
	happensAt(disappear(Object), T).


/****************************************************************
 *		     MEETING					*
 ****************************************************************/

% ----- initiate meeting

initiatedAt(meeting(P1,P2)=true, T) :-
	happensAt(startI(greeting1(P1,P2)=true), T),	
	\+ happensAt(disappear(P1), T),
	\+ happensAt(disappear(P2), T).

initiatedAt(meeting(P1,P2)=true, T) :-
	happensAt(startI(greeting2(P1,P2)=true), T),	
	\+ happensAt(disappear(P1), T),
	\+ happensAt(disappear(P2), T).

% greeting1 

holdsFor(greeting1(P1,P2)=true, I) :-
	holdsFor(activeOrInactivePerson(P1)=true, IAI),
	% optional optimisation check
	\+ IAI=[],
	holdsFor(person(P2)=true, IP2),
	% optional optimisation check	
	\+ IP2=[],
	holdsFor(close(P1,P2,25)=true, IC),
	% optional optimisation check
	\+ IC=[],  
	intersect_all([IAI, IC, IP2], ITemp),
	% optional optimisation check
	\+ ITemp=[], !,
	holdsFor(running(P2)=true, IR2),
	holdsFor(abrupt(P2)=true, IA2),
	relative_complement_all(ITemp, [IR2,IA2], I).

% the rule below is the result of the above optimisation checks
holdsFor(greeting1(_P1,_P2)=true, []).

% greeting2

holdsFor(greeting2(P1,P2)=true, I) :-
	% if P1 were active or inactive 
	% then meeting would have been initiated by greeting1	
	holdsFor(walking(P1)=true, IW1),
	% optional optimisation check
	\+ IW1=[],
	holdsFor(activeOrInactivePerson(P2)=true, IAI2),
	% optional optimisation check
	\+ IAI2=[],
	holdsFor(close(P2,P1,25)=true, IC),
	% optional optimisation check	
	\+ IC=[], !,
	intersect_all([IW1, IAI2, IC], I).

% the rule below is the result of the above optimisation checks
holdsFor(greeting2(_P1,_P2)=true, []).

% activeOrInactivePersion 

holdsFor(activeOrInactivePerson(P)=true, I) :-
	holdsFor(active(P)=true, IA),
	holdsFor(inactive(P)=true, In),
	holdsFor(person(P)=true, IP),
	intersect_all([In,IP], InP),
	union_all([IA,InP], I).


% ----- terminate meeting

% run
initiatedAt(meeting(P1,_P2)=false, T) :-
	happensAt(startI(running(P1)=true), T).

initiatedAt(meeting(_P1,P2)=false, T) :-
	happensAt(startI(running(P2)=true), T).

% move abruptly
initiatedAt(meeting(P1,_P2)=false, T) :-
	happensAt(startI(abrupt(P1)=true), T).

initiatedAt(meeting(_P1,P2)=false, T) :-
	happensAt(startI(abrupt(P2)=true), T).

% move away from each other
initiatedAt(meeting(P1,P2)=false, T) :-
	happensAt(startI(close(P1,P2,34)=false), T).


/****************************************************************
 *		     MOVING					*
 ****************************************************************/

holdsFor(moving(P1,P2)=true, MI) :-
	holdsFor(walking(P1)=true, WP1),
	holdsFor(walking(P2)=true, WP2),
	intersect_all([WP1,WP2], WI),
	% optional optimisation check
	\+ WI=[], 
	holdsFor(close(P1,P2,34)=true, CI),
	% optional optimisation check
	\+ CI=[], !,
	intersect_all([WI,CI], MI).

% the rule below is the result of the above optimisation checks
holdsFor(moving(_P1,_P2)=true, []).


/****************************************************************
 *		     FIGHTING					*
 ****************************************************************/

holdsFor(fighting(P1,P2)=true, FightingI) :-
	holdsFor(abrupt(P1)=true, AbruptP1I),
	holdsFor(abrupt(P2)=true, AbruptP2I),
	union_all([AbruptP1I,AbruptP2I], AbruptI),
	% optional optimisation check
	\+ AbruptI=[],
	holdsFor(close(P1,P2,24)=true, CloseI),
	% optional optimisation check
	\+ CloseI=[],
	intersect_all([AbruptI,CloseI], AbruptCloseI),
	% optional optimisation check	
	\+ AbruptCloseI=[], !,
	holdsFor(inactive(P1)=true, InactiveP1I),
	holdsFor(inactive(P2)=true, InactiveP2I),
	union_all([InactiveP1I,InactiveP2I], InactiveI),
	relative_complement_all(AbruptCloseI, [InactiveI], FightingI).

% the rule below is the result of the above optimisation checks
holdsFor(fighting(_P1,_P2)=true, []).

% The elements of these domains are derived from the ground arguments of input entitites
dynamicDomain(id(_P)).

% Grounding of input entities:
grounding(appear(P)):-
	id(P).
grounding(disappear(P)):-
	id(P).
grounding(orientation(P)=_):-
	id(P).
grounding(appearance(P)=_):-
	id(P).
grounding(coord(P,_,_)=_):-
	id(P).
grounding(walking(P)=_):-
	id(P).
grounding(active(P)=_):-
	id(P).
grounding(inactive(P)=_):-
	id(P).
grounding(running(P)=_):-
	id(P).
grounding(abrupt(P)=_):-
	id(P).

grounding(close(P1,P2,24)=true) :- id(P1), id(P2), P1@<P2.
grounding(close(P1,P2,25)=true) :- id(P1), id(P2), P1@<P2.	
grounding(close(P1,P2,30)=true) :- id(P1), id(P2), P1@<P2.	
grounding(close(P1,P2,34)=true) :- id(P1), id(P2), P1@<P2.
% we are only interesting in caching close=false with respect to the 34 threshold
% we don't need any other thresholds for this fluent in the CAVIAR event description
grounding(close(P1,P2,34)=false) :-	id(P1), id(P2), P1@<P2.
% similarly we are only interesting in caching closeSymmetric=true with respect to the 30 threshold
grounding(closeSymmetric(P1,P2,30)=true) :- id(P1), id(P2), P1@<P2.
grounding(walking(P)=true) :- id(P). 
grounding(active(P)=true) :- id(P). 
grounding(inactive(P)=true) :- id(P).
grounding(abrupt(P)=true) :- id(P).
grounding(running(P)=true) :- id(P).
grounding(person(P)=true) :- id(P).
grounding(activeOrInactivePerson(P)=true) :- id(P).	
grounding(greeting1(P1,P2)=true) :- id(P1), id(P2), P1@<P2.
grounding(greeting2(P1,P2)=true) :- id(P1), id(P2), P1@<P2.
grounding(leaving_object(P,O)=true) :- id(P), id(O), P@<O.
grounding(meeting(P1,P2)=true) :- id(P1), id(P2), P1@<P2.
grounding(moving(P1,P2)=true) :- id(P1), id(P2), P1@<P2.
grounding(fighting(P1,P2)=true) :- id(P1), id(P2), P1@<P2.

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
% output entities. 	 

buildFromPoints(walking(_)=true).
buildFromPoints(active(_)=true).
buildFromPoints(inactive(_)=true).
buildFromPoints(running(_)=true).
buildFromPoints(abrupt(_)=true).


