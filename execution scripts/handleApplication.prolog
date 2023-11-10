
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

% Default window size for supported applications.
% In order to run an application for a different value of this parameter, run:
% 	continuousQueries(ApplicationName, [window_size=WindowSize]).
% For example: 
% 	continuousQueries(toy, [window_size=20]).
default(window_size, toy, 10).
default(window_size, maritime, 86400).
default(window_size, caviar, 100000).
default(window_size, voting, 10).
default(window_size, netbill, 10).
default(window_size, ctm, 10000).
default(window_size, feedback_loops, 10).

% Default step size for supported applications.
% In order to run an application for a different value of this parameter, run:
% 	continuousQueries(ApplicationName, [step=Step]).
% For example: 
% 	continuousQueries(toy, [step=5]).
default(step, toy, 10).
default(step, maritime, 86400).
default(step, caviar, 100000).
default(step, voting, 10).
default(step, netbill, 10).
default(step, ctm, 10000).
default(step, feedback_loops, 10).

% Default start time of reasoning for supported applications.
% In order to run an application for a different value of this parameter, run:
% 	continuousQueries(ApplicationName, [start_time=StartTime]).
% For example: 
% 	continuousQueries(toy, [start_time=10]).
default(start_time, toy, 0).
default(start_time, maritime, 1443650400).
default(start_time, caviar, 0).
default(start_time, voting, 0).
default(start_time, netbill, 0).
default(start_time, ctm, 0).
default(start_time, feedback_loops, 0).

% Default end time of reasoning for supported applications.
% In order to run an application for a different value of this parameter, run:
% 	continuousQueries(ApplicationName, [end_time=EndTime]).
% For example: 
% 	continuousQueries(toy, [end_time=30]).
default(end_time, toy, 50).
default(end_time, maritime, 1459461585). % 1448834400).
default(end_time, caviar, 1007000).
default(end_time, voting, 100).
default(end_time, netbill, 100).
default(end_time, ctm, 50000).
default(end_time, feedback_loops, 100).

% Default clock tick, i.e., temporal distance between consecutive time-points, for supported applications.
% In order to run an application for a different value of this parameter, run:
% 	continuousQueries(ApplicationName, [clock_tick=ClockTick]).
% WARNING: Changing the value of clock_tick in existing applications may affect the 
% 		   correctness of the results.
default(clock_tick, toy, 1):- !.
default(clock_tick, maritime, 1):- !.
default(clock_tick, caviar, 40):- !.
default(clock_tick, voting, 1):- !.
default(clock_tick, netbill, 1):- !.
default(clock_tick, ctm, 1):- !.
default(clock_tick, feedback_loops, 1):- !.
default(clock_tick, _, 1).


% The default results directory for each application. 
% In order to run an application for a different value of this parameter, run:
%   continuousQueries(ApplicationName, [results_directory=ResultsDirectory]).
% For example: 
%   continuousQueries(toy, [results_directory=/home/chris/myresults]).

default(results_directory, Application, Directory):-
	atom_concat('../examples/', Application, Dir0),
	atom_concat(Dir0, '/results/', Directory).

default(output_mode, toy, file):- !.
default(output_mode, maritime, file):- !.
default(output_mode, caviar, file):- !.
default(output_mode, voting, file):- !.
default(output_mode, netbill, file):- !.
default(output_mode, ctm, file):- !.
default(output_mode, feedback_loops, file):- !.
default(output_mode, _, file).

%default(goals, toy, []):- !.
%default(goals, maritime, []):- !.
%default(goals, caviar, []):- !.
%default(goals, voting, []):- !.
%default(goals, netbill, []):- !.
%default(goals, ctm, []):- !.
%default(goals, feedback_loops, [initialiseLoop(simple_neg, [0, 0])]):- !.
%default(goals, _Application, []).

% The default event description files for each application. 
% In order to run an application for a different value of this parameter, run:
%   continuousQueries(ApplicationName, [event_description_files=EventDescriptionFiles]).
default(event_description_files, toy, Files):-
	Files=['../examples/toy/resources/patterns/compiled_rules.prolog', 
		'../examples/toy/dataset/auxiliary/toy_var_domain.prolog'].

default(event_description_files, maritime, Files):-
	Files=['../examples/maritime/resources/patterns/compiled_rules.prolog', 
			'../examples/maritime/resources/auxiliary/compare.prolog',
			'../examples/maritime/resources/auxiliary/loadStaticData.prolog'].

default(event_description_files, caviar, Files):-
	Files=['../examples/caviar/resources/patterns/compiled_rules.prolog', 
			'../examples/caviar/resources/auxiliary/pre-processing.prolog'].

default(event_description_files, voting, Files):-
	Files=[ '../examples/voting/resources/patterns/compiled_rules.prolog', 
			'../examples/voting/dataset/auxiliary/voting_static_generator.prolog'].

default(event_description_files, netbill, Files):-
	Files=['../examples/netbill/resources/patterns/compiled_rules.prolog', 
			'../examples/netbill/dataset/auxiliary/netbill_static_generator.prolog'].

default(event_description_files, ctm, Files):-
	Files=['../examples/ctm/resources/patterns/compiled_rules.prolog'].
			%'../examples/ctm/dataset/auxiliary/vehicles.prolog'].

default(event_description_files, feedback_loops, Files):-
	Files=['../examples/feedback_loops/resources/patterns/feedback_loops_rules_compiled.prolog', 
			'../examples/feedback_loops/resources/patterns/feedback_loops_declarations.prolog',
			'../examples/feedback_loops/resources/auxiliary/static_info.prolog'].

% The default input mode for each application. 
% In order to run an application for a different value of this parameter, run:
%   continuousQueries(ApplicationName, [input_mode=InputMode]).
% There are three possible values for input_mode:
% 	'csv': RTEC opens the input csv files and asserts the input events in the appropriate window.
% 	'fifo': Live stream reasoning. RTEC reads the input events from named pipes and asserts them as soon as they arrive.
%   'dynamic_predicates': RTEC consults directing the input prolog files containing the input events. Event assertions take place in the appropriate window. 
default(input_mode, _Application, csv).

% Default stream rate, i.e., the expected rate at which the input streams have been sped up, for supported applications.
% This variable affects the amount of time RTEC "sleeps" between the processing of consecutive windows.
% In order to run an application for a different value of this parameter, run:
% 	continuousQueries(ApplicationName, [stream_rate=StreamRate]).
% Note: this variable is only useful when running RTEC with the input mode: 'fifo'.
% WARNING: the value of stream_rate should agree with speed rate of the input providers
default(stream_rate, toy, 1).
default(stream_rate, maritime, 1).
default(stream_rate, caviar, 40).
default(stream_rate, voting, 1).
default(stream_rate, netbill, 1).
default(stream_rate, ctm, 1).
default(stream_rate, feedback_loops, 1).

% The default number of time-points each Prolog rule for asserting input events contains for supported applications.
% In order to run an application for a different value of this parameter, run:
% 	continuousQueries(ApplicationName, [sde_batch=SDEBatch]).
% Note: this variable is only useful when running RTEC with the input mode: 'dynamic_predicates'.
% 		The definition of the input_mode parameter is presented shortly.
default(sde_batch, toy, 10):- !.
default(sde_batch, maritime, 86400):- !.
default(sde_batch, caviar, 1000):- !.
default(sde_batch, voting, 10):- !.
default(sde_batch, netbill, 10):- !.
default(sde_batch, ctm, 1000):- !.
default(sde_batch, feedback_loops, 10):- !.
default(sde_batch, _Application, 10).

% Default memory size for allen relations.
default(allen_memory, toy, 10):- !.
default(allen_memory, maritime, 86400):- !.
default(allen_memory, caviar, 100000):- !.
default(allen_memory, voting, 10):- !.
default(allen_memory, netbill, 10):- !.
default(allen_memory, ctm, 10000):- !.
default(allen_memory, feedback_loops, 10):- !.
default(allen_memory, _Application, 10).

% Default values for flag about dynamic grounding, stream ordering and stream preprocessing.
default(dynamic_grounding_flag, _Application, dynamicgrounding). 
default(stream_order_flag, _Application, unordered). 
default(preprocessing_flag, _Application, nopreprocessing). 

% Default values for the memory management thresholds used by RTEC.
default(forget_threshold, _Application, -1).
default(dynamic_grounding_threshold, _Application, -1).

% The default input providers for each application. 
% In order to run an application for a different value of this parameter, run:
%   continuousQueries(ApplicationName, [input_providers=InputProvidersList]).
% WARNING: The provided input paths must agree with the provided input mode.
default(input_providers, toy, csv, ['../examples/toy/dataset/csv/toy_data.csv']).
default(input_providers, toy, fifo, ['fifo1']).
default(input_providers, toy, dynamic_predicates, ['../examples/toy/dataset/prolog/toy_data.prolog']).

default(input_providers, maritime, csv, ['../examples/maritime/dataset/csv/preprocessed_dataset_RTEC_critical_nd.csv']).
default(input_providers, maritime, fifo, ['fifo1']).
default(input_providers, maritime, dynamic_predicates, []):-
	write('ERROR: The maritime use case cannot be run for input_mode=dynamic_predicates. Try the csv or fifo input modes'), nl, exit(1).

default(input_providers, caviar, csv, ['../examples/caviar/dataset/csv/appearance.csv', '../examples/caviar/dataset/csv/movementB.csv']).
default(input_providers, caviar, fifo, ['fifo1', 'fifo2']).
default(input_providers, caviar, dynamic_predicates, ['../examples/caviar/dataset/prolog/appearance.prolog', '../examples/caviar/dataset/prolog/movementB.prolog']).

default(input_providers, voting, csv, ['../examples/voting/dataset/csv/voting.csv']).
default(input_providers, voting, fifo, ['fifo1']).
default(input_providers, voting, dynamic_predicates, ['../examples/voting/dataset/prolog/voting_data_generator.prolog']).

default(input_providers, netbill, csv, ['../examples/netbill/dataset/csv/netbill.csv']).
default(input_providers, netbill, fifo, ['fifo1']).
default(input_providers, netbill, dynamic_predicates, ['../examples/netbill/dataset/prolog/netbill_data_generator.prolog']).

default(input_providers, ctm, csv, ['../examples/ctm/dataset/csv/abrupt_acceleration.csv', '../examples/ctm/dataset/csv/abrupt_deceleration.csv', '../examples/ctm/dataset/csv/internal_temperature_change.csv', '../examples/ctm/dataset/csv/noise_level_change.csv', '../examples/ctm/dataset/csv/passenger_density_change.csv', '../examples/ctm/dataset/csv/sharp_turn.csv', '../examples/ctm/dataset/csv/stop_enter_leave.csv']).
default(input_providers, ctm, fifo, ['fifo1', 'fifo2', 'fifo3', 'fifo4', 'fifo5', 'fifo6', 'fifo7']). % maybe multiple fifos are needed here.
default(input_providers, ctm, dynamic_predicates, ['../examples/ctm/dataset/prolog/updateSDE-ctm.prolog', '../examples/ctm/dataset/prolog/load-ctm-data.prolog']).

default(input_providers, feedback_loops, csv, []).
default(input_providers, feedback_loops, fifo, []).
default(input_providers, feedback_loops, dynamic_predicates, []).

% set_parameter(+ParameterList, +ParameterName, +Application, -Value)
% Search the parameter list for an element containing the selected parameter name
% and update the output value accordingly.
% If the selected parameter name is not found in the list,
% then the output value is the application specific default value defined in a default/3 fact.
set_parameter([], ParameterName, Application, Value):-
	default(ParameterName, Application, Value).
set_parameter([ParameterName=Value|_T], ParameterName, _Application, Value):- !.
set_parameter([dynamicgrounding|_T], dynamic_grounding_flag, _Application, dynamicgrounding):- !.
set_parameter([ordered|_T], stream_order_flag, _Application, ordered):- !.
set_parameter([preprocessing|_T], preprocessing_flag, _Application, preprocessing):- !.
set_parameter([_H|T], ParameterName, Application, Value):-
	set_parameter(T, ParameterName, Application, Value).	

% set_parameter(+ParameterList, +ParameterName, +Application, +InputMode, -Value)
% Same meaning as set_parameter/4.
% The input mode argument is used to fetch the correct default value 
% for the parameter input_providers from a default/4 fact.
set_parameter([], ParameterName, Application, InputMode, Value):-
	default(ParameterName, Application, InputMode, Value).
set_parameter([ParameterName=Value|_T], ParameterName, _Application, _InputMode, Value):- !.
set_parameter([_H|T], ParameterName, Application, InputMode, Value):-
	set_parameter(T, ParameterName, Application, InputMode, Value).	

handleApplication(App, Prolog, ParameterList, PrologFiles, InputMode, InputProviders, LogFile, OutputMode, ResultsFile, WindowSize, Step, StartReasoningTime, EndReasoningTime, StreamOrderFlag, DynamicGroundingFlag, PreprocessingFlag, ForgetThreshold, DynamicGroundingThreshold, ClockTick, SDEBatch, StreamRate, AllenMem) :-
	% Set window and step size
	set_parameter(ParameterList, window_size, App, WindowSize),
	set_parameter(ParameterList, step, App, Step),
	% Start and end times of reasoning
	set_parameter(ParameterList, start_time, App, StartReasoningTime),
	set_parameter(ParameterList, end_time, App, EndReasoningTime),
	% Set temporal distance between two consecutive time-points
	set_parameter(ParameterList, clock_tick, App, ClockTick),
	% The rate at which the input stream have been sped up (in 'fifo' mode)
	set_parameter(ParameterList, stream_rate, App, StreamRate),
        % Set output mode: regular file or named pipe.
	set_parameter(ParameterList, output_mode, App, OutputMode),
	% Set directory for writing logs and the recognised intervals
	set_parameter(ParameterList, results_directory, App, ResultsDir),
	% Set prolog files to be consulted
	set_parameter(ParameterList, event_description_files, App, PrologFiles),
	% Set mode of receiving streams of input events
	set_parameter(ParameterList, input_mode, App, InputMode),
	set_parameter(ParameterList, input_providers, App, InputMode, InputProviders),
	set_parameter(ParameterList, dynamic_grounding_flag, App, DynamicGroundingFlag),
	set_parameter(ParameterList, stream_order_flag, App, StreamOrderFlag),
	set_parameter(ParameterList, preprocessing_flag, App, PreprocessingFlag),
	set_parameter(ParameterList, forget_threshold, App, ForgetThreshold),
	set_parameter(ParameterList, dynamic_grounding_threshold, App, DynamicGroundingThreshold),
	set_parameter(ParameterList, sde_batch, App, SDEBatch),
        %set_parameter(ParameterList, goals, App, Goals),
	set_parameter(ParameterList, allen_memory, App, AllenMem),
	atom_concat(ResultsDir, '/log', ResultsDirLog),
	add_info(ResultsDirLog, '-log.txt', [Prolog, WindowSize, Step, InputMode, OutputMode], LogFile), % execution logs file
	add_info(ResultsDirLog, '-recognised-intervals.txt', [Prolog, WindowSize, Step, InputMode, OutputMode], ResultsFile). % recognised intervals file

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
