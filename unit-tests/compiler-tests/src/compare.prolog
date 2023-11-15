:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.
:-use_module(library(lists)).


compare_clauses:-
    % Rules Comparison
    compare(initiatedAt(_,_,_,_),InitStatus),
    compare(terminatedAt(_,_,_,_),TermStatus),
    compare(holdsForSDFluent(_,_),HoldsStatus),
    compare(fi(_,_,_),FIStatus),
    compare(p(_),PStatus),
    % Declarations Comparison
    compare(grounding(_),GroundingStatus),
    compare(inputEntity(_),InputEntityStatus),
    compare(outputEntity(_),OutputEntityStatus),
    compare(event(_),EventStatus),
    compare(simpleFluent(_),SimpleFluentStatus),
    compare(sDFluent(_),SDFluentStatus),
    compare(index(_,_),IndexStatus),
    compare(cyclic(_),CyclicStatus),
    compare(cachingOrder2(_,_),CachingOrderStatus),
    % TODO: We should also the order of cachingOrder rules wrt: 1. the level, and 2. the processing order in the CDC.
    compare(collectGrounds(_,_),CollectGroundsStatus),
    compare(dgrounded(_,_),DGroundedStatus),
    printDifferences(InitStatus,'initiatedAt/4'),
    printDifferences(TermStatus,'terminatedAt/4'),
    printDifferences(HoldsStatus,'holdsForSDFluent/2'),
    printDifferences(FIStatus,'fi/3'),
    printDifferences(PStatus,'p/1'),
    printDifferences(GroundingStatus,'grounding/1'),
    printDifferences(InputEntityStatus,'inputEntity/1'),
    printDifferences(OutputEntityStatus,'outputEntity/1'),
    printDifferences(EventStatus,'event/1'),
    printDifferences(SimpleFluentStatus,'simpleFluent/1'),
    printDifferences(SDFluentStatus,'sDFluent/1'),
    printDifferences(IndexStatus,'index/2'),
    printDifferences(CyclicStatus,'cyclic/1'),
    printDifferences(CachingOrderStatus,'cachingOrder2/2'),
    printDifferences(CollectGroundsStatus,'collectGrounds/2'),
    printDifferences(DGroundedStatus,'dgrounded/2').

compare(Rule,Status):-
    findall((Head:-BodyNoMod),(clause(manual:Rule,_,Ref),clause(Mod:Head,Body,Ref),remove_mod(Body,BodyNoMod)),Manual),
    findall((Head:-BodyNoMod),(clause(compiler:Rule,_,Ref),clause(Mod:Head,Body,Ref),remove_mod(Body,BodyNoMod)),Compiler),
    compare_clauses(Manual,Compiler,Status).

compare_clauses(Manual,Compiler,(Missing,Additional)):-
    findall( M1,(member(M1,Manual), \+((member(M2,Compiler),M1=@=M2))),Missing),
    findall( M1,(member(M1,Compiler), \+((member(M2,Manual),M1=@=M2))),Additional).

printDifferences(([],[]),Type):-
    write('----Rule Type : '),write(Type),nl,
    write('-----Status: PASSED'),nl.
printDifferences((Missing,Additional),Type):-
    write('----Rule Type : '),write(Type),nl,
    write('-----Status: FAILED'),nl,
    write('-----Missing rules from compiler file:'),nl,
    printRules(Missing),nl,
    write('-----Additional rules in compiler file:'),nl,
    printRules(Additional),nl.


printRules([]).
printRules([(Head:-Body)|Other]):-
    write(Head),write(':-'),nl,
    write(Body),nl,nl,
    printRules(Other).

remove_mod((_S:A,B),(Af,R)):-
    check_findall(A,Af),!,
    remove_mod(B,R).

remove_mod((A,B),(Af,R)):-
    A \= _:_,
    check_findall(A,Af),!,
    remove_mod(B,R).

remove_mod(_:A,Af):- check_findall(A,Af).
remove_mod(A,Af):-A\= _:_ ,check_findall(A,Af).

check_findall(findall(A,_:B,C),findall(A,B,C)):-!.
check_findall(findall(A,B,C),findall(A,B,C)):-B\= _:_,!.
check_findall(A,A).

%-------------DIY structure equivalence predicates
/*
clause_body_list(Clause, Body) :-
    clause(Clause, Elements),
    clause_body_list_aux(Elements, Body).

clause_body_list_aux(Element, [Element]) :-
    Element =.. L,
    L \= [','|_Tail].

clause_body_list_aux(Elements, [Term|Terms]) :-
    Elements =.. [',', Term|[Elements1]],
    clause_body_list_aux(Elements1, Terms).


var_member(A,[L|T]):-L==A.
var_member(A,[L|T]):-A\==L,var_member(A,T).


% list of vars
list_of_vars(A,L,[A|L]):-
    var(A),\+var_member(A,L).

list_of_vars(A,L,L):-
    var(A),var_member(A,L).

list_of_vars(A,L,L):-
    \+var(A),
    A=..[A].

list_of_vars(A,Lprev,Lnew):-
    \+var(A),
    A=..L,
    L\=[_],
    L=[F|R],
    list_of_vars(F,Lprev,L1),
    list_of_vars_f(R,L1,Lnew).

list_of_vars_f([],L,L).
list_of_vars_f([A|Rest],Lold,Lnew):-
    list_of_vars(A,Lold,L1),
    list_of_vars_f(Rest,L1,Lnew).

bind_vars([A],S,[A=Val]):-
    atom_number(Sa,S),
    atom_concat(var,Sa,Val).
bind_vars([V|VOther],S,[V=Val|BOther]):-
    atom_number(Sa,S),
    atom_concat(var,Sa,Val),
    S_1 is S-1,
    bind_vars(VOther,S_1,BOther).
*/
