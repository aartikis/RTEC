%:-use_module(library(lists)).

holdsForSDFluent(workingEfficiently(X)=true,I) :-
     holdsForProcessedIE(X,working(X)=true,Iw),
     holdsForProcessedIE(X,sleeping_at_work(X)=true,Isw),
     relative_complement_all(Iw,[Isw],Ii),
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

inputEntity(working(_Person)=true).
inputEntity(sleeping_at_work(_Person)=true).

outputEntity(workingEfficiently(_Person)=true).

sDFluent(workingEfficiently(_Person)=true).
sDFluent(working(_Person)=true).
sDFluent(sleeping_at_work(_Person)=true).

index(workingEfficiently(Person)=true,Person).
index(working(Person)=true,Person).
index(sleeping_at_work(Person)=true,Person).

cachingOrder2(Person, workingEfficiently(Person)=true) :- 
     person(Person).
