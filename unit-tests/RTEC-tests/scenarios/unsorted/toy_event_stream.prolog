% This is our narrative of events, given as input.

updateSDE(unsorted_1) :-
assert(happensAtIE(win_lottery(chris),21)),
assert(happensAtIE(lose_wallet(chris), 23)),
assert(happensAtIE(go_to(chris, pub), 20)),
assert(happensAtIE(lose_wallet(chris), 27)),
assert(happensAtIE(win_lottery(chris),24)),
assert(happensAtIE(go_to(chris, home), 28)),
assert(happensAtIE(win_lottery(chris),35)).

updateSDE(unsorted_1,18):-	
	assert(happensAtIE(lose_wallet(chris), 16)).
updateSDE(unsorted_1,27):-
	assert(happensAtIE(win_lottery(chris),21)),
	assert(happensAtIE(lose_wallet(chris), 23)),
	assert(happensAtIE(lose_wallet(chris), 27)).
updateSDE(unsorted_1,36):-
	assert(happensAtIE(win_lottery(chris),24)),
	assert(happensAtIE(go_to(chris, home), 28)),
	assert(happensAtIE(win_lottery(chris),35)),
	assert(happensAtIE(go_to(chris, pub), 20)).
