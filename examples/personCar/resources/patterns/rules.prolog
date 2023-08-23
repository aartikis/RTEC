holdsFor(entering_om(P,C)=true, I):-
	holdsFor(far_from_overlaps_adjacent(P,C)=true, Iffoa),
	holdsFor(visible_car_not_person(P,C)=true, Ivdnp),
    meets(Iffoa,Ivdnp,union,I).

holdsFor(far_from_overlaps_adjacent(P,C)=true, I):-
    holdsFor(far_from(P,C)=true,Iff),
    holdsFor(adjacent(P,C)=true,Ia),
    overlaps(Iff,Ia,union,I).

holdsFor(visible_car_not_person(P,C)=true, I):-
	holdsFor(visible_car(C)=true, Id),
	holdsFor(visible_person(P)=false, Ip),
    intersect_all([Id,Ip],I).


% Grounding of input entities 
grounding(far_from(Person,Car)=true) :- person(Person), car(Car).
grounding(adjacent(Person,Car)=true) :- person(Person), car(Car).
grounding(visible_person(Person)=true) :- person(Person).
grounding(visible_person(Person)=false) :- person(Person).
grounding(visible_car(Car)=true) :- car(Car).

% Grounding of output entities
grounding(visible_car_not_person(Person,Car)=true) :- person(Person), car(Car).
grounding(far_from_meets_adjacent(Person,Car)=true) :- person(Person), car(Car).
grounding(far_from_overlaps_adjacent(Person,Car)=true) :- person(Person), car(Car).
grounding(entering_om(Person,Car)=true) :- person(Person), car(Car).

collectIntervals(far_from(_,_)=true).
collectIntervals(adjacent(_,_)=true).
collectIntervals(visible_person(_)=true).
collectIntervals(visible_person(_)=false).
collectIntervals(visible_car(_)=true).
