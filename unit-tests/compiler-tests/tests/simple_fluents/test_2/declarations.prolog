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

simpleFluent(sleeping(_)=true).
outputEntity(sleeping(_)=true).
index(sleeping(Person)=true, Person).

simpleFluent(sleeping(_)=false).
outputEntity(sleeping(_)=false).
index(sleeping(Person)=false, Person).

simpleFluent(rich(_)=true).
outputEntity(rich(_)=true).
index(rich(Person)=true, Person).

simpleFluent(rich(_)=false).
outputEntity(rich(_)=false).
index(rich(Person)=false, Person).

% How are the fluents grounded?
% Define the domain of the variables.

grounding(sleeping(Person)=true)	:- person(Person).
grounding(sleeping(Person)=false)	:- person(Person).
grounding(rich(Person)=true)		:- person(Person).
grounding(rich(Person)=false)		:- person(Person).


% In what order will the output entities be processed by RTEC?

cachingOrder(sleeping(_)=true).
cachingOrder(sleeping(_)=false).
cachingOrder(rich(_)=true).
cachingOrder(rich(_)=false).
