
% In this application, the data are in several files, 
% as indicated by the first argument of updateSDE/4 below

% '1p_all' is an application-specific flag

updateSDE(Start, End) :-
	updateSDE(abrupt_acceleration, '1p_all', Start, End),
	updateSDE(abrupt_deceleration, '1p_all', Start, End),
	updateSDE(sharp_turn, '1p_all', Start, End),
	updateSDE(internal_temperature_change, '1p_all', Start, End),
	updateSDE(noise_level_change, '1p_all', Start, End),
	updateSDE(passenger_density_change, '1p_all', Start, End),
	updateSDE(stop_enter_leave, '1p_all', Start, End).
