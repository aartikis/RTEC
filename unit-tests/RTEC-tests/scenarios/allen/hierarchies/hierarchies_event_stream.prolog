updateSDE(hierarchies_1) :-
	assertz(holdsForIESI(a=true, (2,5))),
	assertz(holdsForIESI(b=true, (3,15))),
	assertz(holdsForIESI(c=true, (12,14))).

updateSDE(hierarchies_2, 0, 10) :-
	assertz(holdsForIESI(a=true, (2,5))),
	assertz(holdsForIESI(b=true, (3,11))).

updateSDE(hierarchies_2, 10, 20) :-
	assertz(holdsForIESI(b=true, (11,15))),
	assertz(holdsForIESI(c=true, (12,14))).

updateSDE(hierarchies_3) :-
	assertz(holdsForIESI(aBefore=true, (4,6))),
	assertz(holdsForIESI(cBefore=true, (3,8))),
	assertz(holdsForIESI(bBefore=true, (12,14))).

updateSDE(hierarchies_4, 0, 10) :-
	assertz(holdsForIESI(aBefore=true, (4,6))),
	assertz(holdsForIESI(cBefore=true, (3,8))).

updateSDE(hierarchies_4, 10, 20) :-
	assertz(holdsForIESI(bBefore=true, (12,14))).

updateSDE(hierarchies_5) :-
	assertz(holdsForIESI(aMeets=true, (2,6))),
	assertz(holdsForIESI(cMeets=true, (5,14))),
	assertz(holdsForIESI(bMeets=true, (13,19))).

updateSDE(hierarchies_6, 0, 10) :-
	assertz(holdsForIESI(aMeets=true, (2,6))),
	assertz(holdsForIESI(cMeets=true, (5,11))).

updateSDE(hierarchies_6, 10, 20) :-
	assertz(holdsForIESI(cMeets=true, (11,14))),
	assertz(holdsForIESI(bMeets=true, (13,19))).

updateSDE(hierarchies_7) :-
	assertz(holdsForIESI(aStarts=true, (2,8))),
	assertz(holdsForIESI(cStarts=true, (6,14))),
	assertz(holdsForIESI(bStarts=true, (6,19))).

updateSDE(hierarchies_8, 0, 10) :-
	assertz(holdsForIESI(aStarts=true, (2,8))),
	assertz(holdsForIESI(cStarts=true, (6,11))),
	assertz(holdsForIESI(bStarts=true, (6,11))).

updateSDE(hierarchies_8, 10, 20) :-
	assertz(holdsForIESI(cStarts=true, (11,14))),
	assertz(holdsForIESI(bStarts=true, (11,19))).

updateSDE(hierarchies_9) :-
	assertz(holdsForIESI(aFinishes=true, (2,6))),
	assertz(holdsForIESI(cFinishes=true, (12,14))),
	assertz(holdsForIESI(bFinishes=true, (5,14))).

updateSDE(hierarchies_10, 0, 10) :-
	assertz(holdsForIESI(aFinishes=true, (2,6))),
	assertz(holdsForIESI(bFinishes=true, (5,11))).

updateSDE(hierarchies_10, 10, 20) :-
	assertz(holdsForIESI(cFinishes=true, (12,14))),
	assertz(holdsForIESI(bFinishes=true, (11,14))).

updateSDE(hierarchies_11) :-
	assertz(holdsForIESI(aDuring=true, (5,8))),
	assertz(holdsForIESI(cDuring=true, (12,14))),
	assertz(holdsForIESI(bDuring=true, (6,17))).

updateSDE(hierarchies_12, 0, 10) :-
	assertz(holdsForIESI(aDuring=true, (5,8))),
	assertz(holdsForIESI(bDuring=true, (6,11))).

updateSDE(hierarchies_12, 10, 20) :-
	assertz(holdsForIESI(cDuring=true, (12,14))),
	assertz(holdsForIESI(bDuring=true, (11,17))).

updateSDE(hierarchies_13) :-
	assertz(holdsForIESI(aDuring=true, (5,8))),
	assertz(holdsForIESI(cDuring=true, (9,14))),
	assertz(holdsForIESI(bDuring=true, (6,17))).

updateSDE(hierarchies_14, 0, 10) :-
	assertz(holdsForIESI(aDuring=true, (5,8))),
	assertz(holdsForIESI(cDuring=true, (9,11))),
	assertz(holdsForIESI(bDuring=true, (6,11))).

updateSDE(hierarchies_14, 10, 20) :-
	assertz(holdsForIESI(cDuring=true, (11,14))),
	assertz(holdsForIESI(bDuring=true, (11,17))).

updateSDE(hierarchies_15) :-
	assertz(holdsForIESI(aOverlaps=true, (5,8))),
	assertz(holdsForIESI(cOverlaps=true, (5,14))),
	assertz(holdsForIESI(bOverlaps=true, (12,17))).

updateSDE(hierarchies_16, 0, 10) :-
	assertz(holdsForIESI(aOverlaps=true, (5,8))),
	assertz(holdsForIESI(cOverlaps=true, (5,11))).

updateSDE(hierarchies_16, 10, 20) :-
	assertz(holdsForIESI(cOverlaps=true, (11,14))),
	assertz(holdsForIESI(bOverlaps=true, (12,17))).

updateSDE(hierarchies_17) :-
	assertz(holdsForIESI(aOverlaps=true, (5,8))),
	assertz(holdsForIESI(cOverlaps=true, (5,14))),
	assertz(holdsForIESI(bOverlaps=true, (9,17))).

updateSDE(hierarchies_18, 0, 10) :-
	assertz(holdsForIESI(aOverlaps=true, (5,8))),
	assertz(holdsForIESI(cOverlaps=true, (5,11))),
	assertz(holdsForIESI(bOverlaps=true, (9,11))).

updateSDE(hierarchies_18, 10, 20) :-
	assertz(holdsForIESI(cOverlaps=true, (11,14))),
	assertz(holdsForIESI(bOverlaps=true, (11,17))).

