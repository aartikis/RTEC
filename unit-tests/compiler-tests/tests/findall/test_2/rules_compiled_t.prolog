:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2,maxDuration/3,maxDurationUE/3.
:-use_module(library(lists)).

holdsForSDFluent(workingEfficiently(X)=true,I) :-
     holdsForProcessedSimpleFluent(X,working(X)=true,Iw),
     holdsForProcessedSDFluent(X,sleeping_at_work(X)=true,Isw),
     relative_complement_all(Iw,[Isw],Ii),
     findall((S,E),(
		    member(Ii,(S,E)),
		    holdsAtProcessedSimpleFluent(X,location(X)=work,S)
		   )
	     ,I).
