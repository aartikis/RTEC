
% These are auxiliary predicates used in the maritime patterns

% intDurGreater(+If,+V,-I)
% Finds the maximal intervals of list <If> whose duration is greater than <V> and stores them in list <I>
% If (S,E) is an open interval, i.e., E=inf, then we measure the distance between S and the current query time QT,
% and store (S,inf) in I if QT-S>D.
intDurGreater(If,V,I) :- 
		findall((S,E), (member((S,E), If),(E \= inf -> (Diff is E - S, Diff > V); (queryTime(QT), Diff is QT - S, Diff > V ))), I).

% intDurLess(+If,+V,-I)
% Finds the maximal intervals of list <If> whose duration is less than <V> and stores them in list <I>
intDurLess(If,V,I) :- 
	findall((S,E), (member((S,E), If),( E\= inf, Diff is E - S, Diff < V)), I).

%absoluteAngleDiff(+An1,+An2,-C)
% <C> is the difference of angles An1 and An2, measured between An1 and An2.
absoluteAngleDiff(An1,An2,C) :- 
	A is An1-An2, 
	A1 is A+180, 
	fmod(A1,360,FM), 
	C is abs(FM-180).

%fmod(+A,+B,-M)
% <M> is the modulo of A/B.
fmod(A,B,M) :- 
	Div is A/B,
	Fln is floor(Div) * B,
	M is A-Fln.

%inRange(+Var,+Min,+Max)
%<Var> is between <Min> and <Max>
inRange(Var,Min,Max) :- 
	Var > Min,
	Var < Max.
