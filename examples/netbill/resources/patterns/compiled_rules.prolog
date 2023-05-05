:- dynamic person/1, person_pair/2.

initiatedAt(quote(_1912,_1914,_1916)=true, _1938, _1882, _1944) :-
     happensAtIE(present_quote(_1912,_1914,_1916,_1926),_1882),
     _1938=<_1882,
     _1882<_1944.

initiatedAt(contract(_1912,_1912,_1916)=true, _2024, _1882, _2030) :-
     happensAtIE(accept_quote(_1912,_1912,_1916),_1882),_2024=<_1882,_1882<_2030,
     holdsAtProcessedSimpleFluent(_1912,quote(_1912,_1912,_1916)=true,_1882),
     \+holdsAtCyclic(_1912,suspended(_1912,merchant)=true,_1882),
     \+holdsAtCyclic(_1912,suspended(_1912,consumer)=true,_1882).

initiatedAt(per(present_quote(_1916,_1918))=false, _1940, _1882, _1946) :-
     happensAtIE(present_quote(_1916,_1918,_1926,_1928),_1882),
     _1940=<_1882,
     _1882<_1946.

initiatedAt(per(present_quote(_1916,_1918))=true, _1938, _1882, _1944) :-
     happensAtIE(request_quote(_1918,_1916,_1926),_1882),
     _1938=<_1882,
     _1882<_1944.

initiatedAt(obl(send_EPO(_1916,iServer,_1920))=false, _1954, _1882, _1960) :-
     happensAtIE(send_EPO(_1916,iServer,_1920,_1930),_1882),_1954=<_1882,_1882<_1960,
     price(_1920,_1930).

initiatedAt(obl(send_goods(_1916,iServer,_1920))=false, _1970, _1882, _1976) :-
     happensAtIE(send_goods(_1916,iServer,_1920,_1930,_1932),_1882),_1970=<_1882,_1882<_1976,
     decrypt(_1930,_1932,_1946),
     meets(_1946,_1920).

initiatedAt(suspended(_1912,merchant)=true, _1970, _1882, _1976) :-
     happensAtIE(present_quote(_1912,_1920,_1922,_1924),_1882),_1970=<_1882,_1882<_1976,
     holdsAtProcessedSimpleFluent(_1912,per(present_quote(_1912,_1920))=false,_1882).

initiatedAt(obl(send_EPO(_1924,iServer,_1928))=true, _1882, _1884, _1886) :-
     initiatedAt(contract(_1938,_1924,_1928)=true,_1882,_1884,_1886).

initiatedAt(obl(send_goods(_1924,iServer,_1928))=true, _1882, _1884, _1886) :-
     initiatedAt(contract(_1924,_1940,_1928)=true,_1882,_1884,_1886).

initiatedAt(obl(send_EPO(_1924,iServer,_1928))=false, _1882, _1884, _1886) :-
     initiatedAt(contract(_1938,_1924,_1928)=false,_1882,_1884,_1886).

initiatedAt(obl(send_goods(_1924,iServer,_1928))=false, _1882, _1884, _1886) :-
     initiatedAt(contract(_1924,_1940,_1928)=false,_1882,_1884,_1886).

initiatedAt(suspended(_1920,merchant)=true, _1882, _1884, _1886) :-
     initiatedAt(contract(_1920,_1934,_1936)=false,_1882,_1884,_1886),
     holdsAtCyclic(_1920,obl(send_goods(_1920,iServer,_1936))=true,_1884).

initiatedAt(suspended(_1920,consumer)=true, _1882, _1884, _1886) :-
     initiatedAt(contract(_1932,_1920,_1936)=false,_1882,_1884,_1886),
     holdsAtCyclic(_1920,obl(send_EPO(_1920,iServer,_1936))=true,_1884).

terminatedAt(quote(_1912,_1914,_1916)=true, _1936, _1882, _1942) :-
     happensAtIE(accept_quote(_1914,_1912,_1916),_1882),
     _1936=<_1882,
     _1882<_1942.

holdsForSDFluent(pow(accept_quote(_1916,_1918,_1920))=true,_1882) :-
     holdsForProcessedSimpleFluent(_1918,quote(_1918,_1916,_1920)=true,_1940),
     holdsForProcessedSimpleFluent(_1916,suspended(_1916,consumer)=true,_1958),
     holdsForProcessedSimpleFluent(_1918,suspended(_1918,merchant)=true,_1976),
     relative_complement_all(_1940,[_1958,_1976],_1882).

maxDuration(contract(_1916,_1918,_1920)=true,contract(_1916,_1918,_1920)=false,5):-
     grounding(contract(_1916,_1918,_1920)=true),
     grounding(contract(_1916,_1918,_1920)=false).

maxDurationUE(quote(_1916,_1918,_1920)=true,quote(_1916,_1918,_1920)=false,5):-
     grounding(quote(_1916,_1918,_1920)=true),
     grounding(quote(_1916,_1918,_1920)=false).

maxDurationUE(per(present_quote(_1920,_1922))=false,per(present_quote(_1920,_1922))=true,10):-
     grounding(per(present_quote(_1920,_1922))=false),
     grounding(per(present_quote(_1920,_1922))=true).

maxDurationUE(suspended(_1916,_1918)=true,suspended(_1916,_1918)=false,3):-
     grounding(suspended(_1916,_1918)=true),
     grounding(suspended(_1916,_1918)=false).

grounding(request_quote(_2228,_2230,_2232)) :- 
     person_pair(_2230,_2228).

grounding(present_quote(_2228,_2230,_2232,_2234)) :- 
     person_pair(_2228,_2230).

grounding(accept_quote(_2228,_2230,_2232)) :- 
     person_pair(_2230,_2228).

grounding(send_EPO(_2228,_2230,_2232,_2234)) :- 
     person(_2228).

grounding(send_goods(_2228,_2230,_2232,_2234,_2236)) :- 
     person(_2228).

grounding(suspended(_2234,_2236)=true) :- 
     person(_2234),role_of(_2234,_2236).

grounding(quote(_2234,_2236,_2238)=true) :- 
     person_pair(_2234,_2236),role_of(_2236,consumer),role_of(_2234,merchant),\+_2234=_2236,queryGoodsDescription(_2238).

grounding(contract(_2234,_2236,_2238)=true) :- 
     person_pair(_2234,_2236),role_of(_2234,merchant),role_of(_2236,consumer),\+_2234=_2236,queryGoodsDescription(_2238).

grounding(contract(_2234,_2236,_2238)=false) :- 
     person_pair(_2234,_2236),role_of(_2234,merchant),role_of(_2236,consumer),\+_2234=_2236,queryGoodsDescription(_2238).

grounding(pow(accept_quote(_2238,_2240,_2242))=true) :- 
     person_pair(_2240,_2238),role_of(_2240,merchant),role_of(_2238,consumer),\+_2238=_2240,queryGoodsDescription(_2242).

grounding(per(present_quote(_2238,_2240))=false) :- 
     person_pair(_2238,_2240),role_of(_2238,merchant),role_of(_2240,consumer),\+_2240=_2238.

grounding(obl(send_EPO(_2238,iServer,_2242))=true) :- 
     person(_2238),role_of(_2238,consumer),queryGoodsDescription(_2242).

grounding(obl(send_goods(_2238,iServer,_2242))=true) :- 
     person(_2238),role_of(_2238,merchant),queryGoodsDescription(_2242).

inputEntity(present_quote(_1936,_1938,_1940,_1942)).
inputEntity(accept_quote(_1936,_1938,_1940)).
inputEntity(request_quote(_1936,_1938,_1940)).
inputEntity(send_EPO(_1936,_1938,_1940,_1942)).
inputEntity(send_goods(_1936,_1938,_1940,_1942,_1944)).

outputEntity(quote(_2028,_2030,_2032)=true).
outputEntity(contract(_2028,_2030,_2032)=true).
outputEntity(per(present_quote(_2032,_2034))=false).
outputEntity(per(present_quote(_2032,_2034))=true).
outputEntity(obl(send_EPO(_2032,_2034,_2036))=false).
outputEntity(obl(send_goods(_2032,_2034,_2036))=false).
outputEntity(suspended(_2028,_2030)=true).
outputEntity(obl(send_EPO(_2032,_2034,_2036))=true).
outputEntity(obl(send_goods(_2032,_2034,_2036))=true).
outputEntity(contract(_2028,_2030,_2032)=false).
outputEntity(quote(_2028,_2030,_2032)=false).
outputEntity(suspended(_2028,_2030)=false).
outputEntity(pow(accept_quote(_2032,_2034,_2036))=true).

event(present_quote(_2156,_2158,_2160,_2162)).
event(accept_quote(_2156,_2158,_2160)).
event(request_quote(_2156,_2158,_2160)).
event(send_EPO(_2156,_2158,_2160,_2162)).
event(send_goods(_2156,_2158,_2160,_2162,_2164)).

simpleFluent(quote(_2248,_2250,_2252)=true).
simpleFluent(contract(_2248,_2250,_2252)=true).
simpleFluent(per(present_quote(_2252,_2254))=false).
simpleFluent(per(present_quote(_2252,_2254))=true).
simpleFluent(obl(send_EPO(_2252,_2254,_2256))=false).
simpleFluent(obl(send_goods(_2252,_2254,_2256))=false).
simpleFluent(suspended(_2248,_2250)=true).
simpleFluent(obl(send_EPO(_2252,_2254,_2256))=true).
simpleFluent(obl(send_goods(_2252,_2254,_2256))=true).
simpleFluent(contract(_2248,_2250,_2252)=false).
simpleFluent(quote(_2248,_2250,_2252)=false).
simpleFluent(suspended(_2248,_2250)=false).

sDFluent(pow(accept_quote(_2380,_2382,_2384))=true).

index(present_quote(_2384,_2438,_2440,_2442),_2384).
index(accept_quote(_2384,_2438,_2440),_2384).
index(request_quote(_2384,_2438,_2440),_2384).
index(send_EPO(_2384,_2438,_2440,_2442),_2384).
index(send_goods(_2384,_2438,_2440,_2442,_2444),_2384).
index(quote(_2384,_2444,_2446)=true,_2384).
index(contract(_2384,_2444,_2446)=true,_2384).
index(per(present_quote(_2384,_2448))=false,_2384).
index(per(present_quote(_2384,_2448))=true,_2384).
index(obl(send_EPO(_2384,_2448,_2450))=false,_2384).
index(obl(send_goods(_2384,_2448,_2450))=false,_2384).
index(suspended(_2384,_2444)=true,_2384).
index(obl(send_EPO(_2384,_2448,_2450))=true,_2384).
index(obl(send_goods(_2384,_2448,_2450))=true,_2384).
index(contract(_2384,_2444,_2446)=false,_2384).
index(quote(_2384,_2444,_2446)=false,_2384).
index(suspended(_2384,_2444)=false,_2384).
index(pow(accept_quote(_2384,_2448,_2450))=true,_2384).

cyclic(contract(_2666,_2666,_2670)=true).
cyclic(suspended(_2666,_2668)=true).
cyclic(obl(send_EPO(_2670,_2672,_2674))=true).
cyclic(obl(send_goods(_2670,_2672,_2674))=true).
cyclic(contract(_2666,_2666,_2670)=false).

cachingOrder2(_2848, quote(_2848,_2850,_2852)=true) :- % level: 1
     person_pair(_2848,_2850),role_of(_2850,consumer),role_of(_2848,merchant),\+_2848=_2850,queryGoodsDescription(_2852).

cachingOrder2(_2830, per(present_quote(_2830,_2832))=false) :- % level: 1
     person_pair(_2830,_2832),role_of(_2830,merchant),role_of(_2832,consumer),\+_2832=_2830.

cachingOrder2(_3462, contract(_3462,_3462,_3466)=true) :- % level: 2
     person_pair(_3462,_3462),role_of(_3462,merchant),role_of(_3462,consumer),\+_3462=_3462,queryGoodsDescription(_3466).

cachingOrder2(_3422, suspended(_3422,_3424)=true) :- % level: 2
     person(_3422),role_of(_3422,_3424).

cachingOrder2(_3402, obl(send_EPO(_3402,iServer,_3406))=true) :- % level: 2
     person(_3402),role_of(_3402,consumer),queryGoodsDescription(_3406).

cachingOrder2(_3378, obl(send_goods(_3378,iServer,_3382))=true) :- % level: 2
     person(_3378),role_of(_3378,merchant),queryGoodsDescription(_3382).

cachingOrder2(_3354, contract(_3354,_3354,_3358)=false) :- % level: 2
     person_pair(_3354,_3354),role_of(_3354,merchant),role_of(_3354,consumer),\+_3354=_3354,queryGoodsDescription(_3358).

cachingOrder2(_4956, pow(accept_quote(_4956,_4958,_4960))=true) :- % level: 3
     person_pair(_4958,_4956),role_of(_4958,merchant),role_of(_4956,consumer),\+_4956=_4958,queryGoodsDescription(_4960).

collectGrounds([send_EPO(_2184,_2198,_2200,_2202), send_goods(_2184,_2198,_2200,_2202,_2204)],person(_2184)).

collectGrounds([present_quote(_2172,_2174,_2200,_2202), accept_quote(_2174,_2172,_2200), request_quote(_2174,_2172,_2200)],person_pair(_2172,_2174)).

dgrounded(quote(_2792,_2794,_2796)=true, person_pair(_2792,_2794)).
dgrounded(contract(_2704,_2706,_2708)=true, person_pair(_2704,_2706)).
dgrounded(per(present_quote(_2628,_2630))=false, person_pair(_2628,_2630)).
dgrounded(suspended(_2578,_2580)=true, person(_2578)).
dgrounded(obl(send_EPO(_2520,iServer,_2524))=true, person(_2520)).
dgrounded(obl(send_goods(_2458,iServer,_2462))=true, person(_2458)).
dgrounded(contract(_2366,_2368,_2370)=false, person_pair(_2366,_2368)).
dgrounded(pow(accept_quote(_2278,_2280,_2282))=true, person_pair(_2280,_2278)).
