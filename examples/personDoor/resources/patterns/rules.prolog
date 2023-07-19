holdsFor(entering(P,D)=true, I):-
	holdsFor(entering_oo(P,D)=true, Ioo),
	holdsFor(entering_om(P,D)=true, Iom),
	holdsFor(entering_mo(P,D)=true, Imo),
	holdsFor(entering_mm(P,D)=true, Imm),
	union_all([Ioo,Iom,Imo,Imm], I).

holdsFor(entering_oo(P,D)=true, I):-
	holdsFor(far_from_overlaps_adjacent(P,D)=true, Iffoa),
	holdsFor(visible_door_not_person(P,D)=true, Ivdnp),
    overlaps(Iffoa,Ivdnp,union,I).

holdsFor(entering_om(P,D)=true, I):-
	holdsFor(far_from_overlaps_adjacent(P,D)=true, Iffoa),
	holdsFor(visible_door_not_person(P,D)=true, Ivdnp),
    meets(Iffoa,Ivdnp,union,I).

holdsFor(entering_mo(P,D)=true, I):-
	holdsFor(far_from_meets_adjacent(P,D)=true, Iffma),
	holdsFor(visible_door_not_person(P,D)=true, Ivdnp),
    overlaps(Iffma,Ivdnp,union,I).

holdsFor(entering_mm(P,D)=true, I):-
	holdsFor(far_from_meets_adjacent(P,D)=true, Iffma),
	holdsFor(visible_door_not_person(P,D)=true, Ivdnp),
    meets(Iffma,Ivdnp,union,I).

holdsFor(far_from_overlaps_adjacent(P,D)=true, I):-
    holdsFor(far_from(P,D)=true,Iff),
    holdsFor(adjacent(P,D)=true,Ia),
    overlaps(Iff,Ia,union,I).

holdsFor(far_from_meets_adjacent(P,D)=true, I):-
    holdsFor(far_from(P,D)=true,Iff),
    holdsFor(adjacent(P,D)=true,Ia),
    meets(Iff,Ia,union,I).

holdsFor(visible_door_not_person(P,D)=true, I):-
	holdsFor(visible_door(D)=true, Id),
	holdsFor(visible_person(P)=false, Ip),
    intersect_all([Id,Ip],I).


% Grounding of input entities 
grounding(far_from(Person,Door)=true) :- person(Person), door(Door).
grounding(adjacent(Person,Door)=true) :- person(Person), door(Door).
grounding(visible_person(Person)=true) :- person(Person).
grounding(visible_person(Person)=false) :- person(Person).
grounding(visible_door(Door)=true) :- door(Door).

% Grounding of output entities
grounding(visible_door_not_person(Person,Door)=true) :- person(Person), door(Door).
grounding(far_from_meets_adjacent(Person,Door)=true) :- person(Person), door(Door).
grounding(far_from_overlaps_adjacent(Person,Door)=true) :- person(Person), door(Door).
grounding(entering_oo(Person,Door)=true) :- person(Person), door(Door).
grounding(entering_om(Person,Door)=true) :- person(Person), door(Door).
grounding(entering_mo(Person,Door)=true) :- person(Person), door(Door).
grounding(entering_mm(Person,Door)=true) :- person(Person), door(Door).
grounding(entering(Person,Door)=true) :- person(Person), door(Door).

collectIntervals(far_from(_,_)=true).
collectIntervals(adjacent(_,_)=true).
collectIntervals(visible_person(_)=true).
collectIntervals(visible_person(_)=false).
collectIntervals(visible_door(_)=true).
