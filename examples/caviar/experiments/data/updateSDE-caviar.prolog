

% updateSDE(+Start, +End)
% In this application, we load SDE from two files: 'movement' and 'appearance'

updateSDE(Start, End) :-
	%findall(Start, updateSDE(movement, Start, End), _),
	%findall(Start, updateSDE(appearance, Start, End), _),
	updateSDE(movement, Start, End),
	updateSDE(appearance, Start, End).

