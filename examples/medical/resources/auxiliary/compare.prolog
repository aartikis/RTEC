trim_interval_suffix(Iaux,Dist,I):-
    findall((S,NewE), (member((S,E), Iaux), E \= inf, NewE is E - Dist), I).
