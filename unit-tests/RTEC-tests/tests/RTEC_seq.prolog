/****************************************
*                                       *
* Author : Manolis Pitsikalis           *
* email  : manospits@iit.demokritos.gr  *
*                                       *
*****************************************/

:-['../src/unit_tester.prolog'].
:-['../scenarios/seq/food/food_var_domain.prolog'].
:-['../rules/seq/food/compiled_rules.prolog'].
:-['../scenarios/seq/food/food_event_stream.prolog'].

testcaseSE(food_1, recipePreparation, 1, [([],3),([(4,19)],20),[]], (10,10,0,30), unordered, nodynamicgrounding, nopreprocessing, 1).                             

testcaseSE(food_2, recipePreparation, 2, [([],3),([],3),([(4,plus(15))],15),([(4,19)],20),[]], (5,5,0,25), unordered, nodynamicgrounding, nopreprocessing, 1).   

check(recipePreparation, N, I):-
    member(N,[1, 2]),
    holdsFor(recipePreparation(steak)=true,I).

testcaseSE(food_1, dishPreparation, 1, [([],3),([],3),([(4,plus(30))],30)], (10,10,0,30), unordered, nodynamicgrounding, nopreprocessing, 1).                             

testcaseSE(food_2, dishPreparation, 2, [([],3),([],3),([],3),([],3),([(4,plus(25))],25)], (5,5,0,25), unordered, nodynamicgrounding, nopreprocessing, 1).                             

check(dishPreparation, N, I):-
    member(N,[1, 2]),
    holdsFor(dishPreparation(steak)=true,I).



