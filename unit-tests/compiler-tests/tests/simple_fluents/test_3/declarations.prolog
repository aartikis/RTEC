% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.



%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%

sDFluent(happy(_)=true).
outputEntity(happy(_)=true).
index(happy(Person)=true, Person).

sDFluent(happy(_)=false).
outputEntity(happy(_)=false).
index(happy(Person)=false, Person).

simpleFluent(shappy(_)=true).
outputEntity(shappy(_)=true).
index(shappy(Person)=true, Person).

% How are the fluents grounded?
% Define the domain of the variables.


grounding(happy(Person)=true)              :- person(Person).
grounding(happy(Person)=false)             :- person(Person).
grounding(shappy(Person)=true)             :- person(Person).


% In what order will the output entities be processed by RTEC?

cachingOrder(shappy(_)=true).


