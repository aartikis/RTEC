initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T).

terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).

initiatedAt(location(X)=Y, T) :-
    happensAt(go_to(X,Y), T).

holdsFor(happy(X)=true, I) :-
    holdsFor(rich(X)=true, I1),
    holdsFor(location(X)=pub, I2),
    union_all([I1,I2], I).
