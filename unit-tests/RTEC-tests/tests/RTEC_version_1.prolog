/****************************************
*                                       *
* Author : Manolis Pitsikalis           *
* email  : manospits@iit.demokritos.gr  *
*                                       *
*****************************************/

:-['../src/unit_tester.prolog'].
:-['../scenarios/toy_var_domain.prolog'].
:-['../rules/rulesV1/toy_declarations.prolog'].
:-['../rules/rulesV1/toy_rules_compiled.prolog'].
:-['../scenarios/initiation/toy_event_stream.prolog'].
:-['../scenarios/termination_from_another_fluent/toy_event_stream.prolog'].
:-['../scenarios/interval_manipulation/toy_event_stream.prolog'].
:-['../scenarios/holds_at_t/toy_event_stream.prolog'].
:-['../scenarios/hierarchy/toy_event_stream.prolog'].
:-['../scenarios/unsorted/toy_event_stream.prolog'].

%%%%%% initiation cases

testcase(initiation_3, initiation, 1, [[(10,14),(15,17),(19,22)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(initiation_1, initiation, 2, [[(10,14),(19,22)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(initiation_2, initiation, 3, [[(19,22)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).

check(initiation,_,Found):-
    holdsFor(rich(chris)=true,Found).


%%%%%% termination from another fluent cases

testcase(tfaf_1, tfaf, 1, [[(10,15)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(tfaf_2, tfaf, 2, [[(10,11)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(tfaf_3, tfaf, 3, [[]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(tfaf_4, tfaf, 4, [[(10,22)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(tfaf_5, tfaf, 5, [[(10,inf)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).

check(tfaf,_N,Found):-
    holdsFor(working(chris)=true,Found).


%%%%%% intervals manipulation
testcase(intervalManipulation_1, intervalManipulation, 1, [[(14,22)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(intervalManipulation_1, intervalManipulation, 2, [[(18,20)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(intervalManipulation_1, intervalManipulation, 3, [[(20,22)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(intervalManipulation_1, intervalManipulation, 4, [[(18,20)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(intervalManipulation_2, intervalManipulation, 5, [[(21,29),(36,inf)]], (36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(intervalManipulation_2, intervalManipulation, 6, [[(22,24),(25,28)]], (36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(intervalManipulation_2, intervalManipulation, 7, [[(21,22),(24,25),(28,29)]], (36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
%testcase(intervalManipulation_2, intervalManipulation, 8, [[(22,24),(25,28)]],(36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
%testcase(intervalManipulation_2, intervalManipulation, 9, [[(14,15)]],(36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
%testcase(intervalManipulation_2, intervalManipulation, 10, [[(10,14),(15,19),(34,37)]],(36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).

check(intervalManipulation,N,U1):-
    member(N,[1,5]),
    holdsFor(happy(chris)=true,U1).
check(intervalManipulation,N,I1):-
    member(N,[2,6]),
    holdsFor(infiniteBeers(chris)=true,I1).
check(intervalManipulation,N,R1):-
    member(N,[3,7]),
    holdsFor(shortHappiness(chris)=true,R1).
check(intervalManipulation,N,I2):-
    member(N,[4,8]),
    holdsFor(drunk(chris)=true,I2).
check(intervalManipulation,9,I3):-
    holdsFor(sleeping_at_work(chris)=true,I3).
check(intervalManipulation,10,R2):-
    holdsFor(workingEfficiently(chris)=true,R2).

%%%%%% holds_at_t
testcase(holds_at_t_1, holds_at_t, 1, [[]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).

check(holds_at_t,1,I_rich):-
    holdsFor(rich(chris)=true,I_rich).

testcase(holds_at_t_2, holds_at_t, 2, [[(10,16)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(holds_at_t_3, holds_at_t, 3, [[(10,16)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).

check(holds_at_t,N,I_rich):-
    member(N,[2,3]),
    holdsFor(sleepingHappy(chris)=true,I_rich).



%%%%% hierarchy
testcase(hierarchy_1,hierarchy,1,[[(21,29),(36,inf)]] ,(36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(hierarchy_1,hierarchy,2,[[(22,24),(25,28),(36,inf)]] ,(36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(hierarchy_1,hierarchy,3,[[(22,29),(37,inf)]] ,(36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(hierarchy_1,hierarchy,4,[[(22,24),(25,28)]] ,(36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).

check(hierarchy,1,I_happy):-
    holdsFor(happy(chris)=true,I_happy).
check(hierarchy,2,I_rich):-
    holdsFor(rich(chris)=true,I_rich).
check(hierarchy,3,I_shappy):-
    holdsFor(shappy(chris)=true,I_shappy).
check(hierarchy,4,I_dr):-
    holdsFor(drunk(chris)=true,I_dr).


%%%%%%%% windows 
testcaseE(hierarchy_1, windows, 1, [[],[(22,24),(25,28)],[(22,24),(25,28),(36,inf)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 2, [[(14,15)],[(14,15)],[(14,15),(29,33)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 3, [[(10,19)],[(10,19)],[(10,19),(34,37)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 4, [[],[(21,inf)],[(21,29),(36,inf)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 5, [[],[(22,24),(25,28)],[(22,24),(25,28)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 6, [[],[(21,22),(24,25),(28,inf)],[(21,22),(24,25),(28,29)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 7, [[],[(22,24),(25,28)],[(25,28)]], (9,9,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 8, [[(14,15)],[(14,15)],[(14,15)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 9, [[(10,14),(15,19)],[(10,14),(15,19)],[(10,14),(15,19),(34,37)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 10, [[(14,15)],[(14,15)],[(29,33)]], (9,18,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 11, [[(10,19)],[(10,19)],[(34,37)]], (9,18,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 12, [[(14,15)],[(14,15)],[]], (9,18,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(hierarchy_1, windows, 13, [[(10,14),(15,19)],[(10,14),(15,19)],[(15,19),(34,37)]], (9,18,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).

check(windows,N,I_rich):-
    member(N,[1]),
    holdsFor(rich(chris)=true,I_rich).
check(windows,N,I_sleep):-
    member(N,[2,10]),
    holdsFor(sleeping(chris)=true,I_sleep).
check(windows,N,I_work):-
    member(N,[3,11]),
    holdsFor(working(_X)=true,I_work).
check(windows,N,I_happy):-
    member(N,[4]),
    holdsFor(happy(_X)=true,I_happy).
check(windows,N,I_infbeers):-
    member(N,[5]),
    holdsFor(infiniteBeers(chris)=true,I_infbeers).
check(windows,N,I_shHap):-
    member(N,[6]),
    holdsFor(shortHappiness(chris)=true,I_shHap).
check(windows,N,I_dr):-
    member(N,[7]),
    holdsFor(drunk(chris)=true,I_dr).
check(windows,N,I_slAw):-
    member(N,[8,12]),
    holdsFor(sleeping_at_work(chris)=true,I_slAw).
check(windows,N,I_wE):-
    member(N,[9,13]),
    holdsFor(workingEfficiently(chris)=true,I_wE).

testcase(unsorted_1, unsorted, 1, [[(21,29),(36,inf)]], (36,36,0,36), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(unsorted_1, unsorted, 2, [[],[(22,24)],[(21,29),(36,inf)]], (9,36,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).
%testcaseE(unsorted_1, unsorted, 3, [[],[(22,24)],[(21,29),(36,inf)]], (9,9,9,36), unordered, nodynamicgrounding, nopreprocessing, 1).

check(unsorted,N,I_happy):-
    member(N,[1,2]),
    holdsFor(happy(chris)=true,I_happy).



