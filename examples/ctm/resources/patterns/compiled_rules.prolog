:- dynamic vehicle/2.

initiatedAt(punctuality(_1900,_1902)=punctual, _1912, -1, _1920) :-
     _1912=< -1,
     -1<_1920.

initiatedAt(passenger_density(_1900,_1902)=low, _1912, -1, _1920) :-
     _1912=< -1,
     -1<_1920.

initiatedAt(noise_level(_1900,_1902)=low, _1912, -1, _1920) :-
     _1912=< -1,
     -1<_1920.

initiatedAt(internal_temperature(_1900,_1902)=normal, _1912, -1, _1920) :-
     _1912=< -1,
     -1<_1920.

initiatedAt(punctuality(_1910,_1912)=punctual, _1934, _1880, _1940) :-
     happensAtIE(stop_enter(_1910,_1912,_1920,scheduled),_1880),
     _1934=<_1880,
     _1880<_1940.

initiatedAt(punctuality(_1910,_1912)=punctual, _1934, _1880, _1940) :-
     happensAtIE(stop_enter(_1910,_1912,_1920,early),_1880),
     _1934=<_1880,
     _1880<_1940.

initiatedAt(punctuality(_1910,_1912)=non_punctual, _1934, _1880, _1940) :-
     happensAtIE(stop_enter(_1910,_1912,_1920,late),_1880),
     _1934=<_1880,
     _1880<_1940.

initiatedAt(punctuality(_1910,_1912)=non_punctual, _1934, _1880, _1940) :-
     happensAtIE(stop_leave(_1910,_1912,_1920,early),_1880),
     _1934=<_1880,
     _1880<_1940.

initiatedAt(passenger_density(_1902,_1904)=_1888, _1936, _1882, _1942) :-
     happensAtIE(passenger_density_change(_1902,_1904,_1888),_1882),_1936=<_1882,_1882<_1942.

initiatedAt(noise_level(_1902,_1904)=_1888, _1936, _1882, _1942) :-
     happensAtIE(noise_level_change(_1902,_1904,_1888),_1882),_1936=<_1882,_1882<_1942.

initiatedAt(internal_temperature(_1902,_1904)=_1888, _1936, _1882, _1942) :-
     happensAtIE(internal_temperature_change(_1902,_1904,_1888),_1882),_1936=<_1882,_1882<_1942.

holdsForSDFluent(punctuality(_1910,_1912)=non_punctual,_1880) :-
     holdsForProcessedSimpleFluent(_1910,punctuality(_1910,_1912)=punctual,_1930),
     complement_all([_1930],_1880).

holdsForSDFluent(driving_style(_1910,_1912)=unsafe,_1880) :-
     holdsForProcessedIE(_1910,sharp_turn(_1910,_1912)=very_sharp,_1930),
     holdsForProcessedIE(_1910,abrupt_acceleration(_1910,_1912)=very_abrupt,_1948),
     holdsForProcessedIE(_1910,abrupt_deceleration(_1910,_1912)=very_abrupt,_1966),
     union_all([_1930,_1948,_1966],_1880).

holdsForSDFluent(driving_style(_1910,_1912)=uncomfortable,_1880) :-
     holdsForProcessedIE(_1910,sharp_turn(_1910,_1912)=sharp,_1930),
     holdsForProcessedIE(_1910,abrupt_acceleration(_1910,_1912)=very_abrupt,_1948),
     holdsForProcessedIE(_1910,abrupt_deceleration(_1910,_1912)=very_abrupt,_1966),
     relative_complement_all(_1930,[_1948,_1966],_1986),
     holdsForProcessedIE(_1910,abrupt_acceleration(_1910,_1912)=abrupt,_2004),
     holdsForProcessedIE(_1910,abrupt_deceleration(_1910,_1912)=abrupt,_2022),
     union_all([_1986,_2004,_2022],_1880).

holdsForSDFluent(driving_quality(_1910,_1912)=high,_1880) :-
     holdsForProcessedSimpleFluent(_1910,punctuality(_1910,_1912)=punctual,_1930),
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=unsafe,_1948),
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=uncomfortable,_1966),
     relative_complement_all(_1930,[_1948,_1966],_1880).

holdsForSDFluent(driving_quality(_1910,_1912)=medium,_1880) :-
     holdsForProcessedSimpleFluent(_1910,punctuality(_1910,_1912)=punctual,_1930),
     \+_1930=[],
     !,
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=uncomfortable,_1958),
     intersect_all([_1930,_1958],_1880).

holdsForSDFluent(driving_quality(_1904,_1906)=medium,[]).

holdsForSDFluent(driving_quality(_1910,_1912)=low,_1880) :-
     holdsForProcessedSimpleFluent(_1910,punctuality(_1910,_1912)=non_punctual,_1930),
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=unsafe,_1948),
     union_all([_1930,_1948],_1880).

holdsForSDFluent(passenger_comfort(_1910,_1912)=reducing,_1880) :-
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=uncomfortable,_1930),
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=unsafe,_1948),
     holdsForProcessedSimpleFluent(_1910,passenger_density(_1910,_1912)=high,_1966),
     holdsForProcessedSimpleFluent(_1910,noise_level(_1910,_1912)=high,_1984),
     holdsForProcessedSimpleFluent(_1910,internal_temperature(_1910,_1912)=very_warm,_2002),
     holdsForProcessedSimpleFluent(_1910,internal_temperature(_1910,_1912)=very_cold,_2020),
     union_all([_1930,_1948,_1966,_1984,_2002,_2020],_1880).

holdsForSDFluent(driver_comfort(_1910,_1912)=reducing,_1880) :-
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=uncomfortable,_1930),
     holdsForProcessedSDFluent(_1910,driving_style(_1910,_1912)=unsafe,_1948),
     holdsForProcessedSimpleFluent(_1910,noise_level(_1910,_1912)=high,_1966),
     holdsForProcessedSimpleFluent(_1910,internal_temperature(_1910,_1912)=very_warm,_1984),
     holdsForProcessedSimpleFluent(_1910,internal_temperature(_1910,_1912)=very_cold,_2002),
     union_all([_1930,_1948,_1966,_1984,_2002],_1880).

holdsForSDFluent(passenger_satisfaction(_1910,_1912)=reducing,_1880) :-
     holdsForProcessedSimpleFluent(_1910,punctuality(_1910,_1912)=non_punctual,_1930),
     holdsForProcessedSDFluent(_1910,passenger_comfort(_1910,_1912)=reducing,_1948),
     union_all([_1930,_1948],_1880).

happensAtEv(punctuality_change(_1898,_1900,punctual),_1880) :-
     happensAtProcessedSimpleFluent(_1898,end(punctuality(_1898,_1900)=non_punctual),_1880).

happensAtEv(punctuality_change(_1898,_1900,non_punctual),_1880) :-
     happensAtProcessedSimpleFluent(_1898,end(punctuality(_1898,_1900)=punctual),_1880).

collectIntervals2(_1884, abrupt_acceleration(_1884,_1886)=abrupt) :-
     vehicle(_1884,_1886).

collectIntervals2(_1884, abrupt_acceleration(_1884,_1886)=very_abrupt) :-
     vehicle(_1884,_1886).

collectIntervals2(_1884, abrupt_deceleration(_1884,_1886)=abrupt) :-
     vehicle(_1884,_1886).

collectIntervals2(_1884, abrupt_deceleration(_1884,_1886)=very_abrupt) :-
     vehicle(_1884,_1886).

collectIntervals2(_1884, sharp_turn(_1884,_1886)=sharp) :-
     vehicle(_1884,_1886).

collectIntervals2(_1884, sharp_turn(_1884,_1886)=very_sharp) :-
     vehicle(_1884,_1886).

grounding(stop_enter(_2216,_2218,_2220,_2222)) :- 
     vehicle(_2216,_2218).

grounding(stop_leave(_2216,_2218,_2220,_2222)) :- 
     vehicle(_2216,_2218).

grounding(internal_temperature_change(_2216,_2218,_2220)) :- 
     vehicle(_2216,_2218).

grounding(noise_level_change(_2216,_2218,_2220)) :- 
     vehicle(_2216,_2218).

grounding(passenger_density_change(_2216,_2218,_2220)) :- 
     vehicle(_2216,_2218).

grounding(punctuality_change(_2216,_2218,punctual)) :- 
     vehicle(_2216,_2218).

grounding(punctuality_change(_2216,_2218,non_punctual)) :- 
     vehicle(_2216,_2218).

grounding(abrupt_acceleration(_2222,_2224)=abrupt) :- 
     vehicle(_2222,_2224).

grounding(abrupt_acceleration(_2222,_2224)=very_abrupt) :- 
     vehicle(_2222,_2224).

grounding(abrupt_deceleration(_2222,_2224)=abrupt) :- 
     vehicle(_2222,_2224).

grounding(abrupt_deceleration(_2222,_2224)=very_abrupt) :- 
     vehicle(_2222,_2224).

grounding(sharp_turn(_2222,_2224)=sharp) :- 
     vehicle(_2222,_2224).

grounding(sharp_turn(_2222,_2224)=very_sharp) :- 
     vehicle(_2222,_2224).

grounding(punctuality(_2222,_2224)=punctual) :- 
     vehicle(_2222,_2224).

grounding(punctuality(_2222,_2224)=non_punctual) :- 
     vehicle(_2222,_2224).

grounding(passenger_density(_2222,_2224)=high) :- 
     vehicle(_2222,_2224).

grounding(noise_level(_2222,_2224)=high) :- 
     vehicle(_2222,_2224).

grounding(internal_temperature(_2222,_2224)=very_warm) :- 
     vehicle(_2222,_2224).

grounding(internal_temperature(_2222,_2224)=very_cold) :- 
     vehicle(_2222,_2224).

grounding(driving_style(_2222,_2224)=unsafe) :- 
     vehicle(_2222,_2224).

grounding(driving_style(_2222,_2224)=uncomfortable) :- 
     vehicle(_2222,_2224).

grounding(driving_quality(_2222,_2224)=high) :- 
     vehicle(_2222,_2224).

grounding(driving_quality(_2222,_2224)=medium) :- 
     vehicle(_2222,_2224).

grounding(driving_quality(_2222,_2224)=low) :- 
     vehicle(_2222,_2224).

grounding(passenger_comfort(_2222,_2224)=reducing) :- 
     vehicle(_2222,_2224).

grounding(driver_comfort(_2222,_2224)=reducing) :- 
     vehicle(_2222,_2224).

grounding(passenger_satisfaction(_2222,_2224)=reducing) :- 
     vehicle(_2222,_2224).

inputEntity(stop_enter(_1934,_1936,_1938,_1940)).
inputEntity(stop_leave(_1934,_1936,_1938,_1940)).
inputEntity(sharp_turn(_1940,_1942)=very_sharp).
inputEntity(abrupt_acceleration(_1940,_1942)=very_abrupt).
inputEntity(abrupt_deceleration(_1940,_1942)=very_abrupt).
inputEntity(sharp_turn(_1940,_1942)=sharp).
inputEntity(abrupt_acceleration(_1940,_1942)=abrupt).
inputEntity(abrupt_deceleration(_1940,_1942)=abrupt).
inputEntity(internal_temperature_change(_1934,_1936,_1938)).
inputEntity(noise_level_change(_1934,_1936,_1938)).
inputEntity(passenger_density_change(_1934,_1936,_1938)).

outputEntity(punctuality(_2062,_2064)=punctual).
outputEntity(punctuality(_2062,_2064)=non_punctual).
outputEntity(passenger_density(_2062,_2064)=high).
outputEntity(noise_level(_2062,_2064)=high).
outputEntity(internal_temperature(_2062,_2064)=very_warm).
outputEntity(internal_temperature(_2062,_2064)=very_cold).
outputEntity(passenger_density(_2062,_2064)=low).
outputEntity(noise_level(_2062,_2064)=low).
outputEntity(internal_temperature(_2062,_2064)=normal).
outputEntity(driving_style(_2062,_2064)=unsafe).
outputEntity(driving_style(_2062,_2064)=uncomfortable).
outputEntity(driving_quality(_2062,_2064)=high).
outputEntity(driving_quality(_2062,_2064)=medium).
outputEntity(driving_quality(_2062,_2064)=low).
outputEntity(passenger_comfort(_2062,_2064)=reducing).
outputEntity(driver_comfort(_2062,_2064)=reducing).
outputEntity(passenger_satisfaction(_2062,_2064)=reducing).
outputEntity(punctuality_change(_2056,_2058,_2060)).

event(punctuality_change(_2220,_2222,_2224)).
event(stop_enter(_2220,_2222,_2224,_2226)).
event(stop_leave(_2220,_2222,_2224,_2226)).
event(internal_temperature_change(_2220,_2222,_2224)).
event(noise_level_change(_2220,_2222,_2224)).
event(passenger_density_change(_2220,_2222,_2224)).

simpleFluent(punctuality(_2318,_2320)=punctual).
simpleFluent(punctuality(_2318,_2320)=non_punctual).
simpleFluent(passenger_density(_2318,_2320)=high).
simpleFluent(noise_level(_2318,_2320)=high).
simpleFluent(internal_temperature(_2318,_2320)=very_warm).
simpleFluent(internal_temperature(_2318,_2320)=very_cold).
simpleFluent(passenger_density(_2318,_2320)=low).
simpleFluent(noise_level(_2318,_2320)=low).
simpleFluent(internal_temperature(_2318,_2320)=normal).

sDFluent(driving_style(_2428,_2430)=unsafe).
sDFluent(driving_style(_2428,_2430)=uncomfortable).
sDFluent(driving_quality(_2428,_2430)=high).
sDFluent(driving_quality(_2428,_2430)=medium).
sDFluent(driving_quality(_2428,_2430)=low).
sDFluent(passenger_comfort(_2428,_2430)=reducing).
sDFluent(driver_comfort(_2428,_2430)=reducing).
sDFluent(passenger_satisfaction(_2428,_2430)=reducing).
sDFluent(sharp_turn(_2428,_2430)=very_sharp).
sDFluent(abrupt_acceleration(_2428,_2430)=very_abrupt).
sDFluent(abrupt_deceleration(_2428,_2430)=very_abrupt).
sDFluent(sharp_turn(_2428,_2430)=sharp).
sDFluent(abrupt_acceleration(_2428,_2430)=abrupt).
sDFluent(abrupt_deceleration(_2428,_2430)=abrupt).

index(punctuality_change(_2514,_2568,_2570),_2514).
index(stop_enter(_2514,_2568,_2570,_2572),_2514).
index(stop_leave(_2514,_2568,_2570,_2572),_2514).
index(internal_temperature_change(_2514,_2568,_2570),_2514).
index(noise_level_change(_2514,_2568,_2570),_2514).
index(passenger_density_change(_2514,_2568,_2570),_2514).
index(punctuality(_2514,_2574)=punctual,_2514).
index(punctuality(_2514,_2574)=non_punctual,_2514).
index(passenger_density(_2514,_2574)=high,_2514).
index(noise_level(_2514,_2574)=high,_2514).
index(internal_temperature(_2514,_2574)=very_warm,_2514).
index(internal_temperature(_2514,_2574)=very_cold,_2514).
index(passenger_density(_2514,_2574)=low,_2514).
index(noise_level(_2514,_2574)=low,_2514).
index(internal_temperature(_2514,_2574)=normal,_2514).
index(driving_style(_2514,_2574)=unsafe,_2514).
index(driving_style(_2514,_2574)=uncomfortable,_2514).
index(driving_quality(_2514,_2574)=high,_2514).
index(driving_quality(_2514,_2574)=medium,_2514).
index(driving_quality(_2514,_2574)=low,_2514).
index(passenger_comfort(_2514,_2574)=reducing,_2514).
index(driver_comfort(_2514,_2574)=reducing,_2514).
index(passenger_satisfaction(_2514,_2574)=reducing,_2514).
index(sharp_turn(_2514,_2574)=very_sharp,_2514).
index(abrupt_acceleration(_2514,_2574)=very_abrupt,_2514).
index(abrupt_deceleration(_2514,_2574)=very_abrupt,_2514).
index(sharp_turn(_2514,_2574)=sharp,_2514).
index(abrupt_acceleration(_2514,_2574)=abrupt,_2514).
index(abrupt_deceleration(_2514,_2574)=abrupt,_2514).


cachingOrder2(_3078, punctuality(_3078,_3080)=punctual) :- % level: 1
     vehicle(_3078,_3080).

cachingOrder2(_3060, passenger_density(_3060,_3062)=high) :- % level: 1
     vehicle(_3060,_3062).

cachingOrder2(_3042, noise_level(_3042,_3044)=high) :- % level: 1
     vehicle(_3042,_3044).

cachingOrder2(_3024, internal_temperature(_3024,_3026)=very_warm) :- % level: 1
     vehicle(_3024,_3026).

cachingOrder2(_3006, internal_temperature(_3006,_3008)=very_cold) :- % level: 1
     vehicle(_3006,_3008).

cachingOrder2(_2934, driving_style(_2934,_2936)=unsafe) :- % level: 1
     vehicle(_2934,_2936).

cachingOrder2(_2916, driving_style(_2916,_2918)=uncomfortable) :- % level: 1
     vehicle(_2916,_2918).

cachingOrder2(_5222, punctuality(_5222,_5224)=non_punctual) :- % level: 2
     vehicle(_5222,_5224).

cachingOrder2(_5204, driving_quality(_5204,_5206)=high) :- % level: 2
     vehicle(_5204,_5206).

cachingOrder2(_5186, driving_quality(_5186,_5188)=medium) :- % level: 2
     vehicle(_5186,_5188).

cachingOrder2(_5168, passenger_comfort(_5168,_5170)=reducing) :- % level: 2
     vehicle(_5168,_5170).

cachingOrder2(_5150, driver_comfort(_5150,_5152)=reducing) :- % level: 2
     vehicle(_5150,_5152).

cachingOrder2(_6350, driving_quality(_6350,_6352)=low) :- % level: 3
     vehicle(_6350,_6352).

cachingOrder2(_6332, passenger_satisfaction(_6332,_6334)=reducing) :- % level: 3
     vehicle(_6332,_6334).

cachingOrder2(_6312, punctuality_change(_6312,_6314,punctual)) :- % level: 3
     vehicle(_6312,_6314).

cachingOrder2(_6312, punctuality_change(_6312,_6314,non_punctual)) :- % level: 3
     vehicle(_6312,_6314).

collectGrounds([stop_enter(_2422,_2424,_2440,_2442), stop_leave(_2422,_2424,_2440,_2442), sharp_turn(_2422,_2424)=very_sharp, abrupt_acceleration(_2422,_2424)=very_abrupt, abrupt_deceleration(_2422,_2424)=very_abrupt, sharp_turn(_2422,_2424)=sharp, abrupt_acceleration(_2422,_2424)=abrupt, abrupt_deceleration(_2422,_2424)=abrupt, internal_temperature_change(_2422,_2424,_2440), noise_level_change(_2422,_2424,_2440), passenger_density_change(_2422,_2424,_2440)],vehicle(_2422,_2424)).

dgrounded(punctuality(_3046,_3048)=punctual, vehicle(_3046,_3048)).
dgrounded(punctuality(_3010,_3012)=non_punctual, vehicle(_3010,_3012)).
dgrounded(passenger_density(_2974,_2976)=high, vehicle(_2974,_2976)).
dgrounded(noise_level(_2938,_2940)=high, vehicle(_2938,_2940)).
dgrounded(internal_temperature(_2902,_2904)=very_warm, vehicle(_2902,_2904)).
dgrounded(internal_temperature(_2866,_2868)=very_cold, vehicle(_2866,_2868)).
dgrounded(driving_style(_2830,_2832)=unsafe, vehicle(_2830,_2832)).
dgrounded(driving_style(_2794,_2796)=uncomfortable, vehicle(_2794,_2796)).
dgrounded(driving_quality(_2758,_2760)=high, vehicle(_2758,_2760)).
dgrounded(driving_quality(_2722,_2724)=medium, vehicle(_2722,_2724)).
dgrounded(driving_quality(_2686,_2688)=low, vehicle(_2686,_2688)).
dgrounded(passenger_comfort(_2650,_2652)=reducing, vehicle(_2650,_2652)).
dgrounded(driver_comfort(_2614,_2616)=reducing, vehicle(_2614,_2616)).
dgrounded(passenger_satisfaction(_2578,_2580)=reducing, vehicle(_2578,_2580)).
dgrounded(punctuality_change(_2540,_2542,punctual), vehicle(_2540,_2542)).
dgrounded(punctuality_change(_2508,_2510,non_punctual), vehicle(_2508,_2510)).
