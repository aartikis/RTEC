
% handleApplication(+Prolog, +ApplicationName, -LogFile, -WM, -Step, -LastTime, -StreamOrderFlag, -PreprocessingFlag, -ClockTick)

% This is a predicate for setting the appropriate parameters for executing an application (see +ApplicationName),
% and consulting the relevant compiled event description, declarations and dataset. 
% Execution parameters:
% LogFile: the file recording the statistics of execution, WM: working memory size, Step: step size,
% LastTime: the last time-point of the dataset, StreamOrderFlag: 'ordered' or 'unordered' dataset, 
% PreprocessingFlag: 'preprocessing' or 'nopreprocessing', 
% ClockTick: temporal distance between two consecutive time-points, SDEBatch: the input narrative size asserted in a single batch

handleApplication(Prolog, toy, LogFile, WM, Step, LastTime, StreamOrderFlag, PreprocessingFlag, ClockTick, SDEBatch) :- 
	(Prolog=yap, 
	 LogFile = '../examples/toy/results/log-YAP-toy.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/toy/results/log-SWI-toy.txt'
	),
	WM = 30,
	Step = 30, 
	LastTime = 30,
	StreamOrderFlag = ordered,
	PreprocessingFlag = nopreprocessing, 
	ClockTick = 1,
	SDEBatch = 10,
	consult('../examples/toy/resources/toy_rules_compiled.prolog'),
	consult('../examples/toy/resources/toy_declarations.prolog'),
	consult('../examples/toy/resources/toy_data.prolog'),
	consult('../examples/toy/resources/toy_var_domain.prolog'), !.

handleApplication(Prolog, caviar, LogFile, WM, Step, LastTime, StreamOrderFlag, PreprocessingFlag, ClockTick, SDEBatch) :-
	(Prolog=yap,
	 LogFile = '../examples/caviar/results/log-YAP-caviar-100K-100K.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/caviar/results/log-SWI-caviar-100K-100K.txt'
	),
	WM = 100000,
	Step = 100000, 
	LastTime = 1007000,
	StreamOrderFlag = ordered,
	PreprocessingFlag = preprocessing, 
	ClockTick = 40,
	SDEBatch = 1000,
	%%%%%%%% LOAD THE APPLICATION-SPECIFIC PRE-PROCESSING MODULE %%%%%%%%
	consult('../examples/caviar/resources/pre-processing.prolog'),
	consult('../examples/caviar/resources/caviar_declarations.prolog'),
	consult('../examples/caviar/resources/compiled_caviar_patterns.prolog'),
	consult('../examples/caviar/resources/updateSDE-caviar.prolog'),
	consult('../examples/caviar/resources/appearance.prolog'),
	consult('../examples/caviar/resources/movementB.prolog'), 
	consult('../examples/caviar/resources/list-of-ids.prolog'), !.

handleApplication(Prolog, ctm, LogFile, WM, Step, LastTime, StreamOrderFlag, PreprocessingFlag, ClockTick, SDEBatch) :-
	(Prolog=yap,
	 LogFile = '../examples/ctm/results/log-YAP-ctm-10K-10K.txt'
	 ;
	 Prolog=swi,
	 LogFile = '../examples/ctm/results/log-SWI-ctm-10K-10K.txt'
	),
	WM = 10000,
	Step = 10000, 
	LastTime = 50000,
	StreamOrderFlag = unordered,
	PreprocessingFlag = nopreprocessing, 
	ClockTick = 1,
	SDEBatch = 1000,
	consult('../examples/ctm/resources/ctm_declarations.prolog'),
	consult('../examples/ctm/resources/compiled_ctm_patterns.prolog'),
	consult('../examples/ctm/resources/updateSDE-ctm.prolog'),
	consult('../examples/ctm/resources/load-ctm-data.prolog'),
	consult('../examples/ctm/resources/vehicles.prolog'), !.

handleApplication(Prolog, toyCLI, LogFile, WM, Step, LastTime, StreamOrderFlag, PreprocessingFlag, ClockTick, SDEBatch, ResultsPath) :- 
	atom_concat(ResultsPath, '/log-toyCLI', LogsPath),
	add_info(LogsPath, '.txt', [Prolog, WM, Step, LastTime], LogFile),
	StreamOrderFlag = ordered,
	PreprocessingFlag = nopreprocessing, 
	ClockTick = 1,
	SDEBatch = 10, !.

handleApplication(Prolog, caviarCLI, LogFile, WM, Step, LastTime, StreamOrderFlag, PreprocessingFlag, ClockTick, SDEBatch, ResultsPath) :-
	atom_concat(ResultsPath, '/log-caviarCLI', LogsPath),
	add_info(LogsPath, '.txt', [Prolog, WM, Step, LastTime], LogFile),
	StreamOrderFlag = ordered,
	PreprocessingFlag = preprocessing, 
	ClockTick = 40,
	SDEBatch = 1000, !.

handleApplication(Prolog, ctmCLI, LogFile, WM, Step, LastTime, StreamOrderFlag, PreprocessingFlag, ClockTick, SDEBatch, ResultsPath) :-
	atom_concat(ResultsPath, '/log-ctmCLI', LogsPath),
	add_info(LogsPath, '.txt', [Prolog, WM, Step, LastTime], LogFile),
	StreamOrderFlag = unordered,
	PreprocessingFlag = nopreprocessing, 
	ClockTick = 1,
	SDEBatch = 1000, !.

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