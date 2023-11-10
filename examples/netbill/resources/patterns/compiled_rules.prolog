:- dynamic person/1, person_pair/2.

initiatedAt(quote(_2006,_2008,_2010)=true, _2032, _1976, _2038) :-
     happensAtIE(present_quote(_2006,_2008,_2010,_2020),_1976),
     _2032=<_1976,
     _1976<_2038.

initiatedAt(contract(_2006,_2006,_2010)=true, _2118, _1976, _2124) :-
     happensAtIE(accept_quote(_2006,_2006,_2010),_1976),_2118=<_1976,_1976<_2124,
     holdsAtProcessedSimpleFluent(_2006,quote(_2006,_2006,_2010)=true,_1976),
     \+holdsAtCyclic(_2006,suspended(_2006,merchant)=true,_1976),
     \+holdsAtCyclic(_2006,suspended(_2006,consumer)=true,_1976).

initiatedAt(per(present_quote(_2010,_2012))=false, _2034, _1976, _2040) :-
     happensAtIE(present_quote(_2010,_2012,_2020,_2022),_1976),
     _2034=<_1976,
     _1976<_2040.

initiatedAt(per(present_quote(_2010,_2012))=true, _2032, _1976, _2038) :-
     happensAtIE(request_quote(_2012,_2010,_2020),_1976),
     _2032=<_1976,
     _1976<_2038.

initiatedAt(obl(send_EPO(_2010,iServer,_2014))=false, _2048, _1976, _2054) :-
     happensAtIE(send_EPO(_2010,iServer,_2014,_2024),_1976),_2048=<_1976,_1976<_2054,
     price(_2014,_2024).

initiatedAt(obl(send_goods(_2010,iServer,_2014))=false, _2064, _1976, _2070) :-
     happensAtIE(send_goods(_2010,iServer,_2014,_2024,_2026),_1976),_2064=<_1976,_1976<_2070,
     decrypt(_2024,_2026,_2040),
     meets(_2040,_2014).

initiatedAt(suspended(_2006,merchant)=true, _2064, _1976, _2070) :-
     happensAtIE(present_quote(_2006,_2014,_2016,_2018),_1976),_2064=<_1976,_1976<_2070,
     holdsAtProcessedSimpleFluent(_2006,per(present_quote(_2006,_2014))=false,_1976).

initiatedAt(obl(send_EPO(_2018,iServer,_2022))=true, _1976, _1978, _1980) :-
     initiatedAt(contract(_2032,_2018,_2022)=true,_1976,_1978,_1980).

initiatedAt(obl(send_goods(_2018,iServer,_2022))=true, _1976, _1978, _1980) :-
     initiatedAt(contract(_2018,_2034,_2022)=true,_1976,_1978,_1980).

initiatedAt(obl(send_EPO(_2018,iServer,_2022))=false, _1976, _1978, _1980) :-
     initiatedAt(contract(_2032,_2018,_2022)=false,_1976,_1978,_1980).

initiatedAt(obl(send_goods(_2018,iServer,_2022))=false, _1976, _1978, _1980) :-
     initiatedAt(contract(_2018,_2034,_2022)=false,_1976,_1978,_1980).

initiatedAt(suspended(_2014,merchant)=true, _1976, _1978, _1980) :-
     initiatedAt(contract(_2014,_2028,_2030)=false,_1976,_1978,_1980),
     holdsAtCyclic(_2014,obl(send_goods(_2014,iServer,_2030))=true,_1978).

initiatedAt(suspended(_2014,consumer)=true, _1976, _1978, _1980) :-
     initiatedAt(contract(_2026,_2014,_2030)=false,_1976,_1978,_1980),
     holdsAtCyclic(_2014,obl(send_EPO(_2014,iServer,_2030))=true,_1978).

terminatedAt(quote(_2006,_2008,_2010)=true, _2030, _1976, _2036) :-
     happensAtIE(accept_quote(_2008,_2006,_2010),_1976),
     _2030=<_1976,
     _1976<_2036.

holdsForSDFluent(pow(accept_quote(_2010,_2012,_2014))=true,_1976) :-
     holdsForProcessedSimpleFluent(_2012,quote(_2012,_2010,_2014)=true,_2034),
     holdsForProcessedSimpleFluent(_2010,suspended(_2010,consumer)=true,_2052),
     holdsForProcessedSimpleFluent(_2012,suspended(_2012,merchant)=true,_2070),
     relative_complement_all(_2034,[_2052,_2070],_1976).

maxDuration(contract(_2010,_2012,_2014)=true,contract(_2010,_2012,_2014)=false,5):-
     grounding(contract(_2010,_2012,_2014)=true),
     grounding(contract(_2010,_2012,_2014)=false).

maxDurationUE(quote(_2010,_2012,_2014)=true,quote(_2010,_2012,_2014)=false,5):-
     grounding(quote(_2010,_2012,_2014)=true),
     grounding(quote(_2010,_2012,_2014)=false).

maxDurationUE(per(present_quote(_2014,_2016))=false,per(present_quote(_2014,_2016))=true,10):-
     grounding(per(present_quote(_2014,_2016))=false),
     grounding(per(present_quote(_2014,_2016))=true).

maxDurationUE(suspended(_2010,_2012)=true,suspended(_2010,_2012)=false,3):-
     grounding(suspended(_2010,_2012)=true),
     grounding(suspended(_2010,_2012)=false).

grounding(request_quote(_2350,_2352,_2354)) :- 
     person_pair(_2352,_2350).

grounding(present_quote(_2350,_2352,_2354,_2356)) :- 
     person_pair(_2350,_2352).

grounding(accept_quote(_2350,_2352,_2354)) :- 
     person_pair(_2352,_2350).

grounding(send_EPO(_2350,_2352,_2354,_2356)) :- 
     person(_2350).

grounding(send_goods(_2350,_2352,_2354,_2356,_2358)) :- 
     person(_2350).

grounding(suspended(_2356,_2358)=true) :- 
     person(_2356),role_of(_2356,_2358).

grounding(suspended(_2356,_2358)=false) :- 
     person(_2356),role_of(_2356,_2358).

grounding(quote(_2356,_2358,_2360)=true) :- 
     person_pair(_2356,_2358),role_of(_2358,consumer),role_of(_2356,merchant),\+_2356=_2358,queryGoodsDescription(_2360).

grounding(quote(_2356,_2358,_2360)=false) :- 
     person_pair(_2356,_2358),role_of(_2358,consumer),role_of(_2356,merchant),\+_2356=_2358,queryGoodsDescription(_2360).

grounding(contract(_2356,_2358,_2360)=true) :- 
     person_pair(_2356,_2358),role_of(_2356,merchant),role_of(_2358,consumer),\+_2356=_2358,queryGoodsDescription(_2360).

grounding(contract(_2356,_2358,_2360)=false) :- 
     person_pair(_2356,_2358),role_of(_2356,merchant),role_of(_2358,consumer),\+_2356=_2358,queryGoodsDescription(_2360).

grounding(pow(accept_quote(_2360,_2362,_2364))=true) :- 
     person_pair(_2362,_2360),role_of(_2362,merchant),role_of(_2360,consumer),\+_2360=_2362,queryGoodsDescription(_2364).

grounding(per(present_quote(_2360,_2362))=false) :- 
     person_pair(_2360,_2362),role_of(_2360,merchant),role_of(_2362,consumer),\+_2362=_2360.

grounding(per(present_quote(_2360,_2362))=true) :- 
     person_pair(_2360,_2362),role_of(_2360,merchant),role_of(_2362,consumer),\+_2362=_2360.

grounding(obl(send_EPO(_2360,iServer,_2364))=true) :- 
     person(_2360),role_of(_2360,consumer),queryGoodsDescription(_2364).

grounding(obl(send_goods(_2360,iServer,_2364))=true) :- 
     person(_2360),role_of(_2360,merchant),queryGoodsDescription(_2364).

grounding(obl(send_EPO(_2360,iServer,_2364))=false) :- 
     person(_2360),role_of(_2360,consumer),queryGoodsDescription(_2364).

grounding(obl(send_goods(_2360,iServer,_2364))=false) :- 
     person(_2360),role_of(_2360,merchant),queryGoodsDescription(_2364).

inputEntity(present_quote(_2030,_2032,_2034,_2036)).
inputEntity(accept_quote(_2030,_2032,_2034)).
inputEntity(request_quote(_2030,_2032,_2034)).
inputEntity(send_EPO(_2030,_2032,_2034,_2036)).
inputEntity(send_goods(_2030,_2032,_2034,_2036,_2038)).

outputEntity(quote(_2122,_2124,_2126)=true).
outputEntity(contract(_2122,_2124,_2126)=true).
outputEntity(per(present_quote(_2126,_2128))=false).
outputEntity(per(present_quote(_2126,_2128))=true).
outputEntity(obl(send_EPO(_2126,_2128,_2130))=false).
outputEntity(obl(send_goods(_2126,_2128,_2130))=false).
outputEntity(suspended(_2122,_2124)=true).
outputEntity(obl(send_EPO(_2126,_2128,_2130))=true).
outputEntity(obl(send_goods(_2126,_2128,_2130))=true).
outputEntity(contract(_2122,_2124,_2126)=false).
outputEntity(quote(_2122,_2124,_2126)=false).
outputEntity(suspended(_2122,_2124)=false).
outputEntity(pow(accept_quote(_2126,_2128,_2130))=true).

event(present_quote(_2250,_2252,_2254,_2256)).
event(accept_quote(_2250,_2252,_2254)).
event(request_quote(_2250,_2252,_2254)).
event(send_EPO(_2250,_2252,_2254,_2256)).
event(send_goods(_2250,_2252,_2254,_2256,_2258)).

simpleFluent(quote(_2342,_2344,_2346)=true).
simpleFluent(contract(_2342,_2344,_2346)=true).
simpleFluent(per(present_quote(_2346,_2348))=false).
simpleFluent(per(present_quote(_2346,_2348))=true).
simpleFluent(obl(send_EPO(_2346,_2348,_2350))=false).
simpleFluent(obl(send_goods(_2346,_2348,_2350))=false).
simpleFluent(suspended(_2342,_2344)=true).
simpleFluent(obl(send_EPO(_2346,_2348,_2350))=true).
simpleFluent(obl(send_goods(_2346,_2348,_2350))=true).
simpleFluent(contract(_2342,_2344,_2346)=false).
simpleFluent(quote(_2342,_2344,_2346)=false).
simpleFluent(suspended(_2342,_2344)=false).

sDFluent(pow(accept_quote(_2474,_2476,_2478))=true).

index(present_quote(_2478,_2532,_2534,_2536),_2478).
index(accept_quote(_2478,_2532,_2534),_2478).
index(request_quote(_2478,_2532,_2534),_2478).
index(send_EPO(_2478,_2532,_2534,_2536),_2478).
index(send_goods(_2478,_2532,_2534,_2536,_2538),_2478).
index(quote(_2478,_2538,_2540)=true,_2478).
index(contract(_2478,_2538,_2540)=true,_2478).
index(per(present_quote(_2478,_2542))=false,_2478).
index(per(present_quote(_2478,_2542))=true,_2478).
index(obl(send_EPO(_2478,_2542,_2544))=false,_2478).
index(obl(send_goods(_2478,_2542,_2544))=false,_2478).
index(suspended(_2478,_2538)=true,_2478).
index(obl(send_EPO(_2478,_2542,_2544))=true,_2478).
index(obl(send_goods(_2478,_2542,_2544))=true,_2478).
index(contract(_2478,_2538,_2540)=false,_2478).
index(quote(_2478,_2538,_2540)=false,_2478).
index(suspended(_2478,_2538)=false,_2478).
index(pow(accept_quote(_2478,_2542,_2544))=true,_2478).

cyclic(contract(_2760,_2760,_2764)=true).
cyclic(suspended(_2760,_2762)=true).
cyclic(obl(send_EPO(_2764,_2766,_2768))=true).
cyclic(obl(send_goods(_2764,_2766,_2768))=true).
cyclic(contract(_2760,_2760,_2764)=false).

cachingOrder2(_2942, quote(_2942,_2944,_2946)=true) :- % level: 1
     person_pair(_2942,_2944),role_of(_2944,consumer),role_of(_2942,merchant),\+_2942=_2944,queryGoodsDescription(_2946).

cachingOrder2(_2924, per(present_quote(_2924,_2926))=false) :- % level: 1
     person_pair(_2924,_2926),role_of(_2924,merchant),role_of(_2926,consumer),\+_2926=_2924.

cachingOrder2(_3306, contract(_3306,_3306,_3310)=true) :- % level: 2
     person_pair(_3306,_3306),role_of(_3306,merchant),role_of(_3306,consumer),\+_3306=_3306,queryGoodsDescription(_3310).

cachingOrder2(_3288, per(present_quote(_3288,_3290))=true) :- % level: 2
     person_pair(_3288,_3290),role_of(_3288,merchant),role_of(_3290,consumer),\+_3290=_3288.

cachingOrder2(_3266, suspended(_3266,_3268)=true) :- % level: 2
     person(_3266),role_of(_3266,_3268).

cachingOrder2(_3246, obl(send_EPO(_3246,iServer,_3250))=true) :- % level: 2
     person(_3246),role_of(_3246,consumer),queryGoodsDescription(_3250).

cachingOrder2(_3222, obl(send_goods(_3222,iServer,_3226))=true) :- % level: 2
     person(_3222),role_of(_3222,merchant),queryGoodsDescription(_3226).

cachingOrder2(_3198, contract(_3198,_3198,_3202)=false) :- % level: 2
     person_pair(_3198,_3198),role_of(_3198,merchant),role_of(_3198,consumer),\+_3198=_3198,queryGoodsDescription(_3202).

cachingOrder2(_3178, quote(_3178,_3180,_3182)=false) :- % level: 2
     person_pair(_3178,_3180),role_of(_3180,consumer),role_of(_3178,merchant),\+_3178=_3180,queryGoodsDescription(_3182).

cachingOrder2(_3958, obl(send_EPO(_3958,iServer,_3962))=false) :- % level: 3
     person(_3958),role_of(_3958,consumer),queryGoodsDescription(_3962).

cachingOrder2(_3934, obl(send_goods(_3934,iServer,_3938))=false) :- % level: 3
     person(_3934),role_of(_3934,merchant),queryGoodsDescription(_3938).

cachingOrder2(_3912, suspended(_3912,_3914)=false) :- % level: 3
     person(_3912),role_of(_3912,_3914).

cachingOrder2(_3892, pow(accept_quote(_3892,_3894,_3896))=true) :- % level: 3
     person_pair(_3894,_3892),role_of(_3894,merchant),role_of(_3892,consumer),\+_3892=_3894,queryGoodsDescription(_3896).

collectGrounds([send_EPO(_2278,_2292,_2294,_2296), send_goods(_2278,_2292,_2294,_2296,_2298)],person(_2278)).

collectGrounds([present_quote(_2266,_2268,_2294,_2296), accept_quote(_2268,_2266,_2294), request_quote(_2268,_2266,_2294)],person_pair(_2266,_2268)).

dgrounded(quote(_3224,_3226,_3228)=true, person_pair(_3224,_3226)).
dgrounded(contract(_3136,_3138,_3140)=true, person_pair(_3136,_3138)).
dgrounded(per(present_quote(_3060,_3062))=false, person_pair(_3060,_3062)).
dgrounded(per(present_quote(_2980,_2982))=true, person_pair(_2980,_2982)).
dgrounded(obl(send_EPO(_2918,iServer,_2922))=false, person(_2918)).
dgrounded(obl(send_goods(_2856,iServer,_2860))=false, person(_2856)).
dgrounded(suspended(_2806,_2808)=true, person(_2806)).
dgrounded(obl(send_EPO(_2748,iServer,_2752))=true, person(_2748)).
dgrounded(obl(send_goods(_2686,iServer,_2690))=true, person(_2686)).
dgrounded(contract(_2594,_2596,_2598)=false, person_pair(_2594,_2596)).
dgrounded(quote(_2506,_2508,_2510)=false, person_pair(_2506,_2508)).
dgrounded(suspended(_2460,_2462)=false, person(_2460)).
dgrounded(pow(accept_quote(_2372,_2374,_2376))=true, person_pair(_2374,_2372)).
