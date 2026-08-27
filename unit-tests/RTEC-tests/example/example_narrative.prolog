%Type A
updateSDE(exampleScenario) :-
  assertz(happensAtIE(starts_test(unit_tester),1)),
  assertz(happensAtIE(ends_test(unit_tester),10)).
%Type B  
updateSDE(exampleScenario,5) :-
  assertz(happensAtIE(starts_test(unit_tester),1)).
updateSDE(exampleScenario,10) :-
  assertz(happensAtIE(ends_test(unit_tester),10)).
%Type C
updateSDE(exampleScenario,0,5) :-
  assertz(happensAtIE(starts_test(unit_tester),1)).
updateSDE(exampleScenario,5,10) :-
  assertz(happensAtIE(ends_test(unit_tester),10)).
