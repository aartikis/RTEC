%%%%%% rich
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+holdsAt(sleeping(X)=true,T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).

%%%%%% sleeping
initiatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_start(X),T).
terminatedAt(sleeping(X)=true,T) :-
    happensAt(sleep_end(X),T).

%%%%% location
initiatedAt(location(X)=Y, T) :-
    happensAt(go_to(X,Y), T).

%%%%% working
initiatedAt(working(X)=true, T):-
    happensAt(starts_working(X),T).

terminatedAt(working(X)=true, T) :-
    happensAt(ends_working(X), T).

terminatedAt(working(X)=true, T) :-
    happensAt(start(rich(X)=true),T).

terminatedAt(working(X)=true,T):-
    happensAt(go_to(X,Y),T),Y\=work.

%%%%% happy
holdsFor(happy(X)=true, I) :-
    holdsFor(rich(X)=true, I1),
    holdsFor(location(X)=pub, I2),
    union_all([I1,I2], I).

%%%%% simpleHappy
initiatedAt(shappy(X)=true,T):-
    happensAt(start(happy(X)=true),T).
terminatedAt(shappy(X)=true,T):-
    happensAt(end(happy(X)=true),T).

%%%%% infinite beers
holdsFor(infiniteBeers(X)=true, I) :-
    holdsFor(location(X)=pub, I1),
    holdsFor(rich(X)=true, I2),
    intersect_all([I1,I2], I).

%%%%% short happiness
holdsFor(shortHappiness(X)=true, I) :-
    holdsFor(location(X)=pub,I1),
    holdsFor(rich(X)=true,I2),
    relative_complement_all(I1,[I2],I).

%%%%% drunk
holdsFor(drunk(X)=true,I) :-
    holdsFor(happy(X)=true,I1),
    holdsFor(infiniteBeers(X)=true,I2),
    intersect_all([I1,I2], I).

%%%%% sleeping at work
holdsFor(sleeping_at_work(X)=true,I) :-
    holdsFor(working(X)=true,I1),
    holdsFor(sleeping(X)=true,I2),
    intersect_all([I1,I2],I).

%%%%% workingEfficiently
holdsFor(workingEfficiently(X)=true,I):-
    holdsFor(working(X)=true,I1),
    holdsFor(sleeping_at_work(X)=true,I2),
    relative_complement_all(I1,[I2],I).









