:- ['../../../src/data loader/dataLoader.prolog'].
:- ['../tests/ctm/ctm_declarations.prolog'].

% performFullEL(['trxs_sef10.csv','trxs_sef.csv'],'times.txt','patterns.txt',2145918139760,3600000,3600000,2145924882586).
performFullEL(IEFileName, TimesFilename, ResultFilename, InitPoint, WM, Step, LastTime) :-
  InitWin is InitPoint + WM,
  openInputFiles(IEFileName,IEStreams,IEPositions),
  loadIEStreams(IEStreams, InitPoint, InitWin, IEPositions, IEPositions1),
  InitWinPlus1 is InitWin+1,
  write('ER: '),write(InitWin),write(' '),write(InitWinPlus1),nl, 
  %statistics(cputime,[S1,T1]), 
  statistics(runtime,[S1,T1]),
  %statistics(cputime,[S2,T2]), T is T2-T1, S is S2-S1, %S=T2,
  statistics(runtime,[S2,T2]), T is T2-T1, S is S2-S1, %S=T2,
  write(S), nl,
  CurrentTime is InitWin+Step,
  loadIEStreams(IEStreams, InitWin, CurrentTime, IEPositions1, NewPositions),
  Diff is CurrentTime-WM,
  querying(IEStreams, NewPositions, WM, Step, CurrentTime, LastTime, [S], WorstCase),
  closeInputFiles(IEStreams),
  % calculate average query time
  sum_list(WorstCase, Sum),
  length(WorstCase, L),
  AvgTime is Sum/L,
  nl, write(AvgTime), nl,
  % calculate max query time
  max_list(WorstCase, Max),
  nl, write(Max), nl,
  !.
  
querying(_IEStreams, _Positions, _WM, _Step, CurrentTime, LastTime, WorstCase, WorstCase) :- 
  CurrentTime > LastTime, 
  !.

querying(IEStreams, Positions, WM, Step, CurrentTime, LastTime, InitWorstCase, WorstCase) :-
  statistics(runtime,[S1,T1]),
  RemainingSteps is (LastTime-CurrentTime)/Step, 
  write('ER: '),write(CurrentTime),write(' '),write(WM),write(' Remaining steps: '),write(RemainingSteps),nl,
  %statistics(cputime,[S1,T1]), 
  %statistics(cputime,[S2,T2]), 
  statistics(runtime,[S2,T2]),
  T is T2-T1, S is S2-S1, %S=T2,
  write(S), nl,
  NewCurrentTime is CurrentTime+Step,
  statistics(runtime,[SL1,TL1]),
  loadIEStreams(IEStreams, CurrentTime, NewCurrentTime, Positions, NewPositions),
  statistics(runtime,[SL2,TL2]),
  TL is TL2-TL1, SL is SL2-SL1, %S=T2,
  write('Loading time: '),write(SL), nl,
  Diff is NewCurrentTime-WM,
  querying(IEStreams, NewPositions, WM, Step, NewCurrentTime, LastTime, [S|InitWorstCase], WorstCase).

  
%openInputFiles(IEFiles,Streams,Positions) :-
	
openInputFiles([File|[]],[Stream|[]],[Position|[]]) :-
	open(File,read,Stream),
	stream_property(Stream,position(Position)).

openInputFiles([File|MoreFiles],[Stream|MoreStreams],[Position|MorePositions]) :-
	open(File,read,Stream),
	stream_property(Stream,position(Position)),
	openInputFiles(MoreFiles,MoreStreams,MorePositions).
	
closeInputFiles([Stream|[]]) :-
	close(Stream).
	
closeInputFiles([Stream|MoreStreams]) :-
	close(Stream),
	closeInputFiles(MoreStreams).
