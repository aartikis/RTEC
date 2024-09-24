/******************************************************************************************************
 *

*************************************** Allen Relations ***********************************************
RTEC supports Allen relations in the definitions of statically determined fluents using the predicates:
before/4, meets/4, starts/4, finishes/4, during/4, overlaps/4, equal/4.
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
	during(Id, Ip, source, I).

The output list of maximal intervals I contains the intervals of Id that are `during' some of Ip. 
For the following case, I would contain id. 

id       ------------------
ip    ---------------------------

The signature of an interval relation, e.g., `during', is the following:
	rel(+InputList1, +InputList2, +ResultType, -OutputList)
InputList1, InputList2 and OutputList are lists of maximal intervals.
ResultType specifies the operation applied to the sublists of the input lists including all intervals satisfying the requested relation.
The possible values of ResultType are `lhs'/`source', `rhs'/`target', `union', `intersection', `relative_complement' and `relative_complement_inverse'

rel is either `before', `meets', `starts', `finishes', `during', `overlaps' or `equal'.
Note: ``Inverse relations, such as `during_inverse', are NOT defined. The user may use an inverse relation by swapping the positions of the input lists when using a stardard relation.

It is not possible to express such patterns with the previously supported interval manipulation operations of RTEC, which 
are union_all, intersect_all, and relative_complement_all, without any (expensive) post processing techniques. 
For example, in order to compute `during' with intersect_all, we could first compute intersect_all([Id, Ip], Ii),
and then find all intervals in list Ii which are match exactly some interval in list Id and whose endpoints are not equal to 
the corresponding endpoint of any interval in list Ip. The latter operation would require the reprocessing of all three lists.

The addition of interval relations in RTEC leads to more succinct and intuitive patterns, while supporting additional expressivity
without compromising complexity.

Notes: 
- The algorithm assumes that both input lists are *temporally sorted* and contain *maximal intervals*.
	Since maximal intervals are non-overlapping, sorting in terms of starting or ending point produces the same list.	
- All intervals are *right-open*, i.e., if I=(S,E), I includes the time-points {S, S+1, ..., E-1}
	S is the starting point of I and E-1 is its ending point.

*/

% atomic_relation(+I1, +I2, +Rel).
% Checks if the given interval relation is satisfied between two given intervals. 
% <Rel>: "before", "meets", "starts", "finishes", "during", "overlaps", "equal".
% All intervals are right-open.

atomic_relation((_S1, E1), (S2, _E2), before):-
	S2>=E1. 

% Contiguous Before
%atomic_relation((_S1, E1), (S2, _E2), contiguous_before):-
%		E1=S2.

atomic_relation((S1, E1), (S2, _E2), meets):-
	\+ E1=inf,
	prevTimePoint(E1, E1Prev), 
	\+ S1=E1Prev, % if (S1, E1) is a unit interval, the relation should be starts.
	E1Prev=S2.

atomic_relation((S1, E1), (S2, E2), starts):-
	S1=S2, E1<E2.

atomic_relation((S1, E1), (S2, E2), finishes):-
	S1>S2, E1=E2.

atomic_relation((S1, E1), (S2, E2), during):-
	S1>S2, E1<E2.

atomic_relation((S1, E1), (S2, E2), overlaps):-
	S1<S2,
	\+ E1=inf,
	prevTimePoint(E1, E1Prev),
	E1Prev>S2, % if E1Prev and S2 were equal, we would have meets.
	E1<E2.

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

% move_to_next(+S, +T, +Rel, -Results)
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
%    satisfying Rel at least once, i.e., appearing in a least one tuple of list Tuples.
%    L1Sat and L2Sat are sorted lists of maximal intervals.
% -  Apply the requested interval operation, specified with OutputType, onto lists L1Sat and L2Sat
%	 The possible values of OutputType are:
%		lhs: return only the intervals in Srel
%		rhs: return only the intervals in Trel
%		union: return the union of the intervals in Srel and Trel
%		intersection: return the intersection of the intervals in Srel and Trel
%		relative_complement: return all subintervals of intervals in Srel which are not part of any interval of Trel
%		relative_complement_inverse: return all subintervals of intervals in Trel which are not part of any interval of Srel
% -  Cache the required source intervals, source interval segment and target interval segment.
%    Index=i means that we are caching the intervals/segments required for the ith allen operation in the rule defining F=V.

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

% compute_allen_construct(+Rel, +SList, +TList, +OutputType, -IsItSatisfied, -OutputListOfIntervals)
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

%windowing_allen(+F=V, +Index, +SList, +TList, +Rel)
windowing_allen(F=V, Index, SList, TList, Rel):-
	retrieveParams(InitTime, Step, AllenMem), 
	allen_intervals_to_cache(SList, TList, Rel, InitTime, Step, AllenMem, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache),
	update_cache(F=V, Index, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache).

%update_cache(+F=V, +Index, +SSegment, +TSegment, +SInts)
update_cache(_, _, null, null, []):- !.
update_cache(F=V, Index, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache):-
	assertz(cachedIntervalsAllen(F=V, Index, SourceSegmentToCache, TargetSegmentToCache, SIntsToCache)).

%allen_intervals_to_cache(+SList, +TList, +Rel, +InitTime, +Step, +Mem, -SourceSegmentToCache, -TargetSegmentToCache, -SIntsToCache)
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

%retrieveParams(-InitTime, -Step, -AllenMem)
retrieveParams(InitTime, Step, AllenMem):-
	initTime(InitTime),
	step(Step),
	allenMemory(AllenMem).

