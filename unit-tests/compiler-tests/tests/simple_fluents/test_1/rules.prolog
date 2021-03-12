%%%%%% sleeping
initiatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_start(X),T).
terminatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_end(X),T).

