/*******************************************
*                                          *   
* Author : Periklis Mantenoglou            *
* email  : pmantenoglou@iit.demokritos.gr  *
*                                          *
********************************************/

:-['../../src/unit_tester.prolog'].
:-['../../rules/allen/personDoor/compiled_rules.prolog'].
:-['../../scenarios/allen/personDoor/person_door_event_stream.prolog'].
:-['../../scenarios/allen/personDoor/person_door_var_domain.prolog'].

%%%%%% allen person-door example %%%%%%
%
% testcase(Scenario, CaseName, CaseNumber, Expected, Ts, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
% Ts = (Step,Window,Start,End)
% In the case of allen relations, we have to assert, before running each test, the parameters required for supporting allen relations with windowing. 
% The required global parameters are: Step and AllenMem.
% The required parameter that changes per window is InitTime.
testcase(person_door_1, personDoor, 1, [[(1,10)]], (10,10,0,10), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(0)).
%      	
testcaseSE(person_door_2, personDoor, 2, [[],[(1,10)]], (5,5,0,10), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(5)),
	assertz(allenMemory(0)).
	

check(personDoor,_N,EnteringIntervals):-
    %holdsFor(far_from(p1,d1)=true,FarFromI),
	%write('Far from intervals: '), write(FarFromI), nl,
    %holdsFor(adjacent(p1,d1)=true,AdjacentI),
	%write('Adjacent intervals: '), write(AdjacentI), nl,
    %holdsFor(visible_door(d1)=true,DoorI),
	%write('Visible Door intervals: '), write(DoorI), nl,
    %holdsFor(visible_person(p1)=true,PersonI),
	%write('Visible Person intervals: '), write(PersonI), nl,
    %holdsFor(visible_door_not_person(p1,d1)=true,DoorNotPersonI),
	%write('Door Not Person intervals: '), write(DoorNotPersonI), nl,
    %holdsFor(far_from_overlaps_adjacent(p1,d1)=true,FarFromOverlapsAdjacentI),
	%write('Far from overalaps adjacent intervals: '), write(FarFromOverlapsAdjacentI), nl,
    %holdsFor(far_from_meets_adjacent(p1,d1)=true,FarFromMeetsAdjacentI),
	%write('Far from meets adjacent intervals: '), write(FarFromMeetsAdjacentI), nl,
    %holdsFor(entering_oo(p1,d1)=true,EnteringOOIntervals),
	%write('EnteringOO intervals: '), write(EnteringOOIntervals), nl,
    %holdsFor(entering_om(p1,d1)=true,EnteringOMIntervals),
	%write('EnteringOM intervals: '), write(EnteringOMIntervals), nl,
    %holdsFor(entering_mo(p1,d1)=true,EnteringMOIntervals),
	%write('EnteringMO intervals: '), write(EnteringMOIntervals), nl,
    %holdsFor(entering_mm(p1,d1)=true,EnteringMMIntervals),
	%write('EnteringMM intervals: '), write(EnteringMMIntervals), nl,
    holdsFor(entering(p1,d1)=true,EnteringIntervals).
	%write('Entering intervals: '), write(EnteringIntervals), nl.

