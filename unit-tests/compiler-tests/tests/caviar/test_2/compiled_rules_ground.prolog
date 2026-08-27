
/************************************************
 * 						*
 * Compiler unit test: Activity recognition	*
 * in CAVIAR					* 
 *                                              *
 ************************************************/

% This file has been produced by a working version of the compiler

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

inputEntity(walking(_136)=true).
inputEntity(disappear(_130)).
inputEntity(running(_136)=true).
inputEntity(active(_136)=true).
inputEntity(abrupt(_136)=true).
inputEntity(appear(_130)).
inputEntity(inactive(_136)=true).
inputEntity(distance(_136,_138,_140)=true).
inputEntity(orientation(_136)=_132).
inputEntity(appearance(_136)=_132).
inputEntity(coord(_136,_138,_140)=_132).

outputEntity(person(_258)=true).
outputEntity(person(_258)=false).
outputEntity(leaving_object(_258,_260)=true).
outputEntity(leaving_object(_258,_260)=false).
outputEntity(meeting(_258,_260)=true).
outputEntity(meeting(_258,_260)=false).
outputEntity(close(_258,_260,_262)=true).
outputEntity(close(_258,_260,_262)=false).
outputEntity(closeSymmetric(_258,_260,_262)=true).
outputEntity(greeting1(_258,_260)=true).
outputEntity(greeting2(_258,_260)=true).
outputEntity(activeOrInactivePerson(_258)=true).
outputEntity(moving(_258,_260)=true).
outputEntity(fighting(_258,_260)=true).

event(disappear(_392)).
event(appear(_392)).

simpleFluent(person(_466)=true).
simpleFluent(person(_466)=false).
simpleFluent(leaving_object(_466,_468)=true).
simpleFluent(leaving_object(_466,_468)=false).
simpleFluent(meeting(_466,_468)=true).
simpleFluent(meeting(_466,_468)=false).

sDFluent(close(_558,_560,_562)=true).
sDFluent(close(_558,_560,_562)=false).
sDFluent(closeSymmetric(_558,_560,_562)=true).
sDFluent(greeting1(_558,_560)=true).
sDFluent(greeting2(_558,_560)=true).
sDFluent(activeOrInactivePerson(_558)=true).
sDFluent(moving(_558,_560)=true).
sDFluent(fighting(_558,_560)=true).
sDFluent(walking(_558)=true).
sDFluent(running(_558)=true).
sDFluent(active(_558)=true).
sDFluent(abrupt(_558)=true).
sDFluent(inactive(_558)=true).
sDFluent(distance(_558,_560,_562)=true).
sDFluent(orientation(_558)=_554).
sDFluent(appearance(_558)=_554).
sDFluent(coord(_558,_560,_562)=_554).

index(disappear(_662),_662).
index(appear(_662),_662).
index(person(_662)=true,_662).
index(person(_662)=false,_662).
index(leaving_object(_662,_722)=true,_662).
index(leaving_object(_662,_722)=false,_662).
index(meeting(_662,_722)=true,_662).
index(meeting(_662,_722)=false,_662).
index(close(_662,_722,_724)=true,_662).
index(close(_662,_722,_724)=false,_662).
index(closeSymmetric(_662,_722,_724)=true,_662).
index(greeting1(_662,_722)=true,_662).
index(greeting2(_662,_722)=true,_662).
index(activeOrInactivePerson(_662)=true,_662).
index(moving(_662,_722)=true,_662).
index(fighting(_662,_722)=true,_662).
index(walking(_662)=true,_662).
index(running(_662)=true,_662).
index(active(_662)=true,_662).
index(abrupt(_662)=true,_662).
index(inactive(_662)=true,_662).
index(distance(_662,_722,_724)=true,_662).
index(orientation(_662)=_716,_662).
index(appearance(_662)=_716,_662).
index(coord(_662,_722,_724)=_716,_662).


cachingOrder2(_1114, close(_1114,_1116,_1232)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1114),id(_1116),_1114@<_1116.

cachingOrder2(_1092, person(_1092)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1092).

cachingOrder2(_1478, close(_1478,_1480,_1596)=false) :- % level in dependency graph: 2, processing order in component: 1
     id(_1478),id(_1480),_1478@<_1480.

cachingOrder2(_1452, closeSymmetric(_1452,_1454,_1720)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1452),id(_1454),_1452@<_1454.

cachingOrder2(_1430, activeOrInactivePerson(_1430)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1430).

cachingOrder2(_1406, moving(_1406,_1408)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1406),id(_1408),_1406@<_1408.

cachingOrder2(_1382, fighting(_1382,_1384)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1382),id(_1384),_1382@<_1384.

cachingOrder2(_2158, leaving_object(_2158,_2160)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2158),id(_2160),_2158@<_2160.

cachingOrder2(_2110, greeting1(_2110,_2112)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2110),id(_2112),_2110@<_2112.

cachingOrder2(_2086, greeting2(_2086,_2088)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_2086),id(_2088),_2086@<_2088.

cachingOrder2(_2554, meeting(_2554,_2556)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2554),id(_2556),_2554@<_2556.

collectGrounds([walking(_734)=true, walking(_734)=true, disappear(_734), running(_734)=true, running(_734)=true, active(_734)=true, active(_734)=true, abrupt(_734)=true, abrupt(_734)=true, appear(_734), inactive(_734)=true, inactive(_734)=true, orientation(_734)=_748, appearance(_734)=_748, coord(_734,_754,_756)=_748],id(_734)).

dgrounded(person(_1540)=true, id(_1540)).
dgrounded(leaving_object(_1484,_1486)=true, id(_1484)).
dgrounded(leaving_object(_1484,_1486)=true, id(_1486)).
dgrounded(meeting(_1428,_1430)=true, id(_1428)).
dgrounded(meeting(_1428,_1430)=true, id(_1430)).
dgrounded(close(_1370,_1372,24)=true, id(_1370)).
dgrounded(close(_1370,_1372,24)=true, id(_1372)).
dgrounded(close(_1312,_1314,25)=true, id(_1312)).
dgrounded(close(_1312,_1314,25)=true, id(_1314)).
dgrounded(close(_1254,_1256,30)=true, id(_1254)).
dgrounded(close(_1254,_1256,30)=true, id(_1256)).
dgrounded(close(_1196,_1198,34)=true, id(_1196)).
dgrounded(close(_1196,_1198,34)=true, id(_1198)).
dgrounded(close(_1138,_1140,34)=false, id(_1138)).
dgrounded(close(_1138,_1140,34)=false, id(_1140)).
dgrounded(closeSymmetric(_1080,_1082,30)=true, id(_1080)).
dgrounded(closeSymmetric(_1080,_1082,30)=true, id(_1082)).
dgrounded(greeting1(_1024,_1026)=true, id(_1024)).
dgrounded(greeting1(_1024,_1026)=true, id(_1026)).
dgrounded(greeting2(_968,_970)=true, id(_968)).
dgrounded(greeting2(_968,_970)=true, id(_970)).
dgrounded(activeOrInactivePerson(_936)=true, id(_936)).
dgrounded(moving(_880,_882)=true, id(_880)).
dgrounded(moving(_880,_882)=true, id(_882)).
dgrounded(fighting(_824,_826)=true, id(_824)).
dgrounded(fighting(_824,_826)=true, id(_826)).

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


