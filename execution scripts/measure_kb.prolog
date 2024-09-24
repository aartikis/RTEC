:- ['logger.prolog']. % for list_stats

consult_app_rules(App,FileName):-
    atom_concat('../examples/', App, PathPrefix0),
    atom_concat(PathPrefix0, '/resources/patterns/', PathPrefix1),
    atom_concat(PathPrefix1, FileName, PathPrefix2),
    atom_concat(PathPrefix2, '.prolog', RulesFile),
    [RulesFile], 
    write("Consulted file: "), write(RulesFile), nl.

count_rules_with_head(Pred, ArgsNo, ListOfConditionNos, NumOfRules, SumOfRuleConditions, Avg, Var, Dev):-
    functor(Head, Pred, ArgsNo),
    findall(Body, (clause(Head, Body0), toProperList(Body0,Body)), RuleBodies),
    count_body_conditions_list(RuleBodies, ListOfConditionNos),
    length(ListOfConditionNos,NumOfRules),
    (NumOfRules>0 -> get_stats_non_empty(ListOfConditionNos, NumOfRules, SumOfRuleConditions, Avg, Var, Dev) ;
     NumOfRules=0 -> SumOfRuleConditions=0, Avg=none, Var=none, Dev=none).

toProperList((Elem, Rest), [Elem|RestList]):-
    !, toProperList(Rest, RestList).
toProperList(Elem, [Elem]).

count_body_conditions_list([], []).
count_body_conditions_list([RuleBody|RestBodies], [NumOfConditions|RestNos]):-
    length(RuleBody, NumOfConditions),
    count_body_conditions_list(RestBodies, RestNos).

count_and_print_stats(Pred, ArgsNo, ListOfConditionNos):-
    count_rules_with_head(Pred, ArgsNo, ListOfConditionNos, NumOfRules, SumOfRuleConditions, Avg, Var, Dev),
    print_message(Pred, NumOfRules, 'Number of rules'),
    print_message(Pred, SumOfRuleConditions, 'Sum of number of conditions of rules'),
    print_message(Pred, Avg, 'Average number of conditions per rule'),
    print_message(Pred, Var, 'Variance of number of conditions of rules'),
    print_message(Pred, Dev, 'Standard deviation of number of conditions of rules'), nl.

print_message(Pred, Stat, StatMessage):-
    write(StatMessage), write(" with head "), write(Pred), write(" is: "), write(Stat), nl.

print_message(Stat, StatMessage):-
    write(StatMessage), write(" is: "), write(Stat), nl.

count_rules(App,FileName):-
    consult_app_rules(App,FileName),
    count_and_print_stats(initiatedAt, 4, InitListOfConditionNos),
    count_and_print_stats(terminatedAt, 4, TermListOfConditionNos),
    count_and_print_stats(holdsForSDFluent, 2, HoldsForListOfConditionNos),
    append([InitListOfConditionNos, TermListOfConditionNos, HoldsForListOfConditionNos], ListOfConditionNos),
    length(ListOfConditionNos,NumOfRules),
    (NumOfRules>0 -> get_stats_non_empty(ListOfConditionNos, NumOfRules, SumOfRuleConditions, Avg, Var, Dev) ;
     NumOfRules=0 -> SumOfRuleConditions=0, Avg=none, Var=none, Dev=none),
    print_message(NumOfRules, 'Number of rules'),
    print_message(SumOfRuleConditions, 'Sum of number of conditions of rules'),
    print_message(Avg, 'Average number of conditions per rule'),
    print_message(Var, 'Variance of number of conditions of rules'),
    print_message(Dev, 'Standard deviation of number of conditions of rules'), nl.

get_stats_non_empty(List, Len, Sum, Avg, Var, Dev):-
    sum_list(List, Sum),
     Avg is Sum/Len,
     list_var(List, Avg, Var1),
     Var is Var1/Len,
     Dev is sqrt(Var).


