
/************************************************
 *		  DISTANCE			*
 ************************************************/

%%%%% NOTE: we only compute the intervals of the distance fluent in (Qi-WM,Qi]
%%%%% This is OK for the CAVIAR event description
%%%%% A proper treatment of this fluent additionally requires the computation
%%%%% of the last interval before (Qi-WM,Qi]

preProcessing(QueryTime) :-
	findall((Id1,Id2,Threshold), 
		(
			iePList(Id1, distance(Id1,Id2,Threshold)=true, _, _), 
			retract(iePList(Id1, distance(Id1,Id2,Threshold)=true, _, _))), 
		_),
	% for each pair of tracked entities ...
	findall((Id1,Id2), (id_pair(Id1,Id2), aux1(Id1,Id2,QueryTime)), _).

% ... compute their distance at each time-point
aux1(Id1, Id2, QueryTime) :-
	findall((T,Dist), h(distance(Id1,Id2,Dist)=true, T), DistList),
	% ... and for each known threshold value ... 	
	findall(Threshold, (threshold(_,Threshold), aux2(Threshold,DistList,QueryTime,Id1,Id2)), _).

% ... compute the maximal intervals for which distance is less than the threshold 
aux2(Threshold, List, QueryTime, Id1, Id2) :-
	setof(T, member((T,Threshold),List), PointList), !,
	% below 40 represents the temporal distance between two consecutive time-points
	makeIntervalsFromAllPoints(PointList, 40, QueryTime, [], L),
	assertz(iePList(Id1, distance(Id1,Id2,Threshold)=true, L, [])).

% do not assert empty list of distance intervals
aux2(_Threshold, _List, _QueryTime, _Id1, _Id2).

id_pair(Id1, Id2):-
	id(Id1), id(Id2), Id1@<Id2.

symmetric_id_pair(Id1, Id2):-
	id(Id1), id(Id2), Id2@<Id1.

% Application-dependent threshold distances
% IMPORTANT: the facts below must be ordered by threshold and there should be no duplicates

threshold(fight, 24).
threshold(interact, 25).
threshold(leave, 30).
threshold(meet_move, 34).


h(distance(Id1,Id2,Dist)=true, T) :-
	holdsAtIE(coord(Id1,X1,Y1)=true, T),
	holdsAtIE(coord(Id2,X2,Y2)=true, T),
	XDiff is abs(X1-X2),
	YDiff is abs(Y1-Y2),
	SideA is XDiff*XDiff,
	SideB is YDiff*YDiff,
	Temp is SideA+SideB,
	D is sqrt(Temp),
	compareWithDistanceThresholds(D, Dist).


compareWithDistanceThresholds(D, Threshold) :- 
	threshold(_, Threshold),  	
	D=<Threshold, !.

% NOTE: if the distance between two tracked entities is greater than the highest threshold
% then we do not need to store it (the distance)




