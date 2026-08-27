/*******************************************
*                                          *   
* Author : Periklis Mantenoglou            *
* email  : pmantenoglou@iit.demokritos.gr  *
*                                          *
********************************************/

:-['../../src/unit_tester.prolog'].
:-['../../rules/allen/hierarchies/compiled_rules.prolog'].
:-['../../scenarios/allen/hierarchies/hierarchies_event_stream.prolog'].

%%%%%% allen person-door example %%%%%%
%
% testcase(Scenario, CaseName, CaseNumber, Expected, Ts, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
% Ts = (Step,Window,Start,End)
% In the case of allen relations, we have to assert, before running each test, the parameters required for supporting allen relations with windowing. 
% The required global parameters are: Step and AllenMem.
% The required parameter that changes per window is InitTime.
testcase(hierarchies_1, hierarchies, 1, [[(2,5)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(0)).

testcaseSE(hierarchies_2, hierarchies, 2, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[], [(2,5)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(0)).

check(hierarchies,N,EIntervals):-
	member(N,[1,2]),
    holdsFor(e=true,EIntervals).

testcase(hierarchies_3, hierarchies, 3, [[(4,6)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_4, hierarchies, 4, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(4,6)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

check(hierarchies,N,EIntervals):-
	member(N,[3,4]),
    holdsFor(eBefore=true,EIntervals).

testcase(hierarchies_5, hierarchies, 5, [[(2,6)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_6, hierarchies, 6, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(2,6)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

check(hierarchies,N,EIntervals):-
	member(N,[5,6]),
    holdsFor(eMeets=true,EIntervals).

testcase(hierarchies_7, hierarchies, 7, [[(2,8)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_8, hierarchies, 8, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(2,8)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

check(hierarchies,N,EIntervals):-
	member(N,[7,8]),
    holdsFor(eStarts=true,EIntervals).

testcase(hierarchies_9, hierarchies, 9, [[(2,6)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_10, hierarchies, 10, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(2,6)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

check(hierarchies,N,EIntervals):-
	member(N,[9,10]),
    holdsFor(eFinishes=true,EIntervals).

testcase(hierarchies_11, hierarchies, 11, [[(5,8)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_12, hierarchies, 12, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(5,8)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

testcase(hierarchies_13, hierarchies, 13, [[(5,8)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_14, hierarchies, 14, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(5,8)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

check(hierarchies,N,EIntervals):-
	member(N,[11,12,13,14]),
    holdsFor(eDuring=true,EIntervals).

testcase(hierarchies_15, hierarchies, 15, [[(5,8)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_16, hierarchies, 16, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(5,8)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

testcase(hierarchies_17, hierarchies, 17, [[(5,8)]], (20,20,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):-
	assertz(step(20)),
	assertz(allenMemory(20)).

testcaseSE(hierarchies_18, hierarchies, 18, [[],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1):- % [[],[(5,8)]] if we cache everything
	assertz(step(10)),
	assertz(allenMemory(10)).

check(hierarchies,N,EIntervals):-
	member(N,[15,16,17,18]),
    holdsFor(eOverlaps=true,EIntervals).




