% This is our narrative of events, given as input.

updateSDE(story, 9, 21) :-
assert(happensAtIE(go_to(chris, work), 9)),
assert(happensAtIE(win_lottery(chris), 13)), 
assert(happensAtIE(go_to(chris, pub), 17)),
assert(happensAtIE(lose_wallet(chris), 19)), 
assert(happensAtIE(go_to(chris, home), 21)).