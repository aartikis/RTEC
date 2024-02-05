
%%%%% workingEfficiently
holdsFor(workingEfficiently(X)=true,I):-
    holdsFor(working(X)=true,I1),
    holdsFor(sleeping_at_work(X)=true,I2),
    relative_complement_all(I1,[I2],Ii),
    findall((S,E),(
		    member(Ii,(S,E)),
		    holdsAt(location(X)=work,S)
		   )
	     ,I).

grounding(working(Person)=true):-
    person(Person).

grounding(sleeping_at_work(Person)=true):-
    person(Person).

grounding(location(Person)=work):-
    person(Person).

grounding(workingEfficiently(Person)=true):-
    person(Person).

