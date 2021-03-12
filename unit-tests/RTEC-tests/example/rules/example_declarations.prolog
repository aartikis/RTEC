
%%%%%%%%%%%%%%%%% INPUT EVENTS %%%%%%%%%%%%%%%%%
event(starts_test(_)).
inputEntity(starts_test(_)).
index(starts_test(X),X).

event(ends_test(_)).
inputEntity(ends_test(_)).
index(ends_test(X), X).

%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%
simpleFluent(runningTest(_)=true).
outputEntity(runningTest(_)=true).
index(runningTest(X)=true, X).

% How are the fluents grounded?
% Define the domain of the variables.

unitTester(unit_tester).

grounding(runningTest(X)=true)             :- unitTester(X).

% In what order will the output entities be processed by RTEC?

cachingOrder(runningTest(_)=true).


