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

% write(+RecognitionTime, +LogFile)
writeResult(Time, LogFileStream):-
  	write(LogFileStream,'+'),
	write(LogFileStream,Time).

logWindowStats(LogFileStream, RecTimes, InputList, (OutputListOutFVpairs,OutputListOutLI,OutputListOutLD)):-
	list_stats(RecTimes,_,_,AvgTime,_,DevTime),
	nl(LogFileStream), nl(LogFileStream),
	write(LogFileStream, 'Recognition Time average (ms)		: '), 
	write(LogFileStream, AvgTime), nl(LogFileStream),
	write(LogFileStream, 'Recognition Time standard deviation (ms): '), 
	write(LogFileStream, DevTime), nl(LogFileStream),
	write('Recognition Time average (ms)			: '), 
	writeln(AvgTime),
	% calculate and record the max query time
	max_list(RecTimes, Max),
	write(LogFileStream, 'Recognition Time worst (ms)		: '), 
	write(LogFileStream, Max), nl(LogFileStream), nl(LogFileStream),
	% calculate and record the average number of input entities per window
	list_stats(InputList,_,_,AvgSDEs,_,DevSDEs),
	write(LogFileStream, 'Input Entities average			: '), 
	write(LogFileStream, AvgSDEs), nl(LogFileStream),
	write(LogFileStream, 'Input Entities standard deviation	: '), 
	write(LogFileStream, DevSDEs), nl(LogFileStream), nl(LogFileStream),
	write('Input Entities average				: '), 
	writeln(AvgSDEs),
	% calculate and record the average and standard deviation of output entity fluent-value pairs per window
	list_stats(OutputListOutFVpairs,_,_,AvgOutFVpairs,_,DevOutFVpairs),
	write(LogFileStream, 'Output Entities (average number of fluent-value pairs)	: '), 
	write(LogFileStream, AvgOutFVpairs), nl(LogFileStream),
	write(LogFileStream, 'Output Entities (standard deviation)	  		: '), 
	write(LogFileStream, DevOutFVpairs), nl(LogFileStream),
	write('Output Entities (average # fluent-value pairs)	: '), writeln(AvgOutFVpairs),
	% calculate and record the average and standard deviation of output entity intervals per window
	list_stats(OutputListOutLI,_,_,AvgOutL,_,DevOutL),
	write(LogFileStream, 'Output Entities (average number of intervals)	: '), 
	write(LogFileStream, AvgOutL), nl(LogFileStream),
	write(LogFileStream, 'Output Entities (standard deviation)	  	: '), 
	write(LogFileStream, DevOutL), nl(LogFileStream),
	write('Output Entities (average # intervals)		: '), 
	writeln(AvgOutL),
	% calculate and record the average and standard deviation of output entity duration per window
	list_stats(OutputListOutLD,_,_,AvgOutLD,_,DevOutLD),
	write(LogFileStream, 'Output Entities (average number of timepoints)	: '), 
	write(LogFileStream, AvgOutLD),nl(LogFileStream),
	write(LogFileStream, 'Output Entities (standard deviation)	 	: '), 
	write(LogFileStream, DevOutLD),nl(LogFileStream),
	write('Output Entities (average # timepoints)		: '), 
	writeln(AvgOutLD),
	writeln('=========================================================').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Log the recognised intervals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% printRecognitionsThread(+CEIntervalsStream, +CurrentTime, +WM)
printRecognitionsThread(CEIntervalsStream, CurrentTime, WM) :-
	StartTime is CurrentTime-WM,
	NextStartTime is StartTime+1,
	NextCurrentTime is CurrentTime+1,
	findall((F=V,L2), 
		(
		outputEntity(F=V),
                holdsFor(F=V,L),
                L\==[],
                intersect_all([L,[(NextStartTime,NextCurrentTime)]],L2)
                ), 
              CEIntervals),
	writeCEs(CEIntervalsStream, CEIntervals).

% printRecognitions(+CEIntervalsStream, +CurrentTime, +WM)
printRecognitions(CEIntervalsFile, CurrentTime, WM) :-
	open(CEIntervalsFile, append, CEIntervalsStream),
	StartTime is CurrentTime-WM,
	NextStartTime is StartTime+1,
	NextCurrentTime is CurrentTime+1,
	findall((F=V,L2), 
		(
		outputEntity(F=V),
                holdsFor(F=V,L),
                L\==[],
                intersect_all([L,[(NextStartTime,NextCurrentTime)]],L2)
                ), 
              CEIntervals),
	writeCEs(CEIntervalsStream, CEIntervals),
	close(CEIntervalsStream).

writeCEs(ResultStream, []) :-
	nl(ResultStream), !.
writeCEs(ResultStream, [(_CE,[])|OtherCCs]) :-
	writeCEs(ResultStream,OtherCCs).
writeCEs(ResultStream,[(F=V,L)|OtherCCs]) :-
	%(
		%\+ datasetType(ground_truth),
	DType = 'predictions',
		%;
		% in some cases the ground truth is computed by RTEC;
		% eg in the maritime application, we consider as ground truth the recognition on the raw dataset
		%datasetType(ground_truth),
		%DType = 'ground_truth'
	%),
	L \= [],
   	F =.. [FluentName|Args],
    	write(ResultStream,'recognitions('),
    	write(ResultStream,DType),
    	write(ResultStream,','),
    	write(ResultStream,FluentName),
    	write(ResultStream,','),
   	write(ResultStream,[Args,V]),
    	write(ResultStream,','),
    	write(ResultStream,L),
    	write(ResultStream,').'),
    	nl(ResultStream),
    	writeCEs(ResultStream,OtherCCs).

printBeforeER(QueryTimeMinusWM, VerifiedQueryTime):-
	write('Current Window                         	: ('), 
	write(QueryTimeMinusWM), write(', '), write(VerifiedQueryTime), writeln(']').

printAfterER(S, QueryTimeMinusWM, VerifiedQueryTime, OELI, OELT, InL, OutFVpairs, OutLI, OutLD):-
 	write('Recognition Time (ms)			: '), writeln(S),
 	% calculate and record the number of input entities
 	findall((Ev,EvT), (inputEntity(Ev),happensAtIE(Ev,EvT)), EvList), length(EvList,InL1),
 	findall((InF,InFT), (inputEntity(InF),holdsAtIE(InF,InFT)), InFList), length(InFList,InL2),
 	InL is InL1+InL2,
 	write('Input Entities				: '), writeln(InL),
 	% compute and record output entity statistics
 	findall(Interval, (outputEntity(F=V),holdsFor(F=V,L),member(Interval,L)), AllIntervals),
 	temporalDistance(TemporalDistance),
 	% fluents_duration(+OELI, +TemporalDistance, +QueryTimeMinusWM, +VerifiedQueryTime, -OELID)
 	fluents_duration(OELI, TemporalDistance, QueryTimeMinusWM, VerifiedQueryTime, OELID),
 	length(OELI, OutFVpairs),
 	length(OELT,OELTL),
 	length(AllIntervals,AllIntervalsL),
 	OutLI is AllIntervalsL+OELTL,
 	OutLD is OELID+OELTL,
 	write('Output Entities (# fluent-value pairs)	: '), writeln(OutFVpairs),
	write('Output Entities (# intervals)		: '), writeln(OutLI),
	write('Output Entities (# timepoints)		: '), writeln(OutLD),
	writeln('=========================================================').

%% multiline arguments to format may produce an error in some Prolog engines, e.g., YAP 7.3
printLogo:- 
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
	"), nl.

