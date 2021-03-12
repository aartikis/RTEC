:-dynamic initiatedAt/4, terminatedAt/4.
initiatedAt(rich(X)=true, T1, T, T2) :-
     happensAtIE(win_lottery(X),T),T1=<T,T<T2,
     \+holdsAtProcessedSDFluent(X,sleeping_at_work(X)=true,T).


terminatedAt(rich(X)=true, T1, T, T2) :-
     happensAtIE(lose_wallet(X),T),
     T1=<T,
     T<T2.


