:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

holdsForSDFluent(drunk(X)=true,I) :-
    holdsForProcessedSDFluent(X,happy(X)=true,I1),
    holdsForProcessedSDFluent(X,infiniteBeers(X)=true,I2),
    intersect_all([I1,I2],I).

cachingOrder2(X, drunk(X)=true) :-person(X).

