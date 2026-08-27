/*******************************************
*                                          *   
* Author : Periklis Mantenoglou            *
* email  : pmantenoglou@iit.demokritos.gr  *
*                                          *
********************************************/

:-['../../src/unit_tester.prolog'].
:-['../../rules/rulesV3-combined/personDoor/compiled_rules.prolog'].
:-['../../scenarios/allen/personDoor/person_door_event_stream.prolog'].
:-['../../scenarios/allen/personDoor/person_door_var_domain.prolog'].

%%%%%% allen person-door example %%%%%%
%
% testcase(Scenario, CaseName, CaseNumber, Expected, Ts, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
% Ts = (Step,Window,Start,End)
% In the case of allen relations, we have to assert, before running each test, the parameters required for supporting allen relations with windowing. 
% The required global parameters are: Step and AllenMem.
% The required parameter that changes per window is InitTime.
testcase(person_door_3, personDoor, 1, [[(9,17)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).

testcase(person_door_3, personDoor, 2, [[(9,inf)],[(9,17)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(0)).

check(personDoor,N,WorkingIntervals):-
    member(N, [1, 2]),
    %oldsFor(entering(p1,d1)=true,EnteringIntervals),
	%write('Entering intervals: '), write(EnteringIntervals), nl,
    holdsFor(working(p1)=true, WorkingIntervals).

testcase(person_door_4, personDoor, 3, [[(10,14)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).

testcaseSE(person_door_5, personDoor, 4, [[], [(10,14)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
    assertz(allenMemory(0)).

check(personDoor,N,DuringIntervals):-
    member(N, [3, 4]),
    holdsFor(brakeDuringWork(p1)=true, DuringIntervals).
