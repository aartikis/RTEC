

%%%%%% rich
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+holdsAt(sleeping(X)=true,T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).
