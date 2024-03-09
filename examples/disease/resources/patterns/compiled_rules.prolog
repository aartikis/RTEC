initiatedAt(disease(_1884,_1886)=true, _1904, _1854, _1910) :-
     happensAtIE(has_diag(_1884,_1886),_1854),
     _1904=<_1854,
     _1854<_1910.

holdsForSDFluent(lungC_disease(_1884)=true,_1854) :-
     holdsForProcessedSimpleFluent(_1884,disease(_1884,c34)=true,_1854).

grounding(has_diag(_2104,_2106)) :- 
     patient(_2104),diagnosis(_2106).

grounding(disease(_2110,_2112)=true) :- 
     patient(_2110),diagnosis(_2112).

grounding(lungC_disease(_2110)=true) :- 
     patient(_2110).

inputEntity(has_diag(_1914,_1916)).

outputEntity(disease(_1988,_1990)=true).
outputEntity(lungC_disease(_1988)=true).

event(has_diag(_2056,_2058)).

simpleFluent(disease(_2130,_2132)=true).

sDFluent(lungC_disease(_2198)=true).

index(has_diag(_2206,_2266),_2206).
index(disease(_2206,_2272)=true,_2206).
index(lungC_disease(_2206)=true,_2206).


cachingOrder2(_2476, disease(_2476,_2478)=true) :- % level in dependency graph: 1, processing order in component: 1
     patient(_2476),diagnosis(_2478).

cachingOrder2(_2650, lungC_disease(_2650)=true) :- % level in dependency graph: 2, processing order in component: 1
     patient(_2650).

