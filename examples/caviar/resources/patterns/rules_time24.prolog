
/*********************************************************************************************************************************
This file represents the event decription written by the user.

Available predicates:
-happensAt(E, T) represents a time-point T in which an event E occurs. 
-holdsFor(U, L) represents the list L of the maximal intervals in which a U holds. 
-holdsAt(U, T) representes a time-point in which U holds. holdsAt may be used only in the body of a rule.
-initially(U) expresses the value of U at time 0. 
-initiatedAt(U, T) states the conditions in which U is initiated. initiatedAt may be used only in the head of a rule.
-terminatedAt(U, T) states the conditions in which U is terminated. terminatedAt may be used only in the head of a rule.

For backward compatibility the following predicates are also allowed:

-initiates(E, U, T) states that the occurrence of event E at time T initiates a period of time for which U holds. initiates may be used only in the head of a rule.
-terminates(E, U, T) states that the occurrence of event E at time T terminates a period of time for which U holds. terminates may be used only in the head of a rule.

NOTE:
-The optimisation checks in the statically determined fluent definitions are optional.
**********************************************************************************************************************************/

/*********************************** CAVIAR CE DEFINITIONS *************************************/

/****************************************
 *		  CLOSE 		*
 ****************************************/

holdsFor(distance(Id1,Id2)=short, I) :-
	holdsFor(distance(Id1,Id2,24)=true, I).

holdsFor(distance(Id1,Id2)=mid, I) :-
	holdsFor(distance(Id1,Id2,30)=true, I).

holdsFor(orientation(Id1,Id2)=facing, I) :-
        % dummy body, just for compilation.
	holdsFor(distance(Id1,Id2,34)=true, I).

/****************************************************************
 *		     INTERACTION			        *
 ****************************************************************/

initiatedAt(interaction(P1,P2)=greeting, T):-
     happensAt(active(P1), T),
     happensAt(active(P2), T),
     holdsAt(distance(P1,P2)=mid, T),
     holdsAt(orientation(P1,P2)=facing, T).

initiatedAt(interaction(P1,P2)=talking, T):-
    happensAt(active(P1), T),
    holdsAt(distance(P1,P2)=short, T),
    holdsAt(orientation(P1,P2)=facing, T),
    \+ holdsAt(movement(P1,P2)=gathering, T).

initiatedAt(interaction(P1,P2)=talking, T):-
    happensAt(active(P2), T),
    holdsAt(distance(P1,P2)=short, T),
    holdsAt(orientation(P1,P2)=facing, T),
    \+ holdsAt(movement(P1,P2)=gathering, T).

terminatedAt(interaction(P1,P2)=talking, T):-
    happensAt(inactive(P1), T),
    happensAt(inactive(P2), T).

/****************************************************************
 *		     MOVEMENT					*
 ****************************************************************/

initiatedAt(movement(P1,P2)=gathering, T):-
    happensAt(walking(P1), T),
    holdsAt(distance(P1,P2)=mid, T),
    holdsAt(orientation(P1,P2)=facing, T).

initiatedAt(movement(P1,P2)=gathering, T):-
    happensAt(walking(P2), T),
    holdsAt(distance(P1,P2)=mid, T),
    holdsAt(orientation(P1,P2)=facing, T).

terminatedAt(movement(P1,P2)=gathering, T):-
    happensAt(active(P1), T),
    \+ happensAt(walking(P2), T).

terminatedAt(movement(P1,P2)=gathering, T):-
    happensAt(active(P2), T),
    \+ happensAt(walking(P1), T).

initiatedAt(movement(P1,P2)=abrupt_gestures, T):-
    happensAt(abrupt(P1), T),
    holdsAt(interaction(P1,P2)=talking, T).

initiatedAt(movement(P1,P2)=abrupt_gestures, T):-
    happensAt(abrupt(P2), T),
    holdsAt(interaction(P1,P2)=talking, T).

terminatedAt(movement(P1,P2)=abrupt_gestures, T):-
    happensAt(active(P1), T),
    happensAt(active(P2), T).

% the rule below is the result of the above optimisation checks
%holdsFor(fighting(_P1,_P2)=true, []).

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

grounding(orientation(P1,P2)=facing) :- id(P1), id(P2), P1@<P2.
grounding(distance(P1,P2)=short) :- id(P1), id(P2), P1@<P2.
grounding(distance(P1,P2)=mid) :- id(P1), id(P2), P1@<P2.
grounding(movement(P1,P2)=gathering) :- id(P1), id(P2), P1@<P2.
%grounding(movement(P1,P2)=abrupt_gestures) :- id(P1), id(P2), P1@<P2.
grounding(interaction(P1,P2)=greeting) :- id(P1), id(P2), P1@<P2.
grounding(interaction(P1,P2)=talking) :- id(P1), id(P2), P1@<P2.

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



