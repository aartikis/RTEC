:-['../unit_tester.prolog'].
:-['./rules/example_rules_compiled.prolog'].
:-['./rules/example_declarations.prolog'].
:-['./example_narrative.prolog'].

%uses Type A narrative
testcase(exampleScenario,example,1, [[(2,11)]],(10,10,0,10)).

%uses Type B narrative
testcaseE(exampleScenario,example,2, [[(2,inf)],[(2,11)]],(5,5,0,10)).

%uses Type C narrative
%expected results of the first query is wrong
testcaseSE(exampleScenario,example,3, [[(2,3)],[(2,11)]],(5,5,0,10)). 

%defining a check rule for the above test cases
check(example,N,I):-
    member(N,[1,2,3]),
    holdsFor(runningTest(unit_tester)=true,I).
