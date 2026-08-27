/*
-Distinguished between deadline fluents that are cyclic and deadline fluents that are not cyclic. In the latter case, checking already computed starting points is sufficient, and we do not re-evaluate initiatedAt rules. Eg, (a) the body initiatedAt condition in the first initiatedAt rule above is replaced by checking starting points; (b) the third clause of brokenOrReInitiated is not evaluated. 
-brokenOrReInitiated above should NOT call the initiatedAt clauses of timeoutTreatment.prolog in the case of fi/3 and p/1. I resolved with the use of a dynamic global variable, inertiaCheck, which is asserted/retracted at the appropriate places. 
-in the case of fi/3 and p/1, the fluent is now extended when the re-initiation takes place at the same time as the deadline.


After reconsidering cycles treatment:

startedBetween4 is almost the same as startedBetween/5; I can use startedBetween/5 
instead of startedBetween4 if I add check for cyclic fluents in the last clause of startedBetween/5
and declare all fluent-value pairs that are initiated by means of deadlines as cyclic (which they are)

gather all broken, started incarnations at the same place in the code, and give them consistent names (Between, At, Once, etc)

optimisations: for cyclic fluents, check whether they have been processed; if they have, then restrict attention to cached starting points; other optimisations?

replace bronkenOnce with brokenOnceAt

brokenOnce: shall we enforce early that T2>T1?
*/

% these predicates are defined in this file
% and may also be defined in an event description
:- multifile initiatedAt/4, fi/3, p/1.

:- dynamic inertiaCheck/1.

%%% initiatedAt(+U, +T1, -T, +T2) %%%	
% initiatedAt/4 for deadline fluents	
initiatedAt(F=NewV, T1, T, T2) :-
        fi(F=V, F=NewV, Duration),
        % do not evaluate dInitiatedAt/5 clauses to look for breaking points 
        % of F=V between an initiation of F=V and its deadline 
        % when the duration of F=V may be extended
	\+ inertiaCheck(F=V),
	% initiatedAt incarnation for deadline fluents:
        dInitiatedAt(F=V, Duration, T1, T, T2).	

%%% dInitiatedAt(+(F=V), +Duration, +T1, -T, +T2) %%%	
        
% the rule below deals with the case where the initiation of a fluent-value pair 
% that is subject to deadlines takes place within the working memory	
dInitiatedAt(F=V, Duration, T1, T, T2) :-
	EarlierT2 is T2-Duration, 
	initTime(InitTime), 
	EarlierT2>InitTime,
	T1MinusDuration is T1-Duration, 
	calcEarlyBoundary(InitTime, T1MinusDuration, EarlierT1),
	% sanity check:
	EarlierT2>EarlierT1,
        indexOf(Index, F=V), 
        % the disjunction below computes the initiation point of F=V
	(
            % for cyclic fluents we cannot restrict attention to stored starting points
            % we have to also evaluate initiatedAt 
            cyclic(F=V),
            initiatedAt(F=V, EarlierT1, EarlierT, EarlierT2) 
            % it proved insufficient to store the above starting point
            ;
            \+ cyclic(F=V),
            % instead of evaluating initiatedAt, look for cached starting points 
            startingPoints(Index, F=V, SPoints), 
            member(EarlierTNext, SPoints), 
            prevTimePoint(EarlierTNext, EarlierT) 
	),
	% make sure that the initiating point in within the correct range
	EarlierT1=<EarlierT, EarlierT<EarlierT2,		
	nextTimePoint(EarlierT, NextEarlierT),
	T is EarlierT+Duration,
	deadlineConditions(Index, F=V, NextEarlierT, T).
	    
% the rule below deals with the case where the initiation of a fluent-value pair 
% that is subject to deadlines takes place before the working memory
dInitiatedAt(F=V, Duration, T1, T, T2) :-
    indexOf(Index, F=V),
	happensAtProcessed(Index, attempt(F=V), T), T1=<T, T<T2, 
	% attempt(F=V) was caused by events taking place before or on Qi-WM 
	EarlyT is T-Duration, 
	initTime(InitTime), 
	EarlyT=<InitTime,
	nextTimePoint(InitTime, NextInitTime),
	deadlineConditions(Index, F=V, NextInitTime, T).	

	
%%% deadlineConditions(+Index, +(F=V), +T1, +T2) %%%	
	
% fluent duration MAY be extended
% ie F=V must not be re-initiated and must not be broken in [T1,T2) 
deadlineConditions(Index, F=V, T1, T2) :-
	p(F=V),
	% extend the period in which we look for re-initiations
	% so that a re-initiation takes precedence over the deadline  
	% (the deadline will not take place)
	nextTimePoint(T2, NextT2),
	\+ startedBetween4(Index, F=V, T1, NextT2),
	% assert inertiaCheck flag to avoid going through dinitiatedAt/5 clauses
	% in the evaluation of brokenOnceRange 
	assertz(inertiaCheck(F=V)),
	\+ brokenOnceRange(Index, F=V, T1, T2), !,
	% retract the above flag
	retract(inertiaCheck(F=V)).
% fluent duration MAY be extended	
% the clause below deals with the case in which F=V is broken
% in this case we need to retract the inertiaCheck flag 
% and indicate failure of deadlineConditions
deadlineConditions(_Index, F=V, _T1, _T2) :-
	p(F=V), !,
	retract(inertiaCheck(F=V)),
	fail.
% fluent duration MAY NOT be extended	
% ie F=V must not be broken in [T1,T2)
% for fluents that may not be extended we do not check re-initiations
deadlineConditions(Index, F=V, T1, T2) :-
	\+ brokenOnceRange(Index, F=V, T1, T2).	
	
	
%%% brokenOnceRange(+Index, +F=V, +T1, +T2) %%%		
% F=V is broken in [T1,T2)
brokenOnceRange(Index, F=V, T1, T2) :-
	brokenOnce(Index, F=V, T1, _, T2).		
	
	
%%% startedBetween4(+Index, +F=V, +T1, +T2) %%%
startedBetween4(_, _, T1, T2) :- T1>=T2, !, false.
% F=V is initiated in [T1,T2)
% for non-cyclic fluents we can restrict the search to cached starting points
startedBetween4(Index, F=V, T1, T2) :-
	startingPoints(Index, F=V, SPoints),
	member(SPoint, SPoints), 
	prevTimePoint(SPoint, T), 
	T1=<T, !, T<T2.
% for cyclic fluents we may have to additionally evaluate initiatedAt
startedBetween4(_Index, F=V, T1, T2) :-
        cyclic(F=V),
	initiatedAt(F=V, T1, _, T2), !.

	
% calcEarlyBoundary(+InitTime, +T1MinusDuration, -EarlierT1)        
calcEarlyBoundary(InitTime, T1MinusDuration, EarlierT1) :-
	T1MinusDuration=<InitTime, !,
        nextTimePoint(InitTime, EarlierT1).
%T1MinusDuration>InitTime,        
calcEarlyBoundary(_, EarlierT1, EarlierT1).        
