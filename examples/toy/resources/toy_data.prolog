% This is our narrative of events, given as input.

updateSDE(0, 10) :-
assert(happensAtIE(go_to(chris, work), 9)).

updateSDE(10, 20) :-
assert(happensAtIE(win_lottery(chris), 13)), 
assert(happensAtIE(go_to(chris, pub), 17)),
assert(happensAtIE(lose_wallet(chris), 19)).

updateSDE(20, 30) :-
assert(happensAtIE(go_to(chris, home), 21)).
