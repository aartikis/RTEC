% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.



%%%%%%%%%%%%%%%%% INPUT EVENTS %%%%%%%%%%%%%%%%%
event(sleep_start(_)).
inputEntity(sleep_start(_)).
index(sleep_start(Person), Person).

event(sleep_end(_)).
inputEntity(sleep_end(_)).
index(sleep_end(Person), Person).

%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%
simpleFluent(sleeping(_)=true).
outputEntity(sleeping(_)=true).
index(sleeping(Person)=true, Person).

% How are the fluents grounded?
% Define the domain of the variables.

grounding(sleeping(Person)=true)           :- person(Person).

% In what order will the output entities be processed by RTEC?

cachingOrder(sleeping(_)=true).
