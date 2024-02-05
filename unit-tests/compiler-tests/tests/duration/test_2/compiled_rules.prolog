initiatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(win_lottery(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

terminatedAt(rich(_5012)=true, _5028, _4982, _5034) :-
     happensAtIE(lose_wallet(_5012),_4982),
     _5028=<_4982,
     _4982<_5034.

fi(rich(_5016)=true,rich(_5016)=false,4):-
     grounding(rich(_5016)=true),
     grounding(rich(_5016)=false).

grounding(win_lottery(_5296)) :- 
     person(_5296).

grounding(lose_lottery(_5296)) :- 
     person(_5296).

grounding(rich(_5302)=true) :- 
     person(_5302).

grounding(rich(_5302)=false) :- 
     person(_5302).

p(rich(_5296)=true).

inputEntity(win_lottery(_5036)).
inputEntity(lose_wallet(_5036)).
inputEntity(lose_lottery(_5036)).

outputEntity(rich(_5116)=true).
outputEntity(rich(_5116)=false).

event(win_lottery(_5178)).
event(lose_wallet(_5178)).
event(lose_lottery(_5178)).

simpleFluent(rich(_5258)=true).
simpleFluent(rich(_5258)=false).


index(win_lottery(_5328),_5328).
index(lose_wallet(_5328),_5328).
index(lose_lottery(_5328),_5328).
index(rich(_5328)=true,_5328).
index(rich(_5328)=false,_5328).


cachingOrder2(_5592, rich(_5592)=true) :- % level in dependency graph: 1, processing order in component: 1
     person(_5592).

cachingOrder2(_5592, rich(_5592)=false) :- % level in dependency graph: 1, processing order in component: 2
     person(_5592).

