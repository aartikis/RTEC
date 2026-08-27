/****************************************
*                                       *
* Author: Alex Artikis                  *
*                                       *
*****************************************/

% To use caviar as a unit test test for RTEC, one must provide the ground truth

% I chose to copy the CAVIAR patterns and data in the unit tests folder;
% This way, any changes in the patterns or data, in the /examples folder,
% due to, say, development reasons, will not affect the unit tests.


% This test uses as ground truth the recognitions of RTEC as of 10 Oct 2019.

:-['../src/unit_tester.prolog'].

/* If we decide to use caviar as a unit test, the files below should be created:

% load the CAVIAR patterns
:-['../rules/caviar/compiled_caviar_patterns.prolog'].
:-['../rules/caviar/caviar_declarations.prolog'].

%%%% In this test, there is a need for pre-processing
:-['../rules/caviar/pre-processing.prolog'].

% load static/groundig information
:-['../scenarios/caviar/list-of-ids.prolog'].

% load test narrative 
:-['../scenarios/caviar/updateSDE-caviar-unit-tests.prolog'].

*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   single window 	    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preprocessing is necessary in CAVIAR 
% ordered input, no dynamic grounding, temporal distance: 40

% fighting

/*

% -------- fighting(id1,id2)=true
testcaseSE(caviar, single_window, 1, [], (1007000,1007000,0,1007000), ordered, nodynamicgrounding, preprocessing, 40).
check(single_window, 1, Found):-
    holdsFor(fighting(id1,id2)=true, Found).

% -------- fighting(id2,id6)=true
testcaseSE(caviar, single_window, 2, [], (1007000,1007000,0,1007000), ordered, nodynamicgrounding, preprocessing, 40).
check(single_window, 2, Found):-
    holdsFor(fighting(id2,id6)=true, Found).

% -------- fighting(id3,id4)=true
testcaseSE(caviar, single_window, 3, [], (1007000,1007000,0,1007000), ordered, nodynamicgrounding, preprocessing, 40).
check(single_window, 3, Found):-
    holdsFor(fighting(id3,id4)=true, Found).

% -------- fighting(id4,id5)=true
testcaseSE(caviar, single_window, 4, [], (1007000,1007000,0,1007000), ordered, nodynamicgrounding, preprocessing, 40).
check(single_window, 4, Found):-
    holdsFor(fighting(id4,id5)=true, Found).

% -------- fighting(id6,id7)=true
testcaseSE(caviar, single_window, 5, [], (1007000,1007000,0,1007000), ordered, nodynamicgrounding, preprocessing, 40).
check(single_window, 5, Found):-
    holdsFor(fighting(id6,id7)=true, Found).

*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   two windows 	    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fighting
/*

% -------- fighting(id1,id2)=true
testcaseSE(caviar, two_windows, 1, [[],[]], (10,10,0,20), ordered, nodynamicgrounding, preprocessing, 40).
check(two_windows, 1, Found):-
    holdsFor(fighting(id1,id2)=true, Found).

*/
