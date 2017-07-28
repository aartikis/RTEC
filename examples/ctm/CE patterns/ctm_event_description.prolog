initially(punctuality(_,_)=punctual).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,scheduled), T).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,early), T).

terminatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,late), T).

terminatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_leave(Id,VehicleType,_,early), T).

holdsFor(punctuality(Id,VehicleType)=non_punctual, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I11),
	complement_all([I11],I).

happensAt(punctuality_change(Id,VehicleType,punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=non_punctual), T).

happensAt(punctuality_change(Id,VehicleType,non_punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=punctual), T).

holdsFor(driving_style(Id,VehicleType)=unsafe, I) :-
	holdsFor(sharp_turn(Id,VehicleType)=very_sharp,I2),
	holdsFor(abrupt_acceleration(Id,VehicleType)=very_abrupt,I4),
	holdsFor(abrupt_deceleration(Id,VehicleType)=very_abrupt,I7),
	union_all([I4,I7,I2],I).

holdsFor(driving_style(Id,VehicleType)=uncomfortable, I) :-
	holdsFor(sharp_turn(Id,VehicleType)=sharp,I71),
	holdsFor(abrupt_acceleration(Id,VehicleType)=very_abrupt,I131),
	holdsFor(abrupt_deceleration(Id,VehicleType)=very_abrupt,I134),
	union_all([I131,I134],I135),
	relative_complement_all(I71,[I135],I137),
	holdsFor(abrupt_acceleration(Id,VehicleType)=abrupt,I139),
	holdsFor(abrupt_deceleration(Id,VehicleType)=abrupt,I142),
	union_all([I139,I142,I137],I).

holdsFor(driving_quality(Id,VehicleType)=high, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I1),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I61),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I64),
	union_all([I61,I64],I65),
	relative_complement_all(I1,[I65],I).

holdsFor(driving_quality(Id,VehicleType)=medium, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I1),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I4),
	intersect_all([I1,I4],I).

holdsFor(driving_quality(Id,VehicleType)=low, I) :-
	holdsFor(punctuality(Id,VehicleType)=non_punctual,I2),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I5),
	union_all([I2,I5],I).

holdsFor(passenger_comfort(Id,VehicleType)=reducing, I) :-
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I2),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I4),
	holdsFor(passenger_density(Id,VehicleType)=high,I6),
	holdsFor(noise_level(Id,VehicleType)=high,I8),
	holdsFor(internal_temperature(Id,VehicleType)=very_warm,I10),
	holdsFor(internal_temperature(Id,VehicleType)=very_cold,I13),
	union_all([I10,I13,I8,I6,I4,I2],I).

initially(passenger_density(_,_)=low).

initiatedAt(passenger_density(Id,VehicleType)=Value, T) :-
	happensAt(passenger_density_change(Id,VehicleType,Value), T).

initially(noise_level(_,_)=low).

initiatedAt(noise_level(Id,VehicleType)=Value, T) :-
	happensAt(noise_level_change(Id,VehicleType,Value), T).

initially(internal_temperature(_,_)=normal).

initiatedAt(internal_temperature(Id,VehicleType)=Value, T) :-
	happensAt(internal_temperature_change(Id,VehicleType,Value), T).

holdsFor(driver_comfort(Id,VehicleType)=reducing, I) :-
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I2),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I4),
	holdsFor(noise_level(Id,VehicleType)=high,I6),
	holdsFor(internal_temperature(Id,VehicleType)=very_warm,I8),
	holdsFor(internal_temperature(Id,VehicleType)=very_cold,I11),
	union_all([I8,I11,I6,I4,I2],I).

holdsFor(passenger_satisfaction(Id,VehicleType)=reducing, I) :-
	holdsFor(punctuality(Id,VehicleType)=non_punctual,I2),
	holdsFor(passenger_comfort(Id,VehicleType)=reducing,I5),
	union_all([I2,I5],I).

