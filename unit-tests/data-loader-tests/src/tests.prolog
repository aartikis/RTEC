
/*************************************************************
	DATA LOADER
*************************************************************/

/*

EXECUTION INSTRUCTIONS:
-Run SWI Prolog; load 'tests.prolog'; type run_tests.

Conditions (or future tests):
			- Input file must be in csv format 
			- One event per line
			- '|' as delimiter
			- Instantaneous events must have format: 
				EventType(string)|ArrivalTime(int)|OccurenceTime(int)|Attribute1|...|AttributeN
				E.g. happensAtIE( stop_enter(75, bus, 008, early), 5) ->
				     stop_enter|5|5|75|bus|008|early
			- Durative events must have format: 
			    EventType(string)|ArrivalTime(int)|StartTime(int)|EndTime(int)|Value|Attribute1|...|AttributeN
			    E.g. holdsForIESI( sharp_turn(75, bus)=very_sharp, (4, 7)) ->
			         sharp_turn|7|4|7|very_sharp|75|bus
			- All lines must be correctly formatted. NO checking performed.
			- If dynamic grounding is required, then attributes to be grounded must be declared
			  in declarations file. 
			  E.g. If buses' ids need to be grounded via stop_enter events, 
			  then the declarations file must include 
			  	needsGrounding(stop_enter,    3,       vehicle).
			  	                   ^          ^           ^
			  	                   |          |           |
			  	                   |          |           |
			  				   event from   index of   predicate
			  				   which		atribute   to ground
			  				   to gather    for value
			  				   groundings
			    From stop_enter|5|5|75|bus|008|early, then vehicle(75) would be asserted.

Cases tested:
			- single input file, instantaneous events, read whole file
			- single input file, durative_events, read whole file
			- two input files, both ies and des (separate), read whole files
			- two input files, both ies and des (separate), partial read of both files, from beginning of files
			- two input files, both ies and des (separate), partial read of one file, from beginning of files
			- two input files, both ies and des (separate), partial read of both files, after beginning of files
			
Input files:
			- ctm_declarations.prolog, consulted from within fullel.prolog
			- stop_enter_leave_sef.csv: 1000 instantaneous events, time: 5-3999
			- sharp_turn_sef.csv:       1000 durative events, time: 7-7999
*/

:- begin_tests(data_loader).

% single input file, instantaneous events, read whole file 
test(whole_single_file_ie) :-
	consult('fullel.prolog'),
	retractall(happensAtIE(_E1,_T1)),
	retractall(holdsForIESI(_F1=_V1,_I1)),
	performFullEL(['../tests/ctm/stop_enter_leave_sef.csv'],
				   '../tests/ctm/times.txt',
				   '../tests/ctm/patterns.txt',
				   0,
				   1000,
				   1000,
				   4000),
	findall(T,happensAtIE(_E,T),LT),
	length(LT,N),
	assertion(N == 1000).
	
% single input file, instantaneous events, read whole file and check for events happening at window limits 
test(window_limits) :-
	retractall(happensAtIE(_E1,_T1)),
	retractall(holdsForIESI(_F1=_V1,_I1)),
	retractall(evTList(_Index1, _E2, _ListofTimePoints)),
	performFullEL(['../tests/ctm/stop_enter_leave_win_lim_sef.csv'],
				   '../tests/ctm/times.txt',
				   '../tests/ctm/patterns.txt',
				   0,
				   1000,
				   1000,
				   4000),
	findall(T,happensAtIE(_E,T),LT),
	length(LT,N),
	assertion(N == 1000).
	
% single input file, durative_events, read whole file
test(whole_single_file_de) :-
	%consult('fullel.prolog'),
	retractall(happensAtIE(_E1,_T1)),
	retractall(holdsForIESI(_F1=_V1,_I1)),
	performFullEL(['../tests/ctm/sharp_turn_sef.csv'],
				   '../tests/ctm/times.txt',
				   '../tests/ctm/patterns.txt',
				   0,
				   1000,
				   1000,
				   8000),
	findall(I,holdsForIESI(_F=_V,I),LI),
	length(LI,N),
	assertion(N == 1000).
	
% two input files, both ies and des (separate), read whole files 
test(whole_two_files_ie_de) :-
	%consult('fullel.prolog'),
	retractall(happensAtIE(_E1,_T1)),
	retractall(holdsForIESI(_F1=_V1,_I1)),
	performFullEL(['../tests/ctm/stop_enter_leave_sef.csv',
				   '../tests/ctm/sharp_turn_sef.csv'],
				   '../tests/ctm/times.txt',
				   '../tests/ctm/patterns.txt',
				   0,
				   1000,
				   1000,
				   8000),
	findall(T,happensAtIE(_E,T),LT),
	length(LT,NT),
	assertion(NT == 1000),
	findall(I,holdsForIESI(_F=_V,I),LI),
	length(LI,NI),
	assertion(NI == 1000).
	
% two input files, both ies and des (separate), partial read of both files, from beginning of files  
test(partial1_two_files_ie_de) :-
	%consult('fullel.prolog'),
	retractall(happensAtIE(_E1,_T1)),
	retractall(holdsForIESI(_F1=_V1,_I1)),
	performFullEL(['../tests/ctm/stop_enter_leave_sef.csv',
				   '../tests/ctm/sharp_turn_sef.csv'],
				   '../tests/ctm/times.txt',
				   '../tests/ctm/patterns.txt',
				   0,
				   1000,
				   1000,
				   2000),
	findall(T,happensAtIE(_E,T),LT),
	length(LT,NT),
	assertion(NT == 750),
	findall(I,holdsForIESI(_F=_V,I),LI),
	length(LI,NI),
	assertion(NI == 375).
	
% two input files, both ies and des (separate), partial read of one file, from beginning of files  
test(partial2_two_files_ie_de) :-
	%consult('fullel.prolog'),
	retractall(happensAtIE(_E1,_T1)),
	retractall(holdsForIESI(_F1=_V1,_I1)),
	performFullEL(['../tests/ctm/stop_enter_leave_sef.csv',
				   '../tests/ctm/sharp_turn_sef.csv'],
				   '../tests/ctm/times.txt',
				   '../tests/ctm/patterns.txt',
				   0,
				   1000,
				   1000,
				   5000),
	findall(T,happensAtIE(_E,T),LT),
	length(LT,NT),
	assertion(NT == 1000),
	findall(I,holdsForIESI(_F=_V,I),LI),
	length(LI,NI),
	assertion(NI == 750).
	
% two input files, both ies and des (separate), partial read of both files, after beginning of files  
test(partial2_two_files_ie_de) :-
	%consult('fullel.prolog'),
	retractall(happensAtIE(_E1,_T1)),
	retractall(holdsForIESI(_F1=_V1,_I1)),
	performFullEL(['../tests/ctm/stop_enter_leave_sef.csv',
				   '../tests/ctm/sharp_turn_sef.csv'],
				   '../tests/ctm/times.txt',
				   '../tests/ctm/patterns.txt',
				   1000,
				   1000,
				   1000,
				   5000),
	findall(T,happensAtIE(_E,T),LT),
	length(LT,NT),
	assertion(NT == 750),
	findall(I,holdsForIESI(_F=_V,I),LI),
	length(LI,NI),
	assertion(NI == 625).


:- end_tests(data_loader).



