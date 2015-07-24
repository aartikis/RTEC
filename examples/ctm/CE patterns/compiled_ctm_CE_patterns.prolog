
:- ['../../../src/RTEC.prolog'].
:- ['ctm_declarations.prolog'].

initially(punctuality(_131445,_131446)=punctual).

initially(passenger_density(_131445,_131446)=low).

initially(noise_level(_131445,_131446)=low).

initially(internal_temperature(_131445,_131446)=normal).

initiatedAt(punctuality(_131136,_131137)=punctual, _, _131124, _) :-
     happensAtIE(stop_enter(_131136,_131137,_131144,scheduled),_131124).

initiatedAt(punctuality(_131136,_131137)=punctual, _, _131124, _) :-
     happensAtIE(stop_enter(_131136,_131137,_131144,early),_131124).

initiatedAt(punctuality(_131136,_131137)=non_punctual, _, _131124, _) :-
     happensAtIE(stop_enter(_131136,_131137,_131144,late),_131124).

initiatedAt(punctuality(_131136,_131137)=non_punctual, _, _131124, _) :-
     happensAtIE(stop_leave(_131136,_131137,_131144,early),_131124).

initiatedAt(passenger_density(_131128,_131129)=_131130, _, _131125, _) :-
     happensAtIE(passenger_density_change(_131128,_131129,_131130),_131125).

initiatedAt(noise_level(_131128,_131129)=_131130, _, _131125, _) :-
     happensAtIE(noise_level_change(_131128,_131129,_131130),_131125).

initiatedAt(internal_temperature(_131128,_131129)=_131130, _, _131125, _) :-
     happensAtIE(internal_temperature_change(_131128,_131129,_131130),_131125).

holdsForSDFluent(punctuality(_131139,_131140)=non_punctual,_131124) :-
     holdsForProcessedSimpleFluent(_131139,punctuality(_131139,_131140)=punctual,_131146),
     complement_all([_131146],_131124).

holdsForSDFluent(driving_style(_131139,_131140)=unsafe,_131124) :-
     holdsForProcessedIE(_131139,sharp_turn(_131139,_131140)=very_sharp,_131146),
     holdsForProcessedIE(_131139,abrupt_acceleration(_131139,_131140)=very_abrupt,_131158),
     holdsForProcessedIE(_131139,abrupt_deceleration(_131139,_131140)=very_abrupt,_131170),
     union_all([_131146,_131158,_131170],_131124).

holdsForSDFluent(driving_style(_131139,_131140)=uncomfortable,_131124) :-
     holdsForProcessedIE(_131139,sharp_turn(_131139,_131140)=sharp,_131146),
     holdsForProcessedIE(_131139,abrupt_acceleration(_131139,_131140)=very_abrupt,_131158),
     holdsForProcessedIE(_131139,abrupt_deceleration(_131139,_131140)=very_abrupt,_131170),
     relative_complement_all(_131146,[_131158,_131170],_131183),
     holdsForProcessedIE(_131139,abrupt_acceleration(_131139,_131140)=abrupt,_131193),
     holdsForProcessedIE(_131139,abrupt_deceleration(_131139,_131140)=abrupt,_131205),
     union_all([_131183,_131193,_131205],_131124).

holdsForSDFluent(driving_quality(_131139,_131140)=high,_131124) :-
     holdsForProcessedSimpleFluent(_131139,punctuality(_131139,_131140)=punctual,_131146),
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=unsafe,_131158),
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=uncomfortable,_131170),
     relative_complement_all(_131146,[_131158,_131170],_131124).

holdsForSDFluent(driving_quality(_131139,_131140)=medium,_131124) :-
     holdsForProcessedSimpleFluent(_131139,punctuality(_131139,_131140)=punctual,_131146),
     \+_131146=[],
     !,
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=uncomfortable,_131169),
     intersect_all([_131146,_131169],_131124).

holdsForSDFluent(driving_quality(_131130,_131131)=medium,[]).

holdsForSDFluent(driving_quality(_131139,_131140)=low,_131124) :-
     holdsForProcessedSDFluent(_131139,punctuality(_131139,_131140)=non_punctual,_131146),
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=unsafe,_131158),
     union_all([_131146,_131158],_131124).

holdsForSDFluent(passenger_comfort(_131139,_131140)=reducing,_131124) :-
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=uncomfortable,_131146),
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=unsafe,_131158),
     holdsForProcessedSimpleFluent(_131139,passenger_density(_131139,_131140)=high,_131170),
     holdsForProcessedSimpleFluent(_131139,noise_level(_131139,_131140)=high,_131182),
     holdsForProcessedSimpleFluent(_131139,internal_temperature(_131139,_131140)=very_warm,_131194),
     holdsForProcessedSimpleFluent(_131139,internal_temperature(_131139,_131140)=very_cold,_131206),
     union_all([_131146,_131158,_131170,_131182,_131194,_131206],_131124).

holdsForSDFluent(driver_comfort(_131139,_131140)=reducing,_131124) :-
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=uncomfortable,_131146),
     holdsForProcessedSDFluent(_131139,driving_style(_131139,_131140)=unsafe,_131158),
     holdsForProcessedSimpleFluent(_131139,noise_level(_131139,_131140)=high,_131170),
     holdsForProcessedSimpleFluent(_131139,internal_temperature(_131139,_131140)=very_warm,_131182),
     holdsForProcessedSimpleFluent(_131139,internal_temperature(_131139,_131140)=very_cold,_131194),
     union_all([_131146,_131158,_131170,_131182,_131194],_131124).

holdsForSDFluent(passenger_satisfaction(_131139,_131140)=reducing,_131124) :-
     holdsForProcessedSDFluent(_131139,punctuality(_131139,_131140)=non_punctual,_131146),
     holdsForProcessedSDFluent(_131139,passenger_comfort(_131139,_131140)=reducing,_131158),
     union_all([_131146,_131158],_131124).

happensAtEv(punctuality_change(_131133,_131134,punctual),_131124) :-
     happensAtProcessedSDFluent(_131133,end(punctuality(_131133,_131134)=non_punctual),_131124).

happensAtEv(punctuality_change(_131133,_131134,non_punctual),_131124) :-
     happensAtProcessedSimpleFluent(_131133,end(punctuality(_131133,_131134)=punctual),_131124).

cachingOrder2(_131123, punctuality(_131123,_131124)=punctual) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, punctuality(_131123,_131124)=non_punctual) :-
     vehicle(_131123,_131124).

cachingOrder2(_131120, punctuality_change(_131120,_131121,punctual)) :-
     vehicle(_131120,_131121).

cachingOrder2(_131120, punctuality_change(_131120,_131121,non_punctual)) :-
     vehicle(_131120,_131121).

cachingOrder2(_131123, passenger_density(_131123,_131124)=high) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, noise_level(_131123,_131124)=high) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, internal_temperature(_131123,_131124)=very_warm) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, internal_temperature(_131123,_131124)=very_cold) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_style(_131123,_131124)=unsafe) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_style(_131123,_131124)=uncomfortable) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_quality(_131123,_131124)=high) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_quality(_131123,_131124)=medium) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driving_quality(_131123,_131124)=low) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, passenger_comfort(_131123,_131124)=reducing) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, driver_comfort(_131123,_131124)=reducing) :-
     vehicle(_131123,_131124).

cachingOrder2(_131123, passenger_satisfaction(_131123,_131124)=reducing) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_acceleration(_131123,_131124)=abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_acceleration(_131123,_131124)=very_abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_deceleration(_131123,_131124)=abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, abrupt_deceleration(_131123,_131124)=very_abrupt) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, sharp_turn(_131123,_131124)=sharp) :-
     vehicle(_131123,_131124).

collectIntervals2(_131123, sharp_turn(_131123,_131124)=very_sharp) :-
     vehicle(_131123,_131124).

