

/*********************************** AMALGAMATING PERIODS *************************************/

/********************************************************************************************** 
   If the last previous interval meets the first new interval then these intervals are united
   Otherwise new intervals are simply appended to previous intervals.
   We could have used union_all to perform this operation - however, when we are interested in 
   amalgamating one interval with a list of intervals the predicate is below is more efficient 
   than the more general union_all.
 **********************************************************************************************/

%amalgamatePeriods([], Periods, Periods) :- !.

%amalgamatePeriods(Periods, [], Periods) :- !.

%amalgamatePeriods([(OS,NS)], [(NS,NE)|TailNewPeriods], [(OS,NE)|TailNewPeriods]) :- !.

%amalgamatePeriods([(OS,ON)], [(NS,NE)|TailNewPeriods], [(OS,ON),(NS,NE)|TailNewPeriods]).

% In the case of allen relations, due to the caching of source/target intervals from the previous window, 
% An interval from the current window may overlap the broken period. For this reason, we use union.

amalgamatePeriods(Periods1, Periods2, Periods):- 
    union_all([Periods1, Periods2], Periods).




