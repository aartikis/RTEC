% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.



%%%%%%%%%%%%%%%%% INPUT EVENTS %%%%%%%%%%%%%%%%%

event(starts_working(_)).
inputEntity(starts_working(_)).
index(starts_working(Person), Person).

event(ends_working(_)).
inputEntity(ends_working(_)).
index(ends_working(Person), Person).


%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%

simpleFluent(working(_)=true).
outputEntity(working(_)=true).
index(working(Person)=true, Person).

simpleFluent(working(_)=false).
outputEntity(working(_)=false).
index(working(Person)=false, Person).

%%%%%%%%%%%%%%%%% grounding %%%%%%%%%%%%%%%%%%
grounding(working(Person)=true)            :- person(Person).
grounding(working(Person)=false)           :- person(Person).

%%%%%%%%%%%%%%%% caching order %%%%%%%%%%%%%%%
cachingOrder(working(_)=true).
cachingOrder(working(_)=false).
