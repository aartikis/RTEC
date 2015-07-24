:- ['../../data/complete caviar/appearance.prolog'].
:- ['../../data/complete caviar/movementB.prolog'].
:- ['../../data/complete caviar/list-of-ids.prolog'].

:- ['../../CE patterns/compiled_caviar_CE_patterns.prolog'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Notes: 
% In this application, WM=Step, while the LastTime of the dataset is 1007000.
% TimesFile records the event recognition times, 
% while InputFile records the number of input events per window.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

continuousER(TimesFile, InputFile, WM, Step, LastTime) :-
  open(TimesFile, write, TimesStream),
  open(InputFile, write, InputStream),
  initialiseRecognition(ordered, preprocessing, 40),
  updateManySDE(0, WM), %retractOrientation,
  WMPlus1 is WM+1, 
  % the first event recognition time should not be counted
  % because there are no old input facts being retracted
  eventRecognition(WM, WMPlus1),
  CurrentTime is WM+Step,
  updateManySDE(WM, CurrentTime), 
  write('ER: '), write(CurrentTime), write(WM), nl, 
  statistics(cputime, [S1,T1]), 
  eventRecognition(CurrentTime, WM), 
  findall((F=V,L), (outputEntity(F=V),holdsFor(F=V,L)), CC),  
  statistics(cputime, [S2,T2]), T is T2-T1, S is S2-S1, %S=T2,
  write(TimesStream, S),
  NewCurrentTime is CurrentTime+Step,
  findall((A,B), happensAtIE(A,B), SDEList), 
  length(SDEList, SDEL),
  findall((A,B), holdsAtIE(A,B), InputList), 
  length(InputList, InputL),
  Input is SDEL+InputL,
  write(InputStream, Input),
  querying(TimesStream, InputStream, WM, Step, NewCurrentTime, LastTime, [S], WorstCase, [Input], InputSum),
  % calculate average query time
  sum_list(WorstCase, Sum),
  length(WorstCase, L),
  AvgTime is Sum/L,
  nl(TimesStream), write(TimesStream, AvgTime),
  % calculate max query time
  max_list(WorstCase, Max),
  nl(TimesStream), write(TimesStream, Max),
  % calculate avg input facts
  sum_list(InputSum, ISum),
  AvgInput is ISum/L,
  nl(InputStream), write(InputStream, AvgInput),
  close(TimesStream),
  close(InputStream), !.

querying(_TimesStream, _InputStream, _WM, _Step, CurrentTime, LastTime, WorstCase, WorstCase, InputSum, InputSum) :- 
  CurrentTime >= LastTime, !.

querying(TimesStream, InputStream, WM, Step, CurrentTime, LastTime, InitWorstCase, WorstCase, InitInput, InputSum) :- 
  OldCurrentTime is CurrentTime-Step,
  updateManySDE(OldCurrentTime, CurrentTime), 
  Diff is CurrentTime-WM,
  write('ER: '),write(CurrentTime),write(' '),write(WM),nl,
  statistics(cputime,[S1,T1]), 
  eventRecognition(CurrentTime, WM), 
  findall((F=V,L), (outputEntity(F=V),holdsFor(F=V,L)), CC),  
  statistics(cputime,[S2,T2]), 
  T is T2-T1, S is S2-S1, %S=T2,
  writeResult(S, TimesStream),
  NewCurrentTime is CurrentTime+Step,
  findall((A,B), happensAtIE(A,B), SDEList), 
  length(SDEList, SDEL),
  findall((A,B), holdsAtIE(A,B),InputList), 
  length(InputList, InputL),
  Input is SDEL+InputL,
  writeResult(Input, InputStream),
  querying(TimesStream, InputStream, WM, Step, NewCurrentTime, LastTime, [S|InitWorstCase], WorstCase, [Input|InitInput], InputSum).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I/O Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

writeResult(Time, Stream):-
  write(Stream,'+'), write(Stream,Time).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update SDE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

updateSDE(Start, End) :-
	findall(Start, updateSDE(movement, Start, End), _),
	findall(Start, updateSDE(appearance, Start, End), _).


updateManySDE(Start, End) :-
	Diff is End-Start,
	Diff =< 1000,
	!,
	updateSDE(Start, End).	

updateManySDE(Start, End) :-
	Diff is End-Start,
	Diff > 1000,
	NewStart is Start + 1000,
	updateSDE(Start, NewStart),
	updateManySDE(NewStart, End).

