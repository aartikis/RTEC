:-dynamic initiatedAt/4, terminatedAt/4, holdsForSDFluent/2.

%%%%% drunk
holdsFor(drunk(X)=true,I) :-
    holdsFor(happy(X)=true,I1),
    holdsFor(infiniteBeers(X)=true,I2),
    intersect_all([I1,I2], I).









