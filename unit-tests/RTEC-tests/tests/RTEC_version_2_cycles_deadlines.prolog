/****************************************
*                                       *
* Author : Manolis Pitsikalis           *
* email  : manospits@iit.demokritos.gr  *
*                                       *
*****************************************/

:-['../src/unit_tester.prolog'].
:-['../../../src/timeoutTreatment.prolog'].
:-['../scenarios/toy_var_domain.prolog'].
:-['../rules/rulesV2/toy_declarations.prolog'].
:-['../rules/rulesV2/toy_rules_compiled.prolog'].
:-['../scenarios/deadlines/toy_event_stream.prolog'].
:-['../scenarios/cycles/toy_event_stream.prolog'].
:-['../scenarios/cycles_unsorted/toy_event_stream.prolog'].

%%%%%% deadlines cases %%%%%%
%   testing fi/3 and p/1  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% basic case in one window attempt succesfull
testcase(deadlines_rich_1, deadlinesUE, 1, [[(10,14)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% normal termination
testcase(deadlines_rich_2, deadlinesUE, 2, [[(10,12)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% extend deadline with initiation
testcase(deadlines_rich_3, deadlinesUE, 3, [[(10,16)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% simultaneous initiation and termination
testcase(deadlines_rich_4, deadlinesUE, 4, [[(10,18)]], (21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% window test
testcase(deadlines_rich_1, deadlinesUE, 5, [[(10,inf)],[(10,14)]], (10,15,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% test result when first initiation is outside the window.
testcase(deadlines_rich_5, deadlinesUE, 6, [[(2,inf)],[(2,inf)],[(2,12)]], (5,8,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).

testcase(deadlines_rich_5, deadlinesUE, 7, [[(2,inf)],[(2,inf)],[(2,inf)],[(2,12)]], (3,3,0,12), unordered, nodynamicgrounding, nopreprocessing, 1).

%A
testcase(deadlines_rich_6, deadlinesUE, 8, [[(2,inf)],[(2,inf)],[(2,inf)],[(2,16)]], (3,15,3,15), unordered, nodynamicgrounding, nopreprocessing, 1).
%B
testcase(deadlines_rich_7, deadlinesUE, 9, [[(2,inf)],[(2,9)]], (6,12,0,12), unordered, nodynamicgrounding, nopreprocessing, 1).
%C
testcase(deadlines_rich_8, deadlinesUE, 10.1, [[(2,inf)],[(2,7),(8,inf)],[(2,7),(8,inf)],[(2,7),(8,inf)],[(2,7),(8,16)]], (3,17,2,17), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(deadlines_rich_8, deadlinesUE, 10.2, [[(2,7),(8,16)]], (17,17,0,17), unordered, nodynamicgrounding, nopreprocessing, 1).
%D
testcase(deadlines_rich_6, deadlinesUE, 11, [[(2,inf)],[(2,inf)],[(2,16)]], (5,15,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).

check(deadlinesUE,N,Found):-
    N < 8,
    holdsFor(rich(chris)=true,Found).

check(deadlinesUE,N,Found):-
    N >= 8,
    holdsFor(rich2(chris)=true,Found).

%%%%%% deadlines cases %%%%%%
%   testing fi/3     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% basic case in one window attempt succesfull
testcase(deadlines_working_1,deadlines,1, [[(10,18)]],(21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% normal termination
testcase(deadlines_working_2,deadlines,2, [[(10,15)]],(21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% extend deadline with initiation
testcase(deadlines_working_3,deadlines,3, [[(10,18)]],(21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% simultaneous initiation and termination
testcase(deadlines_working_4,deadlines,4, [[(10,18)]],(21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% window test
testcase(deadlines_working_1,deadlines,5, [[(10,inf)],[(10,18)]],(10,15,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% test result when first initiation is outside the window.
testcase(deadlines_working_5,deadlines,6,[[(3,inf)],[(3,inf)],[(3,11)],[]],(4,4,0,16), unordered, nodynamicgrounding, nopreprocessing, 1).


%A
testcase(deadlines_working_6,deadlines,8,[[(2,inf)],[(2,10)],[(2,10)],[(2,10)]],(3,15,3,15), unordered, nodynamicgrounding, nopreprocessing, 1).
%B
testcase(deadlines_working_7,deadlines,9,[[(2,inf)],[(2,9)]],(6,12,0,12), unordered, nodynamicgrounding, nopreprocessing, 1).
%C
testcase(deadlines_working_8,deadlines,10,[[(2,inf)],[(2,7),(8,inf)],[(2,7),(8,inf)],[(2,7),(8,inf)],[(2,7),(8,16)]],(3,17,2,17), unordered, nodynamicgrounding, nopreprocessing, 1).
%D
testcase(deadlines_working_6,deadlines,11,[[(2,inf)],[(2,10)],[(2,10)]],(5,15,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).

check(deadlines,_N,Found):-
    holdsFor(working(chris)=true,Found).

%%%%%% cycles cases %%%%%%

% S-W=0 full
%testcase(cycles_strength_1,cycles,1,[[(19,inf)]],(21,21,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
% S-W=-1
testcase(cycles_strength_1,cycles,2,[[(0,10),(19,inf)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).

% S-W=0 lowering
%testcase(cycles_strength_1,cycles,3,[[]],(21,21,0,21)).
% S-W=-1
testcase(cycles_strength_1,cycles,4,[[(10,15)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).

% S-W=0 tired
%testcase(cycles_strength_1,cycles,5,[[]],(21,21,0,21)).
% S-W=-1
testcase(cycles_strength_1,cycles,6,[[(15,19)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).


testcase(cycles_strength_1,cycles,7,[[(0,inf)],[(0,10)],[],[(19,inf)]],(5,6,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_strength_1,cycles,8,[[],[(10,inf)],[(10,15)],[]],(5,6,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_strength_1,cycles,9,[[],[],[(15,inf)],[(15,19)]],(5,6,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_strength_2,cycles,10,[[(10,inf)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_big_1,cycles,11,[[(2,11)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_big_1,cycles,12,[[(8,11)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_big_1,cycles,13,[[(11,16)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_big_1,cycles,14,[[(2,inf)],[(2,11)],[(2,11)]],(5,6,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_big_1,cycles,15,[[],[(8,11)],[(8,11)]],(5,6,0,15), unordered, nodynamicgrounding, nopreprocessing, 1).
testcase(cycles_big_2,cycles,16,[[(13,inf)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).

check(cycles,N,Found):-
    member(N,[1,2,7]),
    holdsFor(strength(chris)=full,Found).

check(cycles,N,Found):-
    member(N,[3,4,8,10]),
    holdsFor(strength(chris)=lowering,Found).

check(cycles,N,Found):-
    member(N,[5,6,9]),
    holdsFor(strength(chris)=tired,Found).

check(cycles,N,Found):-
    member(N,[11,14,16]),
    holdsFor(hungry(chris)=true,Found).

check(cycles,N,Found):-
    member(N,[12,15]),
    holdsFor(eating(chris)=true,Found).

check(cycles,N,Found):-
    member(N,[13]),
    holdsFor(noFoodNeeds(chris)=true,Found).


testcase(unsorted_cycles_1,unsortedCycles,1,[[(0,10),(19,inf)]],(21,22,0,21), unordered, nodynamicgrounding, nopreprocessing, 1).
testcaseE(unsorted_cycles_1,unsortedCycles,2,[[(0,inf)],[(0,10),(19,inf)]],(10,21,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

check(unsortedCycles,N,Found):-
    member(N,[1,2]),
    holdsFor(strength(chris)=full,Found).

