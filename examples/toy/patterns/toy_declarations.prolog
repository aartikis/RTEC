% Information about all our events and fluents.
% - Is each entity an event or a fluent?
% - Is it an input or an output entity?
% - Choose an argument to be used as index for quicker access.

event(go_to(_,_)).	inputEntity(go_to(_,_)).	index(go_to(Person,_), Person).
event(lose_wallet(_)).	inputEntity(lose_wallet(_)).	index(lose_wallet(Person), Person).
event(win_lottery(_)).	inputEntity(win_lottery(_)).	index(win_lottery(Person), Person).

simpleFluent(location(_)=home).	outputEntity(location(_)=home).	index(location(Person)=home, Person).
simpleFluent(location(_)=pub).	outputEntity(location(_)=pub).	index(location(Person)=pub, Person).
simpleFluent(location(_)=work).	outputEntity(location(_)=work).	index(location(Person)=work, Person).
simpleFluent(rich(_)=true).	outputEntity(rich(_)=true).	index(rich(Person)=true, Person).
simpleFluent(rich(_)=false).	outputEntity(rich(_)=false).	index(rich(Person)=false, Person).

sDFluent(happy(_)=true).	outputEntity(happy(_)=true).	index(happy(Person)=true, Person).
sDFluent(happy(_)=false).	outputEntity(happy(_)=false).	index(happy(Person)=false, Person).

% How are the fluents grounded?
% Define the domain of the variables.

grounding(location(Person)=Place) :- person(Person), place(Place).
grounding(rich(Person)=true)      :- person(Person).
grounding(rich(Person)=false)     :- person(Person).
grounding(happy(Person)=true)     :- person(Person).
grounding(happy(Person)=false)    :- person(Person).

% In what order will the output entities be processed by RTEC?

cachingOrder(location(_)=home).
cachingOrder(location(_)=pub).
cachingOrder(location(_)=work).
cachingOrder(rich(_)=true).
cachingOrder(rich(_)=false).
cachingOrder(happy(_)=true).
cachingOrder(happy(_)=false).
