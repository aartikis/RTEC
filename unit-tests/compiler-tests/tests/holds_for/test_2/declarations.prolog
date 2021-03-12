% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.

sDFluent(happy(_)=true).
outputEntity(happy(_)=true).
index(happy(Person)=true, Person).

sDFluent(happy(_)=false).
outputEntity(happy(_)=false).
index(happy(Person)=false, Person).

sDFluent(infiniteBeers(_)=true).
outputEntity(infiniteBeers(_)=true).
index(infiniteBeers(Person)=true, Person).


% How are the fluents grounded?
% Define the domain of the variables.

grounding(happy(Person)=true)              :- person(Person).
grounding(happy(Person)=false)             :- person(Person).
grounding(infiniteBeers(Person)=true)      :- person(Person).

% In what order will the output entities be processed by RTEC?

cachingOrder(infiniteBeers(_)=true).


