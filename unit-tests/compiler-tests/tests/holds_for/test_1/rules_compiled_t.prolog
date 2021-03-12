:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

holdsForSDFluent(infiniteBeers(X)=true,I) :-
    holdsForProcessedSimpleFluent(X,location(X)=pub,I1),
    holdsForProcessedSimpleFluent(X,rich(X)=true,I2),
    intersect_all([I1,I2],I).

cachingOrder2(X, infiniteBeers(X)=true) :-person(X).


