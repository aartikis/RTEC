:- use_module(library(plunit)).

:- ['../../src/utilities/allen.prolog'].
nextTimePoint(T, TNext):-
	TNext is T + 1.	

prevTimePoint(T, TPrev):-
	TPrev is T - 1.

:- begin_tests(test).

%% Tests for computing all interval relations between two sorted lists of maximal intervals %%%
%% all %%
test(1):-
	allen_relations([(5,11)], 
	[(1,4),(4,6),(10,18),(18,20)],
	meets, 
	[ [ (5,11), [(10,18)]] ]).

test(2):-
	allen_relations([(5,11)], 
	[(1,4),(4,6),(10,18),(18,20)],
	before, 
	[ [ (5,11), [(18,20)] ] ]
	).

test(3):-
	allen_relations(
	[(5,11)], 
	[(1,3),(3,5),(5,6),(6,8),(8,11),(12,17),(18,19)],
	before, 
	[ [ (5,11), [(12,17), (18,19)] ] ]
	).

test(4):-
	allen_relations(
	[(5,11)], 
	[(1,3),(3,5),(5,6),(6,8),(8,17),(18,19)],
	overlaps, 
	[ [ (5,11), [(8,17)]]]
	).

test(5):-
	allen_relations(
	[(5,11)], 
	[(1,3),(3,5),(5,6),(6,8),(8,17),(18,19)],
	before, 
	[ [ (5,11), [(18,19)] ] ]
	).

test(6):-
	allen_relations(
	[(5,11)], 
	[(5,11)],
	equal, 
	[ [ (5,11), [(5,11)] ] ]
	).

test(7):-
	allen_relations(
	[(5,11)], 
	[(5,inf)],
	starts, 
	[ [ (5,11), [(5,inf)] ] ]
	).

test(8):-
	allen_relations(
	[(5,11)], 
	[(1,11)],
	finishes, 
	[ [ (5,11), [(1,11)] ] ]
	).

test(9):-
	allen_relations(
	[(5,11)], 
	[(3,21)],
	during, 
	[ [ (5,11), [(3,21)] ] ]
	).

test(10):-
	allen_relations(
	[(5,10), (20,25)], 
	[(11,15), (30,40)],
	before, 
	[ [ (5,10), [(11,15), (30,40)]], 
	  [ (20,25), [(30,40)] ]
	]
	).

test(11):-
	allen_relations(
	[(5,10), (20,25)], 
	[(9,15), (24,40)],
	meets, 
	[ [ (5,10), [(9,15)]], 
	  [ (20,25), [(24,40)]]
	]
	).

test(12):-
	allen_relations(
	[(5,10), (20,25)], 
	[(9,15), (24,40)],
	before, 
	[ [ (5,10), [(24,40)] ] 
	]
	).

test(13):-
	allen_relations(
	[(5,10), (20,25)], 
	[(5,10), (11,15), (20,25), (30,40)],
	equal, 
	[ [ (5,10), [(5,10)]], 
	  [ (20,25), [(20,25)]]
	]
	).

test(14):-
	allen_relations(
	[(5,10), (20,25)], 
	[(5,10), (11,15), (20,25), (30,40)],
	before, 
	[ [ (5,10), [(11,15), (20,25), (30,40)]], 
	  [ (20,25), [(30,40)]]	
	]
	).

test(15):-
	allen_relations(
	[(5,10), (15,17)], 
	[(1,3),(5,10),(12,17),(19,20)],
	equal, 
	[ [ (5,10), [(5,10)]]
	]
	).

test(16):-
	allen_relations(
	[(5,10), (15,17)], 
	[(1,3),(5,10),(12,17),(19,20)],
	finishes, 
	[ 
	  [ (15,17), [(12,17)]]
	]
	).

test(17):-
	allen_relations(
	[(5,10), (15,17)], 
	[(1,3),(5,10),(12,17),(19,20)],
	before, 
	[ [ (5,10), [(12,17), (19,20)] ], 
	  [ (15,17), [(19,20)] ]
	]
	).

test(18):-
	allen_relations(
	[(5,inf)], 
	[(1,2), (4,6), (10,100), (101,102), (1000, inf)],
	before, 
	[] % in all nesting levels, we append elements on demand, not maintaing redundant empty lists
	%[ [ (5,inf), [] ] ]
	).

test(19):-
	allen_relations(
	[(5,inf)], 
	[(1,2), (4,6), (10,100), (101,102), (1000, inf)],
	overlaps, 
	[] % in all nesting levels, we append elements on demand, not maintaing redundant empty lists
	%[ [ (5,inf), [] ] ]
	).

test(20):-
	allen_relations(
	[(1,2), (5,12), (25,30), (42,48), (52,90), (92,96), (100,inf)],
	[(1,3), (6,14), (24,31), (40,48), (52,90), (95, inf)],
	starts, 
	[ [ (1,2), [(1,3)]]
	]
	).

test(21):-
	allen_relations(
	[(1,2), (5,12), (25,30), (42,48), (52,90), (92,96), (100,inf)],
	[(1,3), (6,14), (24,31), (40,48), (52,90), (95, inf)],
	overlaps, 
	[ 
	  [ (5,12), [(6,14)]]
	]
	).

test(22):-
	allen_relations(
	[(1,2), (5,12), (25,30), (42,48), (52,90), (92,96), (100,inf)],
	[(1,3), (6,14), (24,31), (40,48), (52,90), (95, inf)],
	during, 
	[ 
	  [ (25,30), [(24,31)]]
	]
	).

test(23):-
	allen_relations(
	[(1,2), (5,12), (25,30), (42,48), (52,90), (92,96), (100,inf)],
	[(1,3), (6,14), (24,31), (40,48), (52,90), (95, inf)],
	finishes, 
	[ 
	  [ (42,48), [(40,48)]]
	]
	).

test(24):-
	allen_relations(
	[(1,2), (5,12), (25,30), (42,48), (52,90), (92,96), (100,inf)],
	[(1,3), (6,14), (24,31), (40,48), (52,90), (95, inf)],
	meets, 
	[ 
	  [ (92,96), [(95,inf)]] 
	]
	).

test(25):-
	allen_relations(
	[(1,2), (5,12), (25,30), (42,48), (52,90), (92,96), (100,inf)],
	[(1,3), (6,14), (24,31), (40,48), (52,90), (95, inf)],
	before, 
	[ [ (1,2), [(6,14), (24,31), (40,48), (52,90), (95,inf)]], 
	  [ (5,12), [(24,31), (40,48), (52,90), (95,inf)]],
	  [ (25,30), [(40,48), (52,90), (95,inf)]],
	  [ (42,48), [(52,90), (95,inf)]]
	]
	).

%%% specific relations %%%

test(50):-
	allen_relations(
	[(1,3),(5,8)],
	[(3,8)],
	finishes,
	[ [ (5,8), [(3,8)]]
	]
	).

test(51):-
	allen_relations(
	[(1,3),(5,8)],
	[(2,8)],
	meets,
	[ [ (1,3), [(2,8)]]
	]
	).

test(52):-
	allen_relations(
	[(1,3),(5,8)],
	[(1,8)],
	starts,
	[ [ (1,3), [(1,8)]]
	]
	).

test(53):-
	allen_relations(
	[(1,4),(6,8)],
	[(10,12)],
	before,
	[ [ (1,4), [(10,12)]],
	  [ (6,8), [(10,12)]]
	]
	).

test(54):-
	allen_relations(
	[(1,5),(6,8)],
	[(3,12)],
	overlaps,
	[ [ (1,5), [(3,12)]]
	]
	).

test(55):-
	allen_relations(
	[(1,3),(6,8),(12,18),(22,25),(30,32),(38, 44), (46, 54)],
	[(2,3),(5,12),(14,19),(21,40), (42, 55)],
	during,
	[ [ (6,8), [(5,12)]],
	  [ (22,25), [(21,40)]],
	  [ (30,32), [(21,40)]],
	  [ (46,54), [(42,55)]]
	]
	).

test(56):-
	allen_relations(
	[(1,3),(6,8),(12,18),(22,25),(30,32),(38, 44), (46, 54)],
	[(1,3),(5,12),(12,18),(21,40), (46, 54)],
	equal,
	[ [ (1,3), [(1,3)]],
	  [ (12,18), [(12,18)]],
	  [ (46,54), [(46,54)]]
	]
	).

test(sintmeets):-
	allen_intervals_to_cache([(1,3),(3,5),(6,11)], [(2,5),(5,7)], meets, 0, 10, 0, (6,11), null, []).

test(sintoverlaps):-
	allen_intervals_to_cache([(1,3),(3,5),(6,11)], [(2,5),(5,7)], overlaps, 0, 10, 0, (6,11), null, []).

test(sintbefore1):-
	allen_intervals_to_cache([(1,3),(3,5),(6,11)], [(1,2),(8,11)], before, 0, 10, 6, (6,11), (8,11), [(3,5)]).

test(sintbefore2):-
	allen_intervals_to_cache([(1,3),(3,5),(6,11)], [(1,2),(8,11)], before, 0, 10, 5, (6,11), null, []).

test(sintstarts):-
	allen_intervals_to_cache([(1,3),(3,5),(6,11)], [(1,2),(6,11)], starts, 0, 10, 0, (6,11), (6,11), []).

test(sintequal):-
	allen_intervals_to_cache([(1,3),(3,5),(6,11)], [(1,2),(6,11)], equal, 0, 10, 0, (6,11), (6,11), []).

test(sintfinishes):-
	allen_intervals_to_cache([(1,3),(3,5),(8,11)], [(1,2),(6,11)], finishes, 0, 10, 0, (8,11), (6,11), []).

test(sintduring):-
	allen_intervals_to_cache([(1,3),(3,5),(8,11)], [(1,2),(6,11)], during, 0, 10, 0, (8,11), (6,11), []).

test(tintfinishes):-
	allen_intervals_to_cache([(1,3),(3,5),(8,10)], [(1,2),(6,11)], finishes, 0, 10, 0, null, (6,11), []).

test(tintmeets1):-
	allen_intervals_to_cache([(1,3),(3,7)], [(1,2),(6,11)], meets, 0, 10, 0, null, (6,11), [(3,7)]).

test(tintmeets2):-
	allen_intervals_to_cache([(1,3),(3,6)], [(1,2),(6,11)], meets, 0, 10, 0, null, null, []).

test(tintstarts1):-
	allen_intervals_to_cache([(1,3),(6,7)], [(1,2),(6,11)], starts, 0, 10, 0, null, (6,11), [(6,7)]).

test(tintstarts2):-
	allen_intervals_to_cache([(1,3),(6,9),(10,11)], [(1,2),(10,11)], starts, 0, 10, 0, (10,11), (10,11), []).

test(tintequal):-
	allen_intervals_to_cache([(1,3),(6,9),(8,11)], [(1,2),(8,11)], equal, 0, 10, 0, (8,11), (8,11), []).

test(tintoverlaps1):-
	allen_intervals_to_cache([(1,3),(6,9)], [(1,2),(7,11)], overlaps, 0, 10, 0, null, (7,11), [(6,9)]).

test(tintoverlaps2):-
	allen_intervals_to_cache([(1,3),(6,9),(8,11)], [(1,2),(10,11)], overlaps, 0, 10, 0, (8,11), (10,11), []).

test(tintduring1):-
	allen_intervals_to_cache([(1,3),(4,5),(6,9),(8,11)], [(1,2),(2,11)], during, 0, 10, 0, (8,11), (2,11), [(4,5),(6,9)]).

test(tintduring2):-
	allen_intervals_to_cache([(1,3)], [(7,11)], during, 0, 10, 0, null, (7,11), []).

%test(104):-
%	allen_intervals_to_cache([([(2,3),(3,5),(9,11)],[(1,5),(6,7)]),([(14,18)],[(7,13),(14,18)])], [], 10, 10, 10, during, 0, [ [[(2,3), [(1,5)]]], [[(9,11),[(7,13)]]] ]).

%test(105):-
%	allen_intervals_to_cache([([(1,3),(3,5),(6,10)],[(2,5),(5,7)]),([(10,13),(14,18)],[(7,13),(14,18)])], [], 10, 10, 10, before, 10, [ [[(1,3), [(5,7)]], [(3,5), [(5,7)]]] , [[(1,3),[(7,13),(14,18)]], [(3,5), [(7,13), (14,18)]], [(6,10), [(14,18)]], [(10,13), [(14,18)]]] ]).

%test(106):-
%	allen_intervals_to_cache([([(2,5),(3,5),(6,10)],[(1,5),(5,7)]),([(10,13),(16,18)],[(7,13),(14,18)])], [], 10, 10, 10, finishes, 0, [ [[(2,5), [(1,5)]]] , [ [(16,18), [(14,18)]]] ]).

%test(200):-
	

:- end_tests(test).
