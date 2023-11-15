:- dynamic person/1.

initiatedAt(status(_1872)=null, _1882, -1, _1890) :-
     _1882=< -1,
     -1<_1890.

initiatedAt(status(_1882)=proposed, _1928, _1852, _1934) :-
     happensAtIE(propose(_1886,_1882),_1852),_1928=<_1852,_1852<_1934,
     holdsAtCyclic(_1882,status(_1882)=null,_1852).

initiatedAt(status(_1882)=voting, _1928, _1852, _1934) :-
     happensAtIE(second(_1886,_1882),_1852),_1928=<_1852,_1852<_1934,
     holdsAtCyclic(_1882,status(_1882)=proposed,_1852).

initiatedAt(status(_1882)=voted, _1940, _1852, _1946) :-
     happensAtIE(close_ballot(_1886,_1882),_1852),_1940=<_1852,_1852<_1946,
     role_of(_1886,chair),
     holdsAtCyclic(_1882,status(_1882)=voting,_1852).

initiatedAt(status(_1882)=null, _1942, _1852, _1948) :-
     happensAtIE(declare(_1886,_1882,_1890),_1852),_1942=<_1852,_1852<_1948,
     role_of(_1886,chair),
     holdsAtCyclic(_1882,status(_1882)=voted,_1852).

initiatedAt(voted(_1882,_1884)=_1858, _1926, _1852, _1932) :-
     happensAtIE(vote(_1882,_1884,_1858),_1852),_1926=<_1852,_1852<_1932,
     holdsAtProcessedSimpleFluent(_1884,status(_1884)=voting,_1852).

initiatedAt(voted(_1882,_1884)=null, _1910, _1852, _1916) :-
     happensAtProcessedSimpleFluent(_1884,start(status(_1884)=null),_1852),
     _1910=<_1852,
     _1852<_1916.

initiatedAt(outcome(_1882)=_1858, _1936, _1852, _1942) :-
     happensAtIE(declare(_1886,_1882,_1858),_1852),_1936=<_1852,_1852<_1942,
     holdsAtProcessedSimpleFluent(_1882,status(_1882)=voted,_1852),
     role_of(_1886,chair).

initiatedAt(auxPerCloseBallot(_1882)=true, _1908, _1852, _1914) :-
     happensAtProcessedSimpleFluent(_1882,start(status(_1882)=voting),_1852),
     _1908=<_1852,
     _1852<_1914.

initiatedAt(auxPerCloseBallot(_1882)=false, _1908, _1852, _1914) :-
     happensAtProcessedSimpleFluent(_1882,start(status(_1882)=proposed),_1852),
     _1908=<_1852,
     _1852<_1914.

initiatedAt(per(close_ballot(_1886,_1888))=true, _1936, _1852, _1942) :-
     happensAtProcessedSimpleFluent(_1888,end(auxPerCloseBallot(_1888)=true),_1852),_1936=<_1852,_1852<_1942,
     holdsAtProcessedSimpleFluent(_1888,status(_1888)=voting,_1852).

initiatedAt(per(close_ballot(_1886,_1888))=false, _1914, _1852, _1920) :-
     happensAtProcessedSimpleFluent(_1888,start(status(_1888)=voted),_1852),
     _1914=<_1852,
     _1852<_1920.

initiatedAt(obl(declare(_1886,_1888,carried))=true, _1908, _1852, _1914) :-
     happensAtProcessed(_1888,auxMotionOutcomeEvent(_1888,carried),_1852),
     _1908=<_1852,
     _1852<_1914.

initiatedAt(obl(declare(_1886,_1888,carried))=false, _1916, _1852, _1922) :-
     happensAtProcessedSimpleFluent(_1888,start(status(_1888)=null),_1852),
     _1916=<_1852,
     _1852<_1922.

initiatedAt(sanctioned(_1882)=true, _1932, _1852, _1938) :-
     happensAtIE(close_ballot(_1882,_1888),_1852),_1932=<_1852,_1852<_1938,
     \+holdsAtProcessedSimpleFluent(_1882,per(close_ballot(_1882,_1888))=true,_1852).

initiatedAt(sanctioned(_1882)=true, _1962, _1852, _1968) :-
     happensAtProcessedSimpleFluent(_1896,end(status(_1896)=voted),_1852),_1962=<_1852,_1852<_1968,
     \+happensAtIE(declare(_1882,_1896,carried),_1852),
     holdsAtProcessedSimpleFluent(_1882,obl(declare(_1882,_1896,carried))=true,_1852).

initiatedAt(sanctioned(_1882)=true, _1966, _1852, _1972) :-
     happensAtProcessedSimpleFluent(_1896,end(status(_1896)=voted),_1852),_1966=<_1852,_1852<_1972,
     \+happensAtIE(declare(_1882,_1896,not_carried),_1852),
     \+holdsAtProcessedSimpleFluent(_1882,obl(declare(_1882,_1896,carried))=true,_1852).

terminatedAt(outcome(_1882)=_1858, _1908, _1852, _1914) :-
     happensAtProcessedSimpleFluent(_1882,start(status(_1882)=proposed),_1852),
     _1908=<_1852,
     _1852<_1914.

holdsForSDFluent(pow(propose(_1886,_1888))=true,_1852) :-
     holdsForProcessedSimpleFluent(_1888,status(_1888)=null,_1852).

holdsForSDFluent(pow(second(_1886,_1888))=true,_1852) :-
     holdsForProcessedSimpleFluent(_1888,status(_1888)=proposed,_1852).

holdsForSDFluent(pow(vote(_1886,_1888))=true,_1852) :-
     holdsForProcessedSimpleFluent(_1888,status(_1888)=voting,_1852).

holdsForSDFluent(pow(close_ballot(_1886,_1888))=true,_1852) :-
     holdsForProcessedSimpleFluent(_1888,status(_1888)=voting,_1852).

holdsForSDFluent(pow(declare(_1886,_1888))=true,_1852) :-
     holdsForProcessedSimpleFluent(_1888,status(_1888)=voted,_1852).

happensAtEv(auxMotionOutcomeEvent(_1870,carried),_1852) :-
     happensAtProcessedSimpleFluent(_1870,start(status(_1870)=voted),_1852),
     findall(_1908,holdsAtProcessedSimpleFluent(_1908,voted(_1908,_1870)=aye,_1852),_1918),
     length(_1918,_1924),
     findall(_1908,holdsAtProcessedSimpleFluent(_1908,voted(_1908,_1870)=nay,_1852),_1950),
     length(_1950,_1956),
     _1924>=_1956.

fi(status(_1886)=proposed,status(_1886)=null,10):-
     grounding(status(_1886)=proposed),
     grounding(status(_1886)=null).

fi(status(_1886)=voting,status(_1886)=voted,10):-
     grounding(status(_1886)=voting),
     grounding(status(_1886)=voted).

fi(status(_1886)=voted,status(_1886)=null,10):-
     grounding(status(_1886)=voted),
     grounding(status(_1886)=null).

fi(auxPerCloseBallot(_1886)=true,auxPerCloseBallot(_1886)=false,8):-
     grounding(auxPerCloseBallot(_1886)=true),
     grounding(auxPerCloseBallot(_1886)=false).

fi(sanctioned(_1886)=true,sanctioned(_1886)=false,4):-
     grounding(sanctioned(_1886)=true),
     grounding(sanctioned(_1886)=false).

grounding(propose(_2190,_2192)) :- 
     person(_2190),motion(_2192).

grounding(second(_2190,_2192)) :- 
     person(_2190),motion(_2192).

grounding(vote(_2190,_2192,_2194)) :- 
     person(_2190),motion(_2192).

grounding(close_ballot(_2190,_2192)) :- 
     person(_2190),motion(_2192).

grounding(declare(_2190,_2192,_2194)) :- 
     person(_2190),motion(_2192).

grounding(status(_2196)=null) :- 
     queryMotion(_2196).

grounding(status(_2196)=proposed) :- 
     queryMotion(_2196).

grounding(status(_2196)=voting) :- 
     queryMotion(_2196).

grounding(status(_2196)=voted) :- 
     queryMotion(_2196).

grounding(voted(_2196,_2198)=aye) :- 
     person(_2196),role_of(_2196,voter),queryMotion(_2198).

grounding(voted(_2196,_2198)=nay) :- 
     person(_2196),role_of(_2196,voter),queryMotion(_2198).

grounding(auxMotionOutcomeEvent(_2190,_2192)) :- 
     queryMotion(_2190).

grounding(outcome(_2196)=carried) :- 
     queryMotion(_2196).

grounding(outcome(_2196)=not_carried) :- 
     queryMotion(_2196).

grounding(auxPerCloseBallot(_2196)=true) :- 
     queryMotion(_2196).

grounding(per(close_ballot(_2200,_2202))=true) :- 
     person(_2200),role_of(_2200,chair),queryMotion(_2202).

grounding(obl(declare(_2200,_2202,carried))=true) :- 
     person(_2200),role_of(_2200,chair),queryMotion(_2202).

grounding(sanctioned(_2196)=true) :- 
     person(_2196),role_of(_2196,chair).

grounding(auxPerCloseBallot(_2196)=false) :- 
     queryMotion(_2196).

grounding(per(close_ballot(_2200,_2202))=false) :- 
     person(_2200),role_of(_2200,chair),queryMotion(_2202).

grounding(obl(declare(_2200,_2202,carried))=false) :- 
     person(_2200),role_of(_2200,chair),queryMotion(_2202).

grounding(sanctioned(_2196)=false) :- 
     person(_2196),role_of(_2196,chair).

inputEntity(propose(_1912,_1914)).
inputEntity(second(_1912,_1914)).
inputEntity(close_ballot(_1912,_1914)).
inputEntity(declare(_1912,_1914,_1916)).
inputEntity(vote(_1912,_1914,_1916)).

outputEntity(status(_2010)=proposed).
outputEntity(status(_2010)=voting).
outputEntity(status(_2010)=voted).
outputEntity(status(_2010)=null).
outputEntity(voted(_2010,_2012)=aye).
outputEntity(voted(_2010,_2012)=nay).
outputEntity(voted(_2010,_2012)=null).
outputEntity(outcome(_2010)=carried).
outputEntity(outcome(_2010)=not_carried).
outputEntity(auxPerCloseBallot(_2010)=true).
outputEntity(auxPerCloseBallot(_2010)=false).
outputEntity(per(close_ballot(_2014,_2016))=true).
outputEntity(per(close_ballot(_2014,_2016))=false).
outputEntity(obl(declare(_2014,_2016,_2018))=true).
outputEntity(obl(declare(_2014,_2016,_2018))=false).
outputEntity(sanctioned(_2010)=true).
outputEntity(sanctioned(_2010)=false).
outputEntity(pow(propose(_2014,_2016))=true).
outputEntity(pow(second(_2014,_2016))=true).
outputEntity(pow(vote(_2014,_2016))=true).
outputEntity(pow(close_ballot(_2014,_2016))=true).
outputEntity(pow(declare(_2014,_2016))=true).
outputEntity(auxMotionOutcomeEvent(_2004,_2006)).

event(auxMotionOutcomeEvent(_2204,_2206)).
event(propose(_2204,_2206)).
event(second(_2204,_2206)).
event(close_ballot(_2204,_2206)).
event(declare(_2204,_2206,_2208)).
event(vote(_2204,_2206,_2208)).

simpleFluent(status(_2308)=proposed).
simpleFluent(status(_2308)=voting).
simpleFluent(status(_2308)=voted).
simpleFluent(status(_2308)=null).
simpleFluent(voted(_2308,_2310)=aye).
simpleFluent(voted(_2308,_2310)=nay).
simpleFluent(voted(_2308,_2310)=null).
simpleFluent(outcome(_2308)=carried).
simpleFluent(outcome(_2308)=not_carried).
simpleFluent(auxPerCloseBallot(_2308)=true).
simpleFluent(auxPerCloseBallot(_2308)=false).
simpleFluent(per(close_ballot(_2312,_2314))=true).
simpleFluent(per(close_ballot(_2312,_2314))=false).
simpleFluent(obl(declare(_2312,_2314,_2316))=true).
simpleFluent(obl(declare(_2312,_2314,_2316))=false).
simpleFluent(sanctioned(_2308)=true).
simpleFluent(sanctioned(_2308)=false).

sDFluent(pow(propose(_2476,_2478))=true).
sDFluent(pow(second(_2476,_2478))=true).
sDFluent(pow(vote(_2476,_2478))=true).
sDFluent(pow(close_ballot(_2476,_2478))=true).
sDFluent(pow(declare(_2476,_2478))=true).

index(auxMotionOutcomeEvent(_2504,_2564),_2504).
index(propose(_2504,_2564),_2504).
index(second(_2504,_2564),_2504).
index(close_ballot(_2504,_2564),_2504).
index(declare(_2504,_2564,_2566),_2504).
index(vote(_2504,_2564,_2566),_2504).
index(status(_2504)=proposed,_2504).
index(status(_2504)=voting,_2504).
index(status(_2504)=voted,_2504).
index(status(_2504)=null,_2504).
index(voted(_2504,_2570)=aye,_2504).
index(voted(_2504,_2570)=nay,_2504).
index(voted(_2504,_2570)=null,_2504).
index(outcome(_2504)=carried,_2504).
index(outcome(_2504)=not_carried,_2504).
index(auxPerCloseBallot(_2504)=true,_2504).
index(auxPerCloseBallot(_2504)=false,_2504).
index(per(close_ballot(_2504,_2574))=true,_2504).
index(per(close_ballot(_2504,_2574))=false,_2504).
index(obl(declare(_2504,_2574,_2576))=true,_2504).
index(obl(declare(_2504,_2574,_2576))=false,_2504).
index(sanctioned(_2504)=true,_2504).
index(sanctioned(_2504)=false,_2504).
index(pow(propose(_2504,_2574))=true,_2504).
index(pow(second(_2504,_2574))=true,_2504).
index(pow(vote(_2504,_2574))=true,_2504).
index(pow(close_ballot(_2504,_2574))=true,_2504).
index(pow(declare(_2504,_2574))=true,_2504).

cyclic(status(_2858)=proposed).
cyclic(status(_2858)=voting).
cyclic(status(_2858)=voted).
cyclic(status(_2858)=null).

cachingOrder2(_2988, status(_2988)=voting) :- % level in dependency graph: 1, processing order in component: 1
     queryMotion(_2988).

cachingOrder2(_3004, status(_3004)=voted) :- % level in dependency graph: 1, processing order in component: 2
     queryMotion(_3004).

cachingOrder2(_3020, status(_3020)=proposed) :- % level in dependency graph: 1, processing order in component: 3
     queryMotion(_3020).

cachingOrder2(_3036, status(_3036)=null) :- % level in dependency graph: 1, processing order in component: 4
     queryMotion(_3036).

cachingOrder2(_3720, voted(_3720,_3722)=aye) :- % level in dependency graph: 2, processing order in component: 1
     person(_3720),role_of(_3720,voter),queryMotion(_3722).

cachingOrder2(_3696, voted(_3696,_3698)=nay) :- % level in dependency graph: 2, processing order in component: 1
     person(_3696),role_of(_3696,voter),queryMotion(_3698).

cachingOrder2(_3650, outcome(_3650)=carried) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_3650).

cachingOrder2(_3628, outcome(_3628)=not_carried) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_3628).

cachingOrder2(_3590, auxPerCloseBallot(_3590)=true) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_3590).

cachingOrder2(_3590, auxPerCloseBallot(_3590)=false) :- % level in dependency graph: 2, processing order in component: 2
     queryMotion(_3590).

cachingOrder2(_3566, per(close_ballot(_3566,_3568))=false) :- % level in dependency graph: 2, processing order in component: 1
     person(_3566),role_of(_3566,chair),queryMotion(_3568).

cachingOrder2(_3536, obl(declare(_3536,_3538,_4498))=false) :- % level in dependency graph: 2, processing order in component: 1
     person(_3536),role_of(_3536,chair),queryMotion(_3538).

cachingOrder2(_4616, per(close_ballot(_4616,_4618))=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_4616),role_of(_4616,chair),queryMotion(_4618).

cachingOrder2(_4588, auxMotionOutcomeEvent(_4588,_4590)) :- % level in dependency graph: 3, processing order in component: 1
     queryMotion(_4588).

cachingOrder2(_4914, obl(declare(_4914,_4916,_5056))=true) :- % level in dependency graph: 4, processing order in component: 1
     person(_4914),role_of(_4914,chair),queryMotion(_4916).

cachingOrder2(_5152, sanctioned(_5152)=true) :- % level in dependency graph: 5, processing order in component: 1
     person(_5152),role_of(_5152,chair).

cachingOrder2(_5152, sanctioned(_5152)=false) :- % level in dependency graph: 5, processing order in component: 2
     person(_5152),role_of(_5152,chair).

collectGrounds([propose(_2184,_2198), second(_2184,_2198), close_ballot(_2184,_2198), declare(_2184,_2198,_2200), vote(_2184,_2198,_2200)],person(_2184)).

dgrounded(voted(_2824,_2826)=aye, person(_2824)).
dgrounded(voted(_2768,_2770)=nay, person(_2768)).
dgrounded(per(close_ballot(_2584,_2586))=true, person(_2584)).
dgrounded(per(close_ballot(_2524,_2526))=false, person(_2524)).
dgrounded(obl(declare(_2462,_2464,carried))=true, person(_2462)).
dgrounded(obl(declare(_2400,_2402,carried))=false, person(_2400)).
dgrounded(sanctioned(_2352)=true, person(_2352)).
dgrounded(sanctioned(_2308)=false, person(_2308)).
