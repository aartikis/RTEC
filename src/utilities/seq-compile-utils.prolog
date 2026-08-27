rule_body_has_seq(seq(_,_,_)).
rule_body_has_seq((Cond,_)):-
    rule_body_has_seq(Cond),!.
rule_body_has_seq((_,Cond)):-
    rule_body_has_seq(Cond),!.
    
compileConditionsWithSeq(Body, NewBody, Timespan, Cyclic, FVP):-
	 compileConditionsWithSeqInternal(Body, NewBody, Timespan, Cyclic, FVP, []).
	 
%%%% recursive definition of compileConditions/4 %%%%

compileConditionsWithSeqInternal((\+Head,Rest), (\+NewHead,NewRest), Timespan, Cyclic, FVP, ILBindings) :-	
	!, compileConditions1withSeq(Head, NewHead, Timespan, Cyclic, FVP, ILBindings, NewILBindings), 
	compileConditionsWithSeqInternal(Rest, NewRest, Timespan, Cyclic, FVP, NewILBindings).	

compileConditionsWithSeqInternal((Head,Rest), (NewHead,NewRest), Timespan, Cyclic, FVP, ILBindings) :-	
	!, compileConditions1withSeq(Head, NewHead, Timespan, Cyclic, FVP, ILBindings, NewILBindings), 
	% below TimeSpan is set to [] since the constraint 'T1=<T,T<2'
	% can only be imposed on the first body literal
	compileConditionsWithSeqInternal(Rest, NewRest, [], Cyclic, FVP, NewILBindings).

compileConditionsWithSeqInternal(\+Body, \+NewBody, Timespan, Cyclic, FVP, ILBindings) :-	
	!, compileConditions1withSeq(Body, NewBody, Timespan, Cyclic, FVP, ILBindings, _).

compileConditionsWithSeqInternal(Body, NewBody, Timespan, Cyclic, FVP, ILBindings) :-	
	compileConditions1withSeq(Body, NewBody, Timespan, Cyclic, FVP, ILBindings, _).
	

%%% holdsFor

% simple fluent
compileConditions1withSeq(holdsFor(F=V,I), holdsForProcessedSimpleFluent(Index,F=V,I), _Timespan, _Cyclic, _FVP, ILBindings, [(I,F=V) |ILBindings]) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(Index, F=_), !.

% input entity/statically determined fluent
compileConditions1withSeq(holdsFor(F=V,I), holdsForProcessedIE(Index,F=V,I), _Timespan, _Cyclic, _FVP, ILBindings, [(I,F=V) |ILBindings]) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_), !.

% internal entity/statically determined fluent
compileConditions1withSeq(holdsFor(F=V,I), holdsForProcessedIE(Index,F=V,I), _Timespan, _Cyclic, _FVP, ILBindings, [(I,F=V) |ILBindings]) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_), !.

% output entity/statically determined fluent
compileConditions1withSeq(holdsFor(F=V,I), holdsForProcessedSDFluent(Index,F=V,I), _Timespan, _Cyclic, _FVP, ILBindings, [(I,F=V) |ILBindings]) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_), !.

% statically determined fluent that is neither input nor output entity
compileConditions1withSeq(holdsFor(F=V,I), holdsForSDFluent(F=V,I), _Timespan, _Cyclic, _FVP, ILBindings, [(I,F=V)| ILBindings]) :-
        copy_term(F=V, U1), sDFluent(U1), !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sequencing start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

compileConditions1withSeq(seq(R1, R2, Ro), TRSeq, _Timespan, _Cyclic, F=V, ILBindings, [(Ro, seq(FCount,Fl=Vl,Fr=Vr))|ILBindings]):-
        use_rct(yes),!,
	rtec_get_val(f_count, FCount), 
	FCount1 is FCount+1,
	rtec_set_val(f_count, FCount1),
	get_bind(ILBindings,R1,Fl=Vl),
	get_bind(ILBindings,R2,Fr=Vr),
        TRSeq = (catch(call(rct_computation_formula(seq, FCount, F=V, [Fl=Vl, Fr=Vr], [R1, R2], Ro)), _, writeln(assumptionViolation(F=V))) -> true; (queryTime(Q),Ro = ([],Q))).

compileConditions1withSeq(seq(R1, R2, Ro), TRSeq, _Timespan, _Cyclic, _F=_V, ILBindings, [(Ro, seq(FCount,Fl=Vl,Fr=Vr))|ILBindings]):-use_rct(no),!,
	rtec_get_val(f_count, FCount), 
	FCount1 is FCount+1,
	rtec_set_val(f_count, FCount1),
	get_bind(ILBindings,R1,Fl=Vl),
	get_bind(ILBindings,R2,Fr=Vr),
    	TRSeq = seq(R1,R2,Ro). 
    	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sequencing end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


compileConditions1withSeq(Something, Something, _Timespan, _Cyclic, _FVP, ILBindings, ILBindings).

get_bind([(Iv, F=V)|_R], Ir, F=V):-
	same_term(Iv,Ir),!.
get_bind([(_,_)|R], Ir, F=V):-
	get_bind(R, Ir, F=V).
