:- dynamic fi/3, p/1.

%%%%%% rich
initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T).
terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T).
fi(rich(X)=true,rich(X)=false,4):-
    grounding(rich(X)=true).
p(rich(_X)=true).

initiatedAt(rich2(X)=true, T) :-
    happensAt(win_lottery(X), T).
terminatedAt(rich2(X)=true, T) :-
    happensAt(lose_wallet(X), T).
fi(rich2(X)=true,rich2(X)=false,8):-
    grounding(rich2(X)=true).
p(rich2(_X)=true).

%%%%% working
initiatedAt(working(X)=true, T):-
    happensAt(starts_working(X),T).

terminatedAt(working(X)=true, T) :-
    happensAt(ends_working(X), T).

fi(working(X)=true,working(X)=false,8):-
    grounding(working(X)=true).

%%%%%%%%%%%%%%% cycle A %%%%%%%%%%%%%%%%%

initiatedAt(strength(X)=full,T1,-1,T2):-
    T1=<(-1), -1<T2.

initiatedAt(strength(X)=tired,T):-
    happensAt(ends_working(X),T),
    holdsAt(strength(X)=lowering,T).

initiatedAt(strength(X)=lowering,T):-
    happensAt(starts_working(X),T),
    holdsAt(strength(X)=full,T).

initiatedAt(strength(X)=full,T):-
    happensAt(sleep_end(X),T),
    holdsAt(strength(X)=tired,T).

%%%%%%%%%%%%%%% cycle B  %%%%%%%%%%%%%%%%%
initiatedAt(hungry(X)=true,T):-
    happensAt(smell_bacon(X),T),
    \+holdsAt(noFoodNeeds(X)=true,T).

terminatedAt(hungry(X)=true,T):-
    happensAt(ate_bacon(X),T).

initiatedAt(eating(X)=true,T):-
    happensAt(found_bacon(X),T),
    holdsAt(hungry(X)=true,T).

terminatedAt(eating(X)=true,T):-
    happensAt(ate_bacon(X),T).

initiatedAt(noFoodNeeds(X)=true,T):-
   happensAt(ate_bacon(X),T),
   holdsAt(eating(X)=true,T).

terminatedAt(noFoodNeeds(X)=true,T):-
   happensAt(needsFood(X),T).

