

%%%%%% rich

initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+holdsAt(sleeping_at_work(X)=true,T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).










