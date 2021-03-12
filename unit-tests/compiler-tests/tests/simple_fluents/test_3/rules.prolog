


%%%%% simpleHappy
initiatedAt(shappy(X)=true,T):-
    happensAt(startI(happy(X)=true),T).
terminatedAt(shappy(X)=true,T):-
    happensAt(end(happy(X)=true),T).
