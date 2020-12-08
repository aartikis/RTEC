

/*********************************** AMALGAMATING PERIODS *************************************/

/********************************************************************************************** 
   If the last previous interval meets the first new interval then these intervals are united
   Otherwise new intervals are simply appended to previous intervals.
   We could have used union_all to perform this operation - however, when we are interested in 
   amalgamating one interval with a list of intervals the predicate is below is more efficient 
   than the more general union_all.
 **********************************************************************************************/

amalgamatePeriods([], Periods, Periods) :- !.

amalgamatePeriods(Periods, [], Periods) :- !.

amalgamatePeriods([(OS,NS)], [(NS,NE)|TailNewPeriods], [(OS,NE)|TailNewPeriods]) :- !.

amalgamatePeriods([(OS,ON)], [(NS,NE)|TailNewPeriods], [(OS,ON),(NS,NE)|TailNewPeriods]).






