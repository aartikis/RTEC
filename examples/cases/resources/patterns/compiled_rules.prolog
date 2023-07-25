initiatedAt(fa(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(sa(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

initiatedAt(fb(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(sb(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

initiatedAt(fc(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(sc(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

terminatedAt(fa(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(ea(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

terminatedAt(fb(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(eb(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

terminatedAt(fc(_1882)=true, _1898, _1852, _1904) :-
     happensAtIE(ec(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

holdsForSDFluent(caseA(_1882)=true,_1852) :-
     holdsForProcessedSimpleFluent(_1882,fa(_1882)=true,_1898),
     holdsForProcessedSimpleFluent(_1882,fb(_1882)=true,_1914),
     during(caseA(_1882)=true,0,_1914,_1898,union,true,_1924),
     holdsForProcessedSimpleFluent(_1882,fc(_1882)=true,_1940),
     intersect_all([_1924,_1940],_1852).

holdsForSDFluent(caseB(_1882)=true,_1852) :-
     holdsForProcessedSimpleFluent(_1882,fa(_1882)=true,_1898),
     holdsForProcessedSimpleFluent(_1882,fc(_1882)=true,_1914),
     during(caseB(_1882)=true,0,_1914,_1898,union,true,_1924),
     holdsForProcessedSimpleFluent(_1882,fb(_1882)=true,_1940),
     during(caseB(_1882)=true,1,_1940,_1924,union,true,_1852).

grounding(sa(_2120)) :- 
     p(_2120).

grounding(sb(_2120)) :- 
     p(_2120).

grounding(sc(_2120)) :- 
     p(_2120).

grounding(ea(_2120)) :- 
     p(_2120).

grounding(eb(_2120)) :- 
     p(_2120).

grounding(ec(_2120)) :- 
     p(_2120).

grounding(fa(_2126)=true) :- 
     p(_2126).

grounding(fb(_2126)=true) :- 
     p(_2126).

grounding(fc(_2126)=true) :- 
     p(_2126).

grounding(caseA(_2126)=true) :- 
     p(_2126).

grounding(caseB(_2126)=true) :- 
     p(_2126).

inputEntity(sa(_1912)).
inputEntity(sb(_1912)).
inputEntity(sc(_1912)).
inputEntity(ea(_1912)).
inputEntity(eb(_1912)).
inputEntity(ec(_1912)).

outputEntity(fa(_2016)=true).
outputEntity(fb(_2016)=true).
outputEntity(fc(_2016)=true).
outputEntity(caseA(_2016)=true).
outputEntity(caseB(_2016)=true).

event(sa(_2102)).
event(sb(_2102)).
event(sc(_2102)).
event(ea(_2102)).
event(eb(_2102)).
event(ec(_2102)).

simpleFluent(fa(_2206)=true).
simpleFluent(fb(_2206)=true).
simpleFluent(fc(_2206)=true).

sDFluent(caseA(_2286)=true).
sDFluent(caseB(_2286)=true).

index(sa(_2300),_2300).
index(sb(_2300),_2300).
index(sc(_2300),_2300).
index(ea(_2300),_2300).
index(eb(_2300),_2300).
index(ec(_2300),_2300).
index(fa(_2300)=true,_2300).
index(fb(_2300)=true,_2300).
index(fc(_2300)=true,_2300).
index(caseA(_2300)=true,_2300).
index(caseB(_2300)=true,_2300).


cachingOrder2(_2644, fa(_2644)=true) :- % level: 1
     p(_2644).

cachingOrder2(_2628, fb(_2628)=true) :- % level: 1
     p(_2628).

cachingOrder2(_2612, fc(_2612)=true) :- % level: 1
     p(_2612).

cachingOrder2(_2826, caseA(_2826)=true) :- % level: 2
     p(_2826).

cachingOrder2(_2810, caseB(_2810)=true) :- % level: 2
     p(_2810).

