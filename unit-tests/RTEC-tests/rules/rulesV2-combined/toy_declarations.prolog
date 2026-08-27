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

event(sleep_start(_)).
inputEntity(sleep_start(_)).
index(sleep_start(Person), Person).

event(sleep_end(_)).
inputEntity(sleep_end(_)).
index(sleep_end(Person), Person).

event(starts_working(_)).
inputEntity(starts_working(_)).
index(starts_working(Person), Person).

event(ends_working(_)).
inputEntity(ends_working(_)).
index(ends_working(Person), Person).

event(smell_bacon(_)).
inputEntity(smell_bacon(_)).
index(smell_bacon(Person), Person).

event(found_bacon(_)).
inputEntity(found_bacon(_)).
index(found_bacon(Person), Person).

event(ate_bacon(_)).
inputEntity(ate_bacon(_)).
index(ate_bacon(Person), Person).

event(ate_food(_)).
inputEntity(ate_food(_)).
index(ate_food(Person), Person).

event(needsFood(_)).
inputEntity(needsFood(_)).
index(needsFood(Person), Person).

%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%
simpleFluent(rich(_)=true).
outputEntity(rich(_)=true).
index(rich(Person)=true, Person).

simpleFluent(rich(_)=false).
outputEntity(rich(_)=false).
index(rich(Person)=false, Person).

simpleFluent(working(_)=true).
outputEntity(working(_)=true).
index(working(Person)=true, Person).

simpleFluent(working(_)=false).
outputEntity(working(_)=false).
index(working(Person)=false, Person).

%%%%%%%%%%%%%% CYCLIC OUTPUT A %%%%%%%%%%%%%%%%%
simpleFluent(strength(_)=full).
outputEntity(strength(_)=full).
index(strength(Person)=full, Person).

simpleFluent(strength(_)=tired).
outputEntity(strength(_)=tired).
index(strength(Person)=tired, Person).

simpleFluent(strength(_)=lowering).
outputEntity(strength(_)=lowering).
index(strength(Person)=lowering, Person).

%%%%%%%%%%%%%% CYCLIC OUTPUT B %%%%%%%%%%%%%%%%%

simpleFluent(eating(_)=true).
outputEntity(eating(_)=true).
index(eating(X)=true, X).

simpleFluent(hungry(_)=true).
outputEntity(hungry(_)=true).
index(hungry(X)=true, X).

simpleFluent(hungry(_)=false).
outputEntity(hungry(_)=false).
index(hungry(X)=false, X).

simpleFluent(noFoodNeeds(_)=true).
outputEntity(noFoodNeeds(_)=true).
index(noFoodNeeds(X)=true, X).

simpleFluent(noFoodNeeds(_)=false).
outputEntity(noFoodNeeds(_)=false).
index(noFoodNeeds(X)=false, X).
%%%%%%%%%%%%% cycles %%%%%%%%%%%%%%

cyclic(strength(_)=full).
cyclic(strength(_)=tired).
cyclic(strength(_)=lowering).
cyclic(eating(_)=true).
cyclic(hungry(_)=true).
cyclic(hungry(_)=false).
cyclic(noFoodNeeds(_)=true).
cyclic(noFoodNeeds(_)=false).

grounding(rich(Person)=true)               :- person(Person).
grounding(rich(Person)=false)              :- person(Person).
grounding(working(Person)=true)            :- person(Person).
grounding(working(Person)=false)           :- person(Person).
grounding(eating(Person)=true)             :- person(Person).
grounding(hungry(Person)=true)             :- person(Person).
grounding(hungry(Person)=false)            :- person(Person).
grounding(noFoodNeeds(Person)=true)        :- person(Person).
grounding(noFoodNeeds(Person)=false)       :- person(Person).
grounding(strength(Person)=full)           :- person(Person).
grounding(strength(Person)=tired)          :- person(Person).
grounding(strength(Person)=lowering)       :- person(Person).


% In what order will the output entities be processed by RTEC?

cachingOrder(rich(_)=true).
cachingOrder(rich(_)=false).
cachingOrder(working(_)=true).
cachingOrder(working(_)=false).
%%%%%%%%%%% cycle B %%%%%%%%%%%
cachingOrder(eating(_)=true).
cachingOrder(hungry(_)=true).
cachingOrder(noFoodNeeds(_)=true).
cachingOrder(noFoodNeeds(_)=false).
%%%%%%%%%%% cycle A %%%%%%%%%%%
cachingOrder(strength(_)=full).
cachingOrder(strength(_)=tired).
cachingOrder(strength(_)=lowering).
