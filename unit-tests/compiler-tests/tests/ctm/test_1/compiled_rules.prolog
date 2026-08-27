:- dynamic vehicle/2.

initiatedAt(punctuality(_96,_98)=punctual, _108, -1, _116) :-
     _108=< -1,
     -1<_116.

initiatedAt(passenger_density(_96,_98)=low, _108, -1, _116) :-
     _108=< -1,
     -1<_116.

initiatedAt(noise_level(_96,_98)=low, _108, -1, _116) :-
     _108=< -1,
     -1<_116.

initiatedAt(internal_temperature(_96,_98)=normal, _108, -1, _116) :-
     _108=< -1,
     -1<_116.

initiatedAt(punctuality(_106,_108)=punctual, _130, _76, _136) :-
     happensAtIE(stop_enter(_106,_108,_116,scheduled),_76),
     _130=<_76,
     _76<_136.

initiatedAt(punctuality(_106,_108)=punctual, _130, _76, _136) :-
     happensAtIE(stop_enter(_106,_108,_116,early),_76),
     _130=<_76,
     _76<_136.

initiatedAt(internal_temperature(_106,_108)=_82, _128, _76, _134) :-
     happensAtIE(internal_temperature_change(_106,_108,_82),_76),
     _128=<_76,
     _76<_134.

initiatedAt(passenger_density(_98,_100)=_84, _132, _78, _138) :-
     happensAtIE(passenger_density_change(_98,_100,_84),_78),_132=<_78,_78<_138.

initiatedAt(noise_level(_98,_100)=_84, _132, _78, _138) :-
     happensAtIE(noise_level_change(_98,_100,_84),_78),_132=<_78,_78<_138.

terminatedAt(punctuality(_106,_108)=punctual, _130, _76, _136) :-
     happensAtIE(stop_enter(_106,_108,_116,late),_76),
     _130=<_76,
     _76<_136.

terminatedAt(punctuality(_106,_108)=punctual, _130, _76, _136) :-
     happensAtIE(stop_leave(_106,_108,_116,early),_76),
     _130=<_76,
     _76<_136.

holdsForSDFluent(punctuality(_106,_108)=non_punctual,_76) :-
     holdsForProcessedSimpleFluent(_106,punctuality(_106,_108)=punctual,_126),
     complement_all([_126],_76).

holdsForSDFluent(driving_style(_106,_108)=unsafe,_76) :-
     holdsForProcessedIE(_106,sharp_turn(_106,_108)=very_sharp,_126),
     holdsForProcessedIE(_106,abrupt_acceleration(_106,_108)=very_abrupt,_144),
     holdsForProcessedIE(_106,abrupt_deceleration(_106,_108)=very_abrupt,_162),
     union_all([_126,_144,_162],_76).

holdsForSDFluent(driving_style(_106,_108)=uncomfortable,_76) :-
     holdsForProcessedIE(_106,sharp_turn(_106,_108)=sharp,_126),
     holdsForProcessedIE(_106,abrupt_acceleration(_106,_108)=very_abrupt,_144),
     holdsForProcessedIE(_106,abrupt_deceleration(_106,_108)=very_abrupt,_162),
     relative_complement_all(_126,[_144,_162],_182),
     holdsForProcessedIE(_106,abrupt_acceleration(_106,_108)=abrupt,_200),
     holdsForProcessedIE(_106,abrupt_deceleration(_106,_108)=abrupt,_218),
     union_all([_182,_200,_218],_76).

holdsForSDFluent(driving_quality(_106,_108)=high,_76) :-
     holdsForProcessedSimpleFluent(_106,punctuality(_106,_108)=punctual,_126),
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=unsafe,_144),
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=uncomfortable,_162),
     relative_complement_all(_126,[_144,_162],_76).

holdsForSDFluent(driving_quality(_106,_108)=medium,_76) :-
     holdsForProcessedSimpleFluent(_106,punctuality(_106,_108)=punctual,_126),
     \+_126=[],
     !,
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=uncomfortable,_154),
     intersect_all([_126,_154],_76).

holdsForSDFluent(driving_quality(_100,_102)=medium,[]).

holdsForSDFluent(driving_quality(_106,_108)=low,_76) :-
     holdsForProcessedSDFluent(_106,punctuality(_106,_108)=non_punctual,_126),
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=unsafe,_144),
     union_all([_126,_144],_76).

holdsForSDFluent(passenger_comfort(_106,_108)=reducing,_76) :-
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=uncomfortable,_126),
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=unsafe,_144),
     holdsForProcessedSimpleFluent(_106,passenger_density(_106,_108)=high,_162),
     holdsForProcessedSimpleFluent(_106,noise_level(_106,_108)=high,_180),
     holdsForProcessedSimpleFluent(_106,internal_temperature(_106,_108)=very_warm,_198),
     holdsForProcessedSimpleFluent(_106,internal_temperature(_106,_108)=very_cold,_216),
     union_all([_126,_144,_162,_180,_198,_216],_76).

holdsForSDFluent(driver_comfort(_106,_108)=reducing,_76) :-
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=uncomfortable,_126),
     holdsForProcessedSDFluent(_106,driving_style(_106,_108)=unsafe,_144),
     holdsForProcessedSimpleFluent(_106,noise_level(_106,_108)=high,_162),
     holdsForProcessedSimpleFluent(_106,internal_temperature(_106,_108)=very_warm,_180),
     holdsForProcessedSimpleFluent(_106,internal_temperature(_106,_108)=very_cold,_198),
     union_all([_126,_144,_162,_180,_198],_76).

holdsForSDFluent(passenger_satisfaction(_106,_108)=reducing,_76) :-
     holdsForProcessedSDFluent(_106,punctuality(_106,_108)=non_punctual,_126),
     holdsForProcessedSDFluent(_106,passenger_comfort(_106,_108)=reducing,_144),
     union_all([_126,_144],_76).

happensAtEv(punctuality_change(_94,_96,punctual),_76) :-
     happensAtProcessedSDFluent(_94,end(punctuality(_94,_96)=non_punctual),_76).

happensAtEv(punctuality_change(_94,_96,non_punctual),_76) :-
     happensAtProcessedSimpleFluent(_94,end(punctuality(_94,_96)=punctual),_76).

collectIntervals2(_80, abrupt_acceleration(_80,_82)=abrupt) :-
     vehicle(_80,_82).

collectIntervals2(_80, abrupt_acceleration(_80,_82)=very_abrupt) :-
     vehicle(_80,_82).

collectIntervals2(_80, abrupt_deceleration(_80,_82)=abrupt) :-
     vehicle(_80,_82).

collectIntervals2(_80, abrupt_deceleration(_80,_82)=very_abrupt) :-
     vehicle(_80,_82).

collectIntervals2(_80, sharp_turn(_80,_82)=sharp) :-
     vehicle(_80,_82).

collectIntervals2(_80, sharp_turn(_80,_82)=very_sharp) :-
     vehicle(_80,_82).

grounding(stop_enter(_458,_460,_462,_464)) :- 
     vehicle(_458,_460).

grounding(stop_leave(_458,_460,_462,_464)) :- 
     vehicle(_458,_460).

grounding(internal_temperature_change(_458,_460,_462)) :- 
     vehicle(_458,_460).

grounding(noise_level_change(_458,_460,_462)) :- 
     vehicle(_458,_460).

grounding(passenger_density_change(_458,_460,_462)) :- 
     vehicle(_458,_460).

grounding(punctuality_change(_458,_460,_462)) :- 
     vehicle(_458,_460).

grounding(abrupt_acceleration(_464,_466)=abrupt) :- 
     vehicle(_464,_466).

grounding(abrupt_acceleration(_464,_466)=very_abrupt) :- 
     vehicle(_464,_466).

grounding(abrupt_deceleration(_464,_466)=abrupt) :- 
     vehicle(_464,_466).

grounding(abrupt_deceleration(_464,_466)=very_abrupt) :- 
     vehicle(_464,_466).

grounding(sharp_turn(_464,_466)=sharp) :- 
     vehicle(_464,_466).

grounding(sharp_turn(_464,_466)=very_sharp) :- 
     vehicle(_464,_466).

grounding(punctuality(_464,_466)=punctual) :- 
     vehicle(_464,_466).

grounding(punctuality(_464,_466)=non_punctual) :- 
     vehicle(_464,_466).

grounding(passenger_density(_464,_466)=high) :- 
     vehicle(_464,_466).

grounding(noise_level(_464,_466)=high) :- 
     vehicle(_464,_466).

grounding(internal_temperature(_464,_466)=very_warm) :- 
     vehicle(_464,_466).

grounding(internal_temperature(_464,_466)=very_cold) :- 
     vehicle(_464,_466).

grounding(driving_style(_464,_466)=unsafe) :- 
     vehicle(_464,_466).

grounding(driving_style(_464,_466)=uncomfortable) :- 
     vehicle(_464,_466).

grounding(driving_quality(_464,_466)=high) :- 
     vehicle(_464,_466).

grounding(driving_quality(_464,_466)=medium) :- 
     vehicle(_464,_466).

grounding(driving_quality(_464,_466)=low) :- 
     vehicle(_464,_466).

grounding(passenger_comfort(_464,_466)=reducing) :- 
     vehicle(_464,_466).

grounding(driver_comfort(_464,_466)=reducing) :- 
     vehicle(_464,_466).

grounding(passenger_satisfaction(_464,_466)=reducing) :- 
     vehicle(_464,_466).

inputEntity(stop_enter(_130,_132,_134,_136)).
inputEntity(internal_temperature_change(_130,_132,_134)).
inputEntity(stop_leave(_130,_132,_134,_136)).
inputEntity(sharp_turn(_136,_138)=very_sharp).
inputEntity(abrupt_acceleration(_136,_138)=very_abrupt).
inputEntity(abrupt_deceleration(_136,_138)=very_abrupt).
inputEntity(sharp_turn(_136,_138)=sharp).
inputEntity(abrupt_acceleration(_136,_138)=abrupt).
inputEntity(abrupt_deceleration(_136,_138)=abrupt).
inputEntity(noise_level_change(_130,_132,_134)).
inputEntity(passenger_density_change(_130,_132,_134)).

outputEntity(punctuality(_258,_260)=punctual).
outputEntity(internal_temperature(_258,_260)=very_warm).
outputEntity(internal_temperature(_258,_260)=very_cold).
outputEntity(passenger_density(_258,_260)=high).
outputEntity(noise_level(_258,_260)=high).
outputEntity(passenger_density(_258,_260)=low).
outputEntity(noise_level(_258,_260)=low).
outputEntity(internal_temperature(_258,_260)=normal).
outputEntity(punctuality(_258,_260)=non_punctual).
outputEntity(driving_style(_258,_260)=unsafe).
outputEntity(driving_style(_258,_260)=uncomfortable).
outputEntity(driving_quality(_258,_260)=high).
outputEntity(driving_quality(_258,_260)=medium).
outputEntity(driving_quality(_258,_260)=low).
outputEntity(passenger_comfort(_258,_260)=reducing).
outputEntity(driver_comfort(_258,_260)=reducing).
outputEntity(passenger_satisfaction(_258,_260)=reducing).
outputEntity(punctuality_change(_252,_254,_256)).

event(punctuality_change(_416,_418,_420)).
event(stop_enter(_416,_418,_420,_422)).
event(internal_temperature_change(_416,_418,_420)).
event(stop_leave(_416,_418,_420,_422)).
event(noise_level_change(_416,_418,_420)).
event(passenger_density_change(_416,_418,_420)).

simpleFluent(punctuality(_514,_516)=punctual).
simpleFluent(internal_temperature(_514,_516)=very_warm).
simpleFluent(internal_temperature(_514,_516)=very_cold).
simpleFluent(passenger_density(_514,_516)=high).
simpleFluent(noise_level(_514,_516)=high).
simpleFluent(passenger_density(_514,_516)=low).
simpleFluent(noise_level(_514,_516)=low).
simpleFluent(internal_temperature(_514,_516)=normal).


sDFluent(punctuality(_674,_676)=non_punctual).
sDFluent(driving_style(_674,_676)=unsafe).
sDFluent(driving_style(_674,_676)=uncomfortable).
sDFluent(driving_quality(_674,_676)=high).
sDFluent(driving_quality(_674,_676)=medium).
sDFluent(driving_quality(_674,_676)=low).
sDFluent(passenger_comfort(_674,_676)=reducing).
sDFluent(driver_comfort(_674,_676)=reducing).
sDFluent(passenger_satisfaction(_674,_676)=reducing).
sDFluent(sharp_turn(_674,_676)=very_sharp).
sDFluent(abrupt_acceleration(_674,_676)=very_abrupt).
sDFluent(abrupt_deceleration(_674,_676)=very_abrupt).
sDFluent(sharp_turn(_674,_676)=sharp).
sDFluent(abrupt_acceleration(_674,_676)=abrupt).
sDFluent(abrupt_deceleration(_674,_676)=abrupt).

index(punctuality_change(_766,_820,_822),_766).
index(stop_enter(_766,_820,_822,_824),_766).
index(internal_temperature_change(_766,_820,_822),_766).
index(stop_leave(_766,_820,_822,_824),_766).
index(noise_level_change(_766,_820,_822),_766).
index(passenger_density_change(_766,_820,_822),_766).
index(punctuality(_766,_826)=punctual,_766).
index(internal_temperature(_766,_826)=very_warm,_766).
index(internal_temperature(_766,_826)=very_cold,_766).
index(passenger_density(_766,_826)=high,_766).
index(noise_level(_766,_826)=high,_766).
index(passenger_density(_766,_826)=low,_766).
index(noise_level(_766,_826)=low,_766).
index(internal_temperature(_766,_826)=normal,_766).
index(punctuality(_766,_826)=non_punctual,_766).
index(driving_style(_766,_826)=unsafe,_766).
index(driving_style(_766,_826)=uncomfortable,_766).
index(driving_quality(_766,_826)=high,_766).
index(driving_quality(_766,_826)=medium,_766).
index(driving_quality(_766,_826)=low,_766).
index(passenger_comfort(_766,_826)=reducing,_766).
index(driver_comfort(_766,_826)=reducing,_766).
index(passenger_satisfaction(_766,_826)=reducing,_766).
index(sharp_turn(_766,_826)=very_sharp,_766).
index(abrupt_acceleration(_766,_826)=very_abrupt,_766).
index(abrupt_deceleration(_766,_826)=very_abrupt,_766).
index(sharp_turn(_766,_826)=sharp,_766).
index(abrupt_acceleration(_766,_826)=abrupt,_766).
index(abrupt_deceleration(_766,_826)=abrupt,_766).


cachingOrder2(_1360, punctuality(_1360,_1362)=punctual) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1360,_1362).

cachingOrder2(_1378, punctuality(_1378,_1380)=non_punctual) :- % level in dependency graph: 1, processing order in component: 2
     vehicle(_1378,_1380).

cachingOrder2(_1318, internal_temperature(_1318,_1320)=very_cold) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1318,_1320).

cachingOrder2(_1336, internal_temperature(_1336,_1338)=very_warm) :- % level in dependency graph: 1, processing order in component: 2
     vehicle(_1336,_1338).

cachingOrder2(_1276, passenger_density(_1276,_1278)=high) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1276,_1278).

cachingOrder2(_1234, noise_level(_1234,_1236)=high) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1234,_1236).

cachingOrder2(_1174, driving_style(_1174,_1176)=uncomfortable) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1174,_1176).

cachingOrder2(_1192, driving_style(_1192,_1194)=unsafe) :- % level in dependency graph: 1, processing order in component: 2
     vehicle(_1192,_1194).

cachingOrder2(_2222, driving_quality(_2222,_2224)=low) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_2222,_2224).

cachingOrder2(_2240, driving_quality(_2240,_2242)=medium) :- % level in dependency graph: 2, processing order in component: 2
     vehicle(_2240,_2242).

cachingOrder2(_2258, driving_quality(_2258,_2260)=high) :- % level in dependency graph: 2, processing order in component: 3
     vehicle(_2258,_2260).

cachingOrder2(_2198, passenger_comfort(_2198,_2200)=reducing) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_2198,_2200).

cachingOrder2(_2174, driver_comfort(_2174,_2176)=reducing) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_2174,_2176).

cachingOrder2(_2148, punctuality_change(_2148,_2150,_2152)) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_2148,_2150).

cachingOrder2(_2862, passenger_satisfaction(_2862,_2864)=reducing) :- % level in dependency graph: 3, processing order in component: 1
     vehicle(_2862,_2864).

collectGrounds([stop_enter(_618,_620,_636,_638), internal_temperature_change(_618,_620,_636), stop_leave(_618,_620,_636,_638), sharp_turn(_618,_620)=very_sharp, abrupt_acceleration(_618,_620)=very_abrupt, abrupt_deceleration(_618,_620)=very_abrupt, sharp_turn(_618,_620)=sharp, abrupt_acceleration(_618,_620)=abrupt, abrupt_deceleration(_618,_620)=abrupt, noise_level_change(_618,_620,_636), passenger_density_change(_618,_620,_636)],vehicle(_618,_620)).

dgrounded(punctuality(_1210,_1212)=punctual, vehicle(_1210,_1212)).
dgrounded(internal_temperature(_1174,_1176)=very_warm, vehicle(_1174,_1176)).
dgrounded(internal_temperature(_1138,_1140)=very_cold, vehicle(_1138,_1140)).
dgrounded(passenger_density(_1102,_1104)=high, vehicle(_1102,_1104)).
dgrounded(noise_level(_1066,_1068)=high, vehicle(_1066,_1068)).
dgrounded(punctuality(_1030,_1032)=non_punctual, vehicle(_1030,_1032)).
dgrounded(driving_style(_994,_996)=unsafe, vehicle(_994,_996)).
dgrounded(driving_style(_958,_960)=uncomfortable, vehicle(_958,_960)).
dgrounded(driving_quality(_922,_924)=high, vehicle(_922,_924)).
dgrounded(driving_quality(_886,_888)=medium, vehicle(_886,_888)).
dgrounded(driving_quality(_850,_852)=low, vehicle(_850,_852)).
dgrounded(passenger_comfort(_814,_816)=reducing, vehicle(_814,_816)).
dgrounded(driver_comfort(_778,_780)=reducing, vehicle(_778,_780)).
dgrounded(passenger_satisfaction(_742,_744)=reducing, vehicle(_742,_744)).
dgrounded(punctuality_change(_704,_706,_708), vehicle(_704,_706)).
