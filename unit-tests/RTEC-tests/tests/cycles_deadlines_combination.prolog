/****************************************
*                                       *
* Author : Manolis Pitsikalis           *
* email  : manospits@iit.demokritos.gr  *
*                                       *
*****************************************/

:-['../src/unit_tester.prolog'].
:-['../../../src/timeoutTreatment.prolog'].
:-['../scenarios/toy_var_domain.prolog'].
:-['../rules/rulesV2-combined/toy_declarations.prolog'].
:-['../rules/rulesV2-combined/toy_rules_compiled.prolog'].
:-['../scenarios/deadlines-cycles/toy_event_stream.prolog'].


testcase(cycles_deadlines_1, cyclesDeadlines, 1, [[(2,7)]], (21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_deadlines_1, cyclesDeadlines, 2, [[(4,11)]], (21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_deadlines_1, cyclesDeadlines, 3, [[(11,16)]], (21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_deadlines_2, cyclesDeadlines, 4, [[],[(9,inf)],[(9,14)],[]], (5,6,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_deadlines_2, cyclesDeadlines, 5, [[(2,inf)],[(2,7)],[],[(17,inf)]], (5,6,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_deadlines_3, cyclesDeadlines, 6, [[],[],[(8,inf)],[(8,inf)],[(8,14)]], (3,4,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_deadlines_4, cyclesDeadlines, 7, [[],[],[(8,inf)],[(8,inf)],[(8,16)]], (3,4,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_deadlines_5, cyclesDeadlines, 8, [[(2,inf)],[(2,7)]],(3,4,0,6), unordered, nodynamicgrounding, nopreprocessing, 1).
%testcase(cycles_big_1,cycles,14,[[(2,inf)],[(2,11)],[(2,11)]],(5,6,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).
%testcase(cycles_big_1,cycles,15,[[],[(8,11)],[(8,11)]],(5,6,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).
%testcase(cycles_big_1,cycles,16,[[],[],[(11,16)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).


check(cyclesDeadlines,N,Found):-
    member(N,[1,5,8]),
    holdsFor(hungry(chris)=true,Found).

check(cyclesDeadlines,N,Found):-
    member(N,[2]),
    holdsFor(eating(chris)=true,Found).

check(cyclesDeadlines,N,Found):-
    member(N,[3,4,6,7]),
    holdsFor(noFoodNeeds(chris)=true,Found).

