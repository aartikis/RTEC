% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.

simpleFluent(working(_)=true).
outputEntity(working(_)=true).
index(working(Person)=true, Person).

sDFluent(sleeping_at_work(_)=true).
outputEntity(sleeping_at_work(_)=true).
index(sleeping_at_work(Person)=true, Person).

sDFluent(workingEfficiently(_)=true).
outputEntity(workingEfficiently(_)=true).
index(workingEfficiently(Person)=true, Person).

simpleFluent(location(_)=home).
outputEntity(location(_)=home).
index(location(Person)=home, Person).

simpleFluent(location(_)=pub).
outputEntity(location(_)=pub).
index(location(Person)=pub, Person).

simpleFluent(location(_)=work).
outputEntity(location(_)=work).
index(location(Person)=work, Person).

% How are the fluents grounded?
% Define the domain of the variables.
grounding(location(Person)=Place)          :- person(Person), place(Place).
grounding(working(Person)=true)            :- person(Person).
grounding(sleeping_at_work(Person)=true)   :- person(Person).
grounding(workingEfficiently(Person)=true) :- person(Person).

% In what order will the output entities be processed by RTEC?
cachingOrder(workingEfficiently(_)=true).


