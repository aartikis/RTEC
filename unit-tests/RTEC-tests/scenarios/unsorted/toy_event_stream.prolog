% This is our narrative of events, given as input.

updateSDE(unsorted_1) :-
assertz(happensAtIE(win_lottery(chris),21)),
assertz(happensAtIE(lose_wallet(chris), 23)),
assertz(happensAtIE(go_to(chris, pub), 20)),
assertz(happensAtIE(lose_wallet(chris), 27)),
assertz(happensAtIE(win_lottery(chris),24)),
assertz(happensAtIE(go_to(chris, home), 28)),
assertz(happensAtIE(win_lottery(chris),35)).

updateSDE(unsorted_1,18):-	
	assertz(happensAtIE(lose_wallet(chris), 16)).
updateSDE(unsorted_1,27):-
	assertz(happensAtIE(win_lottery(chris),21)),
	assertz(happensAtIE(lose_wallet(chris), 23)),
	assertz(happensAtIE(lose_wallet(chris), 27)).
updateSDE(unsorted_1,36):-
	assertz(happensAtIE(win_lottery(chris),24)),
	assertz(happensAtIE(go_to(chris, home), 28)),
	assertz(happensAtIE(win_lottery(chris),35)),
	assertz(happensAtIE(go_to(chris, pub), 20)).
