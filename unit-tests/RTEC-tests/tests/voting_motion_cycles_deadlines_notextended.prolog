/****************************************
*                                       *
* Author : Alex Artikis                 *
*                                       *
*****************************************/

:-['../src/unit_tester.prolog'].
:-['../../../src/timeoutTreatment.prolog'].
% load voting protocol; standard case: motion deadlines may NOT be extended
:-['../rules/voting/motion_cycle_deadlines_notextended/vopr_RTEC_compiled.prolog'].
:-['../rules/voting/vopr_RTEC_declarations.prolog'].
% load static voting info
:-['../scenarios/voting/voting-static.prolog'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   testing motion          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% cyclic and duration may NOT be extended %%%

% ordered input, deadlines canceled due to termination in the same and next window, no attempts for re-initiation, two windows
% load test narrative 
:-['../scenarios/voting/narrative1.prolog'].

% -------- status(1)=null
testcaseSE(voting_1, cdne_voting_motion_null, 1, [[(0,2),(10,inf)],[(10,16)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=proposed
testcaseSE(voting_1, cdne_voting_motion_proposed, 1, [[(2,6)],[(16,21)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voting
testcaseSE(voting_1, cdne_voting_motion_voting, 1, [[(6,9)],[(21,inf)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voted
testcaseSE(voting_1, cdne_voting_motion_voted, 1, [[(9,10)],[]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

    
% ordered input, no deadlines fired, attempts for re-initiation, two windows
% load test narrative 
:-['../scenarios/voting/narrative2.prolog'].

% -------- status(1)=null
testcaseSE(voting_2, cdne_voting_motion_null, 2, [[(0,2)],[(11,16)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=proposed
testcaseSE(voting_2, cdne_voting_motion_proposed, 2, [[(2,4)],[(16,21)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voting
testcaseSE(voting_2, cdne_voting_motion_voting, 2, [[(4,9)],[(21,inf)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voted
testcaseSE(voting_2, cdne_voting_motion_voted, 2, [[(9,inf)],[(9,11)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).


% ordered input, deadline fired in the next window, attempts for re-initiation, two windows
% load test narrative 
:-['../scenarios/voting/narrative3.prolog'].

% -------- status(1)=null
testcaseSE(voting_3, cdne_voting_motion_null, 3, [[(0,6)],[(16,inf)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=proposed
testcaseSE(voting_3, cdne_voting_motion_proposed, 3, [[(6,inf)],[(6,16)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voting
testcaseSE(voting_3, cdne_voting_motion_voting, 3, [[],[]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voted
testcaseSE(voting_3, cdne_voting_motion_voted, 3, [[],[]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).


% ordered input, deadline fired in the same window, attempts for re-initiation, ONE window
% load test narrative 
:-['../scenarios/voting/narrative4.prolog'].

% -------- status(1)=null
testcaseSE(voting_4, cdne_voting_motion_null, 4, [[(0,6),(16,inf)]], (20,21,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=proposed
testcaseSE(voting_4, cdne_voting_motion_proposed, 4, [[(6,16)]], (20,21,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voting
testcaseSE(voting_4, cdne_voting_motion_voting, 4, [[]], (20,21,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voted
testcaseSE(voting_4, cdne_voting_motion_voted, 4, [[]], (20,21,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).


% unordered input, events against the protocol flow, attempts for re-initiation, two windows
% load test narrative 
:-['../scenarios/voting/narrative5.prolog'].

% -------- status(1)=null
testcaseSE(voting_5, cdne_voting_motion_null, 4, [[(0,2)],[(16,inf)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=proposed
testcaseSE(voting_5, cdne_voting_motion_proposed, 4, [[(2,6)],[]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voting
testcaseSE(voting_5, cdne_voting_motion_voting, 4, [[(6,inf)],[(6,13)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voted
testcaseSE(voting_5, cdne_voting_motion_voted, 4, [[],[(13,16)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).


% unordered input, events against the protocol flow, attempts for re-initiation, two windows
% load test narrative 
:-['../scenarios/voting/narrative6.prolog'].

% -------- status(1)=null
testcaseSE(voting_6, cdne_voting_motion_null, 5, [[(0,3)],[]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=proposed
testcaseSE(voting_6, cdne_voting_motion_proposed, 5, [[(3,6)],[]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voting
testcaseSE(voting_6, cdne_voting_motion_voting, 5, [[(6,inf)],[(6,16)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
% -------- status(1)=voted
testcaseSE(voting_6, cdne_voting_motion_voted, 5, [[],[(16,inf)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   testing sanctioned (top-level fluent, ie testing hierarchy)          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% unordered input, events against the protocol flow, attempts for re-initiation, two windows
% use the already loaded narrative5 

% -------- sanctioned(2)=true
% -------- sanctioned is subject to deadlines which are not extended
testcaseSE(voting_5, cdne_voting_sanctioned, 1, [[],[(13,17)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

% -------- sanctioned(2)=true
% -------- sanctioned is subject to deadlines which are not extended
testcaseSE(voting_6, cdne_voting_sanctioned, 2, [[],[(20,inf)]], (10,11,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).


check(cdne_voting_motion_null, _N, Found):-
    holdsFor(status(1)=null, Found).
check(cdne_voting_motion_proposed, _N, Found):-
    holdsFor(status(1)=proposed, Found).
check(cdne_voting_motion_voting, _N, Found):-
    holdsFor(status(1)=voting, Found).
check(cdne_voting_motion_voted, _N, Found):-
    holdsFor(status(1)=voted, Found).    
check(cdne_voting_sanctioned, _N, Found):-
    holdsFor(sanctioned(2)=true, Found).    
