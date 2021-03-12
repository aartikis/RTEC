:-dynamic initiatedAt/4, terminatedAt/4.

initiatedAt(srich(X)=true, T1, T, T2) :-
     happensAtProcessedSimpleFluent(X,start(rich(X)=true),T),
     T1=<T,T<T2.

terminatedAt(srich(X)=true, T1, T, T2) :-
     happensAtProcessedSimpleFluent(X,end(rich(X)=true),T),
     T1=<T,
     T<T2.

