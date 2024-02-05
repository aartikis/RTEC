%:-['../../../src/timeoutTreatment.prolog'].

initiatedAt(rich(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(win_lottery(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

initiatedAt(working(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(starts_working(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

initiatedAt(strength(_131139)=tired, _131159, _131124, _131161) :-
     happensAtIE(ends_working(_131139),_131124),_131159=<_131124,_131124<_131161,
     holdsAtCyclic(_131139,strength(_131139)=lowering,_131124).

initiatedAt(strength(_131139)=lowering, _131159, _131124, _131161) :-
     happensAtIE(starts_working(_131139),_131124),_131159=<_131124,_131124<_131161,
     holdsAtCyclic(_131139,strength(_131139)=full,_131124).

initiatedAt(strength(_131139)=full, _131159, _131124, _131161) :-
     happensAtIE(sleep_end(_131139),_131124),_131159=<_131124,_131124<_131161,
     holdsAtCyclic(_131139,strength(_131139)=tired,_131124).

initiatedAt(hungry(_131139)=true, _131161, _131124, _131163) :-
     happensAtIE(smell_bacon(_131139),_131124),_131161=<_131124,_131124<_131163,
     \+holdsAtCyclic(_131139,noFoodNeeds(_131139)=true,_131124).

initiatedAt(eating(_131139)=true, _131159, _131124, _131161) :-
     happensAtIE(found_bacon(_131139),_131124),_131159=<_131124,_131124<_131161,
     holdsAtCyclic(_131139,hungry(_131139)=true,_131124).

initiatedAt(noFoodNeeds(_131139)=true, _131159, _131124, _131161) :-
     happensAtIE(ate_food(_131139),_131124),_131159=<_131124,_131124<_131161,
     holdsAtCyclic(_131139,eating(_131139)=true,_131124).

initiatedAt(strength(_131143)=full, _131124, -1, _131126) :-
     _131124=< -1,
     -1<_131126.

terminatedAt(rich(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(lose_wallet(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

terminatedAt(working(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(ends_working(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

terminatedAt(hungry(_131139)=true, _131148, _131124, _131150) :-
     happensAtIE(ate_bacon(_131139),_131124),
     _131148=<_131124,
     _131124<_131150.

terminatedAt(eating(_131139)=true, _131148, _131124, _131150) :-
     happensAtIE(ate_bacon(_131139),_131124),
     _131148=<_131124,
     _131124<_131150.

terminatedAt(noFoodNeeds(_131139)=true, _131148, _131124, _131150) :-
     happensAtIE(needsFood(_131139),_131124),
     _131148=<_131124,
     _131124<_131150.

cachingOrder2(_131123, rich(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, rich(_131123)=false) :-
     person(_131123).

cachingOrder2(_131123, working(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, working(_131123)=false) :-
     person(_131123).

cachingOrder2(_131123, eating(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, hungry(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, noFoodNeeds(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, noFoodNeeds(_131123)=false) :-
     person(_131123).

cachingOrder2(_131123, strength(_131123)=full) :-
     person(_131123).

cachingOrder2(_131123, strength(_131123)=tired) :-
     person(_131123).

cachingOrder2(_131123, strength(_131123)=lowering) :-
     person(_131123).

fi(working(_131166)=true,working(_131166)=false,8) :- 
     grounding(working(_131166)=true).

fi(hungry(_131166)=true,hungry(_131166)=false,5) :- 
     grounding(hungry(_131166)=true).

fi(rich(_131166)=true,rich(_131166)=false,4) :- 
     grounding(rich(_131166)=true).
p(rich(_131166)=true).

fi(noFoodNeeds(_131166)=true,noFoodNeeds(_131166)=false,5) :- 
     grounding(noFoodNeeds(_131166)=true).
p(noFoodNeeds(_131166)=true).

