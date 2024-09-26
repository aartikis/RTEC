updateSDE(person_door_1) :-
	assertz(holdsForIESI(far_from(p1,d1)=true, (1,4))),
	assertz(holdsForIESI(visible_person(p1)=true, (1,6))),
	assertz(holdsForIESI(adjacent(p1,d1)=true, (2, 7))),
	assertz(holdsForIESI(visible_person(p1)=false, (6,10))),
	assertz(holdsForIESI(visible_door(d1)=true, (1,10))).

updateSDE(person_door_2, 0, 5) :-
	assertz(holdsForIESI(far_from(p1,d1)=true, (1,4))),
	assertz(holdsForIESI(visible_person(p1)=true, (1,5))),
	assertz(holdsForIESI(adjacent(p1,d1)=true, (2, 6))),
	assertz(holdsForIESI(visible_door(d1)=true, (1,6))).

updateSDE(person_door_2, 5, 10):-
	assertz(holdsForIESI(adjacent(p1,d1)=true, (6, 7))),
	assertz(holdsForIESI(visible_person(p1)=false, (6,10))),
	assertz(holdsForIESI(visible_door(d1)=true, (6,10))).

updateSDE(person_door_3) :-
	assertz(holdsForIESI(far_from(p1,d1)=true, (1,4))),
	assertz(holdsForIESI(visible_person(p1)=true, (1,6))),
	assertz(holdsForIESI(adjacent(p1,d1)=true, (2, 7))),
	assertz(holdsForIESI(visible_person(p1)=false, (6,10))),
	assertz(holdsForIESI(visible_door(d1)=true, (1,10))),
    assertz(happensAtIE(clock_in(p1), 8)).

updateSDE(person_door_4) :-
	assertz(holdsForIESI(far_from(p1,d1)=true, (1,4))),
	assertz(holdsForIESI(visible_person(p1)=true, (1,6))),
	assertz(holdsForIESI(adjacent(p1,d1)=true, (2, 7))),
	assertz(holdsForIESI(visible_person(p1)=false, (6,10))),
	assertz(holdsForIESI(visible_door(d1)=true, (1,10))),
    assertz(happensAtIE(clock_in(p1), 8)),
    assertz(happensAtIE(phone_rings(p1), 9)),
    assertz(happensAtIE(phone_call_ends(p1), 13)).

updateSDE(person_door_5, 0, 10) :-
	assertz(holdsForIESI(far_from(p1,d1)=true, (1,4))),
	assertz(holdsForIESI(visible_person(p1)=true, (1,6))),
	assertz(holdsForIESI(adjacent(p1,d1)=true, (2, 7))),
	assertz(holdsForIESI(visible_person(p1)=false, (6,10))),
	assertz(holdsForIESI(visible_door(d1)=true, (1,10))),
    assertz(happensAtIE(clock_in(p1), 8)),
    assertz(happensAtIE(phone_rings(p1), 9)).

updateSDE(person_door_5, 10, 20) :-
    assertz(happensAtIE(phone_call_ends(p1), 13)).
