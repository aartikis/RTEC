
%%%%%%%%%%%%%%%%% OUTPUT ENTITIES %%%%%%%%%%%%%%%%%
simpleFluent(location(_)=home).
outputEntity(location(_)=home).
index(location(Person)=home, Person).

simpleFluent(location(_)=pub).
outputEntity(location(_)=pub).
index(location(Person)=pub, Person).

simpleFluent(location(_)=work).
outputEntity(location(_)=work).
index(location(Person)=work, Person).

simpleFluent(rich(_)=true).
outputEntity(rich(_)=true).
index(rich(Person)=true, Person).

simpleFluent(rich(_)=false).
outputEntity(rich(_)=false).
index(rich(Person)=false, Person).

sDFluent(infiniteBeers(_)=true).
outputEntity(infiniteBeers(_)=true).
index(infiniteBeers(Person)=true, Person).

grounding(location(Person)=Place)          :- person(Person), place(Place).
grounding(rich(Person)=true)               :- person(Person).
grounding(rich(Person)=false)              :- person(Person).

grounding(infiniteBeers(Person)=true)      :- person(Person).

cachingOrder(infiniteBeers(_)=true).



