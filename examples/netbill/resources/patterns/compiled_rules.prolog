:- dynamic person/1, person_pair/2.

initiatedAt(quote(_1884,_1886,_1888)=true, _1910, _1854, _1916) :-
     happensAtIE(present_quote(_1884,_1886,_1888,_1898),_1854),
     _1910=<_1854,
     _1854<_1916.

initiatedAt(contract(_1884,_1884,_1888)=true, _1996, _1854, _2002) :-
     happensAtIE(accept_quote(_1884,_1884,_1888),_1854),_1996=<_1854,_1854<_2002,
     holdsAtProcessedSimpleFluent(_1884,quote(_1884,_1884,_1888)=true,_1854),
     \+holdsAtCyclic(_1884,suspended(_1884,merchant)=true,_1854),
     \+holdsAtCyclic(_1884,suspended(_1884,consumer)=true,_1854).

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

maxDuration(contract(_1888,_1890,_1892)=true,contract(_1888,_1890,_1892)=false,5):-
     grounding(contract(_1888,_1890,_1892)=true),
     grounding(contract(_1888,_1890,_1892)=false).

maxDurationUE(quote(_1888,_1890,_1892)=true,quote(_1888,_1890,_1892)=false,5):-
     grounding(quote(_1888,_1890,_1892)=true),
     grounding(quote(_1888,_1890,_1892)=false).

maxDurationUE(per(present_quote(_1892,_1894))=false,per(present_quote(_1892,_1894))=true,10):-
     grounding(per(present_quote(_1892,_1894))=false),
     grounding(per(present_quote(_1892,_1894))=true).

maxDurationUE(suspended(_1888,_1890)=true,suspended(_1888,_1890)=false,3):-
     grounding(suspended(_1888,_1890)=true),
     grounding(suspended(_1888,_1890)=false).

grounding(request_quote(_2200,_2202,_2204)) :- 
     person_pair(_2202,_2200).

grounding(present_quote(_2200,_2202,_2204,_2206)) :- 
     person_pair(_2200,_2202).

grounding(accept_quote(_2200,_2202,_2204)) :- 
     person_pair(_2202,_2200).

grounding(send_EPO(_2200,_2202,_2204,_2206)) :- 
     person(_2200).

grounding(send_goods(_2200,_2202,_2204,_2206,_2208)) :- 
     person(_2200).

grounding(suspended(_2206,_2208)=true) :- 
     person(_2206),role_of(_2206,_2208).

grounding(suspended(_2206,_2208)=false) :- 
     person(_2206),role_of(_2206,_2208).

grounding(quote(_2206,_2208,_2210)=true) :- 
     person_pair(_2206,_2208),role_of(_2208,consumer),role_of(_2206,merchant),\+_2206=_2208,queryGoodsDescription(_2210).

grounding(quote(_2206,_2208,_2210)=false) :- 
     person_pair(_2206,_2208),role_of(_2208,consumer),role_of(_2206,merchant),\+_2206=_2208,queryGoodsDescription(_2210).

grounding(contract(_2206,_2208,_2210)=true) :- 
     person_pair(_2206,_2208),role_of(_2206,merchant),role_of(_2208,consumer),\+_2206=_2208,queryGoodsDescription(_2210).

grounding(contract(_2206,_2208,_2210)=false) :- 
     person_pair(_2206,_2208),role_of(_2206,merchant),role_of(_2208,consumer),\+_2206=_2208,queryGoodsDescription(_2210).

grounding(pow(accept_quote(_2210,_2212,_2214))=true) :- 
     person_pair(_2212,_2210),role_of(_2212,merchant),role_of(_2210,consumer),\+_2210=_2212,queryGoodsDescription(_2214).

grounding(per(present_quote(_2210,_2212))=false) :- 
     person_pair(_2210,_2212),role_of(_2210,merchant),role_of(_2212,consumer),\+_2212=_2210.

grounding(per(present_quote(_2210,_2212))=true) :- 
     person_pair(_2210,_2212),role_of(_2210,merchant),role_of(_2212,consumer),\+_2212=_2210.

grounding(obl(send_EPO(_2210,iServer,_2214))=true) :- 
     person(_2210),role_of(_2210,consumer),queryGoodsDescription(_2214).

grounding(obl(send_goods(_2210,iServer,_2214))=true) :- 
     person(_2210),role_of(_2210,merchant),queryGoodsDescription(_2214).

grounding(obl(send_EPO(_2210,iServer,_2214))=false) :- 
     person(_2210),role_of(_2210,consumer),queryGoodsDescription(_2214).

grounding(obl(send_goods(_2210,iServer,_2214))=false) :- 
     person(_2210),role_of(_2210,merchant),queryGoodsDescription(_2214).

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
outputEntity(contract(_2012,_2014,_2016)=false).
outputEntity(quote(_2012,_2014,_2016)=false).
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
simpleFluent(contract(_2244,_2246,_2248)=false).
simpleFluent(quote(_2244,_2246,_2248)=false).
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
index(contract(_2386,_2452,_2454)=false,_2386).
index(quote(_2386,_2452,_2454)=false,_2386).
index(suspended(_2386,_2452)=false,_2386).
index(pow(accept_quote(_2386,_2456,_2458))=true,_2386).

cyclic(contract(_2680,_2680,_2684)=true).
cyclic(suspended(_2680,_2682)=true).
cyclic(obl(send_EPO(_2684,_2686,_2688))=true).
cyclic(obl(send_goods(_2684,_2686,_2688))=true).
cyclic(contract(_2680,_2680,_2684)=false).

cachingOrder2(_2868, quote(_2868,_2870,_2872)=true) :- % level: 1
     person_pair(_2868,_2870),role_of(_2870,consumer),role_of(_2868,merchant),\+_2868=_2870,queryGoodsDescription(_2872).

cachingOrder2(_2850, per(present_quote(_2850,_2852))=false) :- % level: 1
     person_pair(_2850,_2852),role_of(_2850,merchant),role_of(_2852,consumer),\+_2852=_2850.

cachingOrder2(_3238, contract(_3238,_3238,_3242)=true) :- % level: 2
     person_pair(_3238,_3238),role_of(_3238,merchant),role_of(_3238,consumer),\+_3238=_3238,queryGoodsDescription(_3242).

cachingOrder2(_3220, per(present_quote(_3220,_3222))=true) :- % level: 2
     person_pair(_3220,_3222),role_of(_3220,merchant),role_of(_3222,consumer),\+_3222=_3220.

cachingOrder2(_3198, suspended(_3198,_3200)=true) :- % level: 2
     person(_3198),role_of(_3198,_3200).

cachingOrder2(_3178, obl(send_EPO(_3178,iServer,_3182))=true) :- % level: 2
     person(_3178),role_of(_3178,consumer),queryGoodsDescription(_3182).

cachingOrder2(_3154, obl(send_goods(_3154,iServer,_3158))=true) :- % level: 2
     person(_3154),role_of(_3154,merchant),queryGoodsDescription(_3158).

cachingOrder2(_3130, contract(_3130,_3130,_3134)=false) :- % level: 2
     person_pair(_3130,_3130),role_of(_3130,merchant),role_of(_3130,consumer),\+_3130=_3130,queryGoodsDescription(_3134).

cachingOrder2(_3110, quote(_3110,_3112,_3114)=false) :- % level: 2
     person_pair(_3110,_3112),role_of(_3112,consumer),role_of(_3110,merchant),\+_3110=_3112,queryGoodsDescription(_3114).

cachingOrder2(_3896, obl(send_EPO(_3896,iServer,_3900))=false) :- % level: 3
     person(_3896),role_of(_3896,consumer),queryGoodsDescription(_3900).

cachingOrder2(_3872, obl(send_goods(_3872,iServer,_3876))=false) :- % level: 3
     person(_3872),role_of(_3872,merchant),queryGoodsDescription(_3876).

cachingOrder2(_3850, suspended(_3850,_3852)=false) :- % level: 3
     person(_3850),role_of(_3850,_3852).

cachingOrder2(_3830, pow(accept_quote(_3830,_3832,_3834))=true) :- % level: 3
     person_pair(_3832,_3830),role_of(_3832,merchant),role_of(_3830,consumer),\+_3830=_3832,queryGoodsDescription(_3834).

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
dgrounded(contract(_2490,_2492,_2494)=false, person_pair(_2490,_2492)).
dgrounded(quote(_2402,_2404,_2406)=false, person_pair(_2402,_2404)).
dgrounded(suspended(_2356,_2358)=false, person(_2356)).
dgrounded(pow(accept_quote(_2268,_2270,_2272))=true, person_pair(_2270,_2268)).
