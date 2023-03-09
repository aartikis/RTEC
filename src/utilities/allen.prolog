/******************************************************************************************************
 *

*************************************** Allen Relations ***********************************************
The predicate allen/5 allows for Allen relations in the definitions of statically determined fluents.
*******************************************************************************************************
Maintained by: Periklis Mantenoglou
************************************ Example & Motivation *********************************************

Suppose that happy(P) is a statically determined fluent which is defined as follow: 
``Person P is happy when playing darts while being at the pub''.

playing_darts(P) and at_location(P) are simple fluents, and RTEC has computed that
holdsFor(playing_darts(chris)=true, Id) and holdsFor(at_location(chris)=pub, Ip), i.e., 
a person named Chris is playing darts and is at the pub during maximal intervals in lists Id and Ip, respectively.

According to the specification of happy(P), RTEC should deduce that Chris is happy 
during the maximal intervals of playing_darts(chris)=true, i.e., those in Id, which are subintervals of 
some interval of at_location(chris)=pub, i.e., some interval in Ip.

This specification can be expressed using interval relation ``during'' with the following rule: 
holdsFor(happy(P)=true, I):-
	holdsFor(playing_darts(P)=true, Id),
	holdsFor(at_location(P)=pub, Ip),
	allen(during, Id, Ip, source, true, I).

List I is the list of maximal intervals computed as the intersection of all intervals id and ip in lists Id and Ip, 
such that id takes place `during' ip, that is: 

id       ------------------
ip    ---------------------------

The signature of an interval relation, e.g., `during', is the following:
	rel(+InputList1, +InputList2, +ResultType, -BoolResult, -OutputList)
InputList1, InputList2 and OutputList are lists of maximal intervals.
ResultType specifies the operation applied to the sublists of the input lists including all intervals
		   satisfying the requested relation.
The possible values of ResultType are `lhs', `rhs', `union', `intersection', `relative_complement_inverse'
BoolResult is `true' if there is at least one pair of intervals from the input lists satisfying the requested relation.
			  `false' otherwise.
rel is either `before', `meets', `starts', `finishes', `during', `overlaps' or `equal'.
Note: ``Inverse relations, such as `during_inverse', are NOT defined.
		 The user may use an inverse relation by swapping the positions of the input lists when using a stardard relation.

It is not possible to express such patterns with the previously supported interval manipulation operations of RTEC, which 
are union_all, intersect_all, and relative_complement_all, without any (expensive) post processing techniques. 
For example, in order to compute `during' with intersect_all, we could first compute intersect_all([Id, Ip], Ii),
and then find all intervals in list Ii which are match exactly some interval in list Id and whose endpoints are not equal to 
the corresponding endpoint of any interval in list Ip. The latter operation would require the reprocessing of all three lists.

The addition of interval relations in RTEC leads to more succinct and intuitive patterns, while supporting additional expressivity
without compromising complexity.

Notes: 
- The algorithm assumes that both input lists are *temporally sorted* contain *maximal intervals*.
	Since maximal intervals are non-overlapping, sorting in terms of either starting or ending point, yield the same list.	
- All intervals are *right-open*, i.e., if I=(S,E), I includes the time-points {S, S+1, ..., E-1}
													S is the starting point of I and E-1 is its ending point.

********************************* Technical Notes ****************************************************

The algorithm leverages the fact that the input lists are sorted. The satisfaction of an interval relation between two intervals 
implies addition information regarding the relations satisfied with the remaining intervals of the rhs list. 

Suppose that L1 and L2 are the two input lists and (S1, E1)\in L1, (S2, E2)\in L2. The following implications hold:

If (S1, E1) before (S2, E2), then (S1, E1) before (S2', E2'), where (S2', E2') > (S2, E2), i.e., (S2', E2') is after (S2, E2) in the temporally sorted list L2
		
If (S1, E1) meets (S2, E2), then (S1, E1) before (S2', E2') > (S2, E2)
		
If (S1, E1) starts (S2, E2), then (S1, E1) before (S2', E2') > (S2, E2)
		
If (S1, E1) finishes (S2, E2), then (S1, E1) before (S2', E2') > (S2, E2) % AND (S1', E1') > (S1, E1) is beforeInverse (S2, E2)
		
If (S1, E1) during (S2, E2), then (S1, E1) before (S2', E2') > (S2, E2)
		
If (S1, E1) overlaps (S2, E2), then (S1, E1) before (S2', E2') > (S2, E2)
		
If (S1, E1) equal (S2, E2), then (S1, E1) before (S2', E2') > (S2, E2) % AND (S1', E1') > (S1, E1) is beforeInverse (S2, E2)

The algorithm presented below minimises redundant computations by leveraging these implications.

*******************************************************************************************************/

% atomic_relation(+I1, +I2, +Rel).
% Checks if the given interval relation is satisfied between two given intervals. 
% <Rel>: "before", "meets", "starts", "finishes", "during", "overlaps", "equal".

atomic_relation((_S1, E1), (S2, _E2), before):-
	S2>=E1. %% Intervals are right-open.

%atomic_relation((_S1, E1), (S2, _E2), meets):-
%		E1=S2.
atomic_relation((S1, E1), (S2, _E2), meets):-
	\+ E1=inf,
	prevTimePoint(E1, E1Prev), %% Intervals are right-open. 
	\+ S1=E1Prev, % if I1 is a unit interval, the relation should be starts.
	E1Prev=S2.

atomic_relation((S1, E1), (S2, E2), starts):-
	S1=S2, E1<E2.

atomic_relation((S1, E1), (S2, E2), finishes):-
	S1>S2, E1=E2.

atomic_relation((S1, E1), (S2, E2), during):-
	S1>S2, E1<E2.

atomic_relation((S1, E1), (S2, E2), overlaps):-
	S1<S2, E1>S2, E1<E2.

atomic_relation((S1, E1), (S2, E2), equal):-
	S1=S2, E1=E2.

% source_interval_iteration(+Rel, +SourceInterval, +TargetInterval)
% Meaning: if this predicate succeeds, allen_relations moves over the next source interval.
source_interval_iteration(meets, (_ISStart, ISEnd), (_ITStart, ITEnd)):-
	ISEnd=<ITEnd.
source_interval_iteration(starts, (_ISStart, _ISEnd), (_ITStart, inf)):- !.
source_interval_iteration(starts, (ISStart, _ISEnd), (_ITStart, ITEnd)):-
	RealITEnd is ITEnd - 1, 
	ISStart=<RealITEnd.
source_interval_iteration(finishes, (_ISStart, _ISEnd), (_ITStart, inf)):- !.
source_interval_iteration(finishes, (ISStart, _ISEnd), (_ITStart, ITEnd)):-
	RealITEnd is ITEnd - 1, 
	ISStart=<RealITEnd.
source_interval_iteration(during, (_ISStart, _ISEnd), (_ITStart, inf)):- !.
source_interval_iteration(during, (ISStart, _ISEnd), (_ITStart, ITEnd)):-
	RealITEnd is ITEnd - 1, 
	ISStart=<RealITEnd.
source_interval_iteration(overlaps, (_ISStart, ISEnd), (_ITStart, ITEnd)):-
	ISEnd=<ITEnd.
source_interval_iteration(equal, (_ISStart, _ISEnd), (_ITStart, inf)):- !.
source_interval_iteration(equal, (ISStart, _ISEnd), (_ITStart, ITEnd)):-
	RealITEnd is ITEnd - 1, 
	ISStart=<RealITEnd.

% target_interval_iteration(+Rel, +SourceInterval, +TargetInterval)
% Meaning: if this predicate succeeds, allen_relations moves over the next target interval.
target_interval_iteration(meets, (_ISStart, inf), (_ITStart, _ITEnd)):- !.
target_interval_iteration(meets, (_ISStart, ISEnd), (ITStart, _ITEnd)):-
	RealISEnd is ISEnd - 1,
	RealISEnd>=ITStart.
target_interval_iteration(starts, (_ISStart, inf), (_ITStart, _ITEnd)):- !.
target_interval_iteration(starts, (_ISStart, ISEnd), (ITStart, _ITEnd)):-
	RealISEnd is ISEnd - 1,
	RealISEnd>=ITStart.
target_interval_iteration(finishes, (_ISStart, ISEnd), (_ITStart, ITEnd)):-
	ISEnd>=ITEnd.
target_interval_iteration(during, (_ISStart, ISEnd), (_ITStart, ITEnd)):-
	ISEnd>=ITEnd.
target_interval_iteration(overlaps, (_ISStart, inf), (_ITStart, _ITEnd)):- !.
target_interval_iteration(overlaps, (_ISStart, ISEnd), (ITStart, _ITEnd)):-
	RealISEnd is ISEnd - 1,
	RealISEnd>=ITStart.
target_interval_iteration(equal, (_ISStart, inf), (_ITStart, _ITEnd)):- !.
target_interval_iteration(equal, (_ISStart, ISEnd), (ITStart, _ITEnd)):-
	RealISEnd is ISEnd - 1,
	RealISEnd>=ITStart.

%allen_relation(+S, +T, +Rel, -Results)
% <Rel>: "before", "meets", "starts", "finishes", "during", "overlaps", "equal".
% Rel is never ``all'' in this case.
% Results have the following format:
% Results = [ [ IS1, Rel, TSatRelIS1] | RestTriples ]
%       TSatRelIS1 is the sublist of T containing all intervals IT such that rel(IS1, IT). 
allen_relations([], [], _, []):- !.
allen_relations([], [_|_], _, []).
allen_relations([_|_], [], _, []):- !. % cut may be needed to avoid choice points because of indexing on the first argument.

%% BEFORE %%
% before is satisfied.
allen_relations([IS | SRest], [IT | TRest], before, [[IS, [IT|TRest]] | RestResults ]):-
	atomic_relation(IS, IT, before), !,
	allen_relations(SRest, [IT|TRest], before, RestResults).

% f(is)<=f(it), so add TRest and iterate both pointers.	
allen_relations([(ISStart, ISEnd) | SRest], [(_ITStart, ITEnd) | TRest], before, [[(ISStart, ISEnd), TRest] | RestResults]):-
	% \+ atomic_relation(IS, IT, before),
	ISEnd=<ITEnd,
	\+TRest=[], !,
	allen_relations(SRest, TRest, before, RestResults).

% f(is)<=f(it) and TRest is empty, so just iterate both pointers.	
allen_relations([(_ISStart, ISEnd) | SRest], [(_ITStart, ITEnd) | TRest], before, Results):-
	% \+ atomic_relation(IS, IT, before),
	ISEnd=<ITEnd, !,
	% TRest=[],
	allen_relations(SRest, TRest, before, Results).

% else, iterate only t pointer
allen_relations([IS|SRest], [_|TRest], before, Results):-
	!,
	allen_relations([IS|SRest], TRest, before, Results).

%% REMAINING RELATIONS %%
% the relation is satisfied
allen_relations([IS|SRest], [IT|TRest], Rel, [[IS,[IT]] | RestResults]):-
	atomic_relation(IS, IT, Rel), !,
	move_to_next([IS|SRest], [IT|TRest], Rel, RestResults).

% the relation is not satisfied
allen_relations([IS|SRest], [IT|TRest], Rel, Results):-
	%\+ atomic_relation(IS, IT, Rel),
	move_to_next([IS|SRest], [IT|TRest], Rel, Results).

move_to_next([IS|RestS], [IT|RestT], Rel, Results):-
	source_interval_iteration(Rel, IS, IT),
	target_interval_iteration(Rel, IS, IT), !,
	allen_relations(RestS, RestT, Rel, Results).
		
move_to_next([IS|RestS], [IT|RestT], Rel, Results):-
	source_interval_iteration(Rel, IS, IT), !,
	% \+ target_interval_iteration(IS, IT, Rel), 
	allen_relations(RestS, [IT|RestT], Rel, Results).
		
move_to_next([IS|RestS], [IT|RestT], Rel, Results):-
	target_interval_iteration(Rel, IS, IT), !,
	% \+ source_interval_iteration(IS, IT, Rel), 
	allen_relations([IS|RestS], RestT, Rel, Results).

% incarnation of unroll_tuples for a simpler list format.
unroll_tuples_simple([], before, [], _, _):- !.
unroll_tuples_simple([], _Rel, [], _, []).
unroll_tuples_simple([[_IS, TargetIntervals]|Rest], Rel, CurrentLS, CurrentLT, FinalLT):-
	TargetIntervals=[], !, 
	unroll_tuples_simple(Rest, Rel, CurrentLS, CurrentLT, FinalLT).
	
unroll_tuples_simple([[IS, TargetIntervals]|Rest], before, [IS|RestLS], nil, TargetIntervals):-
	!,
	unroll_tuples_simple(Rest, before, RestLS, TargetIntervals, TargetIntervals).
	
unroll_tuples_simple([[IS, _TargetIntervals]|Rest], before, [IS|RestLS], CurrentLT, FinalLT):-
	!,
	unroll_tuples_simple(Rest, before, RestLS, CurrentLT, FinalLT).

unroll_tuples_simple([[IS, TargetIntervals]|Rest], Rel, [IS|RestLS], IT, CurrentLT):-
	\+ Rel=before,
	TargetIntervals=[IT], !,
	unroll_tuples_simple(Rest, Rel, RestLS, IT, CurrentLT). 

unroll_tuples_simple([[IS, TargetIntervals]|Rest], Rel, [IS|RestLS], _PrevIT, [IT|RestLT]):-
	\+ Rel=before,
	% rel is not before, so we have at most one interval in RHSs
	TargetIntervals=[IT], !, 
	unroll_tuples_simple(Rest, Rel, RestLS, IT, RestLT). 

unwind_tuples_simple(Tuples, Rel, L1, L2):-
	unroll_tuples_simple(Tuples, Rel, L1, nil, L2).

% allen(+F=V, +Index, +Rel, +SList, +TList, +OutputType, -IsItSatisfied, -OutputListOfIntervals)
% -  Retrieve the cached source intervals and append them before the source intervals of the current window.
% -  Compute all intervals pairs among lists SList and TList satisfying relation Rel.
% -  Check if there is at least one such pair of intervals. 
%    If so, IsItSatisfied=true, else, it is false.
% -  Unwind tuples into two lists of intervals containing, resp., all intervals of lists L1 and L2 
%    satisfying Rel in at least once, i.e., appearing in a least one tuple of list Tuples.
%    L1Sat and L2Sat are sorted lists of maximal intervals.
% -  Apply the requested interval operation, specified with OutputType, onto lists L1Sat and L2Sat
%	 The possible values of OutputType are:
%		lhs: return only the intervals in Srel
%		rhs: return only the intervals in Trel
%		union: return the union of the intervals in Srel and Trel
%		intersection: return the intersection of the intervals in Srel and Trel
%		relative_complement: return all subintervals of intervals in Srel which are not part of any interval of Trel
%		relative_complement_inverse: return all subintervals of intervals in Trel which are not part of any interval of Srel
% -  Cache 

allen(F=V, Index, Rel, SList0, TList0, OutputType, IsItSatisfied, OutputListOfIntervals):-
	retract(cachedIntervalsAllen(F=V, Index, CachedSourceSegment, CachedTargetSegment, CachedSourceIntervals)), !,
	(CachedSourceSegment\=null -> amalgamatePeriods([CachedSourceSegment], SList0, SList1); SList1=SList0),
	(CachedTargetSegment\=null -> amalgamatePeriods([CachedTargetSegment], TList0, TList); TList=TList0),
	(CachedSourceIntervals\=[] -> append(CachedSourceIntervals, SList1, SList); SList=SList1),
	compute_allen_construct(Rel, SList, TList, OutputType, IsItSatisfied, OutputListOfIntervals),
	windowing_allen(F=V, Index, SList, TList, Rel).

allen(F=V, Index, Rel, SList, TList, OutputType, IsItSatisfied, OutputListOfIntervals):-
	compute_allen_construct(Rel, SList, TList, OutputType, IsItSatisfied, OutputListOfIntervals),
	windowing_allen(F=V, Index, SList, TList, Rel).

compute_allen_construct(Rel, SList, TList, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen_relations(SList, TList, Rel, Tuples),
	check_nonempty(Tuples, IsItSatisfied),
	unwind_tuples_simple(Tuples, Rel, Srel, Trel),
	apply_return_type(OutputType, Srel, Trel, OutputListOfIntervals).
	
before(F=V, Index, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen(F=V, Index, before, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals).

meets(F=V, Index, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen(F=V, Index, meets, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals). 

starts(F=V, Index, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen(F=V, Index, starts, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals). 

finishes(F=V, Index, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen(F=V, Index, finishes, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals). 

during(F=V, Index, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen(F=V, Index, during, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals). 

overlaps(F=V, Index, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen(F=V, Index, overlaps, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals). 

equal(F=V, Index, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals):-
	allen(F=V, Index, equal, L1, L2, OutputType, IsItSatisfied, OutputListOfIntervals). 

/******* Wrapper Predicate Helpers ************/

% check_nonempty(+List, -Bool)
check_nonempty([], false).
check_nonempty([_|_], true).

% apply_return_type(+OutputType, +L1, +L2, -L)
apply_return_type(source, L1, _L2, L1).
apply_return_type(target, _L1, L2, L2).
apply_return_type(lhs, L1, _L2, L1).
apply_return_type(rhs, _L1, L2, L2).
apply_return_type(union, L1, L2, L):-
    union_all([L1, L2], L).
apply_return_type(intersection, L1, L2, L):-
    intersect_all([L1, L2], L).
apply_return_type(relative_complement, L1, L2, L):-
    relative_complement_all(L1, [L2], L).
apply_return_type(relative_complement_inverse, L1, L2, L):-
    relative_complement_all(L1, [L2], L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WINDOWING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% New windowing allen here
%
%

windowing_allen(F=V, Index, SList, TList, Rel):-
	retrieveParams(InitTime, Step, AllenMem), 
	allen_intervals_to_cache(SList, TList, Rel, InitTime, Step, AllenMem, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache),
	update_cache(F=V, Index, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache).

update_cache(_, _, null, null, []):- !.
update_cache(F=V, Index, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache):-
	assertz(cachedIntervalsAllen(F=V, Index, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache)).

allen_intervals_to_cache(SList, TList, Rel, InitTime, Step, Mem, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache):-
	NextWindowStart is InitTime+Step,
	getIntervalsBeforeTimepoint(SList, NextWindowStart, SNotInNextWindow),	
	getIntervalContainingTimepoint(SList, NextWindowStart, SIntStar),	
	getIntervalContainingTimepoint(TList, NextWindowStart, TIntStar),
	nextTimePoint(NextWindowStart, SegmentEnd),
	sintStarConditions(SIntStar, TIntStar, Rel, SegmentEnd, SourceSegmentToCache),
	MemoryStart is NextWindowStart - Mem, 
	tintStarConditions(TIntStar, SIntStar, SNotInNextWindow, Rel, SegmentEnd, MemoryStart, TargetSegmentToCache, SIntsToCache).

sintStarConditions(null, _, _, _, null):- !.
sintStarConditions((S,_), _, meets, SegmentEnd, (S,SegmentEnd)):- !.
sintStarConditions((S,_), _, overlaps, SegmentEnd, (S,SegmentEnd)):- !.
sintStarConditions((S,_), _, before, SegmentEnd, (S,SegmentEnd)):- !.
sintStarConditions((S,_), (S,_), starts, SegmentEnd, (S,SegmentEnd)):- !.
sintStarConditions((S,_), (S,_), equal, SegmentEnd, (S,SegmentEnd)):- !.
sintStarConditions((SSource,_), (STarget,_), finishes, SegmentEnd, (SSource,SegmentEnd)):-
	SSource>STarget, !.
sintStarConditions((SSource,_), (STarget,_), during, SegmentEnd, (SSource,SegmentEnd)):-
	SSource>STarget, !.
sintStarConditions(_, _, _, _, null).

tintStarConditions(null, _, SNotInNextWindow, before, _, MemoryStart, null, ListBefore):-
	getIntervalsEndingAfterTimepoint(SNotInNextWindow, MemoryStart, ListBefore), !.
tintStarConditions(null, _, _, _, _, _, null, []):- !.	
tintStarConditions((S,_), _, _, finishes, SegmentEnd, _, (S,SegmentEnd), []):- !.	
tintStarConditions((S,E), _, SNotInNextWindow, during, SegmentEnd, _, (S,SegmentEnd), ListDuring):- 
	findSourceDuring((S,E), SNotInNextWindow, ListDuring), !.	
tintStarConditions((S,E), _, SNotInNextWindow, meets, SegmentEnd, _, (S,SegmentEnd), [SSat]):- 
	relSatInSourceList((S,E), SNotInNextWindow, meets, SSat), !.
tintStarConditions((S,E), _, SNotInNextWindow, starts, SegmentEnd, _, (S,SegmentEnd), [SSat]):- 
	relSatInSourceList((S,E), SNotInNextWindow, starts, SSat), !.
tintStarConditions((S,E), _, SNotInNextWindow, overlaps, SegmentEnd, _, (S,SegmentEnd), [SSat]):- 
	relSatInSourceList((S,E), SNotInNextWindow, overlaps, SSat), !.
tintStarConditions((S,_), (S,_), _, starts, SegmentEnd, _, (S,SegmentEnd), []):- !.	
tintStarConditions((S,_), (S,_), _, equal, SegmentEnd, _, (S,SegmentEnd), []):- !.	
tintStarConditions((STarget,_), (SSource,_), _, overlaps, SegmentEnd, _, (STarget,SegmentEnd), []):-
	SSource<STarget, !.
tintStarConditions((S,E), _, SNotInNextWindow, before, SegmentEnd, MemoryStart, (S,SegmentEnd), ListBefore):-
	getIntervalsEndingAfterTimepoint(SNotInNextWindow, MemoryStart, ListBefore),
	relSatInSourceList((S,E), ListBefore, before, _), !.
tintStarConditions(_, _, SNotInNextWindow, before, _, MemoryStart, null, ListBefore):-
	getIntervalsEndingAfterTimepoint(SNotInNextWindow, MemoryStart, ListBefore), !.
tintStarConditions(_, _, _, _, _, _, null, []).

findSourceDuring(_, [], []).
findSourceDuring(TInt, [SInt|Rest], [SInt|RestSat]):-
	atomic_relation(SInt, TInt, during), !,
	findSourceDuring(TInt, Rest, RestSat).	
findSourceDuring(TInt, [_SInt|Rest], ListSat):-
	findSourceDuring(TInt, Rest, ListSat).	

relSatInSourceList(TInt, [SInt|_Rest], Rel, SInt):-
	atomic_relation(SInt,TInt, Rel), !.	
relSatInSourceList(TInt, [_SInt|Rest], Rel, SSat):-
	relSatInSourceList(TInt, Rest, Rel, SSat).

% getIntervalsEndingAfterTimepoint(+ListOfIntervals, +Timepoint, -ListOfIntervalsEndingAfterTp)
getIntervalsEndingAfterTimepoint([], _, []).
getIntervalsEndingAfterTimepoint([(_,E)|RestIntervals], Tp, Output):-
	E=<Tp, !,
	getIntervalsEndingAfterTimepoint(RestIntervals, Tp, Output).
getIntervalsEndingAfterTimepoint([(S,E)|RestIntervals], _Tp, [(S,E)|RestIntervals]).
	
% getIntervalsBeforeTimepoint(+ListOfIntervals, +Timepoint, -ListOfIntervalsBeforeTp)
getIntervalsBeforeTimepoint([], _, []).
getIntervalsBeforeTimepoint([(S,E)|RestIntervals], Tp, [(S,E)|RestBeforeIntervals]):-
	E=<Tp, !,
	getIntervalsBeforeTimepoint(RestIntervals, Tp, RestBeforeIntervals).
getIntervalsBeforeTimepoint([_|_], _, []).

% getIntervalContainingTimepoint(+ListOfIntervals, +Timepoint, -Interval)
% <Interval> is the only interval in <ListOfIntervals> containing <Timepoint>.
% If no such interval exists, then <Interval> is null.
getIntervalContainingTimepoint([], _, null).
getIntervalContainingTimepoint([(_S,E)|RestIntervals], Tp, Interval):-
	E<Tp, !,
	getIntervalContainingTimepoint(RestIntervals, Tp, Interval).
getIntervalContainingTimepoint([(S,E)|_], Tp, (S,E)):-
	E>Tp, S=<Tp, !.
getIntervalContainingTimepoint([_|_], _, null).

retrieveParams(InitTime, Step, AllenMem):-
	initTime(InitTime),
	step(Step),
	allenMemory(AllenMem).

%% The predicates below are only used for experiments.

% allen_window(+IntervalsInAllWindows, +CachedL1, +QueryTime, +WindowSize, +Step, +Rel, +MemorySize, -TuplesInAllWindows)
% IntervalsInAllWindows: A list containing one pair of lists of maximal intervals for each window. Form: [(L1OfFirstWindow, L2OfFirstWindow), ...]
% CachedL1: A list of maximal intervals for list L1 which was cached after the execution of the previous window.
% QueryTime: Current query time of RTEC.
% WindowSize: Window size parameter of RTEC.
% StepSize: Step size parameter of RTEC.
% Rel: one of allen's interval relations to be computed. 
% 	   choose `all' to compute all thirteen relations. 
% MemorySize: In case of `before' or `all', all intervals from the start of the stream must be cached to guarantee correctness.
%			  As a compomise with performance, we cache all intervals starting after NextWindowStart - MemorySize.
% TuplesInAllWindows: One list of computed tuples for each window. 
%	   see compute_allen_relations for the format of the computed tuples.

allen_window([], _, _, _, _, _, _, []):-!.
	
allen_window([(CurrL1,L2)|IntervalsOfRemainingWindows], CachedL1, QueryTime, WindowSize, Step, Rel, MemorySize, [TuplesInWindow|RestTuples]):-
	% Merge the cached intervals of the first list with the intervals of the current window 
	append_without_duplicates(CachedL1, CurrL1, L1),
	% Compute the all tuples of intervals in the current window.	
	allen_relations(L1, L2, Rel, TuplesInWindow), 
	% Compute query time of the next window and cache the required intervals.
	NextQueryTime is QueryTime + Step, 
	WindowStart is QueryTime - WindowSize,
	NextWindowStart is NextQueryTime - WindowSize,
	(L2=[], !, allen_window(IntervalsOfRemainingWindows, L1, NextQueryTime, WindowSize, Step, Rel, MemorySize, RestTuples); 
	earliest_interval_start(L2, WindowStart, NextWindowStart, EarliestL2Start),!,
	findIntervalsToCache(L1, EarliestL2Start, Rel, MemorySize, NextWindowStart, NextCachedL1),
	allen_window(IntervalsOfRemainingWindows, NextCachedL1, NextQueryTime, WindowSize, Step, Rel, MemorySize, RestTuples)).

% naive comparison --- delete afterwards %%%
window_full_memory([], _, _, _, _, _, _, []):-!.
	
window_full_memory([(CurrL1,CurrL2)|IntervalsOfRemainingWindows], CachedL1, CachedL2, QueryTime, WindowSize, Step, Rel, [TuplesInWindow|RestTuples]):-
	% Merge the cached intervals of the first list with the intervals of the current window 
	append_without_duplicates(CachedL1, CurrL1, L1),
	append_without_duplicates(CachedL2, CurrL2, L2),
	% Compute the all tuples of intervals in the current window.	
	compute_allen_relations(L1, L2, Rel, TuplesInWindow), 
	% Compute query time of the next window and cache the required intervals.
	NextQueryTime is QueryTime + Step, 
	window_full_memory(IntervalsOfRemainingWindows, L1, L2, NextQueryTime, WindowSize, Step, Rel, RestTuples).


% Old code below. It handles the specific case where intervals arrive at their ending point. The whole interval is available at the window containing its ending point.
%
/*
%windowing_allen(+F=V, +Slist, +Tlist, +Rel)
% Computes the intervals that should be cached for the execution of the next window for the computation of F=V.
% I will have to assert and retract qi. step, \omega and mem as global parameters.
windowing_allen(F=V, SList, TList, Rel):-
	write('Before Retrieve Params'), nl,
	retrieveParams(QueryTime, WindowSize, Step, AllenMem), 
	write('After Retrieve Params'), nl,
	WindowStart is QueryTime - WindowSize,
	NextWindowStart is QueryTime + Step - WindowSize,
	earliest_interval_start(TList, WindowStart, NextWindowStart, EarliestStart),
	write('Tearliest: '), write(EarliestStart), nl,
	findIntervalsToCache(SList, EarliestStart, Rel, AllenMem, NextWindowStart, IntervalsToCache),
	write('Intervals to Cache: '), write(IntervalsToCache), nl,
	(IntervalsToCache=[], ! ; assertz(cachedIntervalsAllen(F=V, IntervalsToCache))).

retrieveParams(QueryTime, WM, Step, AllenMem):-
	queryTime(QueryTime),
	write(QueryTime), nl,
	windowSize(WM),
	write(WM), nl,
	step(Step),
	write(Step), nl,
	allenMemory(AllenMem),
	write(AllenMem), nl.

% earliest_interval_start(+List, +WindowStart, +NextWindowStart, -EarliestStart)
% Given a sorted list of maximal interval <List> that have occurred in the past,
% this predicate calculates the earliest time-point which may be the starting point
% of interval for list <List> arriving later in the stream.
% Because <List> contains *maximal* intervals, this earliest time-point is the 
% next time-point after the ending point of the last interval ending before the next window.
earliest_interval_start([], WindowStart, _NextWindowStart, WindowStart).
earliest_interval_start([(_S,E)], _WindowStart, NextWindowStart, EarliestStart):-
	E < NextWindowStart, !, 
	EarliestStart is E + 1.
earliest_interval_start([(_S,_E)], WindowStart, _NextWindowStart, WindowStart).
earliest_interval_start([(_S1,E1),(_S2,E2)|_RestIntervals], _WindowStart, NextWindowStart, EarliestStart):- 
	E1 < NextWindowStart,
	E2 > NextWindowStart, !,
	EarliestStart is E1 + 1.
earliest_interval_start([(_S1,_E1),(S2,E2)|RestIntervals], WindowStart, NextWindowStart, EarliestStart):- 
	earliest_interval_start([(S2,E2)|RestIntervals], WindowStart, NextWindowStart, EarliestStart).

% findIntervalsToCache(+ListOfIntervals, +EarliestStart, +Rel, +MemorySize, +WindowStart, +NextWindowStart, -IntervalsToCache)
% Intervals are cached depending on (i) the selected relation <Rel> 
%									(ii) the relative position between <EarliestStart> and its endpoints.
findIntervalsToCache([], _EarliestStart, _Rel, _MemorySize, _NextWindowStart, []).
% When Rel is equal or finishes, we do not cache any intervals.
findIntervalsToCache([_|_], _EarliestStart, equal, _MemorySize, _NextWindowStart, []):- !.
findIntervalsToCache([_|_], _EarliestStart, finishes, _MemorySize, _NextWindowStart, []):- !.
% if the current interval ends after the start of the next window, then it will be re-computed at the next query time. 
% So, do not cache this interval, as well as all the remaining intervals.
findIntervalsToCache([(_S,E)|_RestIntervals], _EarliestStart, _Rel, _MemorySize, NextWindowStart, []):-
	E > NextWindowStart, !.
findIntervalsToCache([(S,E)|RestIntervals], EarliestStart, meets, _MemorySize, _NextWindowStart, [(S,E)|RestIntervals]):-
	E >= EarliestStart, !.
findIntervalsToCache([(S,E)|RestIntervals], EarliestStart, overlaps, _MemorySize, _NextWindowStart, [(S,E)|RestIntervals]):-
	E > EarliestStart, !.
findIntervalsToCache([(S,E)|RestIntervals], EarliestStart, starts, _MemorySize, _NextWindowStart, [(S,E)|RestIntervals]):-
	S >= EarliestStart, !.
findIntervalsToCache([(S,E)|RestIntervals], EarliestStart, during, _MemorySize, _NextWindowStart, [(S,E)|RestIntervals]):-
	S > EarliestStart, !.
% before is a special case.
% In order to have 100% when computing before, we should keep the entire history of source intervals. 
% This is not doable in a streaming setting.
% As a compromise, we keep all intervals ending at most <MemorySize> time-points before the start of the next window.
findIntervalsToCache([(S,E)|RestIntervals], _EarliestStart, before, MemorySize, NextWindowStart, [(S,E)|RestIntervals]):-
	MemoryStart is NextWindowStart - MemorySize,
	E >= MemoryStart, !.
% Note: findIntervalsToCache for `all' follows the definition of the most general case, i.e., before
%findIntervalsToCache([(S,E)|RestIntervals], _EarliestStart, all, MemorySize, NextWindowStart, [(S,E)|RestIntervals]):-
%	MemoryStart is NextWindowStart - MemorySize,
%	S > MemoryStart, !.
findIntervalsToCache([(_S,_E)|RestIntervals], EarliestStart, Rel, MemorySize, NextWindowStart, LCached):-
	findIntervalsToCache(RestIntervals, EarliestStart, Rel, MemorySize, NextWindowStart, LCached).	

append_without_duplicates([], LCurr, LCurr):- !.
append_without_duplicates(LCached, [], LCached):- !.
append_without_duplicates([(S, E)|RestCached], [(S, E)|RestCurr], [(S, E)|Rest]):- 
	!, append_without_duplicates(RestCached, RestCurr, Rest).
append_without_duplicates([(S, _E1)|RestCached], [(S, E)|RestCurr], [(S, E)|Rest]):- 
	!, append_without_duplicates(RestCached, RestCurr, Rest).
append_without_duplicates([(S, E)|RestCached], Curr, [(S, E)|Rest]):- 
	!, append_without_duplicates(RestCached, Curr, Rest).
*/	

