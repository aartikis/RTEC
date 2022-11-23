
/***************************************************************************************************
 This program compiles an event description into a more efficient representation.
 It also compiles some types of declaration into a format that allows for more efficient reasoning.
 Input: 
 (a) Event Calculus axioms.
 (b) Declarations.

 Event processing should be performed on the event description 
 produced by this compiler, along with the declarations.
 ***************************************************************************************************/

:- use_module(library(lists)). % needed to use member/2 in YAP.

% these predicates are defined in this file
:- discontiguous compileHoldsAtTree/3, findChildren/3. 

% these predicates may appear discontiguously in the input rules and declarations files.
:- discontiguous event/1, inputEntity/1, index/2, simpleFluent/1, outputEntity/1, sDFluent/1, initiatedAt/2, terminatedAt/2, holdsFor/3. 

% these predicates may or may not appear in the input rules and declarations files.
:- dynamic initially/1, initiatedAt/2, initiatedAt/4, terminatedAt/2, terminatedAt/4, initiates/3, terminates/3, 
	   happensAt/2, holdsFor/2, holdsAt/2, grounding/1, cyclic/1, collectIntervals/1, buildFromPoints/1.

:- multifile indexOf/2.

indexOf(Index, Entity):-
	index(Entity, Index).

compileEventDescription(Declarations, InputDescription, OutputDescription) :- 
	consult(Declarations),
	consult(InputDescription),
	tell(OutputDescription),
	% compile initially/1 rules	
	compileInitially.

% compile initiatedAt/2 rules
compileEventDescription(_, _, _) :- compileInitiatedAt.
% compile terminatedAt/2 rules
compileEventDescription(_, _, _) :- compileTerminatedAt.
% compile initiates/3 rules
compileEventDescription(_, _, _) :- compileInitiates.
% compile terminates/3 rules
compileEventDescription(_, _, _) :- compileTerminates.
% compile holdsFor/2 rules
compileEventDescription(_, _, _) :- compileHoldsFor.
% compile holdsAt/2 rules
compileEventDescription(_, _, _) :- compileHoldsAt.
% compile happensAt/2 rules
compileEventDescription(_, _, _) :- compileHappensAt.
% compile cachingOrder/1 declarations:
% combine cachingOrder/1, grounding/1 and indexOf/2 to produce cachingOrder2/2
compileEventDescription(_, _, _) :- compileCachingOrder.
% compile collectIntervals/1 declarations: 
% combine collectIntervals/1, grounding/1 and indexOf/2 to produce collectIntervals2/2
compileEventDescription(_, _, _) :- compileCollectIntervals.
% compile buildFromPoints/1 declarations:
% combine buildFromPoints/1, grounding/1 and indexOf/2 to produce buildFromPoints2/2
compileEventDescription(_, _, _) :- compileBuildFromPoints.
compileEventDescription(_, InputDescription, _) :- compileAnythingElse(InputDescription).
% close the new event description file
compileEventDescription(_, _, _) :-  told, !.


% compile initially/1 rules
compileInitially :-
	clause(initially(F=V), Body),	
	\+ var(F),
	T = -1,
	(
		Body = (true),
		BodyWithTimeSpan = (T1=<T, T<T2) 
		;
		Body \= (true),
		BodyWithTimeSpan = (Body,T1=<T, T<T2)
	),
	compileConditions(BodyWithTimeSpan, NewBody, [T1, T2], false),
	%writeCompiledRule('initially', [F=V], NewBody), fail.
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile initiatedAt/2 rules 
compileInitiatedAt :-
	clause(initiatedAt(F=V,T), Body),
	\+ var(F),	
	(
	    	cyclic(F=V),
	    	compileConditions(Body, NewBody, [T1, T2], true)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions(Body, NewBody, [T1, T2], false)
	),    
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile initiatedAt/4 rules 
% In this case, we assume the author treats timespans correctly inside the rule body 
compileInitiatedAt :-
	clause(initiatedAt(F=V,T1,T,T2), Body),
	\+ var(F),    	
	(
		cyclic(F=V),
	    	compileConditions(Body, NewBody, [], true)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions(Body, NewBody, [], false)
	    ),	
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile terminatedAt/2 rules 
compileTerminatedAt :-
	clause(terminatedAt(F=V,T), Body),
	\+ var(F),
	(
		cyclic(F=V),
		compileConditions(Body, NewBody, [T1, T2], true)
		;
		\+ cyclic(F=V),
		compileConditions(Body, NewBody, [T1, T2], false)
	),	
	writeCompiledRule('terminatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile terminatedAt/4 rules 
% In this case, we assume the author treats timespans correctly inside the rule body
compileTerminatedAt :-
	clause(terminatedAt(F=V,T1,T,T2), Body),
	\+ var(F),
	(
	   	cyclic(F=V),
	    	compileConditions(Body, NewBody, [], true)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions(Body, NewBody, [], false)
	),	
	writeCompiledRule('terminatedAt', [F=V,T1,T,T2], NewBody), fail.

% compile initiates/3 rules
compileInitiates :-
	clause(initiates(E,F=V,T), (Body)),
	\+ var(F),	
	(
	    	cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], true)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], false)
	),    
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.

% compile terminates/3 rules
compileTerminates :-
	clause(terminates(E,F=V,T), (Body)),
	\+ var(F),	
	(
	    	cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], true)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], false)
	),    
	writeCompiledRule('terminatedAt', [F=V,T1,T,T2], NewBody), fail.


% compile holdsFor/2 rules
compileHoldsFor :-
	clause(holdsFor(F=V,I), Body),	
	% the condition below makes sure that we do not compile rules from RTEC.prolog 
	% or any other domain-independent code
	\+ var(F),
	compileConditions(Body, NewBody, [], false),	
	writeCompiledRule('holdsFor', [F=V,I], NewBody), fail.
	
% compile holdsAt/2 rules

compileHoldsAt :-
	clause(holdsAt(F=V,_T), Body),	
	% the condition below makes sure that we do not compile rules from RTEC.prolog 
	% or any other domain-independent code
	\+ var(F),
	compileHoldsAtTree(Body, NewBody, I),	
	writeCompiledRule('holdsFor', [F=V,I], NewBody), fail.


% compile happensAt/2 rules 
compileHappensAt :-
	clause(happensAt(E,T), Body),	
	% the condition below makes sure that we do not compile rules from RTEC.prolog 
	% or any other domain-independent code
	\+ var(E),
	compileConditions(Body, NewBody, [], false),	
	writeCompiledRule('happensAt', [E,T], NewBody), fail.


% compile cachingOrder/1 rules
compileCachingOrder :-
	cachingOrder(Entity),
	clause(grounding(Entity), Body),
	indexOf(Index, Entity),	 
	write('cachingOrder2('), write(Index), write(', '), write(Entity), write(') :-'), nl, 
	tab(5), write(Body), write('.'), nl, nl, fail.

% compile collectIntervals/1 rules
compileCollectIntervals :-
	collectIntervals(F=V),
	clause(grounding(F=V), Body),
	indexOf(Index, F=V),	 
	write('collectIntervals2('), write(Index), write(', '), write(F=V), write(') :-'), nl, 
	tab(5), write(Body), write('.'), nl, nl, fail.

% compile buildFromPoints/1 rules
compileBuildFromPoints :-
	buildFromPoints(F=V),
	clause(grounding(F=V), Body),
	indexOf(Index, F=V),	 
	write('buildFromPoints2('), write(Index), write(', '), write(F=V), write(') :-'), nl, 
	tab(5), write(Body), write('.'), nl, nl, fail.
	
%compile for anything other than the EC predicates
compileAnythingElse(InputDescription) :-
	% predicate_property, for some reason, requires absolute path.
	% First check if InputDescription is absolute, else construct absolute path
	%(
	%is_absolute_file_name(InputDescription),
	%InputFullPath = InputDescription
	%;
	%working_directory(Cwd,Cwd),
	%atom_concat(Cwd,InputDescription,InputFullPath)
	%),
	absolute_file_name(InputDescription,[extensions([''])],InputFullPath),
	%predicate_property(Head,file(InputFullPath)),
	source_file(UserHead,InputFullPath),
	(UserHead = user:Head
	;
	UserHead\= user:Head, Head = UserHead),
	Head =.. [HeadPredicate|_],
	\+ member(HeadPredicate,[initially, initiatedAt, terminatedAt, initiates,
				terminates, holdsFor, holdsAt, happensAt]),
	clause(Head,Body),
	write(Head),		
	(
		Body = true
		;
		Body \= true,
		write(' :- '), nl,
		tab(5), write(Body) 
	),
	write('.'), nl, nl, fail.

%%%%%%%% compile body predicates %%%%%%%%

%%%% recursive definition of compileConditions/4 %%%%

compileConditions((\+Head,Rest), (\+NewHead,NewRest), Timespan, Cyclic) :-	
	!, compileConditions1(Head, NewHead, Timespan, Cyclic), 
	compileConditions(Rest, NewRest, Timespan, Cyclic).

compileConditions((Head,Rest), (NewHead,NewRest), Timespan, Cyclic) :-	
	!, compileConditions1(Head, NewHead, Timespan, Cyclic), 
	% below TimeSpan is set to [] since the constraint 'T1=<T,T<2'
	% can only be imposed on the first body literal
	compileConditions(Rest, NewRest, [], Cyclic).

compileConditions(\+Body, \+NewBody, Timespan, Cyclic) :-	
	!, compileConditions1(Body, NewBody, Timespan, Cyclic).

compileConditions(Body, NewBody, Timespan, Cyclic) :-	
	compileConditions1(Body, NewBody, Timespan, Cyclic).
	

%%%% recursive definition of compileHoldsAtTree/3 %%%%
compileHoldsAtTree(Body, NewBody, Interval) :-
	findChildren(Body, Children, Operation),
	!,
	/*findall([ChildNewBody,ChildInterval], 
	        (member(Child,Children),compileHoldsAtTree(Child,ChildNewBody,ChildInterval)),
	        ChildrenBIs),*/
	% findall creates new variable bindings. Use gather instead.
	gatherChildrenBodyIntervals(Children,[],ChildrenBIs),
	completeBody(ChildrenBIs,Operation,NewBody,Interval).
	
gatherChildrenBodyIntervals([HeadChild|[]],InitChildrenBIs,ChildrenBIs) :-
	compileHoldsAtTree(HeadChild,ChildNewBody,ChildInterval),
	append(InitChildrenBIs,[[ChildNewBody,ChildInterval]],ChildrenBIs).
	
gatherChildrenBodyIntervals([HeadChild|TailChildren],InitChildrenBIs,ChildrenBIs) :-
	compileHoldsAtTree(HeadChild,ChildNewBody,ChildInterval),
	append(InitChildrenBIs,[[ChildNewBody,ChildInterval]],NewInitChildrenBIs),
	gatherChildrenBodyIntervals(TailChildren,NewInitChildrenBIs,ChildrenBIs).
	
% simple fluent
compileHoldsAtTree(holdsAt(U,_T), holdsForProcessedSimpleFluent(Index,U,I), I) :-
	simpleFluent(U), indexOf(Index, U), !.
	
% output entity/statically determined fluent
compileHoldsAtTree(holdsAt(U,_T), holdsForProcessedSDFluent(Index,U,I), I) :-
	sDFluent(U), indexOf(Index, U), !.
	
findChildren(Body,Children,Operation) :-
	checkForNegation(Body,Intersections,Unions),
	convertToInters(Intersections,ChildrenI),
	convertToUnions(Unions,ChildrenU),
	Children = [ChildrenI,ChildrenU],
	Operation = negation.
	
checkForNegation(Body,Intersections,Unions) :-
	checkForNegation1(Body,[],Intersections,[],Unions),
	Unions \= [].
	
checkForNegation1((\+Head,Rest),InitIntersections,Intersections,InitUnions,Unions) :-
	append(InitUnions,[Head],NewInitUnions),
	checkForNegation1(Rest,InitIntersections,Intersections,NewInitUnions,Unions).
	
checkForNegation1((Head,Rest),InitIntersections,Intersections,InitUnions,Unions) :-
	append(InitIntersections,[Head],NewInitIntersections),
	checkForNegation1(Rest,NewInitIntersections,Intersections,InitUnions,Unions).

checkForNegation1(\+Body,InitIntersections,InitIntersections,InitUnions,Unions) :-
	append(InitUnions,[Body],Unions).
	
checkForNegation1(Body,InitIntersections,Intersections,InitUnions,InitUnions) :-
	append(InitIntersections,[Body],Intersections).
	
convertToInters([H|[]], H).

convertToInters([H|T],(H,Rest)) :-
	convertToInters(T,Rest).
	
convertToUnions([H|[]], H).

convertToUnions([H|T],(H;Rest)) :-
	convertToUnions(T,Rest).
		
findChildren((Head,Rest),Children,Operation) :-
	findChildren1((Head,Rest), [], Children, Operation).
	
findChildren((Head;Rest),Children,Operation) :-
	findChildren1((Head;Rest), [], Children, Operation).
	
findChildren1((Head,Rest), InitChildren, Children, intersection) :-
	!, append(InitChildren,[Head],NewInitChildren),
	findChildren1(Rest, NewInitChildren, Children, intersection).
	
findChildren1((Head;Rest), InitChildren, Children, union) :-
	!, append(InitChildren,[Head],NewInitChildren),
	findChildren1(Rest, NewInitChildren, Children, union).

findChildren1(Body, InitChildren, Children, _Operation) :-
	append(InitChildren, [Body], Children).
	
completeBody(ChildrenBIs,intersection,(Head,Rest),Interval) :-
	completeBody1(ChildrenBIs,Head,[],Intervals),
	Rest = intersect_all(Intervals, Interval).
	
completeBody(ChildrenBIs,union,(Head,Rest),Interval) :-
	completeBody1(ChildrenBIs,Head,[],Intervals),
	Rest = union_all(Intervals, Interval).
	
completeBody(ChildrenBIs,negation,(Head,Rest),Interval) :-
	completeBody1(ChildrenBIs,Head,[],Intervals),
	Intervals = [H|T],
	Rest = relative_complement_all(H, T, Interval).
	
completeBody1([H|[]],(Head),InitIntervals,Intervals) :-
	H = [Head|Interval],
	append(InitIntervals,Interval,Intervals).

completeBody1([H|T],(Head,Rest),InitIntervals,Intervals) :-
	H = [Head|Interval],
	append(InitIntervals,Interval,NewIntervals),
	completeBody1(T,Rest,NewIntervals,Intervals).
	
%%%% end of recursive definition of compileHoldsAtTree/3 %%%%


%%%% auxiliary predicate dealing with a single condition %%%%

%%% happensAt

% special event: start of simple fluent
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic) :-
	% we use copy_term in compileConditions1 to classify U without 
	% affecting its (free) variables
        copy_term(F=V, U1), simpleFluent(U1),
	% but use U in the compiled event description 
	% a free variable is used below to avoid instantiating V, 
	% in case it is a variable, to some arbitrary ground value
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedSimpleFluent(Index,start(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedSimpleFluent(Index,start(F=V),T), T1=<T, T<T2) 
	), !.
	
% special event: start of input entity/statically determined fluent
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedIE(Index,start(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedIE(Index,start(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: start of internal entity/statically determined fluent
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedIE(Index,start(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedIE(Index,start(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: start of output entity/statically determined fluent
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedSDFluent(Index,start(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedSDFluent(Index,start(F=V),T), T1=<T, T<T2)
	), !.

% ---------------------------------compile startI-------------------------------------
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedSimpleFluent(Index,startI(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedSimpleFluent(Index,startI(F=V),T), T1=<T, T<T2) 
	), !.
	
% special event: start of input entity/statically determined fluent
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedIE(Index,startI(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedIE(Index,startI(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: start of internal entity/statically determined fluent
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedIE(Index,startI(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedIE(Index,startI(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: start of output entity/statically determined fluent
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedSDFluent(Index,startI(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedSDFluent(Index,startI(F=V),T), T1=<T, T<T2)
	), !.
% ---------------------------------compile startI-------------------------------------

% special event: end of simple fluent
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedSimpleFluent(Index,end(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedSimpleFluent(Index,end(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: end of input entity/statically determined fluent
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedIE(Index,end(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedIE(Index,end(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: end of internal entity/statically determined fluent
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedIE(Index,end(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedIE(Index,end(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: end of output entity/statically determined fluent
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_),
	(
		Timespan = [],
		NewBody = happensAtProcessedSDFluent(Index,end(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessedSDFluent(Index,end(F=V),T), T1=<T, T<T2)
	), !.
	
% special event: end of statically determined fluent that is neither an input nor an output entity
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1),
	(
		Timespan = [],
		NewBody = happensAtSDFluent(end(F=V),T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtSDFluent(end(F=V),T), T1=<T, T<T2)
	), !.
/*
%---------------------------- compile endI-------------------------------
% special event: end of simple fluent
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic) :-
	simpleFluent(U), indexOf(Index, U),
	(
	Timespan = [],
	NewBody = happensAtProcessedSimpleFluent(Index,endI(U),T)
	;
	Timespan = [T1, T2],
	NewBody = (happensAtProcessedSimpleFluent(Index,endI(U),T), T1=<T, T<T2)
	), 
	!.
	
% special event: end of input entity/statically determined fluent
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic) :-
	sDFluent(U), inputEntity(U), indexOf(Index, U),
	(
	Timespan = [],
	NewBody = happensAtProcessedIE(Index,endI(U),T)
	;
	Timespan = [T1, T2],
	NewBody = (happensAtProcessedIE(Index,endI(U),T), T1=<T, T<T2)
	), 
	!.
	
% special event: end of internal entity/statically determined fluent
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic) :-
	sDFluent(U), internalEntity(U), indexOf(Index, U),
	(
	Timespan = [],
	NewBody = happensAtProcessedIE(Index,endI(U),T)
	;
	Timespan = [T1, T2],
	NewBody = (happensAtProcessedIE(Index,endI(U),T), T1=<T, T<T2)
	), 
	!.
	
% special event: end of output entity/statically determined fluent
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic) :-
	sDFluent(U), outputEntity(U), indexOf(Index, U),
	(
	Timespan = [],
	NewBody = happensAtProcessedSDFluent(Index,endI(U),T)
	;
	Timespan = [T1, T2],
	NewBody = (happensAtProcessedSDFluent(Index,endI(U),T), T1=<T, T<T2)
	),
	!.
	
% special event: end of statically determined fluent that is neither an input nor an output entity
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic) :-
	sDFluent(U),
	(
	Timespan = [],
	NewBody = happensAtSDFluent(endI(U),T)
	;
	Timespan = [T1, T2],
	NewBody = (happensAtSDFluent(endI(U),T), T1=<T, T<T2)
	),
	!.
% ------------------------- compile endI ------------------------
*/


% input entity/event
compileConditions1(happensAt(E,T), NewBody, Timespan, _Cyclic) :-
	copy_term(E, E1), inputEntity(E1),
	(
		Timespan = [],
		NewBody = happensAtIE(E,T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtIE(E,T), T1=<T, T<T2)
	), !.
	
% output entity/event
compileConditions1(happensAt(E,T), NewBody, Timespan, _Cyclic) :-
        copy_term(E, E1), outputEntity(E1), 
	indexOf(Index, E),
	(
		Timespan = [],
		NewBody = happensAtProcessed(Index,E,T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtProcessed(Index,E,T), T1=<T, T<T2)
	), !.
	
	
%%% initiatedAt/2

compileConditions1(initiatedAt(U,T), NewBody, Timespan, _Cyclic) :-
	(
		Timespan = [],
		NewBody = initiatedAt(U,T)
		;
		Timespan = [T1, T2],
		NewBody = initiatedAt(U,T1,T,T2)
	), !.
	
%%% terminatedAt/2

compileConditions1(terminatedAt(U,T), NewBody, Timespan, _Cyclic) :-
	(
		Timespan = [],
		NewBody = terminatedAt(U,T)
		;
		Timespan = [T1, T2],
		NewBody = terminatedAt(U,T1,T,T2)
	), !.
	

%%% holdsAt

% simple fluent
compileConditions1(holdsAt(F=V,T), NewBody, _Timespan, Cyclic) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(Index, F=_),
	(
		Cyclic,
		cyclic(U1),
		NewBody = holdsAtCyclic(Index,F=V,T)
		;
		NewBody = holdsAtProcessedSimpleFluent(Index,F=V,T)
	), !.
	
compileConditions1(holdsAt(I,F=V,T), NewBody, _Timespan, Cyclic) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(I, F=_),
	(
		Cyclic,
		cyclic(U1),
		NewBody = holdsAtCyclic(I,F=V,T)
		;
		NewBody = holdsAtProcessedSimpleFluent(I,F=V,T)
	), !.
	
% input entity/statically determined fluent
compileConditions1(holdsAt(F=V,T), holdsAtProcessedIE(Index,F=V,T), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_), !.

% internal entity/statically determined fluent
compileConditions1(holdsAt(F=V,T), holdsAtProcessedIE(Index,F=V,T), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_), !.

% output entity/statically determined fluent
compileConditions1(holdsAt(F=V,T), holdsAtProcessedSDFluent(Index,F=V,T), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_), !.

% statically determined fluent that is neither input nor output entity
compileConditions1(holdsAt(F=V,T), holdsAtSDFluent(F=V,T), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), !.

%%% holdsFor

% simple fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedSimpleFluent(Index,F=V,I), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(Index, F=_), !.

% input entity/statically determined fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedIE(Index,F=V,I), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_), !.

% internal entity/statically determined fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedIE(Index,F=V,I), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_), !.

% output entity/statically determined fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedSDFluent(Index,F=V,I), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_), !.

% statically determined fluent that is neither input nor output entity
compileConditions1(holdsFor(F=V,I), holdsForSDFluent(F=V,I), _Timespan, _Cyclic) :-
        copy_term(F=V, U1), sDFluent(U1), !.


%%% other body literals, eg interval manipulation constructs 
%%% or optimisation checks

% special case for findall
compileConditions1(findall(Targets,user:ECPred,List),findall(Targets,NewECPred,List), Timespan, Cyclic) :-
	compileConditions(ECPred, NewECPred, Timespan, Cyclic), !.
	
compileConditions1(findall(Targets,ECPred,List),findall(Targets,NewECPred,List), Timespan, Cyclic) :-
	compileConditions(ECPred, NewECPred, Timespan, Cyclic), !.

compileConditions1(Something, Something, _Timespan, _Cyclic).

compileConditions1(Something, _T1, _T2, Something).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I/O Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


writeCompiledRule(initially, [U], (true)) :-
	!, write('initially('), write(U), write(').'), nl, nl. 

writeCompiledRule(initiatedAt, [U, T], (true)) :-
	!, write('initiatedAt('), write(U), write(', _, '), write(T), write(', _).'), nl, nl.
	
writeCompiledRule(initiatedAt, [U, T1, T, T2], (true)) :-
	!, write('initiatedAt('), write(U), write(', '), write(T1), write(', '), write(T), write(', '), write(T2), write(').'), nl, nl.

writeCompiledRule(terminatedAt, [U, T], (true)) :-
	!, write('terminatedAt('), write(U), write(', _, '), write(T), write(', _).'), nl, nl.
	
writeCompiledRule(terminatedAt, [U, T1, T, T2], (true)) :-
	!, write('terminatedAt('), write(U), write(', '), write(T1), write(', '), write(T), write(', '), write(T2), write(').'), nl, nl.

writeCompiledRule(holdsFor, [U, I], (true)) :-
	!, write('holdsForSDFluent('), write(U), write(','), write(I), write(').'), nl, nl. 

writeCompiledRule(happensAt, [E, T], (true)) :-
	!, write('happensAt('), write(E), write(','), write(T), write(').'), nl, nl.


writeCompiledRule(initially, [U], Body) :-
	write('initially('), write(U), write(') :-'), nl,  
	writeBodyLiterals(Body).

writeCompiledRule(initiatedAt, [U, T], Body) :-
	write('initiatedAt('), write(U), write(', _, '), write(T), write(', _) :-'), nl, 
	writeBodyLiterals(Body).
	
writeCompiledRule(initiatedAt, [U, T1, T, T2], Body) :-
	write('initiatedAt('), 
	write(U), 
	write(', '), write(T1), write(', '),  
	write(T), 
	write(', '), write(T2), 
	write(') :-'), 
	nl, 
	writeBodyLiterals(Body).

writeCompiledRule(terminatedAt, [U, T], Body) :-
	write('terminatedAt('), write(U), write(', _, '), write(T), write(', _) :-'), nl, 
	writeBodyLiterals(Body).
	
writeCompiledRule(terminatedAt, [U, T1, T, T2], Body) :-
	write('terminatedAt('), 
	write(U), 
	write(', '), write(T1), write(', '),  
	write(T), 
	write(', '), write(T2), 
	write(') :-'), 
	nl, 
	writeBodyLiterals(Body).

writeCompiledRule(holdsFor, [U, I], Body) :-
	write('holdsForSDFluent('), write(U), write(','), write(I), write(') :-'), nl,
	writeBodyLiterals(Body).

writeCompiledRule(happensAt, [E, T], Body) :-
	write('happensAtEv('), write(E), write(','), write(T), write(') :-'), nl, 
	writeBodyLiterals(Body).


writeBodyLiterals((Head,true)):-
	!, tab(5), write(Head), write('.'), nl, nl.

writeBodyLiterals((Head,Rest)):-
	!, tab(5), write(Head), write(','), nl,
	writeBodyLiterals(Rest).

writeBodyLiterals(Last) :- 
	tab(5), write(Last), write('.'), nl, nl.


