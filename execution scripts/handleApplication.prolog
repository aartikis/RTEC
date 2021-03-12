
% handleApplication(+Prolog, +ApplicationName, -InputMode, -LogFile, -WM, -Step, -EndReasoningTime, -StreamOrderFlag, -DynamicGroundingFlag, -PreprocessingFlag, -ForgetThreshold, -DynamicGroundingThreshold, -ClockTick)

% This is a predicate for setting the appropriate parameters for executing an application (see +ApplicationName),
% and consulting the relevant compiled event description, declarations and dataset. 
% Execution parameters:
% InputMode: read input data from CSV files or Prolog files
% LogFile: the file recording the statistics of execution, ResultsFile: the file recording the recognised intervals, WM: working memory size, Step: step size,
% StartReasoningTime and EndReasoningTime specify the range of continuous queries, ie continuous queries take place in (StartReasoningTime, EndReasoningTime]
% the last time-point of the dataset, StreamOrderFlag: 'ordered' or 'unordered' dataset, 
% DynamicGroundingFlag: 'dynamicgrounding' or 'nodynamicgrounding', PreprocessingFlag: 'preprocessing' or 'nopreprocessing', 
% ForgetThreshold: a parameter which helps decide which forget mechanism will be used. The mechanisms differ regarding the usage of the retract/retractall predicates
% 				If the number of events (to be retracted) per time-point is greater than ForgetThreshold, use retractall at each time-point. 
% 				Else, retract every event one by one.
%				Set to '-1' to avoid using retractall.
% DynamicGroundingThreshold: a parameter which helps decide the retract-assert mechanism of dynamic grounding. Again, the cases differ with respect to retract/retractall.
%				If the ratio of the size of the intersection of old ground terms and new ground terms to the number of old ground terms is greater than DynamiGroundingThreshold, do not retract/assert that intersection.
%				Else, retractall ground terms and re-assert new ground terms.
%				Set to '-1' to avoid using retractall.   
% ClockTick: temporal distance between two consecutive time-points, SDEBatch: the input narrative size asserted in a single batch


/*
datasetType/1 is used for logging the recognised intervals in continuousQueries.prolog
datasetType/1 is asserted in this file, and checked in continuousQueries.prolog
datasetType(ground_truth) denotes that the recognitions on the corresponding dataset will be used as ground truth
*/
:- dynamic datasetType/1.


%%%%%%%%%%%%%%%%%%%%%%%% TOY EXAMPLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handleApplication(Prolog, toycsv, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :- 
	(Prolog=yap, 
	 LogFile = '../examples/toy/experiments/execution log files/log-YAP-toy-csv.txt',
	 ResultsFile = '../examples/toy/experiments/execution log files/log-YAP-toy-csv-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/toy/experiments/execution log files/log-SWI-toy-csv.txt',
	 ResultsFile = '../examples/toy/experiments/execution log files/log-SWI-toy-csv-recognised-intervals.txt'
	),
	WM = 30,
	Step = 30, 
	StartReasoningTime = 0,
	EndReasoningTime = 30,
	StreamOrderFlag = ordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/toy/patterns/toy_rules_compiled.prolog'),
	consult('../examples/toy/patterns/toy_declarations.prolog'),
	% load the csv file with input data stream	
	InputMode = csv(['../examples/toy/experiments/data/toy_data.csv']), 
	consult('../examples/toy/experiments/data/toy_var_domain.prolog'), !.

handleApplication(Prolog, toy, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :- 
	(Prolog=yap, 
	 LogFile = '../examples/toy/experiments/execution log files/log-YAP-toy.txt',
  	 ResultsFile = '../examples/toy/experiments/execution log files/log-YAP-toy-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/toy/experiments/execution log files/log-SWI-toy.txt',
	 ResultsFile = '../examples/toy/experiments/execution log files/log-SWI-toy-recognised-intervals.txt'
	),
	WM = 30,
	Step = 30, 
	StartReasoningTime = 0,
	EndReasoningTime = 30,
	StreamOrderFlag = ordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/toy/patterns/toy_rules_compiled.prolog'),
	consult('../examples/toy/patterns/toy_declarations.prolog'),
	InputMode = dynamic_predicates(['../examples/toy/experiments/data/toy_data.prolog']), 
	consult('../examples/toy/experiments/data/toy_data.prolog'),
	consult('../examples/toy/experiments/data/toy_var_domain.prolog'), !.

%%%%%%%%%%%%%%%%%%%%%%%% NETBILL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Run Netbill for a small (example) event narrative stored in a csv file. %%
handleApplication(Prolog, netbillSmallcsv, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :- 
	(Prolog=yap, 
	 LogFile = '../examples/negotiation/experiments/execution log files/log-YAP-netbill-csv-small-20-10.txt',
	 ResultsFile = '../examples/negotiation/experiments/execution log files/log-YAP-netbill-csv-small-20-10-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/negotiation/experiments/execution log files/log-SWI-netbill-csv-small-20-10.txt',
	 ResultsFile = '../examples/negotiation/experiments/execution log files/log-SWI-netbill-csv-small-20-10-recognised-intervals.txt'
	),
	WM = 20,
	Step = 10, 
	StartReasoningTime = 0,
	EndReasoningTime = 20,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/negotiation/patterns/netbill_RTEC_compiled.prolog'),
	consult('../examples/negotiation/patterns/netbill_RTEC_declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/negotiation/experiments/data/negotiation-static_test.prolog'),
	InputMode = csv(['../examples/negotiation/experiments/data/csv/negotiation-test_stream.csv']), !.

%% Generate a small (example) event narrative for Netbill and process it with RTEC. %%
handleApplication(Prolog, netbillSmall, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :- 
	(Prolog=yap, 
	 LogFile = '../examples/negotiation/experiments/execution log files/log-YAP-netbill-small-20-10.txt',
	 ResultsFile = '../examples/negotiation/experiments/execution log files/log-YAP-netbill-small-20-10-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/negotiation/experiments/execution log files/log-SWI-netbill-small-20-10.txt',
	 ResultsFile = '../examples/negotiation/experiments/execution log files/log-SWI-netbill-small-20-10-recognised-intervals.txt'
	),
	WM = 20,
	Step = 10, 
	StartReasoningTime = 0,
	EndReasoningTime = 20,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/negotiation/patterns/netbill_RTEC_compiled.prolog'),
	consult('../examples/negotiation/patterns/netbill_RTEC_declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/negotiation/experiments/data/negotiation-static_test.prolog'),
	InputMode = dynamic_predicates(['../examples/negotiation/experiments/data/prolog/negotiation-test_stream.prolog']), !.

%% Generate an event narrative for Netbill using our synthetic dataset generator and process it with RTEC. %%
handleApplication(Prolog, netbillBig, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	WM = 10,
	Step = 10, 
	AgentNo = 4000,
	Seed = 1, 
	add_info('../examples/negotiation/experiments/execution log files/log-netbillBig', '.txt', [Prolog, WM, Step, AgentNo, Seed], LogFile),
	add_info('../examples/negotiation/experiments/execution log files/log-netbillBig', '-recognised-intervals.txt', [Prolog, WM, Step, AgentNo, Seed], ResultsFile),
	StartReasoningTime = 0,
	EndReasoningTime = 100,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	(Prolog=yap, 
	 srandom(Seed) ;
	 Prolog=swi,
	 set_random(seed(Seed))),
	consult('../examples/negotiation/patterns/netbill_RTEC_compiled.prolog'),
	consult('../examples/negotiation/patterns/netbill_RTEC_declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/negotiation/experiments/data/negotiation-static_generator.prolog'),
	assert_n_agents(AgentNo),
	InputMode = dynamic_predicates(['../examples/negotiation/experiments/data/prolog/negotiation-data_generator.prolog']), !.

%% Generate an event narrative for Netbill using our synthetic dataset generator and process it with RTEC. Uses dynamic grounding. %%
handleApplication(Prolog, netbillBigDG, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	WM = 10,
	Step = 10, 
	AgentNo = 4000,
	Seed = 1, 
	add_info('../examples/negotiation/experiments/execution log files/log-netbillBigDG', '.txt', [Prolog, WM, Step, AgentNo, Seed], LogFile),
	add_info('../examples/negotiation/experiments/execution log files/log-netbillBigDG', '-recognised-intervals.txt', [Prolog, WM, Step, AgentNo, Seed], ResultsFile),
	StartReasoningTime = 0,
	EndReasoningTime = 100,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = dynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	(Prolog=yap, 
	 srandom(Seed) ;
	 Prolog=swi,
	 set_random(seed(Seed))),
	consult('../examples/negotiation/patterns/netbill_RTEC_compiled_dg.prolog'),
	consult('../examples/negotiation/patterns/netbill_RTEC_declarations_dg.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/negotiation/experiments/data/negotiation-static_generator.prolog'),
	assert_n_agents(AgentNo),
	InputMode = dynamic_predicates(['../examples/negotiation/experiments/data/prolog/negotiation-data_generator.prolog']), !.

%% Run Netbill for an event narrative stored in a csv file. Uses dynamic grounding. %%
handleApplication(Prolog, netbillBigDGcsv, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	WM = 10,
	Step = 10, 
	AgentNo = 4000,
	Seed = 1, 
	add_info('../examples/negotiation/experiments/execution log files/log-netbillBigDGcsv', '.txt', [Prolog, WM, Step, AgentNo, Seed], LogFile),
	add_info('../examples/negotiation/experiments/execution log files/log-netbillBigDGcsv', '-recognised-intervals.txt', [Prolog, WM, Step, AgentNo, Seed], ResultsFile),
	StartReasoningTime = 0,
	EndReasoningTime = 100,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = dynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	(Prolog=yap, 
	 srandom(Seed) ;
	 Prolog=swi,
	 set_random(seed(Seed))),
	consult('../examples/negotiation/patterns/netbill_RTEC_compiled_dg.prolog'),
	consult('../examples/negotiation/patterns/netbill_RTEC_declarations_dg.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/negotiation/experiments/data/negotiation-static_generator.prolog'),
	assert_n_agents(AgentNo),
	add_info('../examples/negotiation/experiments/data/csv/negotiation', '.csv', [AgentNo ,Seed], InputFile),
	InputMode = csv([InputFile]), !.

%%%%%%%%%%%%%%%%%%%%%%%% VOTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Run voting for a small (example) event narrative stored in a csv file. %%
handleApplication(Prolog, votingSmallcsv, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :- 
	(Prolog=yap,
	 LogFile = '../examples/voting/experiments/execution log files/log-YAP-voting-small-csv-20-10.txt',
	 ResultsFile = '../examples/voting/experiments/execution log files/log-YAP-voting-small-csv-20-10-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/voting/experiments/execution log files/log-SWI-voting-small-csv-20-10.txt',
	 ResultsFile = '../examples/voting/experiments/execution log files/log-SWI-voting-small-csv-20-10-recognised-intervals.txt'
	),
	WM = 30,
	Step = 10, 
	StartReasoningTime = -1,
	EndReasoningTime = 20,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/voting/patterns/vopr_RTEC_compiled.prolog'),
	consult('../examples/voting/patterns/vopr_RTEC_declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/voting/experiments/data/voting-static_test.prolog'),
	InputMode = csv(['../examples/voting/experiments/data/csv/voting-test_stream.csv']), !.

%% Generate a small (example) event narrative for voting and process it with RTEC. %%
handleApplication(Prolog, votingSmall, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :- 
	(Prolog=yap,
	 LogFile = '../examples/voting/experiments/execution log files/log-YAP-voting-small-20-10.txt',
	 ResultsFile = '../examples/voting/experiments/execution log files/log-YAP-voting-small-20-10-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/voting/experiments/execution log files/log-SWI-voting-small-20-10.txt',
	 ResultsFile = '../examples/voting/experiments/execution log files/log-SWI-voting-small-20-10-recognised-intervals.txt'
	),
	WM = 20,
	Step = 10, 
	StartReasoningTime = 0,
	EndReasoningTime = 20,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/voting/patterns/vopr_RTEC_compiled.prolog'),
	consult('../examples/voting/patterns/vopr_RTEC_declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/voting/experiments/data/voting-static_test.prolog'),
	InputMode = dynamic_predicates(['../examples/voting/experiments/data/prolog/voting-test_stream.prolog']), !.

%% Generate an event narrative for voting using our synthetic dataset generator and process it with RTEC. %%
handleApplication(Prolog, votingBig, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	WM = 10,
	Step = 10, 
	AgentNo = 4000,
	Seed = 1,
	add_info('../examples/voting/experiments/execution log files/log-votingBig', '.txt', [Prolog, WM, Step, AgentNo, Seed], LogFile),
	add_info('../examples/voting/experiments/execution log files/log-votingBig', '-recognised-intervals.txt', [Prolog, WM, Step, AgentNo, Seed], ResultsFile),
	StartReasoningTime = 0,
	EndReasoningTime = 100,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	(Prolog=yap, 
	 srandom(Seed) ;
	 Prolog=swi,
	 set_random(seed(Seed))),
	consult('../examples/voting/patterns/vopr_RTEC_compiled.prolog'),
	consult('../examples/voting/patterns/vopr_RTEC_declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/voting/experiments/data/voting-static_generator.prolog'),
	assert_n_agents(AgentNo),
	InputMode = dynamic_predicates(['../examples/voting/experiments/data/prolog/voting-data_generator.prolog']), !.

%% Generate an event narrative for voting using our synthetic dataset generator and process it with RTEC. Uses dynamic grounding. %%
handleApplication(Prolog, votingBigDG, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	WM = 10,
	Step = 10, 
	AgentNo = 4000,
	Seed = 1,
	add_info('../examples/voting/experiments/execution log files/log-votingBigDG', '.txt', [Prolog, WM, Step, AgentNo, Seed], LogFile),
	add_info('../examples/voting/experiments/execution log files/log-votingBigDG', '-recognised-intervals.txt', [Prolog, WM, Step, AgentNo, Seed], ResultsFile),
	StartReasoningTime = 0,
	EndReasoningTime = 100,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = dynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	(Prolog=yap, 
	 srandom(Seed) ;
	 Prolog=swi,
	 set_random(seed(Seed))),
	consult('../examples/voting/patterns/vopr_RTEC_compiled_dg.prolog'),
	consult('../examples/voting/patterns/vopr_RTEC_declarations_dg.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/voting/experiments/data/voting-static_generator.prolog'),
	assert_n_agents(AgentNo),
	InputMode = dynamic_predicates(['../examples/voting/experiments/data/prolog/voting-data_generator.prolog']), !.

%% Run voting for an event narrative stored in a csv file. Uses dynamic grounding. %%
handleApplication(Prolog, votingBigDGcsv, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	WM = 10,
	Step = 10, 
	AgentNo = 4000,
	Seed = 1,
	add_info('../examples/voting/experiments/execution log files/log-votingBigDGcsv', '.txt', [Prolog, WM, Step, AgentNo, Seed], LogFile),
	add_info('../examples/voting/experiments/execution log files/log-votingBigDGcsv', '-recognised-intervals.txt', [Prolog, WM, Step, AgentNo, Seed], ResultsFile),
	StartReasoningTime = 0,
	EndReasoningTime = 100,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = dynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = 10, 
	DynamicGroundingThreshold = 0.8, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/voting/patterns/vopr_RTEC_compiled_dg.prolog'),
	consult('../examples/voting/patterns/vopr_RTEC_declarations_dg.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	consult('../examples/voting/experiments/data/voting-static_generator.prolog'),
	assert_n_agents(AgentNo),
	add_info('../examples/voting/experiments/data/csv/voting', '.csv', [AgentNo, Seed], InputFile),
	InputMode = csv([InputFile]), !.

%%%%%%%%%%%%%%%%%%%%%%%% CAVIAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handleApplication(Prolog, caviarcsv, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	(Prolog=yap,
	 LogFile = '../examples/caviar/experiments/execution log files/log-YAP-csv-caviar-100K-100K.txt',
	 ResultsFile = '../examples/caviar/experiments/execution log files/log-YAP-csv-caviar-100K-100K-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/caviar/experiments/execution log files/log-SWI-csv-caviar-100K-100K.txt',
	 ResultsFile = '../examples/caviar/experiments/execution log files/log-SWI-csv-caviar-100K-100K-recognised-intervals.txt'
	),
	WM = 100000,
	Step = 100000, 
	StartReasoningTime = 0,
	EndReasoningTime = 1007000,
	StreamOrderFlag = ordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = preprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 40,
	SDEBatch = 1000,
	%%%%%%%% LOAD THE APPLICATION-SPECIFIC PRE-PROCESSING MODULE %%%%%%%%
	consult('../examples/caviar/patterns/pre-processing.prolog'),
	consult('../examples/caviar/patterns/caviar_declarations.prolog'),
	consult('../examples/caviar/patterns/compiled_caviar_patterns.prolog'),
	% load the csv file with input data stream	
	InputMode = csv(['../examples/caviar/experiments/data/csv/appearance.csv', '../examples/caviar/experiments/data/csv/movementB.csv']), 
	consult('../examples/caviar/experiments/data/list-of-ids.prolog'), !.

handleApplication(Prolog, caviar, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	(Prolog=yap,
	 LogFile = '../examples/caviar/experiments/execution log files/log-YAP-caviar-100K-100K.txt',
	 ResultsFile = '../examples/caviar/experiments/execution log files/log-YAP-caviar-100K-100K-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/caviar/experiments/execution log files/log-SWI-caviar-100K-100K.txt',
	 ResultsFile = '../examples/caviar/experiments/execution log files/log-SWI-caviar-100K-100K-recognised-intervals.txt'
	),
	WM = 100000,
	Step = 100000, 
	StartReasoningTime = 0,
	EndReasoningTime = 1007000,
	StreamOrderFlag = ordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = preprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 40,
	SDEBatch = 1000,
	%%%%%%%% LOAD THE APPLICATION-SPECIFIC PRE-PROCESSING MODULE %%%%%%%%
	consult('../examples/caviar/patterns/pre-processing.prolog'),
	consult('../examples/caviar/patterns/caviar_declarations.prolog'),
	consult('../examples/caviar/patterns/compiled_caviar_patterns.prolog'),
	consult('../examples/caviar/experiments/data/prolog/updateSDE-caviar.prolog'),
	InputMode = dynamic_predicates(['../examples/caviar/experiments/data/prolog/appearance.prolog', '../examples/caviar/experiments/data/prolog/movementB.prolog']), 
	consult('../examples/caviar/experiments/data/list-of-ids.prolog'), !.

%%%%%%%%%%%%%%%%%%%%%%%% CTM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handleApplication(Prolog, ctmcsv, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	(Prolog=yap,
	 LogFile = '../examples/ctm/experiments/execution log files/log-YAP-csv-ctm-10K-10K.txt',
	 ResultsFile = '../examples/ctm/experiments/execution log files/log-YAP-csv-ctm-10K-10K-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/ctm/experiments/execution log files/log-SWI-csv-ctm-10K-10K.txt',
	 ResultsFile = '../examples/ctm/experiments/execution log files/log-SWI-csv-ctm-10K-10K-recognised-intervals.txt'
	),
	WM = 10000,
	Step = 10000, 
	StartReasoningTime = 0,
	EndReasoningTime = 50000,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 1,
	SDEBatch = 1000,
	consult('../examples/ctm/patterns/ctm_declarations.prolog'),
	consult('../examples/ctm/patterns/compiled_ctm_patterns.prolog'),
	InputMode = csv(['../examples/ctm/experiments/data/csv/abrupt_acceleration.csv', '../examples/ctm/experiments/data/csv/abrupt_deceleration.csv', '../examples/ctm/experiments/data/csv/internal_temperature_change.csv', '../examples/ctm/experiments/data/csv/noise_level_change.csv', '../examples/ctm/experiments/data/csv/passenger_density_change.csv', '../examples/ctm/experiments/data/csv/sharp_turn.csv', '../examples/ctm/experiments/data/csv/stop_enter_leave.csv']),
	consult('../examples/ctm/experiments/data/vehicles.prolog'), !.

handleApplication(Prolog, ctm, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch) :-
	(Prolog=yap,
	 LogFile = '../examples/ctm/experiments/execution log files/log-YAP-ctm-10K-10K.txt',
	 ResultsFile = '../examples/ctm/experiments/execution log files/log-YAP-ctm-10K-10K-recognised-intervals.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/ctm/experiments/execution log files/log-SWI-ctm-10K-10K.txt',
	 ResultsFile = '../examples/ctm/experiments/execution log files/log-SWI-ctm-10K-10K-recognised-intervals.txt'
	),
	WM = 10000,
	Step = 10000, 
	StartReasoningTime = 0,
	EndReasoningTime = 50000,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = nodynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 1,
	SDEBatch = 1000,
	consult('../examples/ctm/patterns/ctm_declarations.prolog'),
	consult('../examples/ctm/patterns/compiled_ctm_patterns.prolog'),
	consult('../examples/ctm/experiments/data/prolog/updateSDE-ctm.prolog'),
	InputMode = dynamic_predicates(['../examples/ctm/experiments/data/prolog/abrupt_acceleration.prolog', '../examples/ctm/experiments/data/prolog/abrupt_deceleration.prolog', '../examples/ctm/experiments/data/prolog/internal_temperature_change.prolog', '../examples/ctm/experiments/data/prolog/noise_level_change.prolog', '../examples/ctm/experiments/data/prolog/passenger_density_change.prolog', '../examples/ctm/experiments/data/prolog/sharp_turn.prolog', '../examples/ctm/experiments/data/prolog/stop_enter_leave.prolog']),
	consult('../examples/ctm/experiments/data/vehicles.prolog'), !.

%%%%%%%%%%%%%%%%%%%%%%%% Maritime-Brest %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Use SWI on the maritime datasets only for debugging

%%%%% critical points

handleApplication(Prolog, brest-critical, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, _SDEBatch) :-
	(Prolog=yap,
 	 LogFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-critical-yap-1day-1day.txt',
	 ResultsFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-critical-yap-1day-1day-recognised-intervals-critical-yap.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-critical-SWI-1day-1day.txt',
	 ResultsFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-critical-SWI-1day-1day-recognised-intervals-critical-SWI.txt'
	),
	WM = 7200, % 86400,
	Step = 7200, % 86400, 
	% start of the dataset:
	StartReasoningTime = 1443650400,
	EndReasoningTime = 1448834400,
	% end of dataset:
	% EndReasoningTime = 1459548000,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = dynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 1,
	% load the patterns:
	consult('../examples/Maritime-Monitoring/maritime patterns/Maritime_Patterns_Compiled.prolog'),
	% these are auxiliary predicates used in the maritime patterns
	consult('../examples/Maritime-Monitoring/maritime patterns/compare.prolog'),	
	consult('../examples/Maritime-Monitoring/maritime patterns/Maritime_Patterns_Declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	% load the dynamic data:
	InputMode = csv(['../examples/Maritime-Monitoring/Brest/experiments/data/dynamic/preprocessed_dataset_RTEC_critical_nd.csv']),
	% load the static data
	consult('../examples/Maritime-Monitoring/Brest/experiments/data/static/loadStaticData.prolog'), !.

%%%%% enriched points

handleApplication(Prolog, brest-enriched, InputMode, LogFile, ResultsFile, WM, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, _SDEBatch) :-
	(Prolog=yap,
 	 LogFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-enriched-yap-1day-1day.txt',
	 ResultsFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-enriched-yap-1day-1day-recognised-intervals-critical-yap.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-enriched-SWI-1day-1day.txt',
	 ResultsFile = '../examples/Maritime-Monitoring/Brest/experiments/execution log files/log-Brest-enriched-SWI-1day-1day-recognised-intervals-critical-SWI.txt'
	),
	WM = 86400,
	Step = 86400, 
	% start of the dataset:
	StartReasoningTime = 1443650400,
	% end of the first week:
	EndReasoningTime = 1444255200,
	StreamOrderFlag = unordered,
	DynamicGroundingFlag = dynamicgrounding,
	PreprocessingFlag = nopreprocessing, 
	ForgetThreshold = -1, 
	DynamicGroundingThreshold = -1, 
	ClockTick = 1,
	% load the patterns:
	consult('../examples/Maritime-Monitoring/maritime patterns/Maritime_Patterns_Compiled.prolog'),
	% these are auxiliary predicates used in the maritime patterns
	consult('../examples/Maritime-Monitoring/maritime patterns/compare.prolog'),	
	consult('../examples/Maritime-Monitoring/maritime patterns/Maritime_Patterns_Declarations.prolog'),
	consult('../src/timeoutTreatment.prolog'),
	% load the dynamic data:
	InputMode = csv(['../examples/Maritime-Monitoring/Brest/experiments/data/dynamic/preprocessed_dataset_RTEC_enriched_nd.csv']),
	%%% Important: instruct the execution script that the recognitions on this dataset will be treated as the ground truth
	assert( datasetType(ground_truth) ),
	% load the static data
	consult('../examples/Maritime-Monitoring/Brest/experiments/data/static/loadStaticData.prolog'), !.

%% Auxiliary predicates to differentiate input/result files based on the parameter of the experiment. %%
%% Usage:   add_info(+PrefixStr, +SuffixStr, +ParametersList, -FinalStr)							  %%
%% Example: add_info('voting-result-file', '.txt', [yap,10,10], 'voting-result-file-yap-10-10.txt')   %%

add_info(PrefixStr, SuffixStr, [], FinalStr):-
	atom_concat(PrefixStr, SuffixStr, FinalStr).

add_info(PrefixStr, SuffixStr, [NewInfo|RestInfo], FinalStr):-
	\+number(NewInfo), !,
	atom_concat(PrefixStr, '-', PrefixStr1),
	atom_concat(PrefixStr1, NewInfo, PrefixStr2),
	add_info(PrefixStr2, SuffixStr, RestInfo, FinalStr).

add_info(PrefixStr, SuffixStr, [NewInfo|RestInfo], FinalStr):-
	current_prolog_flag(dialect, yap), !,
    number_atom(NewInfo, NewInfoAtom),
	atom_concat(PrefixStr, '-', PrefixStr1),
	atom_concat(PrefixStr1, NewInfoAtom, PrefixStr2),
	add_info(PrefixStr2, SuffixStr, RestInfo, FinalStr).

add_info(PrefixStr, SuffixStr, [NewInfo|RestInfo], FinalStr):-
    atom_number(NewInfoAtom, NewInfo), % opposite from above.
	atom_concat(PrefixStr, '-', PrefixStr1),
	atom_concat(PrefixStr1, NewInfoAtom, PrefixStr2),
	add_info(PrefixStr2, SuffixStr, RestInfo, FinalStr).


