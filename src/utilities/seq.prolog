/*
 
  Sequencing for RTEC.
  Author: Manolis Pitsikalis
  
*/


%!  seq(+Ili:list, +Ir:list, -I:list) is det.
%
%   Given two (possibly empty) maximal interval lists, Il and Ir,
%   seq/3 returns a possibly empty list I, containing a list of
%   maximal intervals corresponding to sequence periods. seq/3 is
%   single scan.
seq([], _, []):-!.
seq(_, [], []):-!.

seq([(LTs, LTe)|RemIntsL], [(RTs, RTe)|RemIntsR], [(SLTs, RTe)|I]):-
    LTe < RTs,!,
    skip_left_intervals([(LTs, LTe)|RemIntsL], RTs, UpRemIntsL, SLTs),
    seq(UpRemIntsL, RemIntsR, I).

% LTe greater than RTs, therefore skip interval from right
seq([(LTs, LTe)|RemIntsL], [(_RTs, _RTe)|RemIntsR], I):-
    % LTe >= RTs, % sanity
    seq([(LTs, LTe)|RemIntsL], RemIntsR, I).

% no more intervals to skip return the start of the last one
skip_left_intervals([(LTs, _)|[]], _RTs, [], LTs):-!.

% no more intervals can be skipped, i.e., the next interval is
% not before RTs
skip_left_intervals([(LTs, _)|RemIntsL], RTs, RemIntsL, LTs):-
    RemIntsL = [(_, LTe2)|_],
    LTe2 >= RTs,!.

% next interval is also before RTs, therefore current can be skipped 
skip_left_intervals([(_, _)|RemIntsL], RTs, UpRemIntsL, SLTs):-
    % RemIntsL = [(_, _LTe2)|_],
    % LTe2 < RTs, % sanity
    skip_left_intervals(RemIntsL, RTs, UpRemIntsL, SLTs).



%used only during RCT computation
seq_rct([(LTs, LTe)|RemIntsL], [(RTs, RTe)|_RemIntsR], (SLTs,RTe)):-
    LTe < RTs,!,
    skip_left_intervals([(LTs, LTe)|RemIntsL], RTs, _UpRemIntsL, SLTs).

% LTe greater than RTs, therefore skip interval from right
seq_rct([(LTs, LTe)|RemIntsL], [(_RTs, _RTe)|RemIntsR], (TsA, TeB)):-
    % LTe >= RTs, % sanity
    seq_rct([(LTs, LTe)|RemIntsL], RemIntsR, (TsA, TeB)).


