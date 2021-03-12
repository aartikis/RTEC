% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.



%%%%%%%%%%%%%%%%% INPUT EVENTS %%%%%%%%%%%%%%%%%

event(lose_wallet(_)).
inputEntity(lose_wallet(_)).
index(lose_wallet(Person), Person).

event(win_lottery(_)).
inputEntity(win_lottery(_)).
index(win_lottery(Person), Person).

%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%
simpleFluent(rich(_)=true).
outputEntity(rich(_)=true).
index(rich(Person)=true, Person).

simpleFluent(rich(_)=false).
outputEntity(rich(_)=false).
index(rich(Person)=false, Person).

sDFluent(sleeping_at_work(_)=true).
outputEntity(sleeping_at_work(_)=true).
index(sleeping_at_work(Person)=true, Person).


% How are the fluents grounded?
% Define the domain of the variables.

grounding(rich(Person)=true)               :- person(Person).
grounding(rich(Person)=false)              :- person(Person).
grounding(sleeping_at_work(Person)=true)   :- person(Person).


% In what order will the output entities be processed by RTEC?
cachingOrder(rich(_)=true).
cachingOrder(rich(_)=false).

