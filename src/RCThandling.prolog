/*
 
  RCT handling for RTEC.
  Author: Manolis Pitsikalis
  
*/

:- dynamic retained/4.

%  
rct_forget(TqPrev):-
    retractall(retained(_, _, TqPrev, _)).
%% 
% rct_compiler_init()

%  generic RCT computation formula for 
%  op={seq, union, intersection, complement}
rct_computation_formula(Op, FCount, F=V, InpILFluents, InpILists, Ro):-
    %------get current query time
    queryTime(QueryTime),
    %writeln(F=V),
    %------convert input lists to RCT if not in RCT format
    intervals_to_rct(InpILists, QueryTime, RCTInpListsCurr),
    % index retrieve
    %index_retrieve(Op, FCount, F=V, InpILFluents, Tadv),
    %------retrieve retained information (if available)
    bookkeeping_restore(Op, FCount, F=V, InpILFluents,  RetainedInfo),
    %writeln(bookkeeping_restore(FCount, F=V,  RetainedInfo)),
    %------merge new data with old data
    %writeln(bookkeeping_merge(RCTInpListsCurr, RetainedInfo, RCTInpLists)),
    bookkeeping_merge(RCTInpListsCurr, RetainedInfo, RCTInpLists),
    %------filter out input intervals based on index
    %index_filter(Op, RCTInpListUf, Tadv, RCTInpListU),
    %writeln(    bookkeeping_merge(RCTInpListsCurr, RetainedInfo, RCTInpLists)),
    %-------compute cut-off
    %satisfy_constrains(seq, RCTInpListsU, RCTInpLists),
    %writeln(    compute_cutoff(Op, RCTInpLists, To)),
    compute_cutoff(Op, RCTInpLists, To),
    %writeln(    compute_cutoff(Op, RCTInpLists, To)),
    %--------cutoff intervals inp
    get_cutoff_interval_lists(RCTInpLists, To, CutILists),
    %writeln(    get_cutoff_interval_lists(RCTInpLists, To, CutILists)),
    %writeln(    InpILFluents),
    %--------perform op
    perform_op(seq, CutILists, I),
    %writeln(    perform_op(seq, CutILists, I)),
    %--------bookkeeping find input intervals that should remain
    filter_remaining_intervals_lists(I, RCTInpLists, To, QueryTime, InfoToRetain),
    %writeln(filter_remaining_intervals_lists(I, RCTInpLists, To, QueryTime, InfoToRetain)),
    %--------bookkeeping store
    %writeln(bookkeeping_store(Op, FCount, F=V, InpILFluents, QueryTime, InfoToRetain, RCTInpListsU)),
    bookkeeping_store(Op, FCount, F=V, InpILFluents, QueryTime, InfoToRetain, RCTInpLists),
    %writeln(bookkeeping_store(Op, FCount, F=V, InpILFluents, QueryTime, InfoToRetain, RCTInpListsU)),
    %index_store(Op, FCount, F=V, InpILFluents, To), 
    Ro = (I, To).

/*
satisfy_constrains(seq, [(LIa, Ta), (LIb, Tb)], [(LIa, Ta), (LIbU, Tb)]):-
	findall((Ts,TeP),
		(
		  member((Ts,TeP),LIb),
		  get_te(TeP,Te),
		  \+((
		  	member((TsA,TeAP),LIa),
		  	get_te(TeAP,TeA),
		  	((Ts >= TsA, Ts =< TeA); (Te>=TsA,Te=<TeA))
		    ))
		 ), LIbU).
*/

%!  compute_cutoff(+Op,+RCTLa:list, +RCTLb:list, -RCTI:list) is det.
compute_cutoff(seq, [(LIa, Ta), (LIb, Tb)], To):-
    candidateRCT(seq, [(LIa, Ta), (LIb, Tb)], TcP),
    get_te(TcP, Tc),
    compute_cutoff_extension(seq, Tc, [(LIa, Ta), (LIb, Tb)], To).

candidateRCT(seq, [(LIa,Ta), (LIb, Tb)], Tc):-
    last_before(LIa, Tb,  (TsA,TeAp)),
    get_te(TeAp,TeA),
    %if (TsA,TeAp) has plus the TNP should be +3 not plus 2
    nextPosI(TeAp, TeANP),
    nextPosI(Ta,TaNP),
    max(TeANP, TaNP, TNP), 
    member((TsB,TeB), LIb),
    TsB > TeA,
    TsB =< TNP,
    clear_from_extra1(LIa, LIac),
    seq_rct(LIac, LIb, (TsA,TeB)),
    TeB = Tc,!. 

candidateRCT(seq, [(LIa, _Ta), (_LIb, Tb)], Tc):-
    last_before(LIa, Tb, Ia),
    (TsA,_) = Ia,
    Tc is TsA - 1,!. 

candidateRCT(seq, [(_,Ta), _], Ta).


compute_cutoff_extension(seq, Tc, [(LIa, Ta), (LIb, Tb)], To):-
    extend_left((LIa,Ta), Tc, Tb, Tol),
    extend_right((LIb, Tb), Tol, To).

%--------------------------------------------------
% Extension from the left operand
%
% after finding Tc, we check whether we can 
% extend it from the left operand of the sequence
% for example, if Tc=5, and there are intervals
% from the left operand for which a succesor is 
% impossible to exist we can extend Tc to the 
% start of the last interval out of a sequence 
% of intervals that satisfy this property
%---------------------------------------------------
%
% case A: no intervals of from Tc to Ta -> we can extend to Ta
extend_left(([],Ta), Tc, _, To):- 
    max(Ta, Tc, To).
% case B: last interval of A that can have a succesor
extend_left(([(TsA, _TeA)], _), Tc, _, To):- 
    TsA > Tc, To is TsA -1,!.
% case C: intermediate interval of A that can have a succesor
extend_left(([(TsA,TeA), (TsAA, _TeAA)|_LIa], _Ta), Tc, Tb, To):-
    TsA > Tc,
    nextPosI(TeA, TeANP),
    TsAA >= TeANP,
    TsAA > Tb,
    To is TsA - 1,!.
extend_left(([_|LIa],Ta), Tc, Tb, To):-
    extend_left((LIa,Ta), Tc, Tb, To).

%--------------------------------------------------
% Extension from the right operand
%---------------------------------------------------
%extend_right(([], _Tb), Tc, Tc).
extend_right(([(_, TEbp)|LIb], Tb), Tc, To):-
    get_te(TEbp, TEb),
    TEb =< Tc,!,
    extend_right((LIb,Tb), Tc, To).
extend_right(([(TSb, TEbp)], _Tb), Tc, TEb):-
    nextPosI(Tc, TcNP),
    TSb < TcNP,
    get_te(TEbp,TEb),!.
extend_right(([(TSb, TEb), (TSbb, _TEbb)|_LIb], _Tb), Tc, TEb ):-
    nextPosI(Tc, TcNP),
    TSb < TcNP,
    nextPosI(TEb, TEbNP),
    TSbb >= TEbNP,!.
extend_right(([(TSb, TEb), (TSbb, TEbb)|LIb], Tb), Tc, To ):-
    nextPosI(Tc, TcNP),
    TSb < TcNP,
    nextPosI(TEb, TEbNP),
    TSbb < TEbNP,!,
    extend_right(([(TSbb, TEbb)|LIb], Tb), TEb, To).
extend_right(_, Tc, Tc).

booking_format(seq, no, [[],[]]):-!.
booking_format(seq, R, R).

perform_op(seq, [I1, I2], I):-
    seq(I1, I2, I).
     
%
% Bookkeeping
%
% accepts two lists
%   first: current RCTs
%   second: retained intervals
%   returns: merged RCTs
%   NOTE: first and second should have the same length
bookkeeping_merge(A, no, A):-!.
bookkeeping_merge([], [], []):-!.
bookkeeping_merge([(INew, To)|L], [IRet|LRet], [(I, To)|Lmerged]):-
    merge_efficient(IRet, INew, I),
    bookkeeping_merge(L, LRet, Lmerged).

merge_efficient([],B,B):-!.
merge_efficient(A,[],A):-!.
merge_efficient([(Ts,Te)|A],[(Ts,Te)|B],[(Ts, Te)|R]):-!,
    merge_efficient(A, B, R).

merge_efficient([(TsA,TeA)|A],[(TsB,TeB)|B],[(TsA, TeA)|R]):-
    TeA < TsB,!,
    merge_efficient(A, [(TsB,TeB)|B], R).

merge_efficient([(TsA, TeA)|A],[(TsB, TeBp)|B],[(TsB, TeBp)|R]):-
    get_te(TeBp,TeB),
    TeB < TsA,!,
    merge_efficient([(TsA, TeA)|A], B, R).
    
merge_efficient([(TsA,TeA)|A],[(_TsB,TeBp)|B],[(TsA, TeBp)|R]):-
    get_te(TeBp, TeB),
    TeA =< TeB,!,
    merge_efficient(A, B, R).

merge_efficient([(_TsA,TeA)|A],[(TsB,TeBp)|B],[(TsB, TeA)|R]):-
    get_te(TeBp, TeB),
    TeB =< TeA,
    merge_efficient(A, B, R).


% restore data that was kept in previous query
bookkeeping_restore(seq, FCount, F=V, [_Left, _], [L1,R1]):-
    prevQueryTime(TqR),
    retained(F=V, FCount, TqR, [L1,R1]),!.
bookkeeping_restore(seq, _FCount, _F=_V, _InpILFluents, no).

% store data that will be potentially be used in next query
bookkeeping_store(seq, _FCount, _F=_V, [_Left|_], _Tq, RetainedInfo, [(_Li,_)|_]):-
    all_empty(RetainedInfo),!.
bookkeeping_store(seq, FCount, F=V, [_Left|_], Tq, RetainedInfo, [(_Li,_)|_]):-
    assertz(retained(F=V, FCount, Tq, RetainedInfo)).


/*
% restore data that was kept in previous query
bookkeeping_restore(seq, FCount, F=V, [Left, _], [L12,R1]):-
    prevQueryTime(TqR),
    retained( F=V, FCount, TqR, [L1,R1]),!,
    %writeln(retained(FCount, F=V, TqR, [L1,R1])),
    unknown_future_restore(FCount, Left, [L2]),
    merge_efficient(L1, L2, L12).
bookkeeping_restore(seq, FCount, _F=_V, [Left, _], [L1,[]]):-
    unknown_future_restore(FCount, Left, [L1]),
    L1\=[],!.
    %writeln(unknown_future_restore(FCount, Left, [L1])).
bookkeeping_restore(seq, _FCount, _F=_V, _InpILFluents, no).

% store data that will be potentially be used in next query
bookkeeping_store(seq, FCount, _F=_V, [Left|_], Tq, RetainedInfo, [(Li,_)|_]):-
    all_empty(RetainedInfo),!,
    unknown_future_book(FCount, Left, Tq, Li).
bookkeeping_store(seq, FCount, F=V, [Left|_], Tq, RetainedInfo, [(Li,_)|_]):-
    assertz(retained(F=V, FCount, Tq, RetainedInfo)),
    unknown_future_book(FCount, Left, Tq, Li).

unknown_future_book(_FCount, _Left, _Tq, Li):-
    last_np_interval(Li, []),!.
unknown_future_book(FCount, Left, Tq, Li):-
    last_np_interval(Li, R),!,
    \+(retained(ilsource(Left), FCount, Tq, [R])),
    assertz(retained(ilsource(Left), FCount,  Tq, [R])).

unknown_future_restore(FCount, Left, R):-
    prevQueryTime(TqR),
    retained(ilsource(Left), FCount,  TqR, R),!.
unknown_future_restore(_FCount, _Left, [[]]).
*/


last_np_interval(L, R):-last_np_interval(L, [], R).
last_np_interval([], Last, Last).
last_np_interval([(Ts,Te)|R], _, Last):-
    Te\=plus(_),!,
    last_np_interval(R,[(Ts,Te)],Last).
last_np_interval([(_,plus(_))|R], P, Last):-
    last_np_interval(R,P,Last).


%
% indexing 
%
%index_retrieve(seq, FCount, F=V, InpILFluents, Tadv).
%index_store(seq, FCount, F=V, InpILFluents, To).
%index_filter(seq, RCTInpListUf, Tadv, RCTInpListU).
 
%
% Utilities
%

intervals_in_info(L, S):-
    intervals_in_info(L, 0, S).

intervals_in_info([], S, S).
intervals_in_info([L|R], SP, S):-
    length(L, X),
    NS  is X+SP,
    intervals_in_info(R, NS, S). 

all_empty([]).
all_empty([[]|R]):-all_empty(R).


filter_remaining_intervals_lists(I, RCTInpLists, To, QueryTime, InfoToRetain):-
    % in case the resulting interval list contains an interval
    % that extends futher than To, we should keep the info that 
    % created that interval  
    minimise_to_in_case_of_plus(I, To, ToM),
    filter_remaining_intervals_lists(RCTInpLists, ToM, QueryTime, InfoToRetain).

%filter_remaining_intervals_lists(RCTInpLists, To, InfoToRetain),
filter_remaining_intervals_lists([], _, _, []).
filter_remaining_intervals_lists([(I,_)|L], To, Tq, [RetL|R]):-
    filter_remaining_intervals(I, To, RetLi),
    Tq1 is Tq+1,
    intersect_all([RetLi, [(0, Tq1)]], RetL),
    filter_remaining_intervals_lists(L, To, Tq,  R).

filter_remaining_intervals([], _To, []).
filter_remaining_intervals([(Ts, plus(Te))|L], To, [(Ts,Te1)|R]):-
    Te >= To,!,
    Te1 is Te+1,
    filter_remaining_intervals(L, To, R).
filter_remaining_intervals([(Ts, Te)|L], To, [(Ts,Te)|R]):-
    Te \= plus(_),
    Te > To,!,
    filter_remaining_intervals(L, To, R).
filter_remaining_intervals([_|L], To, R):-
    filter_remaining_intervals(L, To, R).


% accepts a list of interval/RCT lists
% and querytime
% if a list is already RCT nothing happens
% otherwise it is converted to RCT using 
% querytime (if inp list is not an RCT
% then it is monotonic)
intervals_to_rct([],_,[]).
intervals_to_rct([I|L], QueryTime, [IRCT|LRCT]):-
    rct(I, QueryTime, IRCT),
    intervals_to_rct(L, QueryTime, LRCT).

% gets a list of RCT lists and an instant
% returns a set of interval lists that have
% been cutoff using the given instant
get_cutoff_interval_lists([], _, []).
get_cutoff_interval_lists([(I,_)|RCTL], To, [Ic|L]):-
    cutoff_intervals(I, To, Ic),
    get_cutoff_interval_lists(RCTL, To, L).

% cutoff interval list so that it includes
% intervals up to To
cutoff_intervals([], _To, []):-!.
% if interval has plus then plus should remain
cutoff_intervals([(Ts, plus(Te))|LR], To, [(Ts, plus(Te))|L]):-
    Te =< To,!,
    cutoff_intervals(LR, To, L).
% if interval does not have plus treat normally
cutoff_intervals([(Ts, Te)|LR], To, [(Ts, Te)|L]):-
    Te \= plus(_),
    Te =< To,!,
    cutoff_intervals(LR, To, L).
% regardless whther the interval has plus, if Te is less
% than To cut it and add plus
cutoff_intervals([(Ts, TeP)|_LR], To, [(Ts, plus(To))]):-
    get_te(TeP, Te),
    Ts =< To,
    Te > To,!.
cutoff_intervals([_|_], _To, []):-!.
    
% creates RCT list from interval list
% note that infinity is replaced with plus intervals
rct((I,T), _, (I,T)):-!.
rct(I, QueryTime, (I1,QueryTime)):-cutoff_intervals(I, QueryTime, I1).

% used for cutoff computation (see paper)
nextPosI(plus(T), Tn):- Tn is T+3, !.
nextPosI(T, Tn):- Tn is T+2.

last_before([(TsA, TeAp), (_, TeA2p)| _], Tb, (TsA, TeAp)):-
    get_te(TeAp, TeA),
    get_te(TeA2p, TeA2),
    TeA =< Tb,
    TeA2 > Tb,!.
last_before([(TsA, TeAp)], Tb, (TsA, TeAp)):-
    get_te(TeAp, TeA),
    TeA =< Tb,!.

last_before([_|L], Tb, (TsA, TeA)):-
    last_before(L,Tb,(TsA,TeA)).

clear_from_extra((L,_To),L1):-!,
    clear_from_extra1(L, L1).
clear_from_extra(L,L).
clear_from_extra1([],[]).
clear_from_extra1([(Ts,Te1)|L],[(Ts,Te)|L1]):-
    get_te(Te1,Te),
    clear_from_extra1(L, L1).

minimise_to_in_case_of_plus(I, _To, Ta):-
    append(_,[(Ta,plus(_))],I),!.
minimise_to_in_case_of_plus(_I, To, To).

get_te(plus(Te), Te):-!.
get_te(Te, Te).

remove_plus_from_interval_list([], []).
remove_plus_from_interval_list([(Ts, TeP)|LR], [(Ts, Te)|L]):-
	get_te(TeP,Te),
	remove_plus_from_interval_list(LR, L).
	

