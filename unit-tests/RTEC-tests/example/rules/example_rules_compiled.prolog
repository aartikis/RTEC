initiatedAt(runningTest(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(starts_test(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

terminatedAt(runningTest(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(ends_test(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

cachingOrder2(_131123, runningTest(_131123)=true) :-
     unitTester(_131123).

