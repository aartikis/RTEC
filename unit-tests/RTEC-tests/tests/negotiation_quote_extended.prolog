/****************************************
*                                       *
* Author : Alex Artikis                 *
*                                       *
*****************************************/


:-['../src/unit_tester.prolog'].
:-['../../../src/timeoutTreatment.prolog'].
% load netbill protocol
:-['../rules/negotiation/quote_extended/netbill_RTEC_compiled.prolog'].
:-['../rules/negotiation/netbill_RTEC_declarations.prolog'].
% load static voting info
:-['../scenarios/negotiation/negotiation-static.prolog'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   testing quote           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% duration may NOT be extended, no cycles %%%

% ordered input, deadlines canceled due to termination in the same and next window, no attempts for re-initiation, two windows
% load test narrative 
:-['../scenarios/negotiation/narrative1.prolog'].

% -------- quote(1,6,book6)=true
testcaseSE(negotiation_1, e_netbill_quote, 1, [[(6,9),(11,inf)],[(11,16)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

% ordered input, deadlines canceled due to termination in the next window, other deadline fired, attempts for re-initiation, two windows
% load test narrative 
:-['../scenarios/negotiation/narrative2.prolog'].

% -------- quote(1,6,book6)=true
testcaseSE(negotiation_2, e_netbill_quote, 2, [[(9,inf)],[(9,12),(13,18)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

% ordered input, deadlines fired, attempts for re-initiation, deadline coincides with initiation, two windows
% load test narrative 
:-['../scenarios/negotiation/narrative3.prolog'].

% -------- quote(1,6,book6)=true
testcaseSE(negotiation_3, e_netbill_quote, 3, [[(2,inf)],[(2,19)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

% ordered input, deadlines canceled in the same and the next window, other deadline fired, attempts for re-initiation, deadline coincides with initiation, two windows
% load test narrative 
:-['../scenarios/negotiation/narrative4.prolog'].

% -------- quote(1,6,book6)=true
testcaseSE(negotiation_4, e_netbill_quote, 4, [[(2,6),(7,inf)],[(7,12),(14,19)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).

% unordered input, events against the flow of the protocol, two windows
% load test narrative 
:-['../scenarios/negotiation/narrative5.prolog'].

% -------- quote(1,6,book6)=true
testcaseSE(negotiation_5, e_netbill_quote, 5, [[(6,inf)],[(6,14)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   testing suspended (top-level fluent, ie testing hierarchy)      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% suspended may be extended, also part of a large cycle %%%

% use the already loaded narrative1 
% -------- suspended(1,merchant)=true
testcaseSE(negotiation_1, e_netbill_suspended, 1, [[],[(21,inf)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).
    
% use the already loaded narrative2 
% -------- suspended(1,merchant)=true
testcaseSE(negotiation_2, e_netbill_suspended, 2, [[(10,inf)],[(10,16)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).    
    
% use the already loaded narrative3 
% -------- suspended(1,merchant)=true
testcaseSE(negotiation_3, e_netbill_suspended, 3, [[(4,inf)],[(4,17)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).        
    
% use the already loaded narrative4 
% -------- suspended(1,merchant)=true
testcaseSE(negotiation_4, e_netbill_suspended, 4, [[(4,inf)],[(4,17)]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).            
    
% use the already loaded narrative5 
% -------- suspended(1,merchant)=true
testcaseSE(negotiation_5, e_netbill_suspended, 5, [[(3,10)],[]], (10,10,0,20), unordered, nodynamicgrounding, nopreprocessing, 1).  

    
check(e_netbill_quote, _N, Found):-
    holdsFor(quote(1,6,book6)=true, Found).
check(e_netbill_suspended, _N, Found):-
    holdsFor(suspended(1,merchant)=true, Found).
