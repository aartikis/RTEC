%Type A
updateSDE(exampleScenario) :-
  assert(happensAtIE(starts_test(unit_tester),1)),
  assert(happensAtIE(ends_test(unit_tester),10)).
%Type B  
updateSDE(exampleScenario,5) :-
  assert(happensAtIE(starts_test(unit_tester),1)).
updateSDE(exampleScenario,10) :-
  assert(happensAtIE(ends_test(unit_tester),10)).
%Type C
updateSDE(exampleScenario,0,5) :-
  assert(happensAtIE(starts_test(unit_tester),1)).
updateSDE(exampleScenario,5,10) :-
  assert(happensAtIE(ends_test(unit_tester),10)).
