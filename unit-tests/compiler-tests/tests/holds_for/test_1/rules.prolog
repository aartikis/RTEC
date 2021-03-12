
%%%%% infinite beers
holdsFor(infiniteBeers(X)=true, I) :-
    holdsFor(location(X)=pub, I1),
    holdsFor(rich(X)=true, I2),
    intersect_all([I1,I2], I).

