:- dynamic vehicle/2.

initiatedAt(punctuality(_112,_114)=punctual, _136, _82, _142) :-
     happensAtIE(stop_enter(_112,_114,_122,scheduled),_82),
     _136=<_82,
     _82<_142.

initiatedAt(punctuality(_112,_114)=punctual, _136, _82, _142) :-
     happensAtIE(stop_enter(_112,_114,_122,early),_82),
     _136=<_82,
     _82<_142.

initiatedAt(punctuality(_112,_114)=non_punctual, _136, _82, _142) :-
     happensAtIE(stop_enter(_112,_114,_122,late),_82),
     _136=<_82,
     _82<_142.

initiatedAt(punctuality(_112,_114)=non_punctual, _136, _82, _142) :-
     happensAtIE(stop_leave(_112,_114,_122,early),_82),
     _136=<_82,
     _82<_142.

initiatedAt(punctuality(_112,_114)=non_punctual, _136, _82, _142) :-
     happensAtIE(stop_leave(_112,_114,_122,late),_82),
     _136=<_82,
     _82<_142.

terminatedAt(punctuality(_112,_114)=punctual, _136, _82, _142) :-
     happensAtIE(stop_enter(_112,_114,_122,late),_82),
     _136=<_82,
     _82<_142.

terminatedAt(punctuality(_112,_114)=punctual, _136, _82, _142) :-
     happensAtIE(stop_leave(_112,_114,_122,early),_82),
     _136=<_82,
     _82<_142.

holdsForSDFluent(unsafe_driving_style(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,sharp_turn(_112,_114)=very_sharp,I0x0),
     intersect_all([I0x0],I0),
     holdsForProcessedIE(_112,abrupt_acceleration(_112,_114)=very_abrupt,I1x0),
     intersect_all([I1x0],I1),
     holdsForProcessedIE(_112,abrupt_deceleration(_112,_114)=very_abrupt,I2x0),
     intersect_all([I2x0],I2),
     union_all([I2,I1,I0],_82).

holdsForSDFluent(uncomfortable_driving_style(_112,_114)=true,_82) :-
     holdsForProcessedIE(_112,sharp_turn(_112,_114)=sharp,I0x0),
     holdsForProcessedIE(_112,abrupt_acceleration(_112,_114)=very_abrupt,I0x1c),
     complement_all(I0x1c,I0x1),
     holdsForProcessedIE(_112,abrupt_deceleration(_112,_114)=very_abrupt,I0x2c),
     complement_all(I0x2c,I0x2),
     intersect_all([I0x2,I0x1,I0x0],I0),
     holdsForProcessedIE(_112,abrupt_acceleration(_112,_114)=abrupt,I1x0),
     intersect_all([I1x0],I1),
     holdsForProcessedIE(_112,abrupt_deceleration(_112,_114)=abrupt,I2x0),
     intersect_all([I2x0],I2),
     union_all([I2,I1,I0],_82).

holdsForSDFluent(high_driving_quality(_112,_114)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,punctuality(_112,_114)=punctual,I0x0),
     holdsForProcessedSDFluent(_112,unsafe_driving_style(_112,_114)=true,I0x1c),
     complement_all(I0x1c,I0x1),
     holdsForProcessedSDFluent(_112,uncomfortable_driving_style(_112,_114)=true,I0x2c),
     complement_all(I0x2c,I0x2),
     intersect_all([I0x2,I0x1,I0x0],I0),
     union_all([I0],_82).

holdsForSDFluent(medium_driving_quality(_112,_114)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,punctuality(_112,_114)=punctual,I0x0),
     holdsForProcessedSDFluent(_112,uncomfortable_driving_style(_112,_114)=true,I0x1),
     intersect_all([I0x1,I0x0],I0),
     union_all([I0],_82).

holdsForSDFluent(low_driving_quality(_112,_114)=true,_82) :-
     holdsForProcessedSimpleFluent(_112,punctuality(_112,_114)=non_punctual,I0x0),
     intersect_all([I0x0],I0),
     holdsForProcessedSDFluent(_112,unsafe_driving_style(_112,_114)=true,I1x0),
     intersect_all([I1x0],I1),
     union_all([I1,I0],_82).

holdsForSDFluent(passenger_comfort(_112,_114)=reducing,_82) :-
     holdsForProcessedSDFluent(_112,uncomfortable_driving_style(_112,_114)=true,I0x0),
     intersect_all([I0x0],I0),
     holdsForProcessedSDFluent(_112,unsafe_driving_style(_112,_114)=true,I1x0),
     intersect_all([I1x0],I1),
     holdsForProcessedIE(_112,passenger_density(_112,_114)=high,I2x0),
     intersect_all([I2x0],I2),
     holdsForProcessedIE(_112,noise_level(_112,_114)=high,I3x0),
     intersect_all([I3x0],I3),
     holdsForProcessedIE(_112,internal_temperature(_112,_114)=very_warm,I4x0),
     intersect_all([I4x0],I4),
     holdsForProcessedIE(_112,internal_temperature(_112,_114)=very_cold,I5x0),
     intersect_all([I5x0],I5),
     union_all([I5,I4,I3,I2,I1,I0],_82).

holdsForSDFluent(driver_comfort(_112,_114)=reducing,_82) :-
     holdsForProcessedSDFluent(_112,uncomfortable_driving_style(_112,_114)=true,I0x0),
     intersect_all([I0x0],I0),
     holdsForProcessedSDFluent(_112,unsafe_driving_style(_112,_114)=true,I1x0),
     intersect_all([I1x0],I1),
     holdsForProcessedIE(_112,noise_level(_112,_114)=high,I2x0),
     intersect_all([I2x0],I2),
     holdsForProcessedIE(_112,internal_temperature(_112,_114)=very_warm,I3x0),
     intersect_all([I3x0],I3),
     holdsForProcessedIE(_112,internal_temperature(_112,_114)=very_cold,I4x0),
     intersect_all([I4x0],I4),
     union_all([I4,I3,I2,I1,I0],_82).

holdsForSDFluent(passenger_satisfaction(_112,_114)=reducing,_82) :-
     holdsForProcessedSimpleFluent(_112,punctuality(_112,_114)=non_punctual,I0x0),
     intersect_all([I0x0],I0),
     holdsForProcessedSDFluent(_112,passenger_comfort(_112,_114)=reducing,I1x0),
     intersect_all([I1x0],I1),
     union_all([I1,I0],_82).

collectIntervals2(_86, abrupt_acceleration(_86,_88)=abrupt) :-
     vehicle(_86,_88).

collectIntervals2(_86, abrupt_acceleration(_86,_88)=very_abrupt) :-
     vehicle(_86,_88).

collectIntervals2(_86, abrupt_deceleration(_86,_88)=abrupt) :-
     vehicle(_86,_88).

collectIntervals2(_86, abrupt_deceleration(_86,_88)=very_abrupt) :-
     vehicle(_86,_88).

collectIntervals2(_86, sharp_turn(_86,_88)=sharp) :-
     vehicle(_86,_88).

collectIntervals2(_86, sharp_turn(_86,_88)=very_sharp) :-
     vehicle(_86,_88).

grounding(stop_enter(_392,_394,_396,_398)) :- 
     vehicle(_392,_394).

grounding(stop_leave(_392,_394,_396,_398)) :- 
     vehicle(_392,_394).

grounding(internal_temperature_change(_392,_394,_396)) :- 
     vehicle(_392,_394).

grounding(noise_level_change(_392,_394,_396)) :- 
     vehicle(_392,_394).

grounding(passenger_density_change(_392,_394,_396)) :- 
     vehicle(_392,_394).

grounding(punctuality_change(_392,_394,punctual)) :- 
     vehicle(_392,_394).

grounding(punctuality_change(_392,_394,non_punctual)) :- 
     vehicle(_392,_394).

grounding(abrupt_acceleration(_398,_400)=abrupt) :- 
     vehicle(_398,_400).

grounding(abrupt_acceleration(_398,_400)=very_abrupt) :- 
     vehicle(_398,_400).

grounding(abrupt_deceleration(_398,_400)=abrupt) :- 
     vehicle(_398,_400).

grounding(abrupt_deceleration(_398,_400)=very_abrupt) :- 
     vehicle(_398,_400).

grounding(sharp_turn(_398,_400)=sharp) :- 
     vehicle(_398,_400).

grounding(sharp_turn(_398,_400)=very_sharp) :- 
     vehicle(_398,_400).

grounding(punctuality(_398,_400)=punctual) :- 
     vehicle(_398,_400).

grounding(punctuality(_398,_400)=non_punctual) :- 
     vehicle(_398,_400).

grounding(passenger_density(_398,_400)=high) :- 
     vehicle(_398,_400).

grounding(noise_level(_398,_400)=high) :- 
     vehicle(_398,_400).

grounding(internal_temperature(_398,_400)=very_warm) :- 
     vehicle(_398,_400).

grounding(internal_temperature(_398,_400)=very_cold) :- 
     vehicle(_398,_400).

grounding(driving_style(_398,_400)=unsafe) :- 
     vehicle(_398,_400).

grounding(driving_style(_398,_400)=uncomfortable) :- 
     vehicle(_398,_400).

grounding(driving_quality(_398,_400)=high) :- 
     vehicle(_398,_400).

grounding(driving_quality(_398,_400)=medium) :- 
     vehicle(_398,_400).

grounding(driving_quality(_398,_400)=low) :- 
     vehicle(_398,_400).

grounding(passenger_comfort(_398,_400)=reducing) :- 
     vehicle(_398,_400).

grounding(driver_comfort(_398,_400)=reducing) :- 
     vehicle(_398,_400).

grounding(passenger_satisfaction(_398,_400)=reducing) :- 
     vehicle(_398,_400).

inputEntity(stop_enter(_136,_138,_140,_142)).
inputEntity(stop_leave(_136,_138,_140,_142)).
inputEntity(sharp_turn(_142,_144)=very_sharp).
inputEntity(abrupt_acceleration(_142,_144)=very_abrupt).
inputEntity(abrupt_deceleration(_142,_144)=very_abrupt).
inputEntity(sharp_turn(_142,_144)=sharp).
inputEntity(abrupt_acceleration(_142,_144)=abrupt).
inputEntity(abrupt_deceleration(_142,_144)=abrupt).
inputEntity(passenger_density(_142,_144)=high).
inputEntity(noise_level(_142,_144)=high).
inputEntity(internal_temperature(_142,_144)=very_warm).
inputEntity(internal_temperature(_142,_144)=very_cold).
inputEntity(internal_temperature_change(_136,_138,_140)).
inputEntity(noise_level_change(_136,_138,_140)).
inputEntity(passenger_density_change(_136,_138,_140)).
inputEntity(punctuality_change(_136,_138,_140)).
inputEntity(driving_style(_142,_144)=unsafe).
inputEntity(driving_style(_142,_144)=uncomfortable).
inputEntity(driving_quality(_142,_144)=high).
inputEntity(driving_quality(_142,_144)=medium).
inputEntity(driving_quality(_142,_144)=low).

outputEntity(punctuality(_324,_326)=punctual).
outputEntity(punctuality(_324,_326)=non_punctual).
outputEntity(unsafe_driving_style(_324,_326)=true).
outputEntity(uncomfortable_driving_style(_324,_326)=true).
outputEntity(high_driving_quality(_324,_326)=true).
outputEntity(medium_driving_quality(_324,_326)=true).
outputEntity(low_driving_quality(_324,_326)=true).
outputEntity(passenger_comfort(_324,_326)=reducing).
outputEntity(driver_comfort(_324,_326)=reducing).
outputEntity(passenger_satisfaction(_324,_326)=reducing).

event(stop_enter(_434,_436,_438,_440)).
event(stop_leave(_434,_436,_438,_440)).
event(internal_temperature_change(_434,_436,_438)).
event(noise_level_change(_434,_436,_438)).
event(passenger_density_change(_434,_436,_438)).
event(punctuality_change(_434,_436,_438)).

simpleFluent(punctuality(_532,_534)=punctual).
simpleFluent(punctuality(_532,_534)=non_punctual).


sDFluent(sharp_turn(_656,_658)=very_sharp).
sDFluent(abrupt_acceleration(_656,_658)=very_abrupt).
sDFluent(abrupt_deceleration(_656,_658)=very_abrupt).
sDFluent(sharp_turn(_656,_658)=sharp).
sDFluent(abrupt_acceleration(_656,_658)=abrupt).
sDFluent(abrupt_deceleration(_656,_658)=abrupt).
sDFluent(passenger_density(_656,_658)=high).
sDFluent(noise_level(_656,_658)=high).
sDFluent(internal_temperature(_656,_658)=very_warm).
sDFluent(internal_temperature(_656,_658)=very_cold).
sDFluent(driving_style(_656,_658)=unsafe).
sDFluent(driving_style(_656,_658)=uncomfortable).
sDFluent(driving_quality(_656,_658)=high).
sDFluent(driving_quality(_656,_658)=medium).
sDFluent(driving_quality(_656,_658)=low).
sDFluent(unsafe_driving_style(_656,_658)=true).
sDFluent(uncomfortable_driving_style(_656,_658)=true).
sDFluent(high_driving_quality(_656,_658)=true).
sDFluent(medium_driving_quality(_656,_658)=true).
sDFluent(low_driving_quality(_656,_658)=true).
sDFluent(passenger_comfort(_656,_658)=reducing).
sDFluent(driver_comfort(_656,_658)=reducing).
sDFluent(passenger_satisfaction(_656,_658)=reducing).

index(stop_enter(_796,_850,_852,_854),_796).
index(stop_leave(_796,_850,_852,_854),_796).
index(internal_temperature_change(_796,_850,_852),_796).
index(noise_level_change(_796,_850,_852),_796).
index(passenger_density_change(_796,_850,_852),_796).
index(punctuality_change(_796,_850,_852),_796).
index(punctuality(_796,_856)=punctual,_796).
index(punctuality(_796,_856)=non_punctual,_796).
index(sharp_turn(_796,_856)=very_sharp,_796).
index(abrupt_acceleration(_796,_856)=very_abrupt,_796).
index(abrupt_deceleration(_796,_856)=very_abrupt,_796).
index(sharp_turn(_796,_856)=sharp,_796).
index(abrupt_acceleration(_796,_856)=abrupt,_796).
index(abrupt_deceleration(_796,_856)=abrupt,_796).
index(passenger_density(_796,_856)=high,_796).
index(noise_level(_796,_856)=high,_796).
index(internal_temperature(_796,_856)=very_warm,_796).
index(internal_temperature(_796,_856)=very_cold,_796).
index(driving_style(_796,_856)=unsafe,_796).
index(driving_style(_796,_856)=uncomfortable,_796).
index(driving_quality(_796,_856)=high,_796).
index(driving_quality(_796,_856)=medium,_796).
index(driving_quality(_796,_856)=low,_796).
index(unsafe_driving_style(_796,_856)=true,_796).
index(uncomfortable_driving_style(_796,_856)=true,_796).
index(high_driving_quality(_796,_856)=true,_796).
index(medium_driving_quality(_796,_856)=true,_796).
index(low_driving_quality(_796,_856)=true,_796).
index(passenger_comfort(_796,_856)=reducing,_796).
index(driver_comfort(_796,_856)=reducing,_796).
index(passenger_satisfaction(_796,_856)=reducing,_796).


cachingOrder2(_1264, punctuality(_1264,_1266)=non_punctual) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1264,_1266).

cachingOrder2(_1282, punctuality(_1282,_1284)=punctual) :- % level in dependency graph: 1, processing order in component: 2
     vehicle(_1282,_1284).

cachingOrder2(_1554, passenger_comfort(_1554,_1556)=reducing) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_1554,_1556).

cachingOrder2(_1530, driver_comfort(_1530,_1532)=reducing) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_1530,_1532).

cachingOrder2(_1874, passenger_satisfaction(_1874,_1876)=reducing) :- % level in dependency graph: 3, processing order in component: 1
     vehicle(_1874,_1876).

collectGrounds([stop_enter(_1078,_1080,_1096,_1098), stop_leave(_1078,_1080,_1096,_1098), sharp_turn(_1078,_1080)=very_sharp, abrupt_acceleration(_1078,_1080)=very_abrupt, abrupt_deceleration(_1078,_1080)=very_abrupt, sharp_turn(_1078,_1080)=sharp, abrupt_acceleration(_1078,_1080)=abrupt, abrupt_deceleration(_1078,_1080)=abrupt, passenger_density(_1078,_1080)=high, noise_level(_1078,_1080)=high, internal_temperature(_1078,_1080)=very_warm, internal_temperature(_1078,_1080)=very_cold, internal_temperature_change(_1078,_1080,_1096), noise_level_change(_1078,_1080,_1096), passenger_density_change(_1078,_1080,_1096), punctuality_change(_1078,_1080,punctual), punctuality_change(_1078,_1080,non_punctual), driving_style(_1078,_1080)=unsafe, driving_style(_1078,_1080)=uncomfortable, driving_quality(_1078,_1080)=high, driving_quality(_1078,_1080)=medium, driving_quality(_1078,_1080)=low],vehicle(_1078,_1080)).

dgrounded(punctuality(_1314,_1316)=punctual, vehicle(_1314,_1316)).
dgrounded(punctuality(_1278,_1280)=non_punctual, vehicle(_1278,_1280)).
dgrounded(passenger_comfort(_1242,_1244)=reducing, vehicle(_1242,_1244)).
dgrounded(driver_comfort(_1206,_1208)=reducing, vehicle(_1206,_1208)).
dgrounded(passenger_satisfaction(_1170,_1172)=reducing, vehicle(_1170,_1172)).
