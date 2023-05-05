:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(punctuality(_4656,_4658)=punctual, _4668, -1, _4676) :-
     _4668=< -1,
     -1<_4676.

initiatedAt(passenger_density(_4656,_4658)=low, _4668, -1, _4676) :-
     _4668=< -1,
     -1<_4676.

initiatedAt(noise_level(_4656,_4658)=low, _4668, -1, _4676) :-
     _4668=< -1,
     -1<_4676.

initiatedAt(internal_temperature(_4656,_4658)=normal, _4668, -1, _4676) :-
     _4668=< -1,
     -1<_4676.

initiatedAt(punctuality(_3162,_3164)=punctual, _3184, _3134, _3190) :-
     happensAtIE(stop_enter(_3162,_3164,_3172,scheduled),_3134),
     _3184=<_3134,
     _3134<_3190.

initiatedAt(punctuality(_3162,_3164)=punctual, _3184, _3134, _3190) :-
     happensAtIE(stop_enter(_3162,_3164,_3172,early),_3134),
     _3184=<_3134,
     _3134<_3190.

initiatedAt(punctuality(_3162,_3164)=non_punctual, _3184, _3134, _3190) :-
     happensAtIE(stop_enter(_3162,_3164,_3172,late),_3134),
     _3184=<_3134,
     _3134<_3190.

initiatedAt(punctuality(_3162,_3164)=non_punctual, _3184, _3134, _3190) :-
     happensAtIE(stop_leave(_3162,_3164,_3172,early),_3134),
     _3184=<_3134,
     _3134<_3190.

initiatedAt(internal_temperature(_3162,_3164)=_3140, _3182, _3134, _3188) :-
     happensAtIE(internal_temperature_change(_3162,_3164,_3140),_3134),
     _3182=<_3134,
     _3134<_3188.

initiatedAt(passenger_density(_3154,_3156)=_3142, _3186, _3136, _3192) :-
     happensAtIE(passenger_density_change(_3154,_3156,_3142),_3136),_3186=<_3136,_3136<_3192.

initiatedAt(noise_level(_3154,_3156)=_3142, _3186, _3136, _3192) :-
     happensAtIE(noise_level_change(_3154,_3156,_3142),_3136),_3186=<_3136,_3136<_3192.

holdsForSDFluent(punctuality(_3162,_3164)=non_punctual,_3134) :-
     holdsForProcessedSimpleFluent(_3162,punctuality(_3162,_3164)=punctual,_3182),
     complement_all([_3182],_3134).

holdsForSDFluent(driving_style(_3162,_3164)=unsafe,_3134) :-
     holdsForProcessedIE(_3162,sharp_turn(_3162,_3164)=very_sharp,_3182),
     holdsForProcessedIE(_3162,abrupt_acceleration(_3162,_3164)=very_abrupt,_3200),
     holdsForProcessedIE(_3162,abrupt_deceleration(_3162,_3164)=very_abrupt,_3218),
     union_all([_3182,_3200,_3218],_3134).

holdsForSDFluent(driving_style(_3162,_3164)=uncomfortable,_3134) :-
     holdsForProcessedIE(_3162,sharp_turn(_3162,_3164)=sharp,_3182),
     holdsForProcessedIE(_3162,abrupt_acceleration(_3162,_3164)=very_abrupt,_3200),
     holdsForProcessedIE(_3162,abrupt_deceleration(_3162,_3164)=very_abrupt,_3218),
     relative_complement_all(_3182,[_3200,_3218],_3238),
     holdsForProcessedIE(_3162,abrupt_acceleration(_3162,_3164)=abrupt,_3256),
     holdsForProcessedIE(_3162,abrupt_deceleration(_3162,_3164)=abrupt,_3274),
     union_all([_3238,_3256,_3274],_3134).

holdsForSDFluent(driving_quality(_3162,_3164)=high,_3134) :-
     holdsForProcessedSimpleFluent(_3162,punctuality(_3162,_3164)=punctual,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3218),
     relative_complement_all(_3182,[_3200,_3218],_3134).

holdsForSDFluent(driving_quality(_3162,_3164)=medium,_3134) :-
     holdsForProcessedSimpleFluent(_3162,punctuality(_3162,_3164)=punctual,_3182),
     \+_3182=[],
     !,
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3210),
     intersect_all([_3182,_3210],_3134).

holdsForSDFluent(driving_quality(_3156,_3158)=medium,[]).

holdsForSDFluent(driving_quality(_3162,_3164)=low,_3134) :-
     holdsForProcessedSDFluent(_3162,punctuality(_3162,_3164)=non_punctual,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     union_all([_3182,_3200],_3134).

holdsForSDFluent(passenger_comfort(_3162,_3164)=reducing,_3134) :-
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     holdsForProcessedSimpleFluent(_3162,passenger_density(_3162,_3164)=high,_3218),
     holdsForProcessedSimpleFluent(_3162,noise_level(_3162,_3164)=high,_3236),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_warm,_3254),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_cold,_3272),
     union_all([_3182,_3200,_3218,_3236,_3254,_3272],_3134).

holdsForSDFluent(driver_comfort(_3162,_3164)=reducing,_3134) :-
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     holdsForProcessedSimpleFluent(_3162,noise_level(_3162,_3164)=high,_3218),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_warm,_3236),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_cold,_3254),
     union_all([_3182,_3200,_3218,_3236,_3254],_3134).

holdsForSDFluent(passenger_satisfaction(_3162,_3164)=reducing,_3134) :-
     holdsForProcessedSDFluent(_3162,punctuality(_3162,_3164)=non_punctual,_3182),
     holdsForProcessedSDFluent(_3162,passenger_comfort(_3162,_3164)=reducing,_3200),
     union_all([_3182,_3200],_3134).

happensAtEv(punctuality_change(_3150,_3152,punctual),_3134) :-
     happensAtProcessedSDFluent(_3150,end(punctuality(_3150,_3152)=non_punctual),_3134).

happensAtEv(punctuality_change(_3150,_3152,non_punctual),_3134) :-
     happensAtProcessedSimpleFluent(_3150,end(punctuality(_3150,_3152)=punctual),_3134).

cachingOrder2(_3138, punctuality(_3138,_3140)=punctual) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, punctuality(_3138,_3140)=non_punctual) :-
     vehicle(_3138,_3140).

cachingOrder2(_3132, punctuality_change(_3132,_3134,punctual)) :-
     vehicle(_3132,_3134).

cachingOrder2(_3132, punctuality_change(_3132,_3134,non_punctual)) :-
     vehicle(_3132,_3134).

cachingOrder2(_3138, passenger_density(_3138,_3140)=high) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, noise_level(_3138,_3140)=high) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, internal_temperature(_3138,_3140)=very_warm) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, internal_temperature(_3138,_3140)=very_cold) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_style(_3138,_3140)=unsafe) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_style(_3138,_3140)=uncomfortable) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_quality(_3138,_3140)=high) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_quality(_3138,_3140)=medium) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_quality(_3138,_3140)=low) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, passenger_comfort(_3138,_3140)=reducing) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driver_comfort(_3138,_3140)=reducing) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, passenger_satisfaction(_3138,_3140)=reducing) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, abrupt_acceleration(_3138,_3140)=abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, abrupt_acceleration(_3138,_3140)=very_abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, abrupt_deceleration(_3138,_3140)=abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, abrupt_deceleration(_3138,_3140)=very_abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, sharp_turn(_3138,_3140)=sharp) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, sharp_turn(_3138,_3140)=very_sharp) :-
     vehicle(_3138,_3140).
