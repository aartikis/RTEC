:- [library(dcg/basics)].

:- dynamic atem/1, cachingPriority/2, declared/5, defines/3, graphines/2, head/1, noCaching/1, matchRepr/2.

% -----------------------------------------------
% AUXILIARY TOOLS
% -----------------------------------------------

% Split a list into its head and the rest.
list_head([H|T], H, T).

% Add an element to the head or the tail of a list.
addToHead(L, H, [H|L]).

addToTail([], E, [E]).
addToTail([H|T], E, [H|L]) :- addToTail(T, E, L).

% Update the caching priority of an element and propagate this update to all output entities that depend on it.
%propagatePriority(E, P) :-
%	
%	% Initially, the caching priority of E is P.
%	% If there are no dependents, exit.
%	(\+ defines(E, _, _) -> true
%	;
%	
%	% If E is Self-dependent, exit
%	defines(E, E, _) -> true
%	;
%	
%	% Else, update the caching priorities of all dependants.
%	% Find all direct dependents (list has at least one element). Sort them and remove duplicates.
%	findall(H, defines(E, H, _), Heads), Heads \= [], sort(Heads, HeadsSorted),
%	
%	% Find and remove all dependencies with the old value C (Future work: Do this only if old value C \= P)
%	findall((E, B, C), (defines(E, B, C), retract(defines(E, B, C))), _),
%	
%	% For each direct dependent of E assert new dependency with new value P.
%	forall(member(H, HeadsSorted), (assertz(defines(E, H, P)), 
%	
%	% Calculate the new caching priority of dependent H, based on the new dependencies.
%	calculatePriority(H, Q),
%	assertz(cachingPriority(H, Q)),
%	
%	% Repeat procedure, this time for dependent H.
%	propagatePriority(H, Q)))).

% Caclulate the caching priority of an output entity by looking at its dependencies.
%calculatePriority(H, Q) :-
%	
%	% Find all dependencies of H, along with their caching priority values.
%	findall(dddt(O,P), defines(O, H, P), OPS),
%	
%	% Alphabetically sort dependencies, removing duplicates. (Future work: Are both sortings needed?)
%	sort(2, @>=, OPS, OOPS),
%	sort(1, @<, OOPS, OOPSS),
%	
%	% Gather the caching priorities of the dependencies of H in a list
%	% Take the sum of all values in this list
%	% The updated caching priority of H will be the sum of the caching priorities of its dependencies + 1
%	% Adding 1 to the amount above ensures that H will be higher in the caching hierarchy than all of its dependencies.
%	findall(P, member(dddt(_, P), OOPSS), PS),
%	sum_list(PS, TmpQ),
%	Q is TmpQ + 1.

cachingLevel(Node, Level) :-
	findall(Parent, (defines(Parent, Node, _), Parent \= Node), Parents),
	(length(Parents, 0) -> Level is 0
	;
	(findall(L, (member(P, Parents), cachingLevel(P, L)), Levels),
	max_list(Levels, MaxLevel),
	Level is MaxLevel + 1)).

% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------

simplEC(InputFile, OutputFile, DeclarationsFile, GraphFile) :-
	
	% Prepare files for reading and writing
	split_string(InputFile, ".", "", InputFileTokens),
	list_head(InputFileTokens, InputName, _),
	atomics_to_string([InputName, ".log"], LogFile),
	open(InputFile, read, Input),
	open(DeclarationsFile, write, DeclStream),
	open(LogFile, write, LogStream), close(LogStream),
	tell(OutputFile),
	
	% Set auxiliary global variables for interval numbering and logfile production
	nb_setval(intervalNo, 1),
	nb_setval(logFile, LogFile),
	
	% Parse and translate the rules into RTEC format
	read_stream_to_codes(Input, Codes),
	phrase(goal, Codes),
	
	% Finalize dependencies
	findall((A, BPrefix, C), (defines(A, B, C), noCaching(B), retract(defines(A, B, C)), split_string(B, "=", "", BParts), list_head(BParts, BPrefix, _)), DefinesPending),
	findall(D, (declared(D, _, _, _, _), split_string(D, "=", "", DParts), list_head(DParts, DPrefix, _), member((A, DPrefix, C), DefinesPending), assertz(defines(A, D, C))), _),
	findall((AG, BGPrefix), (graphines(AG, BG), matchRepr(B, BG), noCaching(B), retract(graphines(AG, BG)), split_string(BG, "=", "", BGParts), list_head(BGParts, BGPrefix, _)), GraphinesPending),
	findall(DG, (declared(D, DG, _, _, _), split_string(DG, "=", "", DGParts), list_head(DGParts, DGPrefix, _), member((AG, DGPrefix), GraphinesPending), assertz(graphines(AG, DG))), _),
	
	% Build declarations:
	% Find all declared entities. Store them in a list and forget everything else about them.
	% Sort declared entities and remove duplicates.
	% If an entity appears in the rules both as an input and an output entity, we consider it an output entity.
	% After having the declared entities filtered, we assert them anew.
	findall(declFact(DeclRepr, GraphRepr, IndRepr, Type, EType), (declared(DeclRepr, GraphRepr, IndRepr, Type, EType), retract(declared(DeclRepr, GraphRepr, IndRepr, Type, EType))), Tuples),
	sort(5, @>=, Tuples, TuplesDistorted),
	sort(1, @<, TuplesDistorted, TuplesSorted),
	forall(member(declFact(DeclRepr, GraphRepr, IndRepr, Type, EType), TuplesSorted), assertz(declared(DeclRepr, GraphRepr, IndRepr, Type, EType))),
	
	% Find and print all input events.
	findall((DeclRepr, GraphRepr, IndRepr, "event", "input"),
		(declared(DeclRepr, GraphRepr, IndRepr, "event", "input"),
		atomics_to_string(["event(", DeclRepr, ").\tinputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all input SDF's.
	findall((DeclRepr, GraphRepr, IndRepr, "sD", "input"),
		(declared(DeclRepr, GraphRepr, IndRepr, "sD", "input"),
		atomics_to_string(["sDFluent(", DeclRepr, ").\tinputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all output events.
	findall((DeclRepr, GraphRepr, IndRepr, "event", "output"),
		(declared(DeclRepr, GraphRepr, IndRepr, "event", "output"),
		atomics_to_string(["event(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all Simple Fluents.
	findall((DeclRepr, GraphRepr, IndRepr, "simple", "output"),
		(declared(DeclRepr, GraphRepr, IndRepr, "simple", "output"),
		atomics_to_string(["simpleFluent(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all output SDF's.
	findall((DeclRepr, GraphRepr, IndRepr, "sD", "output"),
		(declared(DeclRepr, GraphRepr, IndRepr, "sD", "output"),
		atomics_to_string(["sDFluent(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% For each output entity (among those that have not been flagged as "noCaching") find its maximal caching priority
	% Sort by caching priority value, in ascending order and print in the declarations file
	%findall((H, Q), (head(H), \+ noCaching(H), findall(Pr, cachingPriority(H, Pr), Prs), max_list(Prs, Q)), CachingUnordered),
	%sort(1, @<, CachingUnordered, CachingSorted),
	%sort(2, @=<, CachingSorted, CachingOrdered),
	%findall(H,
	%	(member((H, Q), CachingOrdered),
	%	atomics_to_string(["cachingOrder(", H, ").\t%", Q, "\n"], "", Out),
	%	write(DeclStream, Out)),
	%	_),
	%told,
	%close(Input), close(DeclStream),
	
	% For each output entity (among those that have not been flagged as "noCaching") find its level in the caching hierarchy
	% Sort by caching priority value, in ascending order and print in the declarations file
	findall(cachingHierarchy(Node, Level), (head(Node), \+ noCaching(Node), cachingLevel(Node, Level)), CachingUnordered),
	%write(CachingUnordered),
	sort(1, @<, CachingUnordered, CachingSorted),
	%write(CachingSorted),
	sort(2, @=<, CachingSorted, CachingOrdered),
	%write(CachingOrdered),
	findall(H,
		(member(cachingHierarchy(H, Q), CachingOrdered),
		atomics_to_string(["cachingOrder(", H, ").\t%", Q, "\n"], "", Out),
		write(DeclStream, Out)),
		_),
	told,
	close(Input), close(DeclStream),
	
	% Dependency graph preparation:
	% Create a mapping of the form Q -> {H1, H2, ..., Hn}
	% where Q is a caching priority value and {H1, H2, ..., Hn} are the entities
	% that have Q as their caching priority value
	% (input entities are considered to have Q = 0)
	findall((AG, B), (matchRepr(A, AG), \+ noCaching(A), cachingLevel(A, B)), AllCachingLevels),
	%forall(member(ACL, AllCachingLevels), writeln(ACL)), nl,
	findall(Q, member((_, Q), AllCachingLevels), QS),
	findall(H, member((H, _), AllCachingLevels), HS),
	%findall(H0, (declared(H0, _, _, _), \+ member(cachingHierarchy(H0, _), CachingOrdered)), H0S),
	pairs_keys_values(QHS, QS, HS),
	%forall(member(Pair, QHS), writeln(Pair)), nl,
	sort(QHS, QHSS),
	%forall(member(PairS, QHSS), writeln(PairS)), nl,
	group_pairs_by_key(QHSS, QLSS),
	%forall(member(PairL, QLSS), writeln(PairL)), nl,
	pairs_keys_values(QLSS, List1, List2),
	findall((L1, L2), (member(L1, List1), nth1(Index, List1, L1), nth1(Index, List2, L2)), FinalList),
	%forall(member(PairF, FinalList), writeln(PairF)), nl,
	%addToHead(AlmostFinalList, (0, H0S), FinalList),
	
	% Dependency graph generation:
	% Use the mapping above to group entities of the same caching level together in the graph.
	% Use the existing dependencies to add directed edges to the graph.
	tell(GraphFile),
	write("digraph\n{\n\tnode [shape=Mrecord];\n\trankdir=LR;\n\tranksep=\"1.2 equally\";\n\n"),
	forall(member((Q, L), FinalList), (findall(LabelPart, (member(Part, L), atomics_to_string(["<", Part, "> ", Part], LabelPart)), LabelParts), atomics_to_string(LabelParts, "|", Label), atomics_to_string(["\t", Q, " [label=\"", Label, "\"];\n"], Line), write(Line))),nl,
	%findall(edge(CI, I, CJ, J), (defines(I, J, _), member((J, CJ), CachingOrdered), (member((I, CI), CachingOrdered) -> true ; CI is 0)), Edges),
	findall(edge(CI, IG, CJ, JG), (graphines(IG, JG), matchRepr(I, IG), matchRepr(J, JG), cachingLevel(I, CI), cachingLevel(J, CJ)), Edges),
	sort(Edges, EdgesSorted),
	forall(member(edge(CK, K, CL, L), EdgesSorted), (write("\t"), write(CK), write(":\""), write(K), write("\" -> "), write(CL), write(":\""), write(L), writeln("\""))),
	write("}\n"),
	told, !.

% -----------------------------------------------
% DEFINITE CLAUSE GRAMMAR
% -----------------------------------------------

space 			--> 	"\t", space.
space 			--> 	"\n", space.
space 			--> 	"\r", space.
space 			--> 	" ", space.
space			-->	[].

goal			--> 	space, ceDefinition, space, goal.
goal			--> 	[].

ceDefinition		-->	atemporalPredicates.
ceDefinition		-->	initially.
ceDefinition		-->	holdsFor.
ceDefinition		-->	starAt.
ceDefinition		-->	string_without([46], ErrRule), ".",
				{
					% Write error message in log file
					string_codes(ErrRuleStr, ErrRule),
					nb_getval(logFile, LogFile),
					open(LogFile, append, LogStream),
					write(LogStream, "IN RULE:\n"),
					write(LogStream, ErrRuleStr),
					write(LogStream, "\nERROR: Unknown event pattern detected.\nPlease check your syntax.\n\n"),
					close(LogStream)
				}.
				
atemporalPredicates		--> "atemporal:", space, functawr(FncStr), moreFacts, ".",
				{
					assertz(atem(FncStr))
				}.
				
moreFacts		--> space, ",", space, functawr(FncStr), moreFacts,
				{
					assertz(atem(FncStr))
				}.
moreFacts		--> "".

initially		-->	"initially", space, fluent("simple", "output", CTStr, _, _, _, _, null, null), ".",
				{
					atomics_to_string(["initially(", CTStr, ").\n\n"], "", InitiallyStr),
					write(InitiallyStr)
					%assertz(cachingPriority(DeclRepr, GraphRepr, 1)),
					%propagatePriority(DeclRepr, GraphRepr, 1)
				}.
					
holdsFor		--> 	head(Head, HeadDeclRepr, HeadGraphRepr), space, sep("iff"), space, {nb_setval(intervalNo, 1)}, forBody(Body, _, HeadDeclRepr, HeadGraphRepr), ".",
				{
					split_string(Body, "\n", ",\t\n", BodySubs),
					findall((Term, VNames), (member(Sub, BodySubs), term_string(Term, Sub, [variable_names(VNames)])), Terms),
					last(Terms, (LastTerm, Vars)),
					last(Vars, Name=Var),
					delete(Terms, (LastTerm, Vars), TermsPending),
					delete(Vars, Name=Var, VarsPending),
					addToTail(VarsPending, 'I'=Var, NewVars),
					addToTail(TermsPending, (LastTerm, NewVars), NewTerms),
					findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), ExprStrSplit),
					atomics_to_string(ExprStrSplit, ",\n\t", BodyFinal),
					
					write(Head), write(" :-\n\t"), write(BodyFinal), write(".\n\n"),
					
					%HeadPriority is BodyPriority + 1,
					%
					%% Duplicate handling
					%findall(P, cachingPriority(HeadDeclRepr, P), PS), max_list(PS, OldPriority),
					%findall((HeadDeclRepr, P), (cachingPriority(HeadDeclRepr, P), retract(cachingPriority(HeadDeclRepr, P))), _),
					%assertz(cachingPriority(HeadDeclRepr, OldPriority)),
					
					%% On multiple definitions, we keep the max priority.
					%(OldPriority >= HeadPriority -> true
					%;
					%retract(cachingPriority(HeadDeclRepr, OldPriority)),
					%assertz(cachingPriority(HeadDeclRepr, HeadPriority)),
					%propagatePriority(HeadDeclRepr, HeadPriority)),
					
					split_string(HeadDeclRepr, "=", "", Parts),
					list_head(Parts, _, [Value]),
					string_codes(Value, ValueCodes),
					list_head(ValueCodes, First, _),
					(char_type(First, lower) -> true
					;
					assertz(noCaching(HeadDeclRepr)))
					%findall((D, P), (cachingPriority(D, P), sub_string(D, 0, _, _, Prefix), assertz(head(D)), HeadPriority > P, assertz(cachingPriority(D, HeadPriority)), propagatePriority(D, HeadPriority)), _))
				}.

starAt			-->	head(Head, HeadDeclRepr, HeadGraphRepr), space, sep("if"), space, atBody(EntireBody, _, HeadDeclRepr, HeadGraphRepr), ".",
				{
					split_string(EntireBody, "^", "", BodyParts),
					%writeln(EntireBody),
					%writeln(BodyParts),
					findall(Body,
					(member(Body, BodyParts),
					%writeln(Body),
					string_codes(Body, BodyCodes),
					list_head(BodyCodes, _, CommaFreeBodyCodes),
					string_codes(CommaFreeBody, CommaFreeBodyCodes),
					%writeln(CommaFreeBody),
					write(Head), write(" :-"), write(CommaFreeBody), write(".\n\n")),
					_),
					
					%HeadPriority is BodyPriority + 1,
					%
					%% Duplicate handling
					%findall(P, cachingPriority(HeadDeclRepr, P), PS), max_list(PS, OldPriority),
					%findall((HeadDeclRepr, P), (cachingPriority(HeadDeclRepr, P), retract(cachingPriority(HeadDeclRepr, P))), _),
					%assertz(cachingPriority(HeadDeclRepr, OldPriority)),
					
					%% On multiple definitions, we keep the max priority.
					%(OldPriority >= HeadPriority -> true
					%;
					%retract(cachingPriority(HeadDeclRepr, OldPriority)),
					%assertz(cachingPriority(HeadDeclRepr, HeadPriority)),
					%propagatePriority(HeadDeclRepr, HeadPriority)),
					
					split_string(HeadDeclRepr, "=", "", Parts),
					length(Parts, Length),
					(Length = 2 ->
					(list_head(Parts, _, [Value]),
					string_codes(Value, ValueCodes),
					list_head(ValueCodes, First, _),
					(char_type(First, lower) -> true
					;
					assertz(noCaching(HeadDeclRepr))))
					%findall((D, P), (cachingPriority(D, P), sub_string(D, 0, _, _, Prefix), assertz(head(D)), HeadPriority > P, assertz(cachingPriority(D, HeadPriority)), propagatePriority(D, HeadPriority)), _)))
					;
					true)
				}.
	
sep("iff")		--> 	"iff".
sep("if")		--> 	"if".

head(HeadStr, DeclRepr, GraphRepr)						--> 	fluent("sD", "output", CTStr, DeclRepr, GraphRepr, _, _, null, null),
									{
										atomics_to_string(["holdsFor(", CTStr, ", I)"], "", HeadStr),
										(\+ head(DeclRepr) -> assertz(head(DeclRepr))
										;										true)
									}.
head(HeadStr, DeclRepr, GraphRepr)						--> 	"initiate", space, fluent("simple", "output", CTStr, DeclRepr, GraphRepr, _, _, null, null),
									{
										atomics_to_string(["initiatedAt(", CTStr, ", T)"], "", HeadStr),
										(\+ head(DeclRepr) -> assertz(head(DeclRepr))
										;
										true)
									}.
head(HeadStr, DeclRepr, GraphRepr)						--> 	"terminate", space, fluent("simple", "output", CTStr, DeclRepr, GraphRepr, _, _, null, null),
									{
										atomics_to_string(["terminatedAt(", CTStr, ", T)"], "", HeadStr)
									}.
head(HeadStr, DeclRepr, GraphRepr)						--> 	"happens", space, event("output", EvStr, DeclRepr, GraphRepr, _, null, null),
									{
										atomics_to_string(["happensAt(", EvStr, ", T)"], "", HeadStr)
									}.

fluent(Type, Etype, CTStr, DeclRepr, GraphRepr, Priority, I, HeadDeclRepr, HeadGraphRepr)	--> 	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, Index), ")", value(ValStr, VType), !,
									{
										\+ atem(FncStr),
										atomics_to_string([FncStr, "(", ArgLStr, ")", ValStr], "", CTStr),
										atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRePrefix),
										atomics_to_string([DeclRePrefix, ValStr], "", DeclRepr),
										atomics_to_string([FncStr, "(", GArgLStr, ")", ValStr], "", GraphRepr),
										atomics_to_string([FncStr, "(", IndArgLStr, ")", ValStr, ", ", Index], "", IndRepr),
										
										(VType = val -> true
										;
										findall((D, I, T, E), (declared(D, G, I, T, E), sub_string(D, 0, _, _, DeclRePrefix), assertz(declared(D, G, I, Type, Etype))), _)),
										
										nb_getval(intervalNo, Int),
										string_concat("I", Int, I),
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										
										(declared(DeclRepr, GraphRepr, IndRepr, Type, Etype) -> true
										;
										(VType = var -> true
										;
										assertz(declared(DeclRepr, GraphRepr, IndRepr, Type, Etype)))),
										
										%(cachingPriority(DeclRepr, GraphRepr, _) -> (findall(P, cachingPriority(DeclRepr, GraphRepr, P), PS), max_list(PS, Priority))
										%;
										%assertz(cachingPriority(DeclRepr, GraphRepr, 0)), Priority = 0),
										
										(HeadDeclRepr = null -> assertz(head(DeclRepr))
										;
										assertz(defines(DeclRepr, HeadDeclRepr, Priority))),
										
										(HeadGraphRepr = null -> true
										;
										assertz(graphines(GraphRepr, HeadGraphRepr))),
										
										(matchRepr(DeclRepr, GraphRepr) -> true
										;
										assertz(matchRepr(DeclRepr, GraphRepr)))
									}.

event(Etype, EvStr, DeclRepr, GraphRepr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, Index), ")",
									{
										atomics_to_string([FncStr, "(", ArgLStr, ")"], "", EvStr),
										atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRepr),
										atomics_to_string([FncStr, "(", GArgLStr, ")"], "", GraphRepr),
										atomics_to_string([FncStr, "(", IndArgLStr, "), ", Index], "", IndRepr),
									
										(declared(DeclRepr, GraphRepr, IndRepr, "event", Etype) -> true
										;
										assertz(declared(DeclRepr, GraphRepr, IndRepr, "event", Etype))),
										
										%(cachingPriority(DeclRepr, GraphRepr, _) -> (findall(P, cachingPriority(DeclRepr, GraphRepr, P), PS), max_list(PS, Priority))
										%;
										%assertz(cachingPriority(DeclRepr, GraphRepr, 0)), Priority = 0),
										
										(HeadDeclRepr = null -> assertz(head(DeclRepr))
										;
										assertz(defines(DeclRepr, HeadDeclRepr, Priority))),
										
										(HeadGraphRepr = null -> true
										;
										assertz(graphines(GraphRepr, HeadGraphRepr))),
										
										(matchRepr(DeclRepr, GraphRepr) -> true
										;
										assertz(matchRepr(DeclRepr, GraphRepr)))
									}.

functawr(FncStr)	 					--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
									{
										string_codes(FncStr, [Lower|RCList])
									}.
	
variable(VarStr)						-->	[Upper], { char_type(Upper, upper) }, restChars(RCList),
									{
										string_codes(VarStr, [Upper|RCList])
									}.
variable(VarStr)						-->	"_", restChars(RCList),
									{
										string_codes(RCStr, RCList),
										string_concat("_", RCStr, VarStr)
									}.

value(ValStr, var)						-->	"=", variable(ArgStr),
									{
										string_concat("=", ArgStr, ValStr)
									}.
value(ValStr, val)						-->	"=", functawr(ArgStr),
									{
										string_concat("=", ArgStr, ValStr)
									}.
value(ValStr, val)						-->	"=", number(ArgStr),
									{
										string_concat("=", ArgStr, ValStr)
									}.
value("=true", val)						-->	[].

restChars(Chars)						--> 	string_without([9, 10, 13, 32, 40, 41, 44, 46], Chars).

argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, ArgStr)		--> 	argument(ArgStr), moreArguments(MArgStr, UMArgStr, GMArgStr),
									{
										string_concat(ArgStr, MArgStr, ArgLStr),
										string_concat("_", UMArgStr, UArgLStr),
										
										string_codes(ArgStr, ArgCod),
										list_head(ArgCod, First, _),
										(char_type(First, lower) -> string_concat(ArgStr, GMArgStr, GArgLStr)
										;
										(char_type(First, digit) -> string_concat(ArgStr, GMArgStr, GArgLStr)
										;
										string_concat("_", GMArgStr, GArgLStr))),
										
										string_concat(ArgStr, UMArgStr, IndArgLStr)
									}.
argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, "X")		--> 	"_", moreArguments(MArgStr, UMArgStr, GMArgStr),
									{
										string_concat("_", MArgStr, ArgLStr),
										string_concat("_", UMArgStr, UArgLStr),
										string_concat("_", GMArgStr, GArgLStr),
										string_concat("X", UMArgStr, IndArgLStr)
									}.

argument(ArgStr) 						--> 	functawr(ArgStr).
argument(ArgStr) 						--> 	variable(ArgStr).
argument(ArgStr) 						--> 	number(ArgStr).
argument(ArgStr) 						--> 	list(ArgStr).

moreArguments(MArgStr, MArgStr, MArgStr)					--> 	[],
									{
										string_codes(MArgStr, [])
									}.
moreArguments(MArgStr, UMArgStr, GMArgStr)				-->	",", space, argument(ArgStr), moreArguments(MMArgStr, UMMArgStr, GMMArgStr),
									{
										atomics_to_string([",", ArgStr, MMArgStr], "", MArgStr),
										string_concat(",_", UMMArgStr, UMArgStr),
										
										string_codes(ArgStr, ArgCod),
										list_head(ArgCod, First, _),
										(char_type(First, lower) -> atomics_to_string([",", ArgStr, GMMArgStr], "", GMArgStr)
										;
										(char_type(First, digit) -> atomics_to_string([",", ArgStr, GMMArgStr], "", GMArgStr)
										;
										string_concat(",_", GMMArgStr, GMArgStr)))
									}.
moreArguments(MArgStr, UMArgStr, GMArgStr)				-->	",", space, "_", moreArguments(MMArgStr, UMMArgStr, GMMArgStr),
									{
										string_concat(",_", MMArgStr, MArgStr),
										string_concat(",_", UMMArgStr, UMArgStr),
										string_concat(",_", GMMArgStr, GMArgStr)
									}.

forBody(BodyStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	expression(BodyStr, _, Priority, HeadDeclRepr, HeadGraphRepr).
forBody(BodyStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	expression(ExprStr, _, Priority, HeadDeclRepr, HeadGraphRepr), ",", space, constraints(ConStr),
									{
										atomics_to_string([ExprStr, ConStr], ",\n\t", BodyStr)
									}.

expression(ExprStr, I, _, HeadDeclRepr, HeadGraphRepr)			-->	component(CompStr, T1, _, HeadDeclRepr, HeadGraphRepr), moreComponents(MCompStr, T2, and, _, HeadDeclRepr, HeadGraphRepr),
									{
										nb_getval(intervalNo, Int),
										string_concat("I", Int, I),
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										
										atom_string(T1Atom, T1),
										atom_string(T2Atom, T2),
										atom_string(IAtom, I),
									
										atomics_to_string([CompStr, MCompStr], ",\n\t", ExprStrPending),
										split_string(ExprStrPending, "\n", ",\t\n", SubStrings),
										findall((Term, VNames), (member(Sub, SubStrings), term_string(Term, Sub, [variable_names(VNames)])), Terms),
										(
											(member((complement_all(List, SomeI), Vars), Terms), last(Vars, T2Atom=SomeI)) ->
											delete(Terms, (complement_all(List, SomeI), Vars), TermsPending1),
											delete(Vars, T2Atom=SomeI, VarsPending1),
											addToHead(VarsPending1, T1Atom=Anon1, VarsPending2),
											addToTail(VarsPending2, IAtom=AnonI, NewVars),
											addToTail(TermsPending1, (relative_complement_all(Anon1, List, AnonI), NewVars), NewTerms)
											;
											(member((intersect_all(List, SomeI), Vars), Terms), last(Vars, T1Atom=SomeI)) ->
											delete(Terms, (intersect_all(List, SomeI), Vars), TermsPending1),
											delete(Vars, T1Atom=SomeI, VarsPending1),
											addToHead(VarsPending1, T2Atom=Anon2, VarsPending2),
											addToTail(VarsPending2, IAtom=AnonI, NewVars),
											addToHead(List, Anon2, NewList),
											addToTail(TermsPending1, (intersect_all(NewList, AnonI), NewVars), NewTerms)
											;
											(member((intersect_all(List, SomeI), Vars), Terms), last(Vars, T2Atom=SomeI)) ->
											delete(Terms, (intersect_all(List, SomeI), Vars), TermsPending1),
											delete(Vars, T2Atom=SomeI, VarsPending1),
											addToHead(VarsPending1, T1Atom=Anon1, VarsPending2),
											addToTail(VarsPending2, IAtom=AnonI, NewVars),
											addToHead(List, Anon1, NewList),
											addToTail(TermsPending1, (intersect_all(NewList, AnonI), NewVars), NewTerms)
											;
											addToTail(Terms, (intersect_all([Anon1, Anon2], AnonI), [T1Atom=Anon1, T2Atom=Anon2, IAtom=AnonI]), NewTerms)
										),
										findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), ExprStrSplit),
										atomics_to_string(ExprStrSplit, ",\n\t", ExprStr)
		
										%Priority is Priority1 + Priority2
									}.
expression(ExprStr, I, _, HeadDeclRepr, HeadGraphRepr)			-->	component(CompStr, T1, _, HeadDeclRepr, HeadGraphRepr), moreComponents(MCompStr, T2, or, _, HeadDeclRepr, HeadGraphRepr),
									{
										nb_getval(intervalNo, Int),
										string_concat("I", Int, I),
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										
										atom_string(T1Atom, T1),
										atom_string(T2Atom, T2),
										atom_string(IAtom, I),
										
										atomics_to_string([CompStr, MCompStr], ",\n\t", ExprStrPending),
										split_string(ExprStrPending, "\n", ",\t\n", SubStrings),
										findall((Term, VNames), (member(Sub, SubStrings), term_string(Term, Sub, [variable_names(VNames)])), Terms),
										(
											(member((union_all(List, SomeI), Vars), Terms), last(Vars, T1Atom=SomeI)) ->
											delete(Terms, (union_all(List, SomeI), Vars), TermsPending1),
											delete(Vars, T1Atom=SomeI, VarsPending1),
											addToHead(VarsPending1, T2Atom=Anon2, VarsPending2),
											addToTail(VarsPending2, IAtom=AnonI, NewVars),
											addToTail(List, Anon2, NewList),
											addToTail(TermsPending1, (union_all(NewList, AnonI), NewVars), NewTerms)
											;
											(member((union_all(List, SomeI), Vars), Terms), last(Vars, T2Atom=SomeI)) ->
											delete(Terms, (union_all(List, SomeI), Vars), TermsPending1),
											delete(Vars, T2Atom=SomeI, VarsPending1),
											addToHead(VarsPending1, T1Atom=Anon1, VarsPending2),
											addToTail(VarsPending2, IAtom=AnonI, NewVars),
											addToTail(List, Anon1, NewList),
											addToTail(TermsPending1, (union_all(NewList, AnonI), NewVars), NewTerms)
											;
											addToTail(Terms, (union_all([Anon1, Anon2], AnonI), [T1Atom=Anon1, T2Atom=Anon2, IAtom=AnonI]), NewTerms)
										),
										findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), ExprStrSplit),
										atomics_to_string(ExprStrSplit, ",\n\t", ExprStr)
		
										%Priority is Priority1 + Priority2
									}.
expression(ExprStr, I, Priority, HeadDeclRepr, HeadGraphRepr)			-->	component(ExprStr, I, Priority, HeadDeclRepr, HeadGraphRepr), moreComponents(null).

moreComponents(MCompStr, I, and, Priority, HeadDeclRepr, HeadGraphRepr)	-->	",", space, expression(MCompStr, I, Priority, HeadDeclRepr, HeadGraphRepr).
moreComponents(MCompStr, I, or, Priority, HeadDeclRepr, HeadGraphRepr)		-->	space, "or", space, expression(MCompStr, I, Priority, HeadDeclRepr, HeadGraphRepr).
moreComponents(null)						-->	[].

component(CompStr, T, Priority, HeadDeclRepr, HeadGraphRepr)			-->	fluent("sD", "input", Str, _, _, Priority, T, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\tholdsFor(", Str, ", ", T, ")"], "", CompStr)
									}.
component(CompStr, T, Priority, HeadDeclRepr, HeadGraphRepr)			-->	"(", space, expression(CompStr, T, Priority, HeadDeclRepr, HeadGraphRepr), space, ")".
component(CompStr, T, Priority, HeadDeclRepr, HeadGraphRepr)			-->	"not", space, expression(Str, ExpT, Priority, HeadDeclRepr, HeadGraphRepr),
									{
										nb_getval(intervalNo, Int),
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										string_concat("I", Int, T),
										atomics_to_string([Str, ",\n\tcomplement_all([", ExpT, "], ", T, ")"], "", CompStr)
									}.

constraints(ConStr)						-->	durationConstraint(DCStr), moreConstraints(MConStr),
									{
										atomics_to_string([DCStr, MConStr], ",\n\t", ConStr)
									}.
constraints(ConStr)						-->	atemporalConstraint(ACStr), moreConstraints(MConStr),
									{
										atomics_to_string([ACStr, MConStr], ",\n\t", ConStr)
									}.
constraints("")							-->	[].

moreConstraints(MConStr)					-->	",", space, constraints(MConStr).
moreConstraints("")						-->	[].

durationConstraint(DCStr)					-->	"duration", space, operator(OpStr), space, variable(VarStr),
									{
										nb_getval(intervalNo, Int),
										PrevInt is Int - 1,
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										atomics_to_string([",\n\tfindall((S,E), (member((S,E), I", PrevInt, "), Diff is E-S, Diff ", OpStr, " ", VarStr, "), I", Int, ")"], "", DCStr)
									}.
durationConstraint(DCStr)					-->	"duration", space, operator(OpStr), space, number(NumStr),
									{
										nb_getval(intervalNo, Int),
										PrevInt is Int - 1,
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										atomics_to_string([",\n\tfindall((S,E), (member((S,E), I", PrevInt, "), Diff is E-S, Diff ", OpStr, " ", NumStr, "), I", Int, ")"], "", DCStr)
									}.

atBody(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)			--> atBodyPart(AtBodyPartStr, _, HeadDeclRepr, HeadGraphRepr), moreAtBodyParts(MoreAtBodyPartsStr, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([AtBodyPartStr, "^", MoreAtBodyPartsStr], "", AtBodyStr)
									}.

atBodyPart(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)			-->	event("input", CTStr, _, _, _, HeadDeclRepr, HeadGraphRepr), moreConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\thappensAt(", CTStr, ", T)", MCondStr], "", AtBodyStr)
										%Priority is Priority1 + Priority2
									}.
%atBodyPart(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)			-->	"not happens", space, event("input", CTStr, _, _, _, HeadDeclRepr, HeadGraphRepr), moreConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr),
%									{
%										atomics_to_string([",\n\t\\+ happensAt(", CTStr, ", T)", MCondStr], "", AtBodyStr)
%										%Priority is Priority1 + Priority2
%									}.
atBodyPart(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)			-->	"start", space, fluent("sD", "input", CTStr, _, _, _, _, HeadDeclRepr, HeadGraphRepr), moreConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\thappensAt(start(", CTStr, "), T)", MCondStr], "", AtBodyStr)
										%Priority is Priority1 + Priority2
									}.
atBodyPart(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)			-->	"end", space, fluent("sD", "input", CTStr, _, _, _, _, HeadDeclRepr, HeadGraphRepr), moreConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\thappensAt(end(", CTStr, "), T)", MCondStr], "", AtBodyStr)
										%Priority is Priority1 + Priority2
									}.

moreAtBodyParts(MoreAtBodyPartsStr, _, HeadDeclRepr, HeadGraphRepr)		--> space, "or", space, atBodyPart(AtBodyPartStr, _, HeadDeclRepr, HeadGraphRepr), moreAtBodyParts(MMoreAtBodyPartsStr, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([AtBodyPartStr, "^", MMoreAtBodyPartsStr], "", MoreAtBodyPartsStr)
									}.
moreAtBodyParts("", _, _, _)		--> [].

condition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	"start", space, fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\thappensAt(start(", CTStr, "), T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	"end", space, fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\thappensAt(end(", CTStr, "), T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	"happens", space, event("input", CTStr, _, _, Priority, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\thappensAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	"not happens", space, event("input", CTStr, _, _, Priority, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\t\\+ happensAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\tholdsAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)			-->	"not", space, fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
									{
										atomics_to_string([",\n\t\\+ holdsAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(ACStr, 0, _, _)						-->	atemporalConstraint(ACStr).
	
moreConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr)		-->	",", space, condition(CondStr, _, HeadDeclRepr, HeadGraphRepr), moreConditions(MMCondStr, _, HeadDeclRepr, HeadGraphRepr),
									{
										string_concat(CondStr, MMCondStr, MCondStr)
										%Priority is Priority1 + Priority2
									}.
moreConditions("", 0, _, _)					-->	[].

atemporalConstraint(ACStr)					-->	fact(ACStr).
atemporalConstraint(ACStr)					-->	math(ACStr).

fact(FStr)							-->	functawr(FncStr), "(", argumentsList(ArgLStr, _, _, _, _), ")",
									{
										atomics_to_string([",\n\t", FncStr, "(", ArgLStr, ")"], "", FStr)
									}.

math(MStr)							-->	variable(Var1Str), space, operator(OpStr), space, variable(Var2Str),
									{
										atomics_to_string([",\n\t", Var1Str, " ", OpStr, " ", Var2Str], "", MStr)
									}.
math(MStr)							-->	variable(Var1Str), space, operator(OpStr), space, number(NumStr),
									{
										atomics_to_string([",\n\t", Var1Str, " ", OpStr, " ", NumStr], "", MStr)
									}.

operator(">")							-->	">".
operator(">=")							-->	">=".
operator("<")							-->	"<".
operator("=<")							-->	"=<".
operator("=")							-->	"=".

list(LStr)							-->	"[", space, argumentsList(ArgLStr, _, _, _, _), space, "]",
									{
										atomics_to_string(["[", ArgLStr, "]"], "", LStr)
									}.
list("[]")							-->	"[]".








