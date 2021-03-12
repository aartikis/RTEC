
%%%%%%%%%%%%%%%%% INPUT EVENTS %%%%%%%%%%%%%%%%%

event(sleep_end(_)).
inputEntity(sleep_end(_)).
index(sleep_end(Person), Person).

event(starts_working(_)).
inputEntity(starts_working(_)).
index(starts_working(Person), Person).

event(ends_working(_)).
inputEntity(ends_working(_)).
index(ends_working(Person), Person).

%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%% cycles %%%%%%%%%%%%%%

cyclic(strength(_)=full).
cyclic(strength(_)=tired).
cyclic(strength(_)=lowering).

%%%%%%%%%%%% grounding %%%%%%%%%%%%

grounding(strength(Person)=full)           :- person(Person).
grounding(strength(Person)=tired)          :- person(Person).
grounding(strength(Person)=lowering)       :- person(Person).


cachingOrder(strength(_)=full).
cachingOrder(strength(_)=tired).
cachingOrder(strength(_)=lowering).
