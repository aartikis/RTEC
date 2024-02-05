
/*************************************************************************************************************************************
 This program compiles an event description into a more efficient representation.

 Input: One file containing the Event Calculus rules and grounding information for the entities of the domain.
 Output: One file containing the compiled version of the Event Calculus rules and the declarations needed for efficient reasoning
 
 Event processing should be performed on the event description produced by this compiler.
 *************************************************************************************************************************************/

:- use_module(library(lists)). % needed to use member/2 in YAP.

% these predicates are defined in this file
:- discontiguous compileHoldsAtTree/3, findChildren/3. 

% these predicates may appear discontiguously in the input rules and declarations files.
:- discontiguous event/1, inputEntity/1, index/2, simpleFluent/1, outputEntity/1, sDFluent/1, initiatedAt/2, terminatedAt/2, holdsFor/3, happensAt/2, grounding/1, dgrounded/2, initiatedAt/4, terminatedAt/4, fi/3, p/1, holdsFor/2, initially/1, initiates/3, terminates/3.

% these predicates may or may not appear in the input rules and declarations files.
:- dynamic initially/1, initiatedAt/2, initiatedAt/4, terminatedAt/2, terminatedAt/4, initiates/3, terminates/3, happensAt/2, holdsFor/2, holdsAt/2, grounding/1, cyclic/1, collectIntervals/1, buildFromPoints/1, internalEntity/1, simpleFluent/1, sDFluent/1, event/1, outputEntity/1, inputEntity/1, index/2, dynamicDomain/1, allen_count/1.

:- multifile indexOf/2.

% these predicates are asserted dynamically by the compiler.
% they should be retracted before terminating.
:- dynamic scc/1, fdependency/2, idependency/2, dynamicAndGrounder/2, fcdedge/2, frdwcc/1, fcdscc/1, cdc/1, cyclicPathInFCD/1, cdedge/2, cdcLevel/2.

% Compile the rules of <ApplicationName> found in '../examples/<ApplicationName>/resources/patterns/rules.prolog'. 
% This incarnation of compileED does not construct a dependency graph.
compileED(EventDescription):-
	% compile the event description specified with <ApplicationName>.
	compileApplication(EventDescription),
	% retract facts asserted by the compiler. 
	cleanCache.

% Compile the rules of <ApplicationName> found in '../examples/<ApplicationName>/resources/patterns/rules.prolog'. 
% Next, create the dependency graph of the application in the folder: '../examples/<ApplicationName>/resources/graphs'.
% Possible values of <EventsFlag>: 
%	'withEvents' -> show the 0th level of the dependency graph.
%	'withoutEvents'. -> do not show the 0th level of the dependency graph.
compileED(EventDescription, DependencyGraphFile, EventsFlag):-
	% compile the event description specified with <ApplicationName>.
	compileApplication(EventDescription),
	% create dependency graph the event description.
	createDependencyGraphTxt(DependencyGraphFile, EventsFlag),
	% retract facts asserted by the compiler. 
	cleanCache.

% retract the declarations asserted during compilation to facilitate, e.g., the automatic derivation of cachingOrder2 rules in a correct order.
cleanCache:-
	retractall(inputEntity(_)), retractall(outputEntity(_)),
	retractall(event(_)), retractall(simpleFluent(_)), retractall(sDFluent(_)),
	retractall(index(_,_)),
	retractall(scc(_)),
	retractall(dependency(_,_)),
	retractall(fdependency(_,_)),
	retractall(idependency(_,_)),
        retractall(cyclicPathInFCD(_)),
        retractall(frdwcc(_)),
        retractall(fcdedge(_,_)),
        retractall(fcdscc(_)),
        retractall(cdc(_)),
        retractall(cdedge(_,_)),
        retractall(cdcLevel(_,_)).

%compileApplication(+ApplicationName)
% Compile the event description of the selected application.
% Input file: '../examples/<ApplicationName>/resources/patterns/rules.prolog'. 
% Output file: '../examples/<ApplicationName>/resources/patterns/compiled_rules.prolog'. 
%compileApplication(toy):-
	%compileEventDescription('../examples/toy/resources/patterns/rules.prolog', '../examples/toy/resources/patterns/compiled_rules.prolog'), !.
%compileApplication(voting) :-
	%compileEventDescription('../examples/voting/resources/patterns/rules.prolog', '../examples/voting/resources/patterns/compiled_rules.prolog'), !.
%compileApplication(netbill):-
	%compileEventDescription('../examples/netbill/resources/patterns/rules.prolog', '../examples/netbill/resources/patterns/compiled_rules.prolog'), !.
%compileApplication(maritime):-
	%compileEventDescription('../examples/maritime/resources/patterns/rules.prolog', '../examples/maritime/resources/patterns/compiled_rules.prolog'), !.
%compileApplication(caviar):-
	%compileEventDescription('../examples/caviar/resources/patterns/rules.prolog', '../examples/caviar/resources/patterns/compiled_rules.prolog'), !.
%compileApplication(ctm):-
	%compileEventDescription('../examples/ctm/resources/patterns/rules.prolog', '../examples/ctm/resources/patterns/compiled_rules.prolog'), !.
% compileApplication(+EventDescriptionFile)
% Compile the event description of the selected file.
% Input file: <EventDescriptionFile>
% Output file: /path/to/input/file/compiled_rules.prolog
compileApplication(EventDescriptionFile):-
	split_string(EventDescriptionFile, "/", "", PathSpl),
	constructOutputFile(PathSpl, "", CompiledFile),
	compileEventDescription(EventDescriptionFile, CompiledFile).

constructOutputFile([_FileName], Curr, CompiledFile):-
	atom_concat(Curr, "compiled_rules.prolog", CompiledFile).
constructOutputFile([Dir|RestPath], Curr, CompiledFile):-
	atom_concat(Curr, Dir, NextCurr0),
	atom_concat(NextCurr0, "/", NextCurr),
	constructOutputFile(RestPath, NextCurr, CompiledFile).


% Returns the default path of the dependency graph text file for the given application.
% The path is: '../examples/<ApplicationName>/resources/graphs/<ApplicationName>_dependency_graph.txt'.
% dependency_graph_file(+ApplicationName, -DGFile)
%dependency_graph_file(ApplicationName, DGFile):-
%atom_concat('../examples/', ApplicationName, Path0),
%atom_concat(Path0, '/resources/graphs/', Path1),
%atom_concat(Path1, ApplicationName, Path2),
%atom_concat(Path2, '_dependency_graph.txt', DGFile).

indexOf(Index, Entity):-
	index(Entity, Index).

%compileEventDescription(+InputDescription, -OutputDescription)
%<InputDescription> file contains:
%	- Application-specific precompiled rules in RTEC format.
%	- Grounding rules for input and output entities.
%	- Optionally, index/2 facts stating the indices of entities. If no index is provided, then the index is the first argument of the predicate.
%	- Optionally, dynamicDomain/1 facts stating which input entities should be dynamic grounded. 
%	- Optionally, collectIntervals/buildFromPoints/points declarations statiting whether the input statically determined fluents arrive in time-points or intervals.
compileEventDescription(InputDescription, OutputDescription):-
	consult(InputDescription),
	tell(OutputDescription),
	processRules.

% compile fi/3 should come first..
% at this stage, the pre-compiled event description has already been asserted.
% we should retract fi and extensible facts, and cancellationConditions rules, and assert their intermediate form.
% compile initially/1 rules	
compileEventDescription(_, _) :- compileInitially.
% compile initiatedAt/2 rules
compileEventDescription(_, _) :- compileInitiatedAt.
% compile initiates/3 rules
compileEventDescription(_, _) :- compileInitiates.
% compile terminatedAt/2 rules
compileEventDescription(_, _) :- compileTerminatedAt.
% compile terminates/3 rules
compileEventDescription(_, _) :- compileTerminates.
% compile holdsFor/2 rules
compileEventDescription(_, _) :- compileHoldsFor.
% compile holdsAt/2 rules
compileEventDescription(_, _) :- compileHoldsAt.
% compile happensAt/2 rules
compileEventDescription(_, _) :- compileHappensAt.
% compile fi/3 and p/1 facts
compileEventDescription(_,_) :- compileFI.
% compile collectIntervals/1 declarations: 
% combine collectIntervals/1, grounding/1 and indexOf/2 to produce collectIntervals2/2
compileEventDescription(_, _) :- compileCollectIntervals.
% compile buildFromPoints/1 declarations:
% combine buildFromPoints/1, grounding/1 and indexOf/2 to produce buildFromPoints2/2
compileEventDescription(_, _) :- compileBuildFromPoints.
compileEventDescription(InputDescription, _) :- compileAnythingElse(InputDescription).

compileEventDescription(_, _) :- writeDeclarations.

compileEventDescription(_, _) :- writeDynamicGroundingRules.
% retract the auxiliary facts asserted during compilation and close the new event description file
compileEventDescription(_, _) :-  told, !.

compileEventDescription(Declarations, InputDescription, OutputDescription) :- 
	consult(Declarations),
	consult(InputDescription),
	tell(OutputDescription),
	% deriveCachingOrder computes the caching order (cachingOrder2/2 rules), without cachingOrder declarations, and the cyclic FVPs (cyclic/1 facts).
	% since compileInitiatedAt needs to know which FVPs are cyclic, we have to run deriveCachingOrder first.
	deriveCachingOrder.

% compile initially/1 rules	
compileEventDescription(_, _, _) :- compileInitially.
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
% compile collectIntervals/1 declarations: 
% combine collectIntervals/1, grounding/1 and indexOf/2 to produce collectIntervals2/2
compileEventDescription(_, _, _) :- compileCollectIntervals.
% compile buildFromPoints/1 declarations:
% combine buildFromPoints/1, grounding/1 and indexOf/2 to produce buildFromPoints2/2
compileEventDescription(_, _, _) :- compileBuildFromPoints.
compileEventDescription(_, InputDescription, _) :- compileAnythingElse(InputDescription).

compileEventDescription(_, _, _) :- writeCachingOrder.

% retract the auxiliary facts asserted during compilation and close the new event description file
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
	compileConditions(BodyWithTimeSpan, NewBody, [T1, T2], false, _),
	%writeCompiledRule('initially', [F=V], NewBody), fail.
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile initiatedAt/2 rules 
compileInitiatedAt :-
	clause(initiatedAt(F=V,T), Body),
	\+ var(F),	
	(
	    	cyclic(F=V),
	    	compileConditions(Body, NewBody, [T1, T2], true, _)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions(Body, NewBody, [T1, T2], false, _)
	),    
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile initiatedAt/4 rules 
% In this case, we assume the author treats timespans correctly inside the rule body 
compileInitiatedAt :-
	clause(initiatedAt(F=V,T1,T,T2), Body),
	\+ var(F),    	
	(
		cyclic(F=V),
	    	compileConditions(Body, NewBody, [], true, _)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions(Body, NewBody, [], false, _)
	    ),	
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile terminatedAt/2 rules 
compileTerminatedAt :-
	clause(terminatedAt(F=V,T), Body),
	\+ var(F),
	(
		cyclic(F=V),
		compileConditions(Body, NewBody, [T1, T2], true, _)
		;
		\+ cyclic(F=V),
		compileConditions(Body, NewBody, [T1, T2], false, _)
	),	
	writeCompiledRule('terminatedAt', [F=V,T1,T,T2], NewBody), fail.
	
% compile terminatedAt/4 rules 
% In this case, we assume the author treats timespans correctly inside the rule body
compileTerminatedAt :-
	clause(terminatedAt(F=V,T1,T,T2), Body),
	\+ var(F),
	(
	   	cyclic(F=V),
	    	compileConditions(Body, NewBody, [], true, _)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions(Body, NewBody, [], false, _)
	),	
	writeCompiledRule('terminatedAt', [F=V,T1,T,T2], NewBody), fail.

% compile initiates/3 rules
compileInitiates :-
	clause(initiates(E,F=V,T), (Body)),
	\+ var(F),	
	(
	    	cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], true, _)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], false, _)
	),    
	writeCompiledRule('initiatedAt', [F=V,T1,T,T2], NewBody), fail.

% compile terminates/3 rules
compileTerminates :-
	clause(terminates(E,F=V,T), (Body)),
	\+ var(F),	
	(
	    	cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], true, _)
	    	;
	    	\+ cyclic(F=V),
	    	compileConditions((happensAt(E,T),Body), NewBody, [T1, T2], false, _)
	),    
	writeCompiledRule('terminatedAt', [F=V,T1,T,T2], NewBody), fail.


% compile holdsFor/2 rules
compileHoldsFor :-
	clause(holdsFor(F=V,I), Body),	
	% the condition below makes sure that we do not compile rules from RTEC.prolog 
	% or any other domain-independent code
	\+ var(F), 
	assertz(allen_count(0)),
	compileConditions(Body, NewBody, [], false, F=V),
	retractall(allen_count(_)),
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
	compileConditions(Body, NewBody, [], false, _),	
	writeCompiledRule('happensAt', [E,T], NewBody), fail.

% compile fi/3 facts.
% p/1 facts do not need any modifications (the arguments of the fluent are always when invoking p/1, because it is always preceeded by fi/3).
% So, we compile p/1 using the compileAnythingElse clause.
compileFI :-
	clause(fi(F1=V1, F2=V2, R), Body),
	write(fi(F1=V1, F2=V2, R)),
        ((Body=true, \+ clause(grounding(F1=V1), _), \+ clause(grounding(F2=V2), _)) -> write('.\n\n') ; write(':-\n')),
	(Body\=true -> (tab(5), write(Body), write(','), nl); true),
        (clause(grounding(F1=V1), _) -> (tab(5), write('grounding('), write(F1=V1), write('),\n')); true),
        (clause(grounding(F2=V2), _) -> (tab(5), write('grounding('), write(F2=V2), write(').\n\n')); true),
        fail.

% unused
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
	indexOf(Index, F=V),	 
	write('collectIntervals2('), write(Index), write(', '), write(F=V), write(')'),
	(clause(grounding(F=V), Body) -> (write(' :-'), nl, tab(5), write(Body), write('.'), nl, nl)
				      ;  write('.\n\n')),
	fail.

% compile buildFromPoints/1 rules
compileBuildFromPoints :-
	buildFromPoints(F=V),
	indexOf(Index, F=V),	 
	write('buildFromPoints2('), write(Index), write(', '), write(F=V), write(')'),
	(clause(grounding(F=V), Body) -> (write(' :-'), nl, tab(5), write(Body), write('.'), nl, nl)
				       ;  write('.\n\n')),
	fail.
	
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
	% The following predicates have either already been compiled or are not required by RTEC.
	\+ member(HeadPredicate,[initially, initiatedAt, terminatedAt, initiates,
				terminates, holdsFor, holdsAt, happensAt, fi,
			    buildFromPoints, collectIntervals, index, dynamicDomain]),
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

compileConditions((\+Head,Rest), (\+NewHead,NewRest), Timespan, Cyclic, FVP) :-	
	!, compileConditions1(Head, NewHead, Timespan, Cyclic, FVP), 
	compileConditions(Rest, NewRest, Timespan, Cyclic, FVP).

compileConditions((Head,Rest), (NewHead,NewRest), Timespan, Cyclic, FVP) :-	
	!, compileConditions1(Head, NewHead, Timespan, Cyclic, FVP), 
	% below TimeSpan is set to [] since the constraint 'T1=<T,T<2'
	% can only be imposed on the first body literal
	compileConditions(Rest, NewRest, [], Cyclic, FVP).

compileConditions(\+Body, \+NewBody, Timespan, Cyclic, FVP) :-	
	!, compileConditions1(Body, NewBody, Timespan, Cyclic, FVP).

compileConditions(Body, NewBody, Timespan, Cyclic, FVP) :-	
	compileConditions1(Body, NewBody, Timespan, Cyclic, FVP).
	

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
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(start(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(startI(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(end(F=V),T), NewBody, Timespan, _Cyclic, _FVP) :-
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
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic, _FVP) :-
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
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic, _FVP) :-
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
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic, _FVP) :-
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
compileConditions1(happensAt(endI(U),T), NewBody, Timespan, Cyclic, _FVP) :-
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
compileConditions1(happensAt(E,T), NewBody, Timespan, _Cyclic, _FVP) :-
	copy_term(E, E1), inputEntity(E1),
	(
		Timespan = [],
		NewBody = happensAtIE(E,T)
		;
		Timespan = [T1, T2],
		NewBody = (happensAtIE(E,T), T1=<T, T<T2)
	), !.
	
% output entity/event
compileConditions1(happensAt(E,T), NewBody, Timespan, _Cyclic, _FVP) :-
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

compileConditions1(initiatedAt(U,T), NewBody, Timespan, _Cyclic, _FVP) :-
	(
		Timespan = [],
		NewBody = initiatedAt(U,T)
		;
		Timespan = [T1, T2],
		NewBody = initiatedAt(U,T1,T,T2)
	), !.
	
%%% terminatedAt/2

compileConditions1(terminatedAt(U,T), NewBody, Timespan, _Cyclic, _FVP) :-
	(
		Timespan = [],
		NewBody = terminatedAt(U,T)
		;
		Timespan = [T1, T2],
		NewBody = terminatedAt(U,T1,T,T2)
	), !.
	

%%% holdsAt

% simple fluent
compileConditions1(holdsAt(F=V,T), NewBody, _Timespan, Cyclic, _FVP) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(Index, F=_),
	(
		Cyclic,
		cyclic(U1),
		NewBody = holdsAtCyclic(Index,F=V,T)
		;
		NewBody = holdsAtProcessedSimpleFluent(Index,F=V,T)
	), !.
	
compileConditions1(holdsAt(I,F=V,T), NewBody, _Timespan, Cyclic, _FVP) :-
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
compileConditions1(holdsAt(F=V,T), holdsAtProcessedIE(Index,F=V,T), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_), !.

% internal entity/statically determined fluent
compileConditions1(holdsAt(F=V,T), holdsAtProcessedIE(Index,F=V,T), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_), !.

% output entity/statically determined fluent
compileConditions1(holdsAt(F=V,T), holdsAtProcessedSDFluent(Index,F=V,T), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_), !.

% statically determined fluent that is neither input nor output entity
compileConditions1(holdsAt(F=V,T), holdsAtSDFluent(F=V,T), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), !.

%%% holdsFor

% simple fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedSimpleFluent(Index,F=V,I), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), simpleFluent(U1), 
	indexOf(Index, F=_), !.

% input entity/statically determined fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedIE(Index,F=V,I), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), inputEntity(U1), 
	indexOf(Index, F=_), !.

% internal entity/statically determined fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedIE(Index,F=V,I), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), internalEntity(U1), 
	indexOf(Index, F=_), !.

% output entity/statically determined fluent
compileConditions1(holdsFor(F=V,I), holdsForProcessedSDFluent(Index,F=V,I), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), outputEntity(U1), 
	indexOf(Index, F=_), !.

% statically determined fluent that is neither input nor output entity
compileConditions1(holdsFor(F=V,I), holdsForSDFluent(F=V,I), _Timespan, _Cyclic, _FVP) :-
        copy_term(F=V, U1), sDFluent(U1), !.

% allen predicates
compileConditions1(allen(before, I1, I2, Outmode ,I), before(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount),
	incr_allen_count(AllenCount), !.
compileConditions1(allen(meets, I1, I2, Outmode ,I), meets(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(allen(starts, I1, I2, Outmode ,I), starts(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(allen(finishes, I1, I2, Outmode ,I), finishes(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(allen(during, I1, I2, Outmode ,I), during(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(allen(overlaps, I1, I2, Outmode ,I), overlaps(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(allen(equal, I1, I2, Outmode ,I), equal(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.

compileConditions1(before(I1, I2, Outmode ,I), before(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount),
	incr_allen_count(AllenCount), !.
compileConditions1(meets(I1, I2, Outmode ,I), meets(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(starts(I1, I2, Outmode ,I), starts(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(finishes(I1, I2, Outmode ,I), finishes(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(during(I1, I2, Outmode ,I), during(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(overlaps(I1, I2, Outmode ,I), overlaps(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.
compileConditions1(equal(I1, I2, Outmode ,I), equal(F=V, AllenCount, I1, I2, Outmode, true, I), _Timespan, _Cyclic, F=V) :-
	allen_count(AllenCount), 
	incr_allen_count(AllenCount), !.


%%% other body literals, eg interval manipulation constructs 
%%% or optimisation checks

% special case for findall
compileConditions1(findall(Targets,user:ECPred,List),findall(Targets,NewECPred,List), Timespan, Cyclic, FVP) :-
	compileConditions(ECPred, NewECPred, Timespan, Cyclic, FVP), !.
	
compileConditions1(findall(Targets,ECPred,List),findall(Targets,NewECPred,List), Timespan, Cyclic, FVP) :-
	compileConditions(ECPred, NewECPred, Timespan, Cyclic, FVP), !.

compileConditions1(Something, Something, _Timespan, _Cyclic, _FVP).

compileConditions1(Something, _T1, _T2, Something, _).

incr_allen_count(Count):-
	retract(allen_count(Count)),
	NewCount is Count + 1,
	assertz(allen_count(NewCount)).

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

%%%%% Automatic derivation of the declarations of the event description %%%%%%%%
%
%%% Some auxiliary predicates %%%
%
% unwrapSimpleFluent(?EntityPredicate, ?SimpleFluent)
unwrapSimpleFluent(initiatedAt(U, _), U).
unwrapSimpleFluent(terminatedAt(U, _), U).
unwrapSimpleFluent(initiatedAt(U, _, _, _), U).
unwrapSimpleFluent(terminatedAt(U, _, _, _), U).
unwrapSimpleFluent(initiates(_, U, _), U).
unwrapSimpleFluent(terminates(_, U, _), U).
unwrapSimpleFluent(fi(_, U, _), U).
unwrapSimpleFluent(initially(U), U).

% unwrapOutputSDFluent(?EntityPredicate, ?SDFluent)
unwrapOutputSDFluent(holdsFor(U, _), U).

% unwrapOutputEvent(?EntityPredicate, ?Event)
unwrapOutputEvent(happensAt(U, _), U).

unwrapOutputEntity(P,U):-
	unwrapSimpleFluent(P, U) ; unwrapOutputSDFluent(P, U) ; unwrapOutputEvent(P, U).

% outputEntityPredicate(?OutputEntityPredicate)
outputEntityPredicate(P):-
	unwrapSimpleFluent(P, _) ; unwrapOutputSDFluent(P, _) ; unwrapOutputEvent(P, _).

%unwrapInputFluent(holdsAt(U, _), U).

% unwrapInputSDFluent(?EntityPredicate, ?SDFluent)
%unwrapInputSDFluent(holdsFor(U, _), U).
%unwrapInputSDFluent(holdsAt(U, _), U).

%outputEntityPre
entityPredicate(holdsAt(_,_)).
entityPredicate(P):-
	unwrapSimpleFluent(P, _) ; unwrapOutputSDFluent(P, _) ; unwrapOutputEvent(P, _).
initiatesOrTerminates(initiates(_,_,_)).
initiatesOrTerminates(terminates(_,_,_)).
deadlinesPredicate(fi(_,_,_)).

%  This is the first step of the compilation. 
%  We derive and assert all possible entity declarations based on the input file. 
%  We will write these declarations in the output file later, in order for the them to be below the compiled rules.
processRules:-
	deriveEntitySorts, % assert all inputEntity, outputEntity, event, simpleFluent, sDFluent declarations.
	deriveIndices, % assert all index/2 declarations that have not been provided.
	%deriveOutputGroundings, % we could consider producing grounding rules for output entities based on the groundings of their dependencies.
	deriveCachingOrder, % assert dependency/2, scc/2 and cyclic/2 declarations that are useful to derive the caching order.
	deriveDynamicEntities, % assert
	fail.

% assumption: input and output entities are mutually exclusive.
% (i) find all entities appearing in the head of at least one rule or as the second argument of an fi rule. These are the output entities.
% (ii) find all entities in the body of at least one rule or in the head of a grounding rule that are not output entities. These are the input entities.
deriveEntitySorts:-
	deriveOutputEntities,
	deriveInputEntities.

% process all possible types of rules and find the entities appearing in the head.
deriveOutputEntities:-
	findall(U, (entityPredicate(Head), clause(Head, _), (
	unwrapSimpleFluent(Head, F0=V0), freeConstants(F0=V0,F=V0), groundValue(F=V0, F=V), \+ outputEntity(F=V), assertz(simpleFluent(F=V)), assertz(outputEntity(F=V)) 
	; unwrapOutputSDFluent(Head, F0=V0), freeConstants(F0=V0,F=V0), groundValue(F=V0, F=V), \+ outputEntity(F=V), assertz(sDFluent(F=V)), assertz(outputEntity(F=V))
	; unwrapOutputEvent(Head, U0), freeConstants(U0,U), \+ outputEntity(U), assertz(event(U)), assertz(outputEntity(U))
	)), _).

% Excluding the asserted output entities, find all entities appearing in the body of a rule or in the head of a grounding rule. These are the input entities.
deriveInputEntities :-
	% find all entities that appear in the body of a rule defining an output entity and have not been flagged as output entities.
	findall(_, (outputEntityPredicate(P), clause(P, Body), deriveBodyInputs(Body)), _),
	% find all entities that have been grounded and have not be discovered so far.
	findall(_, (clause(grounding(U0), _), freeConstants(U0,U), assertInputEntity(U)), _).

% case: not last literal of Body
deriveBodyInputs((\+Literal, Rest)):-
	!, assertInput(Literal),
	deriveBodyInputs(Rest).
deriveBodyInputs((Literal, Rest)):-
	!, assertInput(Literal),
	deriveBodyInputs(Rest).
% case: last literal of Body	
deriveBodyInputs(\+Literal):-
	!, assertInput(Literal).
deriveBodyInputs(Literal):-
	assertInput(Literal).

% through recursive calls, the input may be a variable.
% we do not assert anything in this case. 
assertInput(V):-
	var(V), !.
% assert the statically determined fluent wrapped in a start/end event.
assertInput(happensAt(start(U), _)):-
	!, assertSDF(U).
assertInput(happensAt(end(U), _)):-
	!, assertSDF(U).
assertInput(happensAt(startI(U), _)):-
	!, assertSDF(U).
assertInput(happensAt(endI(U), _)):-
	!, assertSDF(U).
% assert normal events. 
assertInput(happensAt(E, _)):-
	!, assertE(E).
% assert fluent. Only statically determined fluents can be input entities.
assertInput(holdsAt(U, _)):-
	!, assertSDF(U).
assertInput(holdsFor(U, _)):-
	!, assertSDF(U).
% handle the case  
%assertInput(P):-
%outputEntityPredicate(P), !.
% A body literal may be a compound term containing entity predicates.
% For example, see the definition of auxMotionOutcomeEvent in voting.
assertInput(F):-
	F =.. [H1,H2|T], !,
	assertInputAll([H1,H2|T]).
% match anything (constant)
assertInput(_).
% assertInputEntity(+U)
assertInputEntity(F=V):-
	!, assertSDF(F=V).
assertInputEntity(E):-
	assertE(E).

assertInputAll([]).
assertInputAll([H|T]):-
	assertInput(H),
   	assertInputAll(T).

% after freeing its variables, assert sDFluent as input entity
assertSDF(U0):-
	freeConstants(U0, U),
	\+ outputEntity(U), \+ inputEntity(U), !, 
	assertz(sDFluent(U)), assertz(inputEntity(U)).
% match anything
assertSDF(_).

% after freeing its variables, assert event as input entity
assertE(E0):-
	freeConstants(E0, E), 
	\+ outputEntity(E), \+ inputEntity(E), !, 
	assertz(event(E)), assertz(inputEntity(E)).
% match anything
assertE(_).

%% freeConstants(+Entity, -EntityWithGroundArgs)
% Case "Entity is a constant": EntityWithGroundArgs = Entity.
% Case "Entity is a compound term": free recursively the arguments of Entity.
freeConstants(C, C):-
    atom(C), !.
freeConstants(V, V):-
	var(V), !.
freeConstants(F=V, F2=V):-
	!, F=..[FName|Args],
	% if an argument is a compound term, ground recursively.
	freeConstantsList(Args, NewArgs),
	F2=..[FName|NewArgs].
freeConstants(E, E2):-
	!, E=..[EName|Args],
	% if an argument is a compound term, ground recursively.
	freeConstantsList(Args, NewArgs),
	E2=..[EName|NewArgs].

freeConstantsList([], []).
freeConstantsList([Arg|R], [NewArg|NewR]):-
	freeConstantsRec(Arg, NewArg),
	freeConstantsList(R, NewR).

freeConstantsRec(V, V):-
	var(V), !.
freeConstantsRec(C, V):-
	atom(C), !, var(V).
freeConstantsRec(C, V):-
	number(C), !, var(V).
freeConstantsRec(F=V, F2=V):-
	!, F=..[FName|Args],
	% if an argument is a compound term, ground recursively.
	freeConstantsList(Args, NewArgs),
	F2=..[FName|NewArgs].
freeConstantsRec(E, E2):-
	!, E=..[EName|Args],
	% if an argument is a compound term, ground recursively.
	freeConstantsList(Args, NewArgs),
	E2=..[EName|NewArgs].

groundValue(F=V, F=V):-
	nonvar(V), !.
groundValue(F=V, F=V):-
	clause(grounding(F=V), _).
	

% for the entities with no provided index/2 declaration, declare their first argument as their index.
deriveIndices :-
	findall(_, (event(E), \+ index(E, _), findIndexOfEntity(E, FirstArg), assertz(index(E, FirstArg))), _),
	findall(_, ((simpleFluent(F=V) ; sDFluent(F=V)), \+ index(F=V, _), findIndexOfEntity(F, FirstArg), assertz(index(F=V, FirstArg))), _).

% findIndexOfEntity(+Entity,-Index)
% if entity has no args, then its event/fluent type is its index.
findIndexOfEntity(C, C):-
    atom(C), !.
% if entity is a compound term, i.e., it has at least one argument, then search first args recursively until it is not a compound term.
findIndexOfEntity(U, FirstArg):-
	U=..[_, FirstArg0|_],
	firstArgRec(FirstArg0, FirstArg).

% firstArgRec(+Entity,-FirstArgFreed) Aux of: findIndexOfEntity/2.
% first arg may be a compound term. So, we 
firstArgRec(V, V):-
	var(V), !.
firstArgRec(C, V):-
	atom(C), !, var(V).
firstArgRec(U, FirstArg):-
	U=..[_, FirstArg0|_],
	firstArgRec(FirstArg0, FirstArg).

% deriveCachingOrder works as follows: 
% (i) We find all "direct" dependencies among entities and store them in the database as dependency/2 facts.
% Suppose that we have the following rule: 
%  initiatedAt(f1=v1, T):-
%    happensAt(e1, T), 
%    holdsAt(f2=v2, T).
% In that case, we assert that: 
%  dependency(e1, f1=v1) and dependency(f2=v2, f1=v1) (possible arguments of e1, f1 and f2 are asserted as _).
% f1=v1 depends "indirectly" on the dependencies of e1 and f2=v2.
% (ii) We identify the "strongly connected components" (SCCs) of all entities based on the derived dependency/2 facts.
% An entity may depend indirectly on itself. For example, if 
% dependency(f2=v2, f1=v1), dependency(f1=v1, f3=v3), dependency(f3=v3, f2=v2),
% then all fi=vi take part in a cycle of dependences, and thus they are in the same SCC.
% Entities in the same SCC have the same hierarchical level and may be processed in any order.
deriveCachingOrder :-
	% <Entities> contains all outputEntities (F=V, where F contains no constants)
	findall(Entity, outputEntity(Entity), Entities),
	% Assert fdependency/2 and idependency facts. dependency(U1, U2) holds iff there is a rule stating that U2 depends on U1.
	assertDependenciesOfEntities(Entities),
        %write('Printing i-dependencies...'), nl,
        %findall((U1, U2), (idependency(U1,U2), write(idependency(U1,U2)), nl), _),
        %write('Printing f-dependencies...'), nl,
        %findall((U1, U2), (fdependency(U1,U2), write(fdependency(U1,U2)), nl), _),
	% dependency/2 facts induce a 'dependency graph', where entities correspond to nodes and dependency/2 facts form edges among entities.
        findWCCsOfFReducedGraph,
        %write('Printing WCCs of f-reduced dependency graph...'), nl,
        %findall(FRDWCC, (frdwcc(FRDWCC), write(FRDWCC), nl), _),
        findEdgesOfFContractedGraph,
        %write('Printing edges of f-contracted dependency graph...'), nl,
        %findall((FRDWCC1,FRDWCC2), (fcdedge(FRDWCC1,FRDWCC2), write(fcdedge(FRDWCC1,FRDWCC2)), nl), _),
        % Assert all cyclic paths that do not contain repeated nodes.
        assertCyclicPathsInFCD,
        %write('Printing cyclic paths in the f-contracted graph...'), nl,
        %findall(CyclicPath, (cyclicPathInFCD(CyclicPath), write(cyclicPathInFCD(CyclicPath)), nl), _),
        % find the strongly connected components (SCCs) of the contracted dependency graph.
        findSCCsInFCD,
        %write('Printing SCCs in the f-contracted graph...'), nl,
        %findall(SCC, (fcdscc(SCC), write(fcdscc(SCC)), nl), _),
        % find the contracted components (CDCs) of the dependency graph.
        findCDCs,
        %write('Printing the CDCs of the dependency graph...'), nl,
        %findall(CDC, (cdc(CDC), write(cdc(CDC)), nl), _),
        % All entities in a CDC containing an i-edge have to be in a cycle.
	% So, we assert cyclic facts for these entities.
	assertCyclic,
        %write('Printing cyclic FVPs...'), nl,
        %findall(U, (cyclic(U), write(cyclic(U)), nl), _),
        % For each CDC that does not contain cycles, sort its FVPs based on a processing order induced by f-edges.
        sortCDCsbyProcessingOrder,
        %write('Sorted CDCs based on processing order...'), nl,
        %findall(CDC, (cdc(CDC), write(cdc(CDC)), nl), _),
        % find the edges of the contracted graph.
        findEdgesInContractedGraph,
        %write('Printing the edges of the contracted graph...'), nl,
        %findall((U1,U2), (cdedge(U1,U2), write(cdedge(U1,U2)), nl), _),
        findCDCLevels.
        %write('Printing the levels of (the FVPs in) a CDC...'), nl,
        %findall(CDC, (cdc(CDC), cdcLevel(CDC, Level), write(cdcLevel(CDC, Level)), nl), _).

% assertDependenciesOfEntities(+EntitiesList)
assertDependenciesOfEntities([]).
assertDependenciesOfEntities([Entity|Rest]):-
	assertDependencies(Entity),
	assertDependenciesOfEntities(Rest).	
% Find all rules in the input file whose head include <Entity>.
% Fetch the body of each such rule and assert one dependency/2 facts for each body literal including some entity.
% Assert idependency/2 if we have a dependency due to an initiatedAt/terminatedAt rule, and fdependency/2 if we have a dependency because of an fi fact.
% assertDependencies(+Entity)
assertDependencies(Entity):-
	% for rules.
	findall(Body, 
		(outputEntityPredicate(Head), 
		clause(Head, Body),
		unwrapOutputEntity(Head, Entity),
	   	freeConstants(Entity, HeadEntity), % TODO: Do we want to generalise entities. E.g., suspended for merchants and consumers might have a different definition.
		assertBodyDependencies(Body,HeadEntity)), _),
	% for initiates/terminates/3 facts.
	findall(SourceEntity, 
		(initiatesOrTerminates(Head),
		 clause(Head, _Body), % Body is in most cases empty, but not always.
		 Head =.. [_PredicateName, SourceEntity, Entity, _T],
		assertIDependency(SourceEntity, Entity)), _),
	% for fi facts.
	findall(_, 
	     (deadlinesPredicate(Head),
		  clause(Head, _FIBody), % Body is in most cases empty, but not always.
		  Head=..[_PredName, SourceEntity, TargetEntity, _DeadlineLength],
                  % Change to the commented line if you want to assert that all FVPs with the same fluent as the <SourceEntity> depend on <SourceEntity>.
                  assertFDependency(SourceEntity, TargetEntity)), _).
		  

% extractEntity(?FullEntity, ?EntityNoValue)
% extract F=V from start/end wrappers
extractEntity(F=V, F=V):- !.
extractEntity(start(F=V), F=V):- !.
extractEntity(end(F=V), F=V):- !.
extractEntity(startI(F=V), F=V):- !.
extractEntity(endI(F=V), F=V):- !.
extractEntity(E, E).

% getEntity(+Predicate, -Entity)
% Return the valueless entity wrapped in <Predicate>.
getEntity(Predicate, TargetEntity):-
	initiatesOrTerminates(Predicate), !, 
	Predicate =.. [_PredicateName|Arguments],
	Arguments=[_SourceEntity, TargetEntity0, _TimeStamp],
	extractEntity(TargetEntity0, TargetEntity).
getEntity(Predicate, Entity):-
	entityPredicate(Predicate),
	Predicate =.. [_PredicateName, Entity0|_TimeVars],
	extractEntity(Entity0, Entity).
% Handle negated literals.
getEntity(\+Predicate, Entity):-
	entityPredicate(Predicate),
	Predicate =.. [_PredicateName, Entity0|_TimeVars],
	extractEntity(Entity0, Entity).

% assertBodyDependencies(+Body,+HeadEntity)
% case: not last body literal && literal contains an entity.
%assertBodyDependencies((Literal, RestLiterals), HeadEntity):-
    %getEntity(Literal, EntityGnd), !, 
    %assertIDependencyFromEntity(EntityGnd, HeadEntity),     
    %assertBodyDependencies(RestLiterals, HeadEntity).
% case: an entity can be found recursively
assertBodyDependencies((Literal, RestLiterals), HeadEntity):-
        % \+ getEntity(Literal, EntityGnd), 
        assertIDependencies(Literal, HeadEntity), 
	assertBodyDependencies(RestLiterals, HeadEntity).
% case: not last body literal && literal does not contain an entity.
%assertBodyDependencies((_Literal, RestLiterals), HeadEntity):-
    %assertBodyDependencies(RestLiterals, HeadEntity).
% case: last body literal && literal contains an entity.
assertBodyDependencies(Literal, HeadEntity):- 	
        assertIDependencies(Literal, HeadEntity).
        %getEntity(Literal, EntityGnd), !, 
        %assertIDependencyFromEntity(EntityGnd, HeadEntity).
% case: last body literal && literal does not contain an entity.
%assertBodyDependencies(_Literal, _HeadEntity).

assertIDependencyFromEntity(EntityGnd, HeadEntity):-
	% freeConstants turns constants in entity arguments to variables.
        freeConstants(EntityGnd, Entity),
	assertIDependency(Entity, HeadEntity).

assertIDependenciesFromList([], _HeadEntity).
assertIDependenciesFromList([Term|Rest], HeadEntity):-
    assertIDependencies(Term, HeadEntity),
    assertIDependenciesFromList(Rest, HeadEntity).

assertIDependencies(Literal, _HeadEntity):-
    var(Literal), !.

assertIDependencies(Literal, _HeadEntity):-
    atomic(Literal), !.

assertIDependencies(Literal, HeadEntity):-
    getEntity(Literal, EntityGnd), !, 
    assertIDependencyFromEntity(EntityGnd, HeadEntity).

assertIDependencies(Literal, HeadEntity):-
    Literal =.. [_LName | Args], !,
    assertIDependenciesFromList(Args, HeadEntity).

assertIDependencies(_, _).

% assertIDependency(+BodyEntity, +HeadEntity)
% This predicate asserts idependency(BodyEntity, HeadEntity).
% In all cases, we first check whether this dependency fact is already in the knowledge base to avoid duplicates.
%case: the body entity is a fluent-value pair whose value is a free variable.
% 	   Assert one dependency fact for each possible value of the body fluent.
assertIDependency(F=V, HeadEntity):-
	var(V), !,
	findall(V1, 
                ((simpleFluent(F=V1) ; sDFluent(F=V1)),
                 \+idependency(F=V1, HeadEntity), 
                assertz(idependency(F=V1, HeadEntity))), _). %, write(dependency(F=V1, HeadEntity)), nl), _).
% case: <BodyEntity> is an event or a FVP with a ground value.
assertIDependency(BodyEntity, HeadEntity):-
	\+idependency(BodyEntity, HeadEntity), !, 
	assertz(idependency(BodyEntity, HeadEntity)). %, write(dependency(BodyEntity, HeadEntity)), nl.
% case: dependency fact already present. So, do nothing.
assertIDependency(_, _).

% assertFDependency(+BodyEntity, +HeadEntity)
% This predicate asserts fdependency(BodyEntity, HeadEntity).
% We first check whether this dependency fact is already in the knowledge base to avoid duplicates.
assertFDependency(BodyEntity, HeadEntity):-
	\+fdependency(BodyEntity, HeadEntity), !, 
	assertz(fdependency(BodyEntity, HeadEntity)). %, write(dependency(BodyEntity, HeadEntity)), nl.
% The dependency fact already present. So, do nothing.
assertFDependency(_, _).

inFRDWCC(F=V, FRDWCC):-
    frdwcc(FRDWCC),
    member(F=V, FRDWCC), !.

fdependencyUndirected(U1, U2):-
    fdependency(U1, U2), !.

fdependencyUndirected(U1, U2):-
    fdependency(U2, U1).

fpath(U1, U2):-
    fdependencyUndirected(U1, U2), !.

fpath(U1, U2):-
    fdependencyUndirected(U1, Z),
    fpath(Z, U2), !.

deriveFRDWCC(F=V, [F=V]):-
    \+ fdependencyUndirected(F=V,_), !.

deriveFRDWCC(F=V, [F=V|FRDWCC]):-
    findall(U, fpath(U, F=V), FRDWCC).
    
findWCCsOfFReducedGraph:-
    % The f-contracted graph contains one vertex for each WCC of the f-reduced graph. These WCCs are stored in frdwcc/1 facts.
    % For each simple fluent, assert the WCC of the f-reduced graph that contains its vertex, provided that this WCC has not been asserted already.
    findall(F=V, (simpleFluent(F=V), \+inFRDWCC(F=V, _), deriveFRDWCC(F=V, FRDWCC), assertz(frdwcc(FRDWCC))), _),
    % Events and statically-determined fluents do not appear in fi facts, and thus they are not connected with f-edges.
    % The vertex of an event or statically-determined fluent forms a WCC in the f-reduced graph, i.e., the vertex is disconnected from all other edges.
    findall(F=V, (event(E), assertz(frdwcc([E]))), _),
    findall(F=V, (sDFluent(F=V), assertz(frdwcc([F=V]))), _).

findEdgesOfFContractedGraph:-
    % Each i-edge in the dependency graph is transformed into an edge of the f-contracted graph, which connected the corresponding WCC-vertices.
    % The edges in the f-contracted graph are unique.
    % The vertices of these new edges are marked with WCCs of the f-reduced graph.
    findall((U1,U2), (idependency(U1,U2), inFRDWCC(U1,FRDWCC1), inFRDWCC(U2,FRDWCC2), \+ FRDWCC1=FRDWCC2, \+fcdedge(FRDWCC1, FRDWCC2), assertz(fcdedge(FRDWCC1, FRDWCC2))), _).

% assert fact cyclicPathInFCD(CyclicPath) if CyclicPath is cycle of the f-contracted dependency graph that does not contain vertex repetitions.
assertCyclicPathsInFCD:-
    % For each simple fluent F=V, assert all cyclic paths that start and end at F=V.
    findall(FRDWCC, (frdwcc(FRDWCC), deriveCyclicPathInFCD(FRDWCC,CyclicPathStartingFromFRDWCC), assertz(cyclicPathInFCD(CyclicPathStartingFromFRDWCC))), _).

deriveCyclicPathInFCD(FRDWCC1, CyclicPathStartingFromFRDWCC):-
    deriveCyclicPathInFCD0(FRDWCC1, FRDWCC2, [], CyclicPathStartingFromFRDWCC),
    % The arguments of the first and the last FVP in the path do not need to unify. It suffices that the fluent type and the value are the same.
    checkSameFRDWCCs(FRDWCC1,FRDWCC2).

deriveCyclicPathInFCD0(StartNode, CurrentNode, PathSoFar, [StartNode,CurrentNode|PathSoFar]):-
    % If there is an edge pointing to the first node of the path, close the cycle.
    fcdedge(CurrentNode, StartNode).

deriveCyclicPathInFCD0(StartNode,CurrentNode, PathSoFar, FinalPath):-
    % Move to NextNode, if it is not part of the path so far.
    fcdedge(CurrentNode,NextNode), \+ member(NextNode,PathSoFar),
    deriveCyclicPathInFCD0(StartNode,NextNode,[CurrentNode|PathSoFar], FinalPath).

checkSameFRDWCCs([], []).
checkSameFRDWCCs([F1=V|RestUs1], [F2=V|RestUs2]):-
    F1=..[FType|_],
    F2=..[FType|_],
    checkSameFRDWCCs(RestUs1, RestUs2).

%% isCyclic(+F=+V)
% check if F=V is part of a cycle created by dependency/2 facts.
isCyclic(FRDWCC):-
   cyclicPathInFCD([FRDWCC|_]), !.

removeDuplicates([], Final, Final).
removeDuplicates([Entity0|Rest], Curr, Final):-
	freeConstants(Entity0, Entity), 
	member(Entity, Curr), !, 
	removeDuplicates(Rest, Curr, Final).
removeDuplicates([Entity0|Rest], Curr, Final):-
	freeConstants(Entity0, Entity), 
	removeDuplicates(Rest, [Entity|Curr], Final).

% return a list of FVPs that appear in a cycle including F=V. These FVPs comprise a strongly-connected component (SCC) of the graph.
inAnyCyclicPathOf(FRDWCC, FinalEntities):-
        findall(Entity, (cyclicPathInFCD([FRDWCC|T]), member(Entity, [FRDWCC|T])), Entities), 
        removeDuplicates(Entities, [], FinalEntities).

% check if the SCC of F=V has been derived at a previous step.
inSCC(FRDWCC):-
	fcdscc(SCC), member(FRDWCC, SCC).

% For each cyclic simple fluent whose SCCs have not been derived at a previous step, compute and assert its SCC.
findSCCsInFCD:-
	findall(FRDWCC, 
		(frdwcc(FRDWCC), isCyclic(FRDWCC), 
		\+ inSCC(FRDWCC),
		inAnyCyclicPathOf(FRDWCC, SCC), assertz(fcdscc(SCC))),
		_EntitiesInCycle), fail.

% For the entities U that are not cyclic, assert scc([U]).
findSCCsInFCD:-
	findall(FRDWCC, (frdwcc(FRDWCC), \+isCyclic(FRDWCC), \+inSCC(FRDWCC), assertz(fcdscc([FRDWCC]))), _).


flattenFCDSCC([], CDC, CDC).

flattenFCDSCC([FRDWCC|RestFRDWCC], CurrentCDC, FinalCDC):-
    append(FRDWCC, CurrentCDC, NewCDC),
    flattenFCDSCC(RestFRDWCC, NewCDC, FinalCDC).

findCDCs:-
    findall(FCDSCC, (fcdscc(FCDSCC), flatten(FCDSCC,CDC), assertz(cdc(CDC))), _).

% check if the SCC of F=V has been derived at a previous step.
inCDC(U, CDC):-
    cdc(CDC), member(U, CDC).

findEdgesInContractedGraph:-
    % Each edge in the f-contracted graph is transformed into an edge of the contracted graph, which connects the corresponding CDC-vertices.
    % The edges in the contracted graph are unique.
    % The vertices of these new edges are marked with the CDCs of the dependency graph.
    findall((U1,U2), (idependency(U1,U2), inCDC(U1,CDC1), inCDC(U2,CDC2), \+ CDC1=CDC2, \+cdedge(CDC1, CDC2), assertz(cdedge(CDC1, CDC2))), _).


iEdgeInCDC(CDC):-
    member(U1, CDC), 
    member(U2, CDC),        
    idependency(U1,U2), !.

assertCyclic:-
	findall(CDC,
		(cdc(CDC),
                iEdgeInCDC(CDC),
		assertCyclic(CDC)),
		_).

assertCyclic([]).
assertCyclic([F=V|Rest]):-
	findall(F=V, (simpleFluent(F=V), assertz(cyclic(F=V))), _), 
	assertCyclic(Rest).

getProcessingOrder([], _Visited, []).
getProcessingOrder([U|RestU], Visited, CDCSorted):-
    member(U, Visited), !,
    getProcessingOrder(RestU, Visited, CDCSorted).
getProcessingOrder([U|RestU], Visited, CDCSorted):-
    % \+ member(U, Visited),
    fdependency(U,V),
    member(V, Visited), !,
    getProcessingOrder(RestU, [U|Visited], CDCSortedPrefix),
    append(CDCSortedPrefix, [U], CDCSorted).
getProcessingOrder([U|RestU], Visited, CDCSorted):-
    % \+ member(U, Visited),
    fdependency(U,V), !,
    % \+ member(V, Visited), !,
    getProcessingOrder([V,U|RestU], Visited, CDCSorted).
getProcessingOrder([U|RestU], Visited, CDCSorted):-
    \+ fdependency(U, _), !,
    getProcessingOrder(RestU, [U|Visited], CDCSortedPrefix),
    append(CDCSortedPrefix, [U], CDCSorted).

assertCDCsInList([]).
assertCDCsInList([CDC|RestCDCs]):-
    assertz(cdc(CDC)),
    assertCDCsInList(RestCDCs).

sortCDCsbyProcessingOrder:-
    findall(CDCSorted, (cdc(CDC), \+iEdgeInCDC(CDC), getProcessingOrder(CDC, [], CDCSorted), retract(cdc(CDC))), ListOfSortedCDCs),
    assertCDCsInList(ListOfSortedCDCs).

getCDCLevel(CDC, 0):-
    \+ cdedge(_, CDC), !.

getCDCLevel(CDC, Level):-
    findall(LevelPrev, (cdedge(CDCPrev, CDC), getCDCLevel(CDCPrev, LevelPrev)), PrevLevels),
    max_list(PrevLevels, MaxPrevLevel),
    Level is MaxPrevLevel + 1.

findCDCLevels:-
    findall(CDC, (cdc(CDC), getCDCLevel(CDC, Level), assertz(cdcLevel(CDC, Level))), _).

entityCachingLevel(Entity, Level):-
    cdcOfEntity(Entity, CDC),
    cdcLevel(CDC, Level).

cdcOfEntity(Entity, CDC):-
	cdc(CDC), member(Entity, CDC).

% State that the predicated declared with the dynamicDomain/1 are dynamic predicates at the top of the compiled file.
deriveDynamicEntities:-
	% Find the predicate name and the arity of all dynamic entities.
	findall([Name, ArgNo], (dynamicDomain(DE), DE=..[Name|Args], length(Args,ArgNo)), DynamicEntities),
	% If there is at least one dynamic entity, write a 'dynamic' declaration at the top of the compiled file.
	length(DynamicEntities, Len),
	(Len>0 -> write(':- dynamic '), writeDynamicEntities(DynamicEntities); true).

%special case for the last dynamic entity.
writeDynamicEntities([[Name,ArgNo]]):-
	!, write(Name), write('/'), write(ArgNo), write('.\n\n').

%write the next dynamic entity.
writeDynamicEntities([[Name,ArgNo]|T]):-
	write(Name), write('/'), write(ArgNo), write(', '),
	writeDynamicEntities(T).

% Write the declaration of the event description under the compiled rules.
writeDeclarations :-
	writeEntities,
	writeIndices,
	%writeGroundings,
	writeCachingOrder, fail.

% For each entity there should be
% (a) a fact stating whether it is an input or output entity.
% (b) a fact stating whether it is an event, a simple fluent or a statically determined fluent.
writeEntities :-
	findall(_, (inputEntity(Entity), write(inputEntity(Entity)), write('.\n')), _), write('\n'),
	findall(_, (outputEntity(Entity), write(outputEntity(Entity)), write('.\n')), _), write('\n'),
	findall(_, (event(Entity), write(event(Entity)), write('.\n')), _), write('\n'),
	findall(_, (simpleFluent(Entity), write(simpleFluent(Entity)), write('.\n')), _), write('\n'),
	findall(_, (sDFluent(Entity), write(sDFluent(Entity)), write('.\n')), _), write('\n').

% there should be an index declaration for each entity.
writeIndices :-
	findall(_, (index(U, I), write(index(U, I)), write('.\n')), _), write('\n'). 

% write collectGrounds and dgrounded declarations for the dynamic entities.
writeDynamicGroundingRules:-
	% fetch the grounding rules for input entities.
	findall([InputEntity, Body], (inputEntity(InputEntity), clause(grounding(InputEntity), Body)), Rules),
	% assert auxiliary 'dynamicAndGrounder' facts for (DynamicEntity, InputEntity) pairs.
	assertDynamicAndGrounder(Rules),
	% collect all dynamic entities
	findall(DE, dynamicDomain(DE), DynamicEntities),
	% write a collectGrounds rules for each dynamic entity, based on the dynamicAndGrounder assertions
	findCollectGrounds(DynamicEntities),
	% write all 
	findDGrounded,
	fail.

findCollectGrounds([]):-
	(retractall(dynamicAndGrounder(_,_)), ! ; true).
findCollectGrounds([DE|RestDEs]):-
	write('collectGrounds(['),
	assertz(first),
	(
	 dynamicAndGrounder(DE, IE), (first -> retract(first); write(', ')), write(IE), fail ;
	 true
	 ),
	write('],' ), write(DE), write(').\n\n'),
	findCollectGrounds(RestDEs).

assertDynamicAndGrounder([]).
assertDynamicAndGrounder([[InputEntity,Body]|T]):-
	assertDynamicAndGrounder0(Body, InputEntity),
	assertDynamicAndGrounder(T).
% case: not last literal
assertDynamicAndGrounder0((DynamicEntity, T), InputEntity):-
	dynamicDomain(DynamicEntity), !, assertz(dynamicAndGrounder(DynamicEntity, InputEntity)),
	assertDynamicAndGrounder0(T, InputEntity).
assertDynamicAndGrounder0((_NotDynamicEntity, T), InputEntity):-
	!, assertDynamicAndGrounder0(T, InputEntity).
% case: last literal
assertDynamicAndGrounder0(DynamicEntity, InputEntity):-
	dynamicDomain(DynamicEntity), !, assertz(dynamicAndGrounder(DynamicEntity, InputEntity)).
assertDynamicAndGrounder0(_NotDynamicEntity, _InputEntity).

findDGrounded:-
	% collect all rules of output entities.
	findall([OutputEntity, Body], (outputEntity(OutputEntity), clause(grounding(OutputEntity), Body)), Rules),
	% assert a dgrounded fact for each dynamic entity appearing in such a rule.
	writeDGrounded(Rules).

% write all dgrounded facts induced by each such rule.
writeDGrounded([]).
writeDGrounded([Rule|Rest]):-
	writeDGroundedRule(Rule),	
	writeDGrounded(Rest).
% for each body literal that is a dynamic entity, write the corresponding dgrounded fact.
writeDGroundedRule([OutputEntity, (H, T)]):-
	dynamicDomain(H), !, write('dgrounded('), write(OutputEntity), write(', '), write(H), write(').\n'),
	writeDGroundedRule([OutputEntity, T]).
writeDGroundedRule([OutputEntity, (_H, T)]):-
	!, writeDGroundedRule([OutputEntity, T]).
writeDGroundedRule([OutputEntity, H]):-
	dynamicDomain(H), !, write('dgrounded('), write(OutputEntity), write(', '), write(H), write(').\n').
writeDGroundedRule([_OutputEntity, _H]).

%%%% derive cachingOrder2 from rule structure, without requiring cachingOrder declarations.
%
% writeCachingOrder assigns hierarchical levels to SCCs and write the cachingOrder2 rules of these entities in ascending SCC level order.
% For example, if SCCi=[f1=v1, f2=v2], then the hierarchical level of SCCi is:
% level(SCCi)=max(maxLevelInBodiesOf(f1=v1),maxLevelInBodiesOf(f2=v2))+1.
% Bottom case: level(SCC)=1 if SCC contains only one input entity.
% this is the last operation of the rule compilation. 
% we do not retract dependencies and sccs yet, because they are needed to construct the dependency graph.
writeCachingOrder :-
	% write the asserted cyclic/1 declarations in the compiled file.
	% retract the asserted cyclic facts, because they may be re-asserted if the user invokes RTEC in the same Prolog session.
	writeAndRetractCyclic,
	% derive hierachical levels of SCCs and write cachingOrder2 rules in the correct order.
	writeCachingOrder(1).

writeAndRetractCyclic:-
	findall(F=V, (simpleFluent(F=V), cyclic(F=V), write('cyclic('), write(F=V), write(').'), nl, retract(cyclic(F=V))), _), nl.

% writeCachingOrder(+Level)
% if there are entity with hierarchical level = <Level>,
% then write the corresponding rules and move to the next level.
writeCachingOrder(Level):-
	findall(CDC, (cdc(CDC), cdcLevel(CDC, Level)), CDCsInLevel),
	\+ CDCsInLevel = [], !,
	writeCachingOrderRulesOfCDCs(CDCsInLevel, Level),
	NextLevel is Level + 1,
	writeCachingOrder(NextLevel).
	
% If Entities=[] for some level, then there are no entities with a larger level
% So, retract all cachingLevels and exit.
writeCachingOrder(_).

writeCachingOrderRulesOfCDCs([], _Level).
writeCachingOrderRulesOfCDCs([CDC|RestCDCs], Level):-
    writeCachingOrderRulesOf(CDC, 1, Level),
    writeCachingOrderRulesOfCDCs(RestCDCs, Level).

% writeCachingOrderRulesOf(+Entities)
% write the cachingOrder2 rules of all given entities.
writeCachingOrderRulesOf([], _ProcOrd, _Level).
writeCachingOrderRulesOf([Entity|Rest],  ProcOrd, Level):-
        %findall(Entity, (extractEntity(Entity, Entity0), 
	indexOf(Index, Entity),
        % If there is a grounding declaration for <Entity>:
	clause(grounding(Entity), Body), !,
        freeConstants(Entity, EntityNoConst), 
        % Write cachingOrder2 rule with body "grounding" facts.
	write('cachingOrder2('), write(Index), write(', '), write(EntityNoConst), write(') :-'), write(' % level in dependency graph: '), write(Level), write(', processing order in component: '), write(ProcOrd), nl, 
	tab(5), write(Body), write('.'), nl, nl,
        NextProcOrd is ProcOrd + 1,
	writeCachingOrderRulesOf(Rest, NextProcOrd, Level).

% If there is no grounding rule for an entity, then RTEC should process that entity?
% If the answer is no, use the following rule:
writeCachingOrderRulesOf([_|Rest], ProcOrd, Level):-
    writeCachingOrderRulesOf(Rest, ProcOrd, Level).
% If the answer is yes, use the following rule:
%writeCachingOrderRulesOf([Entity|Rest], ProcOrd, Level):-
        %findall(Entity, (extractEntity(Entity, Entity0), write('Entity: '), write(Entity), nl,
        %indexOf(Index, Entity),
        % There is no grounding declaration for <Entity>:
        %\+ clause(grounding(Entity), Body),
        % So, write a cachingOrder2 fact:
        %write('cachingOrder2('), write(Index), write(', '), write(Entity), write(').'), write(' % level in dependency graph: '), write(Level), write(', processing order in component: '), write(ProcOrd), nl,
        %NextProcOrd is ProcOrd + 1,
        %tab(5), write(Body), write('.'), nl, nl), _), 
        %writeCachingOrderRulesOf(Rest, NextProcOrd, Level).








%%%%%%% DEPENDENCY GRAPH GENERATION %%%%%%%%%
% The following code creates a specification of the dependency graph in the DOT language.
% The script running RTEC may subsequently invoke Graphviz to transform the dot file into a png.

% Write in a txt file the hierarchical levels of entities and their dependencies in a format accepted by GraphViz.
%createDependencyGraphTxt(+ApplicationName, +EventsFlag)
% Possible values of <EventsFlag>: 
%	'withEvents' -> show the 0th level of the dependency graph.
%	'withoutEvents'. -> do not show the 0th level of the dependency graph.
createDependencyGraphTxt(DGFile, EventsFlag):-
	% make the file for the DOT specification of the dependency graph the default output.
	tell(DGFile),
	write("digraph\n{\n\tnode [shape=record, style=filled, fillcolor=white, fontsize=16.0];\n\trankdir=LR;\n\tranksep=\"1.2 equally\"\n\n"),
	% first, we specify the entities that are in each level of the graph.
	writeCDCLevelByLevel(EventsFlag),
	write("\n"),
	% next, we specify the edges, i.e, all dependencies among entities.
	writeAllDependencies(EventsFlag),
	write("}\n"),
	told.


anyDependency(U1,U2):-
    idependency(U1,U2).

anyDependency(U1,U2):-
    fdependency(U1,U2).


writeAllDependencies(EventsFlag):-
		findall((DependsOn, Entity),
	   		(anyDependency(DependsOn, Entity),
			 % if <EventsFlag> is withoutEvents, then do not write edges stemming from the first level of the hierarchy.
			 (EventsFlag=withoutEvents -> outputEntity(DependsOn) ; EventsFlag=withEvents), 
			 % Fetch the hierarchy level of each entity and make sure they are different, i.e., the entities are not in a cycle.
			 entityCachingLevel(DependsOn, LevelSource),
			 entityCachingLevel(Entity, LevelTarget),
			 \+LevelSource=LevelTarget,
			 write("\t"), write(LevelSource), write(":\""),
			 writeEntityUnderscores(DependsOn),
			 write("\" -> "), write(LevelTarget), write(":\""),
			 writeEntityUnderscores(Entity), write("\"\n"))
			 , _).

writeCDCLevelByLevel(withEvents):-
	!, writeCDCLevelByLevel(0).

writeCDCLevelByLevel(withoutEvents):-
	!, writeCDCLevelByLevel(1).

writeCDCLevelByLevel(Level):-
	findall(CDC, (cdc(CDC), cdcLevel(CDC,Level)), CDCs),
	CDCs=[], !.

writeCDCLevelByLevel(Level):-
	findall([CDC, Color], (cdc(CDC), cdcLevel(CDC,Level),
			       (length(CDC, 1), Color=black ; length(CDC, Len), Len>1, getNextColor(Color))),
				CDCAndColors),
	write("\t"), write(Level), write(" [shape=none label=<<table border=\"0\" cellspacing=\"0\">\n"),
	writeAllEntitiesInCDCsAndColors(CDCAndColors),
	write("\t</table>>\n\t]\n\n"),
	NextLevel is Level + 1,
	writeCDCLevelByLevel(NextLevel).

writeAllEntitiesInCDCsAndColors([]).
writeAllEntitiesInCDCsAndColors([[CDC, Color]|Rest]):-
	writeEntitiesWithColor(CDC, Color),
	writeAllEntitiesInCDCsAndColors(Rest).
	
writeEntitiesWithColor([], _Color).
writeEntitiesWithColor([U|Rest], Color):-
	(anyDependency(U,_) ; anyDependency(_,U)), !, % write entities having at least one incoming or outgoing edge.
	write("\t\t<tr><td port=\""), writeEntityUnderscores(U), write("\" border=\"1\" color=\""), write(Color), write("\">"), writeEntityUnderscores(U), write("</td></tr>\n"),
	writeEntitiesWithColor(Rest, Color).
writeEntitiesWithColor([_U|Rest], Color):-
	writeEntitiesWithColor(Rest, Color).

:- dynamic nextColor/1.
% color each cycle (CDC with more that one entity) with a different color, if possible.
% reuse cyclicly the colors in the following list.
nextColor(0).
graphVizColors([red, blue, green4, orangered1, steelblue3, yellow3, violetred1, thistle2]).
getNextColor(Color):-
	retract(nextColor(ColorID)),
	graphVizColors(Colors),
	nth0(ColorID, Colors, Color),
	length(Colors, ColorsNo),
	ColorIDNext is (ColorID +1) mod ColorsNo,
	assertz(nextColor(ColorIDNext)).

writeAllEntitiesInCDC([U]):- !,
	write("<"), writeEntityUnderscores(U), write("> "), writeEntityUnderscores(U), write("\"];\n").
writeAllEntitiesInCDC([U|Rest]):-
	write("<"), writeEntityUnderscores(U), write("> "), writeEntityUnderscores(U), write("|"),
	writeAllEntitiesInCDC(Rest).

writeEntityUnderscores(F=V):-
	var(V), !, writeEntityUnderscores(F), write("="), write("_").

writeEntityUnderscores(F=V):-
	!, writeEntityUnderscores(F), write("="), write(V).

writeEntityUnderscores(E):-
	E =.. [EntityName|Args],
	Args=[], !,
	write(EntityName).

writeEntityUnderscores(E):-
	E =.. [EntityName|Args], !,	
	write(EntityName), write("("), writeArgsUnderscores(Args), write(")").

writeArgsUnderscores([Arg]):-
	var(Arg), 
	!, write("_"). 

writeArgsUnderscores([Arg]):-
	Arg =.. [_ArgName|ArgArgs],
	\+ ArgArgs=[], !,
	writeEntityUnderscores(Arg).

writeArgsUnderscores([_Arg]):-
	!, write("_"). 

writeArgsUnderscores([Arg|RestArgs]):-
	var(Arg), 
	!, write("_, "),
	writeArgsUnderscores(RestArgs).

writeArgsUnderscores([Arg|RestArgs]):-
	Arg =.. [_ArgName|ArgArgs],
	\+ ArgArgs=[], !,
	writeEntityUnderscores(Arg), 
	writeArgsUnderscores(RestArgs).

writeArgsUnderscores([_Arg|RestArgs]):-
	write("_, "),
	writeArgsUnderscores(RestArgs).

/*
createDependenciesFile(File):-
	tell(File),
	findall((DependsOn, Entity), (anyDependency(DependsOn, Entity), writeDependency(DependsOn, Entity)), _),
	told.

writeDependency(DependsOn, Entity):-
	cdc(CDC), member(DependsOn, CDC), member(Entity, CDC), !,
	write("cyclic_dependency("), writeEntityUnderscores(DependsOn), write(","), writeEntityUnderscores(Entity), write(").\n").

writeDependency(DependsOn, Entity):-
	write("dependency("), writeEntityUnderscores(DependsOn), write(","), writeEntityUnderscores(Entity), write(").\n").
*/
