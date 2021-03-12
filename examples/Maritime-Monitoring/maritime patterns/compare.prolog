
% These are auxiliary predicates used in the maritime patterns

intDurGreater(If,V,I) :- 
	findall((S,E), (member((S,E), If),(( E\= inf, Diff is E - S, Diff > V);( E = inf))), I).

intDurLess(If,V,I) :- 
	findall((S,E), (member((S,E), If),( E\= inf, Diff is E - S, Diff < V)), I).

absoluteAngleDiff(An1,An2,C) :- 
	A is An1-An2, 
	A1 is A+180, 
	fmod(A1,360,FM), 
	C is abs(FM-180).

fmod(A,B,M) :- 
	Div is A/B,
	Fln is floor(Div) * B,
	M is A-Fln.

inRange(Var,Min,Max) :- 
	Var > Min,
	Var < Max.
