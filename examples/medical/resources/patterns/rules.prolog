% Rules defining output entities
initiatedAt(y_aux=true, T):-
    happensAt(x,T).

fi(y_aux=true,y_aux=false,Dist):-
    max_admin_dist(Dist).
p(y_aux=true).

holdsFor(y=true, I):-
    holdsFor(y_aux=true, Iaux),
    max_admin_dist(Dist),
    trim_interval_suffix(Iaux,Dist,I).

% Grounding of input entities 
grounding(x).

% Grounding of output entities
grounding(y_aux=true).
grounding(y_aux=false).
grounding(y=true).

