
:- ['handleApplication.prolog'].

%%%%%% RUN YAP: yap -s 0 -h 0 -t 0 -l continuousQueries.prolog
%%%%%% RUN SWI: swipl -L0 -G0 -T0 -l continuousQueries.prolog


% continuousER(+PrologCompiler, +ApplicationName)

% eg: continuousER(yap, toy).
% eg: continuousER(swi, toy).

% eg: continuousER(yap, caviar).
% eg: continuousER(swi, caviar).

% eg: continuousER(yap, ctm).
% eg: continuousER(swi, ctm).

continuousER(Prolog, App) :-
  % load RTEC according to the requested Prolog compiler
  % also return the correct statistics flag ('cputime' for YAP or 'runtime' for SWI)
  handleProlog(Prolog, StatisticsFlag),
  % load the requested event description, declarations, data; 
  % return the parameters of the application: WM, Step, LastTime of the dataset, 
  % StreamOrderFlag (ordered or unordered), 
  % PreprocessingFlag (preprocessing or nopreprocessing), 
  % ClockTick: temporal distance between two consecutive time-points
  % SDEBatch: the input narrative size asserted in a single batch
  handleApplication(Prolog, App, LogFile, WM, Step, LastTime, StreamOrderFlag, PreprocessingFlag, ClockTick, SDEBatch),
  format("                                                                 
8 888888888o. 8888888 8888888888 8 8888888888       ,o888888o.    
8 8888    `88.      8 8888       8 8888            8888     `88.  
8 8888     `88      8 8888       8 8888         ,8 8888       `8. 
8 8888     ,88      8 8888       8 8888         88 8888           
8 8888.   ,88'      8 8888       8 888888888888 88 8888           
8 888888888P'       8 8888       8 8888         88 8888           
8 8888`8b           8 8888       8 8888         88 8888           
8 8888 `8b.         8 8888       8 8888         `8 8888       .8' 
8 8888   `8b.       8 8888       8 8888            8888     ,88'  
8 8888     `88.     8 8888       8 888888888888     `8888888P'   
  "),
  open(LogFile, write, LogFileS),
  % initialise RTEC
  initialiseRecognition(StreamOrderFlag, PreprocessingFlag, ClockTick),
  % load the SDE of the current window
  updateManySDE(0, WM, SDEBatch),
  WMPlus1 is WM+1, 
  nl, write('Current Window				: (-1, '), write(WM), writeln(']'), 
  %%%%%%%%% compute the recognition time of the current window
  statistics(StatisticsFlag, [S1,_T1]), 
  eventRecognition(WM, WMPlus1),
  findall((F=V,L), (outputEntity(F=V),holdsFor(F=V,L),L\=[]), OELI), 
  findall((EE,TT), (outputEntity(EE),happensAt(EE,TT)), OELT),
  statistics(StatisticsFlag,[S2,_T2]), 
  %%%%%%%%% compute the recognition time of the current window
  S is S2-S1, %S=T2,
  write(LogFileS, S),
  write('Recognition Time (ms)			: '), writeln(S),
  % calculate and record the number of input entities
  findall((Ev,EvT), (inputEntity(Ev),happensAtIE(Ev,EvT)), EvList), length(EvList,InL1),
  findall((InF,InFT), (inputEntity(InF),holdsAtIE(InF,InFT)), InFList), length(InFList,InL2),
  InL is InL1+InL2,
  write('Input Entities				: '), writeln(InL), 
  % compute and record output entity statistics
  findall(Interval, (outputEntity(F=V),holdsFor(F=V,L),member(Interval,L)), AllIntervals),
  temporalDistance(TemporalDistance),
  fluents_duration(OELI, TemporalDistance, -1, WM, OELID),
  length(OELI, OutFVpairs),
  length(OELT, OELTL),
  length(AllIntervals, AllIntervalsL),
  OutLI is AllIntervalsL+OELTL,
  OutLD is OELID+OELTL,
  write('Output Entities (# fluent-value pairs)	: '),writeln(OutFVpairs),
  write('Output Entities (# intervals)		: '),writeln(OutLI),
  write('Output Entities (# timepoints)		: '),writeln(OutLD),
  writeln('========================================================='),
  % move to the next query-time
  CurrentTime is WM+Step,
  updateManySDE(WM, CurrentTime, SDEBatch),
  querying(StatisticsFlag, LogFileS, WM, Step, CurrentTime, LastTime, [S], RecTimes, [InL], InputList, ([OutFVpairs],[OutLI],[OutLD]), (OutputListOutFVpairs,OutputListOutLI,OutputListOutLD), SDEBatch),
  % calculate and record the recognition time statistics
  list_stats(RecTimes,_,_,AvgTime,_,DevTime),
  nl(LogFileS), nl(LogFileS),
  write(LogFileS, 'Recognition Time average (ms)		: '), write(LogFileS, AvgTime), nl(LogFileS),
  write(LogFileS, 'Recognition Time standard deviation (ms): '), write(LogFileS, DevTime), nl(LogFileS),
  write('Recognition Time average (ms)			: '), writeln(AvgTime),
  % calculate and record the max query time
  max_list(RecTimes, Max),
  write(LogFileS, 'Recognition Time worst (ms)		: '), write(LogFileS, Max), nl(LogFileS), nl(LogFileS),
  % calculate and record the average number of input entities per window
  list_stats(InputList,_,_,AvgSDEs,_,DevSDEs),
  write(LogFileS, 'Input Entities average			: '), write(LogFileS, AvgSDEs), nl(LogFileS),
  write(LogFileS, 'Input Entities standard deviation	: '), write(LogFileS, DevSDEs), nl(LogFileS), nl(LogFileS),
  write('Input Entities average				: '), writeln(AvgSDEs),
  % calculate and record the average and standard deviation of output entity fluent-value pairs per window
  list_stats(OutputListOutFVpairs,_,_,AvgOutFVpairs,_,DevOutFVpairs),
  write(LogFileS, 'Output Entities (average number of fluent-value pairs)	: '), write(LogFileS, AvgOutFVpairs), nl(LogFileS),
  write(LogFileS, 'Output Entities (standard deviation)	  		: '), write(LogFileS, DevOutFVpairs), nl(LogFileS),
  write('Output Entities (average # fluent-value pairs)	: '), writeln(AvgOutFVpairs),
  % calculate and record the average and standard deviation of output entity intervals per window
  list_stats(OutputListOutLI,_,_,AvgOutL,_,DevOutL),
  write(LogFileS, 'Output Entities (average number of intervals)	: '), write(LogFileS, AvgOutL), nl(LogFileS),
  write(LogFileS, 'Output Entities (standard deviation)	  	: '), write(LogFileS, DevOutL), nl(LogFileS),
  write('Output Entities (average # intervals)		: '), writeln(AvgOutL),
  % calculate and record the average and standard deviation of output entity duration per window
  list_stats(OutputListOutLD,_,_,AvgOutLD,_,DevOutLD),
  write(LogFileS, 'Output Entities (average number of timepoints)	: '), write(LogFileS, AvgOutLD),nl(LogFileS),
  write(LogFileS, 'Output Entities (standard deviation)	 	: '), write(LogFileS, DevOutLD),nl(LogFileS),
  write('Output Entities (average # timepoints)		: '), writeln(AvgOutLD),
  writeln('========================================================='),
  close(LogFileS), !.

querying(_StatisticsFlag, _LogFileS, _WM, _Step, CurrentTime, LastTime, RecTimes, RecTimes, InputList, InputList, OutputList, OutputList, _SDEBatch) :-
  CurrentTime > LastTime, !.

querying(StatisticsFlag, LogFileS, WM, Step, CurrentTime, LastTime, InitRecTime, RecTimes, InitInput, InputList, (InitOutputOutFVpairs,InitOutputOutLI,InitOutputOutLD), OutputList, SDEBatch) :-
  CurrentTimeMinusWM is CurrentTime-WM,
  write('Current Window                         	: ('), write(CurrentTimeMinusWM), write(', '), write(CurrentTime), writeln(']'),
  %%%%%%%%% compute the recognition time of the current window
  statistics(StatisticsFlag,[S1,_T1]),
  eventRecognition(CurrentTime, WM),
  findall((F=V,L), (outputEntity(F=V),holdsFor(F=V,L),L\=[]), OELI),
  findall((EE,TT), (outputEntity(EE),happensAt(EE,TT)), OELT),
  statistics(StatisticsFlag,[S2,_T2]),
  %%%%%%%%% compute the recognition time of the current window
  S is S2-S1, %S=T2,
  writeResult(S, LogFileS),
  write('Recognition Time (ms)			: '), writeln(S),
  % calculate and record the number of input entities
  findall((Ev,EvT), (inputEntity(Ev),happensAtIE(Ev,EvT)), EvList), length(EvList,InL1),
  findall((InF,InFT), (inputEntity(InF),holdsAtIE(InF,InFT)), InFList), length(InFList,InL2),
  InL is InL1+InL2,
  write('Input Entities				: '), writeln(InL),
  % compute and record output entity statistics
  findall(Interval, (outputEntity(F=V),holdsFor(F=V,L),member(Interval,L)), AllIntervals),
  temporalDistance(TemporalDistance),
  fluents_duration(OELI, TemporalDistance, CurrentTimeMinusWM, CurrentTime, OELID),
  length(OELI, OutFVpairs),
  length(OELT,OELTL),
  length(AllIntervals,AllIntervalsL),
  OutLI is AllIntervalsL+OELTL,
  OutLD is OELID+OELTL,
  write('Output Entities (# fluent-value pairs)	: '),writeln(OutFVpairs),
  write('Output Entities (# intervals)		: '), writeln(OutLI),
  write('Output Entities (# timepoints)		: '), writeln(OutLD),
  writeln('========================================================='),
  % move to the next query-time
  NewCurrentTime is CurrentTime+Step,
  updateManySDE(CurrentTime, NewCurrentTime, SDEBatch),
  querying(StatisticsFlag, LogFileS, WM, Step, NewCurrentTime, LastTime, [S|InitRecTime], RecTimes, [InL|InitInput], InputList, ([OutFVpairs|InitOutputOutFVpairs],[OutLI|InitOutputOutLI],[OutLD|InitOutputOutLD]), OutputList, SDEBatch).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% handleProlog(+PrologCompiler, -StatisticsFlag) 
handleProlog(yap, cputime) :-
	consult('../src/RTEC.prolog').
% in case of SWI load the necessary Prolog declarations 
handleProlog(swi, runtime) :-
	!, consult('../src/RTEC-swi.prolog').

% write(+RecognitionTime, +LogFile)
writeResult(Time, LogFileS):-
  	write(LogFileS,'+'),
	write(LogFileS,Time).

%Input   :  List L of numbers
%returns :  Length of L (Len)
%           Sum of L (Sum) 
%           Mean (Avg), Variance (Var) and Standard Deviations of L elements
list_stats(L,Len,Sum,Avg,Var,Dev):-
	sum_list(L,Sum),
	length(L,Len),
	Avg is Sum/Len,
	list_var(L,Avg,Var1),
	Var is Var1/Len,
	Dev is sqrt(Var).

%Input   :  List L and List Mean (Avg)
%Returns :  X where X = Variance of L * Length of L
list_var([],_,0).
list_var([El|Other],Avg,Var):-
	list_var(Other,Avg,VarIn),
	Var is (VarIn + ((El-Avg)*(El-Avg))).

%Input   :  List L of pairs (F=V,I)
%           TemporalDistance of timepoints,
%           S,E where S and E are the values of the intersection interval (S,E)
%Returns :  Total Duration of intervals
fluents_duration([],_,_,_,0).
fluents_duration([(_=_,Li)|OtherFluents],TemporalDistance,S,E,Duration):-
	fluents_duration(OtherFluents,TemporalDistance,S,E,DurationIn),
	intersect_all([Li,[(S,E)]],L),
	interval_list_duration(L,CurDur),
	CurrentDuration is CurDur/TemporalDistance,
	Duration is DurationIn + CurrentDuration.

%Input   : Interval List
%Returns : Duration of intervals without taking into consideration TemporalDistance
interval_list_duration([],0).
interval_list_duration([(S,E)|L],T) :- 
	interval_list_duration(L,S1),
	D is E-S,
	T is S1+D.

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assert narrative (SDEs)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% updateManySDE(+Start, +End, +SDEBatch)

% assert SDE from +Start to +End using batches of +SDEBatch size
% updateSDE, as opposed to updateManySDE, is defined in an application-specific manner

updateManySDE(Start, End, SDEBatch) :-
	Diff is End-Start,
	Diff =< SDEBatch,
	%!,
	updateSDE(Start, End), !.	

updateManySDE(Start, End, SDEBatch) :-
	Diff is End-Start,
	Diff > SDEBatch,
	NewStart is Start+SDEBatch,
	updateSDE(Start, NewStart), !,
	updateManySDE(NewStart, End, SDEBatch).

updateManySDE(_, _, _).
