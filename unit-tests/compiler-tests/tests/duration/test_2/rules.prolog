
%%%%%% rich
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).
maxDurationUE(rich(X)=true,rich(X)=false,4):-
    grounding(rich(X)=true).


