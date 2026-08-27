:- dynamic logVariable/3.

% Enable/disable logs.
skipLogs:- fail.
%skipLogs.

% use the correct atom to measure execution time according to the Prolog implementation.
% cputime -> yap, runtime -> swi.
% handleProlog(-PrologCompiler, -StatisticsFlag) 
handleProlog(yap, cputime) :-
	current_prolog_flag(dialect, yap).
handleProlog(swi, runtime) :-
	current_prolog_flag(dialect, swi).

% This is used when the time measurement should override the skipLogs/0 flag.
getCPUtime(T, always):-
	current_prolog_flag(dialect, Prolog),
	handleProlog(Prolog, TimeOption),
	statistics(TimeOption, [T,_]).

% T=current cpu time.
% getCPUtime(-T)
getCPUtime(T):-
	(skipLogs, ! ;
	current_prolog_flag(dialect, Prolog),
	handleProlog(Prolog, TimeOption),
	statistics(TimeOption, [T,_])).

% update a global variable and commit the new value to the corresponding 'list' global variable.
% updateVariable(+VariableName, +Value)
updateVariable(VariableName, Value):-
  (skipLogs, ! ; 
  \+ logVariable(VariableName, _, _), !;
  nb_getval(VariableName, CurrValue), NewValue is CurrValue + Value, nb_setval(VariableName, NewValue),
  global_list(VariableName, ListName), nb_getval(ListName, CurrL), append(CurrL, [Value], NewList), nb_setval(ListName, NewList)).

% update a variable used to measure the execution time of a process of RTEC.
% updateTime(+VariableName, +Tbefore, +Tafter)
updateTime(VariableName, Tbefore, Tafter):-
	(skipLogs, !; 
	\+ logVariable(VariableName, _, _);
	T is Tafter-Tbefore, updateVariable(VariableName, T)).

% same as updateVariable, but without adding the new value to the 'list' global variable.
% perhaps the new value does not correspond to value of the variable for the current window. i.e. it is an intermediate result.
% updateVariableTemp(+VariableName, +Value)
updateVariableTemp(VariableName, Value):-
  (skipLogs, ! ;
  \+ logVariable(VariableName, _, _), !;
  nb_getval(VariableName, CurrValue), NewValue is CurrValue + Value, nb_setval(VariableName, NewValue)).

% update a time variable without committing its value to the 'list' global variable.
% updateTimeTemp(+VariableName, +Tbefore, +Tafter)
updateTimeTemp(VariableName, Tbefore, Tafter):-
 	(skipLogs, ! ;
 	\+ logVariable(VariableName, _, _), !;
	T is Tafter-Tbefore, updateVariableTemp(VariableName, T)).

% update the 'list' global variable of a variable which is being updated using updateVariableTemp/updateTimeTemp.
% commitVariable(+VariableName)
commitVariable(VariableName):-
	(skipLogs, !; 
	nb_getval(VariableName, CurrSum), global_list(VariableName, ListName), nb_getval(ListName, CurrL),
	sum_list(CurrL, SumUntilPrevWindow), 
	NewValueToRecord is CurrSum - SumUntilPrevWindow,
	append(CurrL, [NewValueToRecord], NewList), nb_setval(ListName, NewList)).

% commit all variable which have the argument CommitStepFlag.
% commitVariables(+CommitStepFlag)
commitVariables(CommitStepFlag):-
  (skipLogs; findall(_VariableName, (logVariable(VariableName, _VariableMessage, CommitStepFlag), commitVariable(VariableName)), _VarList)).

initGlobals:-
  (skipLogs, ! ; 
  nb_setval(index_counter, 0), % stores the next 'counter' value in the case of a fresh index for the internal database
  write('Initialising logs...'), nl,
  findall(_Var, (logVariable(Var, _Mess, _Flag), initVariable(Var)) , _VarList)).
  % Uncomment the following to write the reasoning time per fluent in logs.
  %findall(_SF, (simpleFluent(F=_V), functor(F, SF, _), atom_concat(SF, time, VariableName), \+logVariable(VariableName, _, _), atom_concat(SF, instances, VarInstName),
  				%atom_concat('Process time of ', SF, VariableMessage), atom_concat('Number of instances of ',SF, VarInstMessage),
 				%assert(logVariable(VariableName, VariableMessage, processEntityFlag)), assert(logVariable(VarInstName, VarInstMessage, processEntityFlag)), 
  			    %initVariable(VariableName), initVariable(VarInstName)), _SFList),
  %findall(_SDF, (sDFluent(SD=_SDV), functor(SD, SDF, _), atom_concat(SDF, time, VariableName), \+logVariable(VariableName, _, _), atom_concat(SDF, instances, VarInstName),
  				%atom_concat('Process time of ', SDF, VariableMessage), atom_concat('Number of instances of ',SDF, VarInstMessage),
 				%assert(logVariable(VariableName, VariableMessage, processEntityFlag)), assert(logVariable(VarInstName, VarInstMessage, processEntityFlag)), 
  			    %initVariable(VariableName), initVariable(VarInstName)), _SDFList)).
                %
                %
% The initial value of all variables is 0.
% Also, every variable is associated with a global 'list' which is initially empty.
% initVariable(+VariableName)
initVariable(VariableName):-
	(skipLogs, ! ; global_list(VariableName, ListName),
	nb_setval(VariableName, 0),
	nb_setval(ListName, [])).

% associate a global variable V with a 'list' global variable LV 
% which includes the values of V for each processed window.
% global_list(+VariableName, -ListName) 
global_list(VariableName, ListName):-
	atomic_concat(VariableName, '_list', ListName).

% writeGlobal(+LogFileStream, +VariableName, +VariableMessage)
writeGlobal(LogFileStream, VariableName, VariableMessage):-
	(skipLogs, ! ; global_list(VariableName, ListName),
	write(LogFileStream, VariableMessage), nb_getval(ListName, L), 
	write(LogFileStream, L), write(LogFileStream, ', with Sum: '), 
	nb_getval(VariableName, V), write(LogFileStream, V), write(LogFileStream, ', and Avg: '), 
	length(L, Len), (Len>0, Avg is div(V,Len), write(LogFileStream, Avg); Len=0), nl(LogFileStream)).

% All variables are written in logs.
% Check if log messages are written in the correct order.
% writeAllGlobals(+LogFileStream)
writeAllGlobals(LogFileStream):-
	(skipLogs, ! ; 
  findall(_VariableName, (logVariable(VariableName, VariableMessage, _), writeGlobal(LogFileStream, VariableName, VariableMessage)), _VarList)).

% Insert a new log variable here.
% logVariable(VariableName, LogMessage, Flag)
%logVariable(forget_time, 'Forget times: ', notTemp).
%logVariable(forget_determine_method_time, 'Determine Forget Method times: ', notTemp).
%logVariable(forget_retractions_time, 'Forget Retractions times: ', notTemp).
%logVariable(forget_happens_time,'\tForget, retract happensAt times: ', notTemp).
%logVariable(forget_before, '\tNumber of happensAt before Forget: ', notTemp).
%logVariable(forget_after, '\tNumber of happensAt after Forget: ', notTemp).

%logVariable(dg_time, 'Dynamic Grounding times: ', notTemp).
%logVariable(dg_retract_time, '\tRetract times: ', notTemp).
%logVariable(dgold_number, '\tNumber of Old Terms: ', notTemp).
%logVariable(dginp_number, '\tNumber of Input Terms: ', notTemp).
%logVariable(dgrem_number, '\tNumber of Remaining Terms: ', notTemp).
%logVariable(dgadd_number, '\tNumber of New Asserted Terms: ', notTemp).
%logVariable(dgrm_number, '\tNumber of Old Retracted Terms: ', notTemp).
%logVariable(dg_remove_outdated_time, '\tRemove outdated times: ', notTemp).
%logVariable(dg_outdated_sf_number, '\tNumber of Outdated Simple Fluents: ', notTemp).
%logVariable(dg_all_sf_number, '\tNumber of All Simple Fluents before retracts: ', notTemp).

%logVariable(process_time, 'Process Entity times: ', notTemp).
%logVariable(process_simple_fluent_time, '\tProcess Simple Fluents times: ', processEntityFlag).
%logVariable(processed_simple_fluents, '\tNumber of Processed Simple Fluents: ', processEntityFlag).
%logVariable(find_FPL_time, '\t\tFind Simple Fluent Lists times: ', processEntityFlag).
%logVariable(fetch_FPL_time, '\t\t\tFetch Simple Fluent Lists times: ', processEntityFlag).
%logVariable(retract_FPL_time, '\t\t\tRetract Simple Fluent Lists times: ', processEntityFlag).
%logVariable(retract_FPL_number, '\t\t\tNumber of retract for Simple Fluent Lists: ', processEntityFlag).
%logVariable(amalgamate_FPL_time, '\t\t\tAmalgamate Simple Fluent Lists times: ', processEntityFlag).
%logVariable(starting_point_time, '\t\tCompute Starting Points times: ', processEntityFlag).
%logVariable(starting_point_number, '\t\tNumber of Computed Starting Points: ', processEntityFlag).
%logVariable(store_starting_point_time, '\t\tStore Starting Points times: ', processEntityFlag).
%logVariable(holdsFor_simple_fluent_time, '\t\tholdsFor Simple Fluent times: ', processEntityFlag).
%logVariable(ending_point_time, '\t\t\tCompute Ending Points times: ', processEntityFlag).
%logVariable(ending_point_number, '\t\t\tNumber of Computed Ending Points: ', processEntityFlag).
%logVariable(make_intervals_time, '\t\t\tMake Intervals times: ', processEntityFlag).
%logVariable(interval_number, '\t\t\tNumber of Intervals: ', processEntityFlag).
%logVariable(compute_FPL_time, '\t\tCompute and Update Simple Fluent Lists times: ', processEntityFlag).

%logVariable(computed_initiations_extensible, 'Extensible Deadlines: Number of computed initiatedAt rules: ', processEntityFlag).

%logVariable(computed_initiations_non_extensible, 'Non-Extensible Deadlines: Number of computed initiatedAt rules: ', processEntityFlag).

logVariable(process_sdfluent_time, '\tProcess SD Fluents times: ', processEntityFlag).
logVariable(sdfluent_interval_no, '\t\tSD Fluent number of Intervals: ', processEntityFlag).
logVariable(process_translatable_simple_fluent_time, '\tProcess Translatable Simple Fluents times: ', processEntityFlag).
logVariable(translatable_simple_fluent_interval_no, '\t\tTranslatable Simple Fluent number of Intervals: ', processEntityFlag).
logVariable(process_non_translatable_simple_fluent_time, '\tProcess Non Translatable Simple Fluents times: ', processEntityFlag).
logVariable(non_translatable_simple_fluent_interval_no, '\t\tNon Translatable Simple Fluent number of Intervals: ', processEntityFlag).
%logVariable(process_output_event_time, '\tProcess Output Events times: ', processEntityFlag).
%logVariable(process_deadline_initiations, '\tCompute deadline initiations times: ', processEntityFlag).
%logVariable(deadline_initiation_instances, '\tNumber of Deadline initiations: ', processEntityFlag).

%logVariable(deadlines_time, 'Deadlines times: ', notTemp).
%logVariable(user_time, 'User Queries times: ', notTemp).
%logVariable(happensAtOE, '\tNumber of holdsForOE: ', notTemp).
%logVariable(holdsForOE, '\tNumber of happensAtOE: ', notTemp).
%logVariable(open_intervals, '\tNumber of open intervals: ', notTemp).

%logVariable(number_of_contract_init_evaluations, 'Number of Contract Evaluations: ', processEntityFlag).
%logVariable(number_of_contract_init_calls, 'Number of Calls: ', processEntityFlag).
%logVariable(start_cyclic_time, 'Start Cyclic Time: ', processEntityFlag).
%logVariable(end_cyclic_time, 'End Cyclic Time: ', processEntityFlag).
%logVariable(start_cyclic_instances, 'Start Cyclic Instances: ', processEntityFlag).
%logVariable(end_cyclic_instances, 'End Cyclic Instances: ', processEntityFlag).

printStatistics:-
	%statistics(atoms, [NumberOfAtoms, SpaceUsedByAtoms]), 
	%write('Number of Atoms: '), write(NumberOfAtoms), nl,
	%write('Space Used By Atoms: '), write(SpaceUsedByAtoms), nl, nl,
	statistics(garbage_collection, [NumberOfGC, TotalGlobalRecovered, TotalTimeGC]),
	write('Number of Garbage Collections: '), write(NumberOfGC), nl,
	write('Total Global Recovered: '), write(TotalGlobalRecovered), nl,
	write('Total Time Spent in Garbage Collections: '), write(TotalTimeGC), nl, nl,
	statistics(global_stack, [GlobalStackUsed, ExecutionStackFree]),
	write('Global Stack Used: '), write(GlobalStackUsed), nl,
	write('Execution Stack Free: '), write(ExecutionStackFree), nl, nl,
	statistics(local_stack, [LocalStackUsed, _ExecutionStackFree2]),
	write('Local Stack Used: '), write(LocalStackUsed), nl, nl.
	%write('Execution Stack Free: '), write(ExecutionStackFree2), nl, nl.

printLocalStackInfo:-
	%deterministic(Det), write('Det: '), write(Det), nl,
	prolog_current_frame(F), write(F), nl,
	%prolog_frame_attribute(F, alternative, Alt), write('Alternative: '), write(Alt), nl,
	prolog_frame_attribute(F, goal, Goal), write('Goal: '), write(Goal), nl,
	prolog_frame_attribute(F, level, Level), write('Level: '), write(Level), nl, nl,
	localStackPrintAllAncestors(F).

localStackPrintAllAncestors(F):-
	prolog_frame_attribute(F, parent, Parent), !, write('Parent: '), write(Parent), nl, 
	prolog_frame_attribute(Parent, goal, Goal), write('Goal: '), write(Goal), nl,
	prolog_frame_attribute(Parent, level, Level), write('Level: '), write(Level), nl, nl,
	localStackPrintAllAncestors(Parent).

localStackPrintAllAncestors(_).	
