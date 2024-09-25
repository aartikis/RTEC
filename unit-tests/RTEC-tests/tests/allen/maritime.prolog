/*******************************************
*                                          *   
* Author : Periklis Mantenoglou            *
* email  : pmantenoglou@iit.demokritos.gr  *
*                                          *
********************************************/

:-['../../src/unit_tester.prolog'].
:-['../../rules/allen/maritime/compiled_rules.prolog'].
:-['../../scenarios/allen/maritime/maritime_event_stream.prolog'].
:-['../../scenarios/allen/maritime/auxiliary/loadStaticData.prolog'].

%%%%%% allen person-door example %%%%%%
%
% testcase(Scenario, CaseName, CaseNumber, Expected, Ts, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
% Ts = (Step,Window,Start,End)
% In the case of allen relations, we have to assert, before running each test, the parameters required for supporting allen relations with windowing. 
% The required global parameters are: Step and AllenMem.
% The required parameter that changes per window is InitTime.
testcase(maritime_1, maritime, 1, [[(5,12)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).
     	
testcaseSE(maritime_2, maritime, 2, [[],[(5,12)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(10)).

check(maritime,N,StoppedWithinAreaIntervals):-
    member(N, [1,2]),
    %holdsFor(withinArea(1234500,natura)=true,WithinAreaIntervals),
    %write('Within Area Natura: '), write(WithinAreaIntervals), nl,
    %holdsFor(stopped(1234500)=farFromPorts,StoppedIntervals),
    %write('Stopped: '), write(StoppedIntervals), nl,
    holdsFor(stoppedWithinArea(1234500,natura)=true,StoppedWithinAreaIntervals).
    %write('StoppedWithinAreaIntervals: '), write(StoppedWithinAreaIntervals), nl.

testcase(maritime_3, maritime, 3, [[(6,13),(16,19)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).
     	
testcaseSE(maritime_4, maritime, 4, [[],[(6,13),(16,19)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(10)).

check(maritime,N,HSNCbeforeDiftingIntervals):-
    member(N, [3,4]),
    holdsFor(highSpeedNCBeforeDrifting(1234500)=true,HSNCbeforeDiftingIntervals).

testcase(maritime_5, maritime, 5, [[(6,19)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).
     	
testcaseSE(maritime_6, maritime, 6, [[],[(6,19)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(10)).

check(maritime,N,DangerNearCoastIntervals):-
    member(N, [5,6]),
    holdsFor(dangerNearCoast(1234500)=true,DangerNearCoastIntervals).

testcase(maritime_7, maritime, 7, [[(15,19)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).
     	
testcaseSE(maritime_8, maritime, 8, [[],[(15,19)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(10)).

check(maritime,N,SpeedChangeAboveIntervals):-
    member(N, [7,8]),
    %holdsFor(movingSpeed(1234500)=above,MovingSpeedIntervals),
    %holdsFor(gainingSpeed(1234500)=true,GainingSpeedIntervals),
    holdsFor(speedChangeAbove(1234500)=true,SpeedChangeAboveIntervals).

testcase(maritime_9, maritime, 9, [[(8,13)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).
     	
testcaseSE(maritime_10, maritime, 10, [[(8,inf)],[(8,13)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(10)).

check(maritime,N,AnchoredNearPortsIntervals):-
    member(N, [9,10]),
    %holdsFor(stopped(1234500)=nearPorts,StoppedNearPortsIntervals),
    %write('StoppedNearPortsIntervals: '), write(StoppedNearPortsIntervals), nl,
    %holdsFor(anchoredOrMoored(1234500)=true,AnchoredOrMooredIntervals),
    %write('AnchoredOrMooredIntervals: '), write(AnchoredOrMooredIntervals), nl,
    holdsFor(anchoredNearPorts(1234500)=true,AnchoredNearPortsIntervals).

testcase(maritime_11, maritime, 11, [[(5,17)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
        assertz(allenMemory(0)).
     	
testcaseSE(maritime_12, maritime, 12, [[(5,inf)],[(5,17)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(10)),
        assertz(allenMemory(10)).

check(maritime,N,AnchoredFarFromPortsIntervals):-
    member(N, [11,12]),
    %holdsFor(stopped(1234500)=nearPorts,StoppedNearPortsIntervals),
    %write('StoppedNearPortsIntervals: '), write(StoppedNearPortsIntervals), nl,
    %holdsFor(anchoredOrMoored(1234500)=true,AnchoredOrMooredIntervals),
    %write('AnchoredOrMooredIntervals: '), write(AnchoredOrMooredIntervals), nl,
    holdsFor(anchoredFarFromPorts(1234500)=true,AnchoredFarFromPortsIntervals).

