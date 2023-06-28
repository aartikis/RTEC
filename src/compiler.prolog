
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
:- discontiguous event/1, inputEntity/1, index/2, simpleFluent/1, outputEntity/1, sDFluent/1, initiatedAt/2, terminatedAt/2, holdsFor/3, grounding/1, dgrounded/2, initiatedAt/4, terminatedAt/4, maxDurationUE/3, maxDuration/3, holdsFor/2, initially/1, initiates/3, terminates/3.

% these predicates may or may not appear in the input rules and declarations files.
:- dynamic initially/1, initiatedAt/2, initiatedAt/4, terminatedAt/2, terminatedAt/4, initiates/3, terminates/3, happensAt/2, holdsFor/2, holdsAt/2, grounding/1, cyclic/1, collectIntervals/1, buildFromPoints/1, internalEntity/1, simpleFluent/1, sDFluent/1, event/1, outputEntity/1, inputEntity/1, index/2, dynamicDomain/1.

:- multifile indexOf/2.

% these predicates are asserted dynamically by the compiler.
% they should be retracted before terminating.
:- dynamic scc/1, dependency/2, dynamicAndGrounder/2.

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
	retractall(dependency(_,_)).



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

% compile initially/1 rules	
compileEventDescription(_, _) :- compileInitially.
% compile initiatedAt/2 rules
compileEventDescription(_, _) :- compileInitiatedAt.
% compile terminatedAt/2 rules
compileEventDescription(_, _) :- compileTerminatedAt.
% compile initiates/3 rules
compileEventDescription(_, _) :- compileInitiates.
% compile terminates/3 rules
compileEventDescription(_, _) :- compileTerminates.
% compile holdsFor/2 rules
compileEventDescription(_, _) :- compileHoldsFor.
% compile holdsAt/2 rules
compileEventDescription(_, _) :- compileHoldsAt.
% compile happensAt/2 rules
compileEventDescription(_, _) :- compileHappensAt.
% compile maxDuration/3 facts
compileEventDescription(_,_) :- compileMaxDuration.
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

compileMaxDuration :-
	clause(maxDuration(F1=V1, F2=V2, R), Body),
	write(maxDuration(F1=V1, F2=V2, R)), write(':-\n'),	
	(Body\=true -> (tab(5), write(Body), write(','), nl); true),
	tab(5), write('grounding('), write(F1=V1), write('),\n'),
	tab(5), write('grounding('), write(F2=V2), write(').\n\n'), fail.

compileMaxDuration :-
	clause(maxDurationUE(F1=V1, F2=V2, R), Body),
	write(maxDurationUE(F1=V1, F2=V2, R)), write(':-\n'),
	(Body\=true -> (tab(5), write(Body), write(','), nl); true),
	tab(5), write('grounding('), write(F1=V1), write('),\n'),
	tab(5), write('grounding('), write(F2=V2), write(').\n\n'), fail.

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
	% The following predicates have either already been compiled or are not required by RTEC.
	\+ member(HeadPredicate,[initially, initiatedAt, terminatedAt, initiates,
				terminates, holdsFor, holdsAt, happensAt, maxDuration, maxDurationUE,
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
unwrapSimpleFluent(maxDuration(_, U, _), U).
unwrapSimpleFluent(maxDurationUE(_, U, _), U).
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
deadlinesPredicate(maxDuration(_,_,_)).
deadlinesPredicate(maxDurationUE(_,_,_)).

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
% (i) find all entities appearing in the head of at least one rule or as the second argument of a maxDuration(UE) rule. These are the output entities.
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

% assert the statically determined fluent wrapped in a start/end event.
assertInput(happensAt(start(U), _)):-
	!, assertSDF(U).
assertInput(happensAt(end(U), _)):-
	!, assertSDF(U).
% assert normal events. 
assertInput(happensAt(E, _)):-
	!, assertE(E).
% assert fluent. Only statically determined fluents can be input entities.
assertInput(holdsAt(U, _)):-
	!, assertSDF(U).
assertInput(holdsFor(U, _)):-
	!, assertSDF(U).
% A body literal may be a compound term containing entity predicates.
% For example, see the definition of auxMotionOutcomeEvent in voting.
assertInput(F):-
	F =.. [H1,H2|T], !,
	assertInputAll([H1,H2|T]).
% match anything
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

freeConstants(V, V):-
	var(V), !.
freeConstants(C, V):-
	atom(C), !, var(V).
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
	freeConstants(Arg, NewArg),
	freeConstantsList(R, NewR).

groundValue(F=V, F=V):-
	nonvar(V), !.
groundValue(F=V, F=V):-
	clause(grounding(F=V), _).
	

% for the entities with no provided index/2 declaration, declare their first argument as their index.
deriveIndices :-
	findall(_, (event(E), \+ index(E, _), firstArgRec(E, FirstArg), assertz(index(E, FirstArg))), _),
	findall(_, ((simpleFluent(F=V) ; sDFluent(F=V)), \+ index(F=V, _), firstArgRec(F, FirstArg), assertz(index(F=V, FirstArg))), _).

% first arg may be a compound term. So, we search first args recursively until it is not a compound term.
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
	% Assert dependency/2 facts. dependency(U1, U2) holds iff there is a rule stating that U2 depends on U1.
	assertDependenciesOfEntities(Entities),
	%findall(_, (dependency(X, Y), write(dependency(X, Y)), nl), _),
	% dependency/2 facts induce a 'dependency graph', where entities correspond to nodes and dependency/2 facts form edges among entities.
	% find the strongly connected components (SCCs) of the dependency graph.
	findSCCs,
	% All entities in a SCC containing more than 1 entity are part of at least one cycle.
	% So, we assert cyclic facts for these entities.
	assertCyclic.

% assertDependenciesOfEntities(+EntitiesList)
assertDependenciesOfEntities([]).
assertDependenciesOfEntities([Entity|Rest]):-
	assertDependencies(Entity),
	assertDependenciesOfEntities(Rest).	
% assertDependencies(+Entity)
% Find all rules in the input file whose head include <Entity>.
% Fetch the body of each such rule and assert one dependency/2 facts for each body literal including some entity.
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
		 clause(Head, true),
		 Head =.. [_PredicateName, SourceEntity, Entity, _T],
		assertDependency(SourceEntity, Entity)), _),
	% for maxDuration and maxDurationUE facts.
	findall(_, 
	     (deadlinesPredicate(Head),
		  clause(Head, true),
		  Head=..[_PredName, SourceEntity, TargetEntity, _DeadlineLength],
		  assertDependency(SourceEntity, TargetEntity)), _).
		  

% assertBodyDependencies(+Body,+HeadEntity)
% case: not last body literal && literal contains an entity.
assertBodyDependencies((Literal, RestLiterals), HeadEntity):-
	% freeConstants turns constants in entity arguments to variables.
	getEntity(Literal, EntityGnd), !, freeConstants(EntityGnd, Entity), 
	assertDependency(Entity, HeadEntity),
	assertBodyDependencies(RestLiterals, HeadEntity).
% case: not last body literal && literal does not contain an entity.
assertBodyDependencies((_Literal, RestLiterals), HeadEntity):-
	assertBodyDependencies(RestLiterals, HeadEntity).
% case: last body literal && literal contains an entity.
assertBodyDependencies(Literal, HeadEntity):- 	
	getEntity(Literal, EntityGnd), !, freeConstants(EntityGnd, Entity),
	assertDependency(Entity, HeadEntity).
% case: last body literal && literal does not contain an entity.
assertBodyDependencies(_Literal, _HeadEntity).

% assertDependency(+BodyEntity, +HeadEntity)
% This predicate asserts dependency(BodyEntity, HeadEntity).
% In all cases, we first check whether this dependency fact is already in the knowledge base to avoid duplicates.
%case: the body entity is a fluent-value pair whose value is a free variable.
% 	   Assert one dependency fact for each possible value of the body fluent.
assertDependency(F=V, HeadEntity):-
	var(V), !,
	findall(V1, 
			((simpleFluent(F=V1) ; sDFluent(F=V1)),
			 \+dependency(F=V1, HeadEntity), 
			assertz(dependency(F=V1, HeadEntity))), _). %, write(dependency(F=V1, HeadEntity)), nl), _).

% case: <BodyEntity> is an event or a FVP with a ground value.
assertDependency(BodyEntity, HeadEntity):-
	\+dependency(BodyEntity, HeadEntity), !, 
	assertz(dependency(BodyEntity, HeadEntity)). %, write(dependency(BodyEntity, HeadEntity)), nl.

% case: dependency fact already present. So, do nothing.
assertDependency(_, _).

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

%% isCyclic(+F=+V)
% check if F=V is part of a cycle created by dependency/2 facts.
% unification with V1, V2 is used to include cases where V is a free variable in dependency/2.
isCyclic(F=V):-
	path(F=V1, F=V2, [], _), V1=V, V2=V.

%path(+X,+Z,+Visited,-Path)
% check if there is a dependency path from X to Z.
% <Visited> stores visited nodes/entities to avoid infinite loops.
path(X, Z, _, []):-
	dependency(X, Z).
path(X, Z, Visited, [Y|T]):-
	dependency(X, Y),
	\+member(Y, Visited),
	path(Y, Z, [Y|Visited], T).

% cycle(+X,-C)
% Finds a cycle of entities <C> starting from entity <X> and containing <X>
cycle(X, C) :-
  cycle(X, X, [], C).
% cycle(+CurrentNode, +StartNode, +VisitedNodes, -Cycle)
%case: Curr -> Next, Next has been visited, and we can go back from Next to Start, i.e., Start is part of the cycle.
cycle(Curr, Start, Visited, [Curr|Visited]) :-
  dependency(Curr, Next), 
  member(Next, Visited), 
  path(Next, Start, [], _). 
%case: Curr -> Next, Next has been visited, but Start is not reachable from Next. 
cycle(Curr, Start, Visited, []) :-
  dependency(Curr, Next), 
  member(Next, Visited), 
  \+path(Next, Start, [], _).
cycle(Curr, Start, Visited, C) :-
  dependency(Curr, Next), \+ member(Next, Visited),
  cycle(Next, Start, [Curr|Visited], C).

inAnyCyclicPathOf(F, FinalEntities):-
	findall(Entity, inCyclicPath(Entity, F), Entities),
	removeDuplicates(Entities, [], FinalEntities).

removeDuplicates([], Final, Final).

removeDuplicates([Entity0|Rest], Curr, Final):-
	freeConstants(Entity0, Entity), 
	member(Entity, Curr), !, 
	removeDuplicates(Rest, Curr, Final).

removeDuplicates([Entity0|Rest], Curr, Final):-
	freeConstants(Entity0, Entity), 
	removeDuplicates(Rest, [Entity|Curr], Final).

inCyclicPath(Entity, F):-
	cycle(F, CyclicEntities), 
	member(F, CyclicEntities),
	member(Entity, CyclicEntities).

findSCCs:-
	findall(F=V, 
		(simpleFluent(F=V), isCyclic(F=V),
		\+ inSCC(F=V),
		inAnyCyclicPathOf(F=V, SCC), assertz(scc(SCC))),
		_EntitiesInCycle), fail.

findSCCs:-
	findall(F=V, (simpleFluent(F=V), \+isCyclic(F=V), \+inSCC(F=V), assertz(scc([F=V]))), _), fail.

findSCCs:-
	findall(E, (event(E), assertz(scc([E]))), _), fail.

findSCCs:-
	findall(F=V, (sDFluent(F=V), assertz(scc([F=V]))), _).

inSCC(F=V):-
	scc(SCC), member(F=V, SCC).

% all entities in SCC depend on Entity, i.e., there is at least one Ent in SCC such that dependency(Entity,Ent).
sccLevel(SCC, Level):-
	findall(DependsOn, (member(Entity, SCC), dependency(DependsOn, Entity), \+member(DependsOn, SCC)), DirectDependencies),
	maxCachingLevel(DirectDependencies, -1, LevelDep),
	Level is LevelDep + 1.

maxCachingLevel([], Level, Level).
maxCachingLevel([Entity|Rest], CurrLevel, Level):-
	entityCachingLevel(Entity, EntityLevel),
	EntityLevel>CurrLevel, !,
	maxCachingLevel(Rest, EntityLevel, Level).
maxCachingLevel([_Entity|Rest], CurrLevel, Level):-
	maxCachingLevel(Rest, CurrLevel, Level).

entityCachingLevel(Entity, Level):-
	sccOfEntity(Entity, SCC), 
	sccLevel(SCC, Level).

sccOfEntity(Entity, SCC):-
	scc(SCC), member(Entity, SCC).

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


% writeCachingOrder(+Level)
% if there are entity with hierarchical level = <Level>,
% then write the corresponding rules and move to the next level.
writeCachingOrder(Level):-
	findall(Entity, (outputEntity(Entity), entityCachingLevel(Entity, Level)), Entities),
	\+ Entities= [], !,
	writeCachingOrderRulesOf(Entities, Level),
	NextLevel is Level + 1,
	writeCachingOrder(NextLevel).
	
% If Entities=[] for some level, then there are no entities with a larger level
% So, retract all cachingLevels and exit.
writeCachingOrder(_).

% writeCachingOrderRulesOf(+Entities)
% write the cachingOrder2 rules of all given entities.
writeCachingOrderRulesOf([], _Level).
writeCachingOrderRulesOf([Entity0|Rest], Level):-
	findall(Entity, (extractEntity(Entity, Entity0), !,
	indexOf(Index, Entity),
	clause(grounding(Entity), Body),
	write('cachingOrder2('), write(Index), write(', '), write(Entity), write(') :-'), write(' % level: '), write(Level), nl, 
	tab(5), write(Body), write('.'), nl, nl), _), 
	writeCachingOrderRulesOf(Rest, Level).

assertCyclic:-
	findall(SCC,
		(scc(SCC), 
		SCC=[_,_|_],
		assertCyclic(SCC)),
		_).

assertCyclic([]).
assertCyclic([F=V|Rest]):-
	findall(F=V, (simpleFluent(F=V), assertz(cyclic(F=V))), _), 
	assertCyclic(Rest).

writeAndRetractCyclic:-
	findall(F=V, (simpleFluent(F=V), cyclic(F=V), write('cyclic('), write(F=V), write(').'), nl, retract(cyclic(F=V))), _), nl.

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
	writeSCCLevelByLevel(EventsFlag),
	write("\n"),
	% next, we specify the edges, i.e, all dependencies among entities.
	writeAllDependencies(EventsFlag),
	write("}\n"),
	told.


isOutputEntity(U):-
	% we need to prove that U is in at least one dependency(_,U) fact, so matching once is sufficient.
	% make sure we do not backtrack with a cut. 
	dependency(_, U), !. 


writeAllDependencies(EventsFlag):-
		findall(dependency(DependsOn, Entity),
	   		(dependency(DependsOn, Entity),
			 % if <EventsFlag> is withoutEvents, then do not write edges stemming from the first level of the hierarchy.
			 (EventsFlag=withoutEvents -> isOutputEntity(DependsOn) ; EventsFlag=withEvents), 
			 % Fetch the hierarchy level of each entity and make sure they are different, i.e., the entities are not in a cycle.
			 entityCachingLevel(DependsOn, LevelSource),
			 entityCachingLevel(Entity, LevelTarget),
			 \+LevelSource=LevelTarget,
			 write("\t"), write(LevelSource), write(":\""),
			 writeEntityUnderscores(DependsOn),
			 write("\" -> "), write(LevelTarget), write(":\""),
			 writeEntityUnderscores(Entity), write("\"\n"))
			 , _).

%writeAllDependencies(withoutEvents):-	
%	findall(dependency(DependsOn, Entity), (dependency(DependsOn, Entity), isOutputEntity(DependsOn), entityCachingLevel(DependsOn, LevelSource), entityCachingLevel(Entity, LevelTarget), \+LevelSource=LevelTarget, write("\t"), write(LevelSource), write(":\""), writeEntityUnderscores(DependsOn), write("\" -> "), write(LevelTarget), write(":\""), writeEntityUnderscores(Entity), write("\"\n")), _).

writeSCCLevelByLevel(withEvents):-
	!, writeSCCLevelByLevel(0).

writeSCCLevelByLevel(withoutEvents):-
	!, writeSCCLevelByLevel(1).

writeSCCLevelByLevel(Level):-
	findall(SCC, (scc(SCC), sccLevel(SCC,Level)), SCCs),
	SCCs=[], !.

writeSCCLevelByLevel(Level):-
	findall([SCC, Color], (scc(SCC), 
						(length(SCC, 1), Color=black ; length(SCC, Len), Len>1, getNextColor(Color)),
					 		sccLevel(SCC,Level)), SCCAndColors),
	write("\t"), write(Level), write(" [shape=none label=<<table border=\"0\" cellspacing=\"0\">\n"),
	writeAllEntitiesInSCCsAndColors(SCCAndColors),
	write("\t</table>>\n\t]\n\n"),
	NextLevel is Level + 1,
	writeSCCLevelByLevel(NextLevel).

writeAllEntitiesInSCCsAndColors([]).
writeAllEntitiesInSCCsAndColors([[SCC, Color]|Rest]):-
	writeEntitiesWithColor(SCC, Color),
	writeAllEntitiesInSCCsAndColors(Rest).
	
writeEntitiesWithColor([], _Color).
writeEntitiesWithColor([U|Rest], Color):-
	(dependency(U,_) ; dependency(_,U)), !, % write entities having at least one incoming or outgoing edge.
	write("\t\t<tr><td port=\""), writeEntityUnderscores(U), write("\" border=\"1\" color=\""), write(Color), write("\">"), writeEntityUnderscores(U), write("</td></tr>\n"),
	writeEntitiesWithColor(Rest, Color).
writeEntitiesWithColor([_U|Rest], Color):-
	writeEntitiesWithColor(Rest, Color).

:- dynamic nextColor/1.
% color each cycle (SCC with more that one entity) with a different color, if possible.
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

writeAllEntitiesInSCC([U]):- !,
	write("<"), writeEntityUnderscores(U), write("> "), writeEntityUnderscores(U), write("\"];\n").
writeAllEntitiesInSCC([U|Rest]):-
	write("<"), writeEntityUnderscores(U), write("> "), writeEntityUnderscores(U), write("|"),
	writeAllEntitiesInSCC(Rest).

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

createDependenciesFile(File):-
	tell(File),
	findall(dependency(DependsOn, Entity), (dependency(DependsOn, Entity), writeDependency(DependsOn, Entity)), _),
	told.

writeDependency(DependsOn, Entity):-
	scc(SCC), member(DependsOn, SCC), member(Entity, SCC), !,
	write("cyclic_dependency("), writeEntityUnderscores(DependsOn), write(","), writeEntityUnderscores(Entity), write(").\n").

writeDependency(DependsOn, Entity):-
	write("dependency("), writeEntityUnderscores(DependsOn), write(","), writeEntityUnderscores(Entity), write(").\n").
