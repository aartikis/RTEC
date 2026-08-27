%%%%%% runningTest
initiatedAt(runningTest(X)=true, T) :-
    happensAt(starts_test(X), T).
terminatedAt(runningTest(X)=true, T) :-
    happensAt(ends_test(X), T).


