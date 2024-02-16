:- dynamic person/1, person_pair/2.

initiatedAt(quote(_1884,_1886,_1888)=true, _1910, _1854, _1916) :-
     happensAtIE(present_quote(_1884,_1886,_1888,_1898),_1854),
     _1910=<_1854,
     _1854<_1916.

initiatedAt(contract(_1884,_1886,_1888)=true, _1996, _1854, _2002) :-
     happensAtIE(accept_quote(_1886,_1884,_1888),_1854),_1996=<_1854,_1854<_2002,
     holdsAtProcessedSimpleFluent(_1884,quote(_1884,_1886,_1888)=true,_1854),
     \+holdsAtCyclic(_1884,suspended(_1884,merchant)=true,_1854),
     \+holdsAtCyclic(_1886,suspended(_1886,consumer)=true,_1854).

initiatedAt(per(present_quote(_1888,_1890))=false, _1912, _1854, _1918) :-
     happensAtIE(present_quote(_1888,_1890,_1898,_1900),_1854),
     _1912=<_1854,
     _1854<_1918.

initiatedAt(per(present_quote(_1888,_1890))=true, _1910, _1854, _1916) :-
     happensAtIE(request_quote(_1890,_1888,_1898),_1854),
     _1910=<_1854,
     _1854<_1916.

initiatedAt(obl(send_EPO(_1888,iServer,_1892))=false, _1926, _1854, _1932) :-
     happensAtIE(send_EPO(_1888,iServer,_1892,_1902),_1854),_1926=<_1854,_1854<_1932,
     price(_1892,_1902).

initiatedAt(obl(send_goods(_1888,iServer,_1892))=false, _1942, _1854, _1948) :-
     happensAtIE(send_goods(_1888,iServer,_1892,_1902,_1904),_1854),_1942=<_1854,_1854<_1948,
     decrypt(_1902,_1904,_1918),
     meets(_1918,_1892).

initiatedAt(suspended(_1884,merchant)=true, _1942, _1854, _1948) :-
     happensAtIE(present_quote(_1884,_1892,_1894,_1896),_1854),_1942=<_1854,_1854<_1948,
     holdsAtProcessedSimpleFluent(_1884,per(present_quote(_1884,_1892))=false,_1854).

initiatedAt(obl(send_EPO(_1896,iServer,_1900))=true, _1854, _1856, _1858) :-
     initiatedAt(contract(_1910,_1896,_1900)=true,_1854,_1856,_1858).

initiatedAt(obl(send_goods(_1896,iServer,_1900))=true, _1854, _1856, _1858) :-
     initiatedAt(contract(_1896,_1912,_1900)=true,_1854,_1856,_1858).

initiatedAt(obl(send_EPO(_1896,iServer,_1900))=false, _1854, _1856, _1858) :-
     initiatedAt(contract(_1910,_1896,_1900)=false,_1854,_1856,_1858).

initiatedAt(obl(send_goods(_1896,iServer,_1900))=false, _1854, _1856, _1858) :-
     initiatedAt(contract(_1896,_1912,_1900)=false,_1854,_1856,_1858).

initiatedAt(suspended(_1892,merchant)=true, _1854, _1856, _1858) :-
     initiatedAt(contract(_1892,_1906,_1908)=false,_1854,_1856,_1858),
     holdsAtCyclic(_1892,obl(send_goods(_1892,iServer,_1908))=true,_1856).

initiatedAt(suspended(_1892,consumer)=true, _1854, _1856, _1858) :-
     initiatedAt(contract(_1904,_1892,_1908)=false,_1854,_1856,_1858),
     holdsAtCyclic(_1892,obl(send_EPO(_1892,iServer,_1908))=true,_1856).

terminatedAt(quote(_1884,_1886,_1888)=true, _1908, _1854, _1914) :-
     happensAtIE(accept_quote(_1886,_1884,_1888),_1854),
     _1908=<_1854,
     _1854<_1914.

holdsForSDFluent(pow(accept_quote(_1888,_1890,_1892))=true,_1854) :-
     holdsForProcessedSimpleFluent(_1890,quote(_1890,_1888,_1892)=true,_1912),
     holdsForProcessedSimpleFluent(_1888,suspended(_1888,consumer)=true,_1930),
     holdsForProcessedSimpleFluent(_1890,suspended(_1890,merchant)=true,_1948),
     relative_complement_all(_1912,[_1930,_1948],_1854).

fi(quote(_1888,_1890,_1892)=true,quote(_1888,_1890,_1892)=false,5):-
     grounding(quote(_1888,_1890,_1892)=true),
     grounding(quote(_1888,_1890,_1892)=false).

fi(contract(_1888,_1890,_1892)=true,contract(_1888,_1890,_1892)=false,5):-
     grounding(contract(_1888,_1890,_1892)=true),
     grounding(contract(_1888,_1890,_1892)=false).

fi(per(present_quote(_1892,_1894))=false,per(present_quote(_1892,_1894))=true,10):-
     grounding(per(present_quote(_1892,_1894))=false),
     grounding(per(present_quote(_1892,_1894))=true).

fi(suspended(_1888,_1890)=true,suspended(_1888,_1890)=false,3):-
     grounding(suspended(_1888,_1890)=true),
     grounding(suspended(_1888,_1890)=false).

grounding(request_quote(_2196,_2198,_2200)) :- 
     person_pair(_2198,_2196).

grounding(present_quote(_2196,_2198,_2200,_2202)) :- 
     person_pair(_2196,_2198).

grounding(accept_quote(_2196,_2198,_2200)) :- 
     person_pair(_2198,_2196).

grounding(send_EPO(_2196,_2198,_2200,_2202)) :- 
     person(_2196).

grounding(send_goods(_2196,_2198,_2200,_2202,_2204)) :- 
     person(_2196).

grounding(suspended(_2202,_2204)=true) :- 
     person(_2202),role_of(_2202,_2204).

grounding(suspended(_2202,_2204)=false) :- 
     person(_2202),role_of(_2202,_2204).

grounding(quote(_2202,_2204,_2206)=true) :- 
     person_pair(_2202,_2204),role_of(_2204,consumer),role_of(_2202,merchant),\+_2202=_2204,queryGoodsDescription(_2206).

grounding(quote(_2202,_2204,_2206)=false) :- 
     person_pair(_2202,_2204),role_of(_2204,consumer),role_of(_2202,merchant),\+_2202=_2204,queryGoodsDescription(_2206).

grounding(contract(_2202,_2204,_2206)=true) :- 
     person_pair(_2202,_2204),role_of(_2202,merchant),role_of(_2204,consumer),\+_2202=_2204,queryGoodsDescription(_2206).

grounding(contract(_2202,_2204,_2206)=false) :- 
     person_pair(_2202,_2204),role_of(_2202,merchant),role_of(_2204,consumer),\+_2202=_2204,queryGoodsDescription(_2206).

grounding(pow(accept_quote(_2206,_2208,_2210))=true) :- 
     person_pair(_2208,_2206),role_of(_2208,merchant),role_of(_2206,consumer),\+_2206=_2208,queryGoodsDescription(_2210).

grounding(per(present_quote(_2206,_2208))=false) :- 
     person_pair(_2206,_2208),role_of(_2206,merchant),role_of(_2208,consumer),\+_2208=_2206.

grounding(per(present_quote(_2206,_2208))=true) :- 
     person_pair(_2206,_2208),role_of(_2206,merchant),role_of(_2208,consumer),\+_2208=_2206.

grounding(obl(send_EPO(_2206,iServer,_2210))=true) :- 
     person(_2206),role_of(_2206,consumer),queryGoodsDescription(_2210).

grounding(obl(send_goods(_2206,iServer,_2210))=true) :- 
     person(_2206),role_of(_2206,merchant),queryGoodsDescription(_2210).

grounding(obl(send_EPO(_2206,iServer,_2210))=false) :- 
     person(_2206),role_of(_2206,consumer),queryGoodsDescription(_2210).

grounding(obl(send_goods(_2206,iServer,_2210))=false) :- 
     person(_2206),role_of(_2206,merchant),queryGoodsDescription(_2210).

p(quote(_2196,_2198,_2200)=true).

p(per(present_quote(_2200,_2202))=false).

p(suspended(_2196,_2198)=true).

inputEntity(present_quote(_1914,_1916,_1918,_1920)).
inputEntity(accept_quote(_1914,_1916,_1918)).
inputEntity(request_quote(_1914,_1916,_1918)).
inputEntity(send_EPO(_1914,_1916,_1918,_1920)).
inputEntity(send_goods(_1914,_1916,_1918,_1920,_1922)).

outputEntity(quote(_2012,_2014,_2016)=true).
outputEntity(contract(_2012,_2014,_2016)=true).
outputEntity(per(present_quote(_2016,_2018))=false).
outputEntity(per(present_quote(_2016,_2018))=true).
outputEntity(obl(send_EPO(_2016,_2018,_2020))=false).
outputEntity(obl(send_goods(_2016,_2018,_2020))=false).
outputEntity(suspended(_2012,_2014)=true).
outputEntity(obl(send_EPO(_2016,_2018,_2020))=true).
outputEntity(obl(send_goods(_2016,_2018,_2020))=true).
outputEntity(quote(_2012,_2014,_2016)=false).
outputEntity(contract(_2012,_2014,_2016)=false).
outputEntity(suspended(_2012,_2014)=false).
outputEntity(pow(accept_quote(_2016,_2018,_2020))=true).

event(present_quote(_2146,_2148,_2150,_2152)).
event(accept_quote(_2146,_2148,_2150)).
event(request_quote(_2146,_2148,_2150)).
event(send_EPO(_2146,_2148,_2150,_2152)).
event(send_goods(_2146,_2148,_2150,_2152,_2154)).

simpleFluent(quote(_2244,_2246,_2248)=true).
simpleFluent(contract(_2244,_2246,_2248)=true).
simpleFluent(per(present_quote(_2248,_2250))=false).
simpleFluent(per(present_quote(_2248,_2250))=true).
simpleFluent(obl(send_EPO(_2248,_2250,_2252))=false).
simpleFluent(obl(send_goods(_2248,_2250,_2252))=false).
simpleFluent(suspended(_2244,_2246)=true).
simpleFluent(obl(send_EPO(_2248,_2250,_2252))=true).
simpleFluent(obl(send_goods(_2248,_2250,_2252))=true).
simpleFluent(quote(_2244,_2246,_2248)=false).
simpleFluent(contract(_2244,_2246,_2248)=false).
simpleFluent(suspended(_2244,_2246)=false).

sDFluent(pow(accept_quote(_2382,_2384,_2386))=true).

index(present_quote(_2386,_2446,_2448,_2450),_2386).
index(accept_quote(_2386,_2446,_2448),_2386).
index(request_quote(_2386,_2446,_2448),_2386).
index(send_EPO(_2386,_2446,_2448,_2450),_2386).
index(send_goods(_2386,_2446,_2448,_2450,_2452),_2386).
index(quote(_2386,_2452,_2454)=true,_2386).
index(contract(_2386,_2452,_2454)=true,_2386).
index(per(present_quote(_2386,_2456))=false,_2386).
index(per(present_quote(_2386,_2456))=true,_2386).
index(obl(send_EPO(_2386,_2456,_2458))=false,_2386).
index(obl(send_goods(_2386,_2456,_2458))=false,_2386).
index(suspended(_2386,_2452)=true,_2386).
index(obl(send_EPO(_2386,_2456,_2458))=true,_2386).
index(obl(send_goods(_2386,_2456,_2458))=true,_2386).
index(quote(_2386,_2452,_2454)=false,_2386).
index(contract(_2386,_2452,_2454)=false,_2386).
index(suspended(_2386,_2452)=false,_2386).
index(pow(accept_quote(_2386,_2456,_2458))=true,_2386).

cyclic(contract(_2680,_2682,_2684)=true).
cyclic(suspended(_2680,_2682)=true).
cyclic(obl(send_EPO(_2684,_2686,_2688))=true).
cyclic(obl(send_goods(_2684,_2686,_2688))=true).
cyclic(contract(_2680,_2682,_2684)=false).
cyclic(suspended(_2680,_2682)=false).

cachingOrder2(_2920, quote(_2920,_2922,_2924)=true) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_2920,_2922),role_of(_2922,consumer),role_of(_2920,merchant),\+_2920=_2922,queryGoodsDescription(_2924).

cachingOrder2(_2920, quote(_2920,_2922,_2924)=false) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_2920,_2922),role_of(_2922,consumer),role_of(_2920,merchant),\+_2920=_2922,queryGoodsDescription(_2924).

cachingOrder2(_2874, per(present_quote(_2874,_2876))=false) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_2874,_2876),role_of(_2874,merchant),role_of(_2876,consumer),\+_2876=_2874.

cachingOrder2(_2874, per(present_quote(_2874,_2876))=true) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_2874,_2876),role_of(_2874,merchant),role_of(_2876,consumer),\+_2876=_2874.

cachingOrder2(_3656, obl(send_goods(_3656,_3892,_3660))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_3656),role_of(_3656,merchant),queryGoodsDescription(_3660).

cachingOrder2(_3680, obl(send_EPO(_3680,_4050,_3684))=true) :- % level in dependency graph: 2, processing order in component: 2
     person(_3680),role_of(_3680,consumer),queryGoodsDescription(_3684).

cachingOrder2(_3700, suspended(_3700,_3702)=true) :- % level in dependency graph: 2, processing order in component: 3
     person(_3700),role_of(_3700,_3702).

cachingOrder2(_3718, suspended(_3718,_3720)=false) :- % level in dependency graph: 2, processing order in component: 4
     person(_3718),role_of(_3718,_3720).

cachingOrder2(_3736, contract(_3736,_3738,_3740)=true) :- % level in dependency graph: 2, processing order in component: 5
     person_pair(_3736,_3738),role_of(_3736,merchant),role_of(_3738,consumer),\+_3736=_3738,queryGoodsDescription(_3740).

cachingOrder2(_3756, contract(_3756,_3758,_3760)=false) :- % level in dependency graph: 2, processing order in component: 6
     person_pair(_3756,_3758),role_of(_3756,merchant),role_of(_3758,consumer),\+_3756=_3758,queryGoodsDescription(_3760).

cachingOrder2(_4720, obl(send_EPO(_4720,_4856,_4724))=false) :- % level in dependency graph: 3, processing order in component: 1
     person(_4720),role_of(_4720,consumer),queryGoodsDescription(_4724).

cachingOrder2(_4690, obl(send_goods(_4690,_5014,_4694))=false) :- % level in dependency graph: 3, processing order in component: 1
     person(_4690),role_of(_4690,merchant),queryGoodsDescription(_4694).

cachingOrder2(_4660, pow(accept_quote(_4660,_4662,_4664))=true) :- % level in dependency graph: 3, processing order in component: 1
     person_pair(_4662,_4660),role_of(_4662,merchant),role_of(_4660,consumer),\+_4660=_4662,queryGoodsDescription(_4664).

collectGrounds([send_EPO(_2168,_2182,_2184,_2186), send_goods(_2168,_2182,_2184,_2186,_2188)],person(_2168)).

collectGrounds([present_quote(_2156,_2158,_2184,_2186), accept_quote(_2158,_2156,_2184), request_quote(_2158,_2156,_2184)],person_pair(_2156,_2158)).

dgrounded(quote(_3120,_3122,_3124)=true, person_pair(_3120,_3122)).
dgrounded(contract(_3032,_3034,_3036)=true, person_pair(_3032,_3034)).
dgrounded(per(present_quote(_2956,_2958))=false, person_pair(_2956,_2958)).
dgrounded(per(present_quote(_2876,_2878))=true, person_pair(_2876,_2878)).
dgrounded(obl(send_EPO(_2814,iServer,_2818))=false, person(_2814)).
dgrounded(obl(send_goods(_2752,iServer,_2756))=false, person(_2752)).
dgrounded(suspended(_2702,_2704)=true, person(_2702)).
dgrounded(obl(send_EPO(_2644,iServer,_2648))=true, person(_2644)).
dgrounded(obl(send_goods(_2582,iServer,_2586))=true, person(_2582)).
dgrounded(quote(_2490,_2492,_2494)=false, person_pair(_2490,_2492)).
dgrounded(contract(_2402,_2404,_2406)=false, person_pair(_2402,_2404)).
dgrounded(suspended(_2356,_2358)=false, person(_2356)).
dgrounded(pow(accept_quote(_2268,_2270,_2272))=true, person_pair(_2270,_2268)).
