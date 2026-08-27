
holdsFor(workingEfficiently(X)=true,I):-
    holdsFor(working(X)=true,I1),
    holdsFor(sleeping_at_work(X)=true,I2),
    relative_complement_all(I1,[I2],Ii),
    findall((S,E),
		  (
		    member(Ii,(S,E)),
		    Diff is E-S,
		    compare(>,Diff,2)
                   ),I).

grounding(working(Person)=true):-
    person(Person).

grounding(sleeping_at_work(Person)=true):-
    person(Person).

grounding(workingEfficiently(Person)=true):-
    person(Person).

