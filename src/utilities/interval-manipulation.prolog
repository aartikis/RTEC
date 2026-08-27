
/*
Alexander Artikis
*/


/******************* Main predicate for union *******************/


union_all([], []) :- !.

union_all([H|Tail], Union) :-
	union2(H, Tail, Union).


union2(List, [], List) :- !.

union2(List, [H|Tail], FinalUnion) :-
	iset_union(List, H, TempUnion),
	union2(TempUnion, Tail, FinalUnion).


/******************* Main predicate for intersection *******************/


intersect_all(List, []) :- 
	member([], List), !.

intersect_all([], []) :- !.

intersect_all([H|Tail], Intersection) :-
	intersect(H, Tail, Intersection).


intersect(List, [], List) :- !.

intersect(List, [H|Tail], FinalIntersection) :-
	iset_intersection(List, H, TempIntersection),
	intersect(TempIntersection, Tail, FinalIntersection).


/******************* Main predicate for relative complement *******************/


relative_complement_all(List, [], List) :- !.

relative_complement_all([], _List, []) :- !.

relative_complement_all(List, [H|Tail], FinalComplement) :-
	iset_difference(List, H, TempComplement),
	relative_complement_all(TempComplement, Tail, FinalComplement).


/******************* Main predicate for complement *******************/

% complement is defined in terms of relative complement
% given the list of lists of intervals List 
% we compute the list of intervals NewI 
% such that  union_all([NewI|List], WM)  and  intersect_all([NewI|List], [])
complement_all(List, NewI) :-
	% retrieve InitTime from computer memory
	initTime(InitTime),
	(
		InitTime<0, NewInitTime is 0 
		;
		nextTimePoint(InitTime, NewInitTime)
	), !,
	% the intervals of this value of the fluent are simply computed by relative_complement_all
	relative_complement_all([(NewInitTime,inf)], List, NewI).


/************* Min-Max *********************/


max(X,Y,Y) :- geq(Y, X), !.
max(X,Y,X) :- geq(X, Y), !.
max(_X,inf,inf) :- !.
max(inf, _X, inf).

min(X,Y,Y) :- geq(X, Y), !.
min(X,Y,X) :- geq(Y, X), !. 
min(X,inf,X) :- !.
min(inf,X,X).


gt(_X,inf) :- !, fail.
gt(inf,_Y) :- !.
gt(X,Y) :- X>Y.
%%% gt(X,Y) :- \+(Y=inf), X>Y.

geq(_X,inf) :- !, fail.
geq(inf,_Y) :- !.
geq(X,Y) :- X>=Y.

lt(inf,_Y) :- !, fail.
lt(_X, inf) :- !.
lt(X,Y) :- X<Y.

leq(inf,_Y) :- !, fail.
leq(_X, inf) :- !.
leq(X,Y) :- X=<Y.

/*
geq(inf,_Y) :- !.
geq(X,Y) :- \+(Y=inf), X>=Y.

lt(_X, inf) :- !.
lt(X,Y) :- \+(X=inf), X<Y.

leq(_X, inf) :- !.
leq(X,Y) :- \+(X=inf), X=<Y.
*/


/************* next & previous time-point *********************/

% the next and previous time-points are defined based on 
% the temporal distance between two time-points

nextTimePoint(inf, inf) :- !.
nextTimePoint(T, NextT) :-
	temporalDistance(TD),
	NextT is T+TD-(T mod TD). 

prevTimePoint(inf, inf) :- !.
prevTimePoint(T, PrevT) :-
	temporalDistance(TD),
	% test if T is a 'legal' time-point
	Temp is T mod TD, Temp=0, !,
	PrevT is T-TD. 
prevTimePoint(T, PrevT) :-
	temporalDistance(TD),
	PrevT is T-(T mod TD).


/************* Interval Library *********************/
/* 
The code below is a slightly modified version of intervals.pl from Carnegie Mellon.
Intervals are represented as (S,E) as opposed to S--E
(S,E) now means [S,E) as opposed to [S,E]
*/

iset_intersection( _A, [], [] ) :- !.

iset_intersection( [], _B, [] ) :- !.

iset_intersection( [(A11,A12)|A2_n], [(B11,B12)|B2_n], IRest ) :-
    interval_is_less( [A11,A12], [B11,B12] ),
    iset_intersection( A2_n, [(B11,B12)|B2_n], IRest ), !.

iset_intersection( [(A11,A12)|A2_n], [(B11,B12)|B2_n], IRest ) :-
    interval_is_less( [B11,B12], [A11,A12] ),
    iset_intersection( [(A11,A12)|A2_n], B2_n, IRest ), !.

iset_intersection( [(A11,A12)|A2_n], [(B11,B12)|B2_n], [(I11,I12)|IRest] ) :-
    interval_intersection( [A11,A12], [B11,B12], [I11,I12] ),
    drop_lowest( [(A11,A12)|A2_n], [(B11,B12)|B2_n], A_Rest, B_Rest ),
    iset_intersection( A_Rest, B_Rest, IRest ).


interval_is_less( [_L1,U1], [L2,_U2] ) :-
    % U1 < L2, 
    leq(U1, L2), 
    !.


interval_intersection( [L1,U1], [L2,U2], [L3,U3] ) :-
    localmax( L1, L2, L3 ),
    localmin( U1, U2, U3 ).


drop_lowest( [I|A2_n], [I|B2_n], A2_n, B2_n ) :- !.

drop_lowest( [(A11,A12)|A2_n], [(B11,B12)|B2_n], A2_n, [(B11,B12)|B2_n] ) :-
    interval_ends_first( [A11,A12], [B11,B12] ), !.

drop_lowest( A, [_B1|B2_n], A, B2_n ).


localmax( A, B, A ) :- gt(A, B), !.
localmax( _A, B, B ).

localmin( A, B, A ) :- lt(A, B), !.
localmin( _A, B, B ).

interval_ends_first( [_,U1], [_,U2] ) :-
    %U1 < U2, 
    lt(U1, U2),
    !.





iset_difference( A, [], A ) :- !.

iset_difference( [], _B, [] ) :- !.

iset_difference( [(A11,A12)|A2_n], [(B11,B12)|B2_n], [(A11,A12)|DRest] ) :-
    interval_is_less( [A11,A12], [B11,B12] ),
    iset_difference( A2_n, [(B11,B12)|B2_n], DRest ), !.

iset_difference( [(A11,A12)|A2_n], [(B11,B12)|B2_n], DRest ) :-
    interval_is_less( [B11,B12], [A11,A12] ),
    iset_difference( [(A11,A12)|A2_n], B2_n, DRest ), !.
/*
iset_difference( [(A1_low,A1_high)|A2_n], [(B1_low,B1_high)|B2_n],
                 [(A1_low,B1_low_less_1) | D_Rest ]  ) :-
    % A1_low < B1_low,
    lt(A1_low, B1_low),
    !,
    B1_low_less_1 is B1_low - 1,
    iset_difference( [ (B1_low,A1_high) | A2_n ],
                     [ (B1_low,B1_high) | B2_n ],
                     D_Rest ), !.
*/
iset_difference( [(A1_low,A1_high)|A2_n], [(B1_low,B1_high)|B2_n],
                 [(A1_low,B1_low) | D_Rest ]  ) :-
    % A1_low < B1_low,
    lt(A1_low, B1_low),
    !,
    %%% B1_low_less_1 is B1_low - 1,
    iset_difference( [ (B1_low,A1_high) | A2_n ],
                     [ (B1_low,B1_high) | B2_n ],
                     D_Rest ), !.

iset_difference( [(_A1_low,High)|A2_n], [(_B1_low,High)|B2_n], D ) :-
    iset_difference( A2_n, B2_n, D ), !.
/*
iset_difference( [(A1_low,A1_high)|A2_n], [(B1_low,B1_high)|B2_n], D ) :-
    %A1_high > B1_high,
    gt(A1_high, B1_high),
    !,
    B1_high_add_1 is B1_high + 1,
    iset_difference( [ (B1_high_add_1,A1_high) | A2_n ], B2_n, D ), !.

iset_difference( [(A1_low,A1_high)|A2_n], [(B1_low,B1_high)|B2_n], D ) :-
    %A1_high < B1_high,
    lt(A1_high, B1_high),
    !,
    A1_high_add_1 is A1_high + 1,
    iset_difference( A2_n, [ (A1_high_add_1,B1_high) | B2_n ], D ), !.
*/
iset_difference( [(_A1_low,A1_high)|A2_n], [(_B1_low,B1_high)|B2_n], D ) :-
    %A1_high > B1_high,
    gt(A1_high, B1_high),
    !,
    %%% B1_high_add_1 is B1_high + 1,
    iset_difference( [ (B1_high,A1_high) | A2_n ], B2_n, D ), !.

iset_difference( [(_A1_low,A1_high)|A2_n], [(_B1_low,B1_high)|B2_n], D ) :-
    %A1_high < B1_high,
    lt(A1_high, B1_high),
    !,
    %%% A1_high_add_1 is A1_high + 1,
    iset_difference( A2_n, [ (A1_high,B1_high) | B2_n ], D ), !.





iset_union( A, [], A ) :- !.

iset_union( [], B, B ) :- !.

iset_union( [(A11,A12)|A2_n], [(B11,B12)|B2_n], [(B11,B12)|URest] ) :-
    interval_is_less_and_not_coalescable( [B11,B12], [A11,A12] ),
    iset_union( [(A11,A12)|A2_n], B2_n, URest ), !.

iset_union( [(A11,A12)|A2_n], [(B11,B12)|B2_n], [(A11,A12)|URest] ) :-
    interval_is_less_and_not_coalescable( [A11,A12], [B11,B12] ),
    iset_union( A2_n, [(B11,B12)|B2_n], URest ), !.

iset_union( [(A11,A12)|A2_n], [(B11,B12)|B2_n], U ) :-
    /*  A1 overlaps B1  */
    interval_union( [A11,A12], [B11,B12], [U11,U12] ),
    union_overlap( [U11,U12], A2_n, B2_n, U ).


interval_is_less_and_not_coalescable( [_L1,U1], [L2,_U2] ) :-
    %%% L2_less_1 is L2-1,
    %U1 < L2_less_1, 
    %%% lt(U1, L2_less_1),
    lt(U1, L2),
    !.


intervals_are_not_coalescable( I1, I2 ) :-
    interval_is_less_and_not_coalescable( I1, I2 ), !.

intervals_are_not_coalescable( I1, I2 ) :-
    interval_is_less_and_not_coalescable( I2, I1 ), !.


intervals_are_coalescable( I1, I2 ) :-
    not( intervals_are_not_coalescable( I1, I2 ) ).


interval_union( [L1,U1], [L2,U2], [L3,U3] ) :-
    localmin( L1, L2, L3 ),
    localmax( U1, U2, U3 ).


union_overlap( [U11,U12], [(A11,A12)|A2_n], B, URest ) :-
    intervals_are_coalescable( [U11,U12], [A11,A12] ),
    interval_union( [U11,U12], [A11,A12], J ),
    union_overlap( J, A2_n, B, URest ), !.

union_overlap( [U11,U12], A, [(B11,B12)|B2_n], URest ) :-
    intervals_are_coalescable( [U11,U12], [B11,B12] ),
    interval_union( [U11,U12], [B11,B12], J ),
    union_overlap( J, A, B2_n, URest ), !.

union_overlap( [U11,U12], A, B, [(U11,U12)|URest] ) :-
    iset_union( A, B, URest ), !.





/********* THE PREDICATES BELOW ARE OBSOLETE *************/

/*
Convert a list of lists of intervals [[(S11,E11), (S12,E12), ...], [(S21, E21), (S22, E22), ...], ...]
to a list of lists of intervals [[S11--E11, S12--E12, ...], [S21--E21, S22--E22, ...], ...] 
The latter representation is used in the file intervals.pl

convertToDDashAll( +List, -List, [] )
*/
/*
convertToDDashAll( [], OL, OL ) :- !.

convertToDDashAll( IL, CIL, Aux ) :-
  IL=[H|Tail],
  convertToDDash( H, CH, [] ),
  append( Aux, [CH], NewAux ),
  convertToDDashAll( Tail, CIL, NewAux ).

:- op( 31, xfx, -- ).
*/
/*
Convert a list of intervals [(S1, E1), (S2, E2), ...]
to a list of intervals [S1--E1, S2--E2, ...]
The latter representation is used in the file intervals.pl

convertToDDash( +List, -List, [] )
*/
/*
convertToDDash( [], OL, OL ) :- !.
	
convertToDDash( IL, OL, Aux ) :- 
  IL=[(S,E)|Tail],
  \+ E = inf, 
  !,
  NewE is E-1,
  append( Aux, [S--NewE], NewAux ),
  convertToDDash( Tail, OL, NewAux ).

convertToDDash( IL, OL, Aux ) :- 
  IL=[(S,inf)|Tail],
  append( Aux, [S--inf], NewAux ),
  convertToDDash( Tail, OL, NewAux ).
*/



/*
Convert a list of intervals [S1--E1, S2--E2, ...]
to a list of intervals [(S1, E1), (S2, E2), ...]

revertToSE( +List, -List, [] )
*/
/*
revertToSE( [], OL, OL ) :- !.

revertToSE( IL, OL, Aux ) :- 
  IL=[H|Tail],
  H=S--E,
  \+ E = inf, 
  !,
  NewE is E+1,
  append( Aux, [(S, NewE)], NewAux ),
  revertToSE( Tail, OL, NewAux ).

revertToSE( IL, OL, Aux ) :- 
  IL=[H|Tail],
  H=S--inf,
  append( Aux, [(S, inf)], NewAux ),
  revertToSE( Tail, OL, NewAux ).
*/
