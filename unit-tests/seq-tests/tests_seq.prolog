:- use_module(library(plunit)).

:- ['../../src/utilities/seq.prolog'].


:- begin_tests(test).

%% Tests for non windowed seq operation between lists of maximal intervals
test(empty_list_left):-
	seq([],[(1,2)],[]). 

test(empty_list_right):-
	seq([(1,2)],[],[]).

test(empty_list_both):-
	seq([],[],[]).

test(simple_case_wr_length_1):-
	seq([(1,3)],[(4,5)],[(1,5)]).

test(simple_case_nr_length_1):-
	seq([(4,5)],[(1,3)],[]).

test(simple_case_wr_skip_left):-
	seq([(1,2),(3,4),(5,6)],[(7,8)],[(5,8)]).

test(simple_case_wr_skip_left_mul):-
	seq([(1,2),(3,4),(5,6),(9,10)],[(7,8),(11,12)],[(5,8),(9,12)]).

test(simple_case_wr_skip_right):-
	seq([(7,8),(11,12)],[(1,2),(3,4),(5,6),(9,10),(13,14)], [(7,10),(11,14)]).

:- end_tests(test).
