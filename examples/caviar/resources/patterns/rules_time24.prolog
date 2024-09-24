
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

holdsFor(distance(Id1,Id2)=long, I) :-
	holdsFor(distance(Id1,Id2,34)=true, I).

/****************************************************************
 *		     MEETING					*
 ****************************************************************/

 initiatedAt(meeting(P1,P2)=greeting, T):-
     happensAt(active(P1), T),
     happensAt(active(P2), T),
     holdsAt(distance(P1,P2)=mid, T).

 terminatedAt(meeting(P1,P2)=greeting, T):-
     happensAt(walking(P1), T).

terminatedAt(meeting(P1,P2)=greeting, T):-
     happensAt(walking(P2), T).

initiatedAt(gathering(P1,P2)=true, T):-
    happensAt(walking(P1), T),
    holdsAt(meeting(P1,P2)=greeting, T).

initiatedAt(gathering(P1,P2)=true, T):-
    happensAt(walking(P2), T),
    holdsAt(meeting(P1,P2)=greeting, T).

terminatedAt(gathering(P1,P2)=true, T):-
    happensAt(active(P1), T),
    happensAt(active(P2), T),
    holdsAt(distance(P1,P2)=short, T).

initiatedAt(meeting(P1,P2)=interacting, T):-
    happensAt(active(P1), T),
    happensAt(active(P2), T),
    holdsAt(distance(P1,P2)=short, T),
    holdsAt(gathering(P1,P2)=true, T).

terminatedAt(meeting(P1,P2)=interacting, T):-
    happensAt(inactive(P1), T),
    happensAt(inactive(P2), T).

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

grounding(distance(P1,P2)=short) :- id(P1), id(P2), P1@<P2.
grounding(distance(P1,P2)=mid) :- id(P1), id(P2), P1@<P2.
grounding(distance(P1,P2)=long) :- id(P1), id(P2), P1@<P2.
grounding(gathering(P1,P2)=true) :- id(P1), id(P2), P1@<P2.
grounding(meeting(P1,P2)=greeting) :- id(P1), id(P2), P1@<P2.
grounding(meeting(P1,P2)=interacting) :- id(P1), id(P2), P1@<P2.

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



