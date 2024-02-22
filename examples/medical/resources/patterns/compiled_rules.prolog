initiatedAt(y_aux=true, _5052, _5014, _5058) :-
     happensAtIE(x,_5014),
     _5052=<_5014,
     _5014<_5058.

holdsForSDFluent(y=true,_5014) :-
     holdsForProcessedSimpleFluent(y_aux,y_aux=true,_5052),
     max_admin_dist(_5056),
     trim_interval_suffix(_5052,_5056,_5014).

fi(y_aux=true,y_aux=false,_5016):-
     max_admin_dist(_5016),
     grounding(y_aux=true),
     grounding(y_aux=false).

grounding(x).

grounding(y_aux=true).

grounding(y_aux=false).

grounding(y=true).

p(y_aux=true).

inputEntity(x).

outputEntity(y_aux=true).
outputEntity(y_aux=false).
outputEntity(y=true).

event(x).

simpleFluent(y_aux=true).
simpleFluent(y_aux=false).

sDFluent(y=true).

index(x,x).
index(y_aux=true,y_aux).
index(y_aux=false,y_aux).
index(y=true,y).


cachingOrder2(y_aux, y_aux=true) :- % level in dependency graph: 1, processing order in component: 1
     true.

cachingOrder2(y_aux, y_aux=false) :- % level in dependency graph: 1, processing order in component: 2
     true.

cachingOrder2(y, y=true) :- % level in dependency graph: 2, processing order in component: 1
     true.

