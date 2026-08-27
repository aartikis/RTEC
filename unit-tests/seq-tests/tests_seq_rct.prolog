:- use_module(library(plunit)).

:- ['../../src/RTEC.prolog'].

:- begin_tests(test).

test(paper_a):-
	compute_cutoff(seq,[([(0,1)],2),([(2,3)], 4)], 3). 

test(paper_b):-
    compute_cutoff(seq,[([(0,1),(7,8)],8),([(2,3)], 4)], 6).

test(paper_c):- % extension right
    compute_cutoff(seq,[([(0,1)],2),([(2,3),(4,5)], 7)], 5).

test(extension_left):-
    compute_cutoff(seq,[([(0,1),(6,7),(10,12)],12),([(2,3)], 4)], 5).

test(extension_left_nextPosI_plus):-
    compute_cutoff(seq,[([(0,1),(4,plus(5))],5),([(2,3),(8,10)], 10)], 10).

test(extension_left_nextPosI):-
    compute_cutoff(seq,[([(0,1),(4,5)],5),([(2,3),(8,10)], 10)], 3).

test(no_a_b):-
    compute_cutoff(seq,[([],2),([], 7)], 2).

test(no_a_extend_right):-
   compute_cutoff(seq,[([],2),([(2,3),(4,5)], 7)], 5).

test(correct_a_selection):-
    compute_cutoff(seq,[([(1,3),(6,7)],7),([], 7)], 5).

test(correct_a_selection2):-
    compute_cutoff(seq,[([(1,3),(6,7)],7),([], 3)], 0).

test(sanity):-
    compute_cutoff(seq,[([(1,3)],10),([(5,6)], 10)], 10).

:- end_tests(test).
