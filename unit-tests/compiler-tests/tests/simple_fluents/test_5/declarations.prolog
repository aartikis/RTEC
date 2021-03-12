% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.




%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%
simpleFluent(rich(_)=true).
outputEntity(rich(_)=true).
index(rich(Person)=true, Person).

simpleFluent(srich(_)=true).
outputEntity(srich(_)=true).
index(srich(Person)=true, Person).


% How are the fluents grounded?
% Define the domain of the variables.

grounding(rich(Person)=true)               :- person(Person).
grounding(srich(Person)=true)               :- person(Person).


% In what order will the output entities be processed by RTEC?

cachingOrder(srich(_)=true).


