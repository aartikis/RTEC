:- dynamic id/1.

initiatedAt(meeting(_7970,_7972)=greeting, _8028, _7940, _8034) :-
     happensAtIE(active(_7970),_7940),_8028=<_7940,_7940<_8034,
     happensAtIE(active(_7972),_7940),
     holdsAtProcessedSDFluent(_7970,distance(_7970,_7972)=mid,_7940).

initiatedAt(gathering(_7970,_7972)=true, _8012, _7940, _8018) :-
     happensAtIE(walking(_7970),_7940),_8012=<_7940,_7940<_8018,
     holdsAtProcessedSimpleFluent(_7970,meeting(_7970,_7972)=greeting,_7940).

initiatedAt(gathering(_7970,_7972)=true, _8012, _7940, _8018) :-
     happensAtIE(walking(_7972),_7940),_8012=<_7940,_7940<_8018,
     holdsAtProcessedSimpleFluent(_7970,meeting(_7970,_7972)=greeting,_7940).

initiatedAt(meeting(_7970,_7972)=interacting, _8052, _7940, _8058) :-
     happensAtIE(active(_7970),_7940),_8052=<_7940,_7940<_8058,
     happensAtIE(active(_7972),_7940),
     holdsAtProcessedSDFluent(_7970,distance(_7970,_7972)=short,_7940),
     holdsAtProcessedSimpleFluent(_7970,gathering(_7970,_7972)=true,_7940).

terminatedAt(meeting(_7970,_7972)=greeting, _7988, _7940, _7994) :-
     happensAtIE(walking(_7970),_7940),
     _7988=<_7940,
     _7940<_7994.

terminatedAt(meeting(_7970,_7972)=greeting, _7988, _7940, _7994) :-
     happensAtIE(walking(_7972),_7940),
     _7988=<_7940,
     _7940<_7994.

terminatedAt(gathering(_7970,_7972)=true, _8028, _7940, _8034) :-
     happensAtIE(active(_7970),_7940),_8028=<_7940,_7940<_8034,
     happensAtIE(active(_7972),_7940),
     holdsAtProcessedSDFluent(_7970,distance(_7970,_7972)=short,_7940).

terminatedAt(meeting(_7970,_7972)=interacting, _8004, _7940, _8010) :-
     happensAtIE(inactive(_7970),_7940),_8004=<_7940,_7940<_8010,
     happensAtIE(inactive(_7972),_7940).

holdsForSDFluent(distance(_7970,_7972)=short,_7940) :-
     holdsForProcessedIE(_7970,distance(_7970,_7972,24)=true,_7940).

holdsForSDFluent(distance(_7970,_7972)=mid,_7940) :-
     holdsForProcessedIE(_7970,distance(_7970,_7972,30)=true,_7940).

holdsForSDFluent(distance(_7970,_7972)=long,_7940) :-
     holdsForProcessedIE(_7970,distance(_7970,_7972,34)=true,_7940).

buildFromPoints2(_7944, walking(_7944)=true) :-
     id(_7944).

buildFromPoints2(_7944, active(_7944)=true) :-
     id(_7944).

buildFromPoints2(_7944, inactive(_7944)=true) :-
     id(_7944).

buildFromPoints2(_7944, running(_7944)=true) :-
     id(_7944).

buildFromPoints2(_7944, abrupt(_7944)=true) :-
     id(_7944).

points(orientation(_8284)=_8280).

points(appearance(_8284)=_8280).

points(coord(_8284,_8286,_8288)=true).

points(walking(_8284)=true).

points(active(_8284)=true).

points(inactive(_8284)=true).

points(running(_8284)=true).

points(abrupt(_8284)=true).

grounding(appear(_8284)) :- 
     id(_8284).

grounding(disappear(_8284)) :- 
     id(_8284).

grounding(orientation(_8290)=_8286) :- 
     id(_8290).

grounding(appearance(_8290)=_8286) :- 
     id(_8290).

grounding(coord(_8290,_8292,_8294)=_8286) :- 
     id(_8290).

grounding(walking(_8290)=_8286) :- 
     id(_8290).

grounding(active(_8290)=_8286) :- 
     id(_8290).

grounding(inactive(_8290)=_8286) :- 
     id(_8290).

grounding(running(_8290)=_8286) :- 
     id(_8290).

grounding(abrupt(_8290)=_8286) :- 
     id(_8290).

grounding(distance(_8290,_8292)=short) :- 
     id(_8290),id(_8292),_8290@<_8292.

grounding(distance(_8290,_8292)=mid) :- 
     id(_8290),id(_8292),_8290@<_8292.

grounding(distance(_8290,_8292)=long) :- 
     id(_8290),id(_8292),_8290@<_8292.

grounding(gathering(_8290,_8292)=true) :- 
     id(_8290),id(_8292),_8290@<_8292.

grounding(meeting(_8290,_8292)=greeting) :- 
     id(_8290),id(_8292),_8290@<_8292.

grounding(meeting(_8290,_8292)=interacting) :- 
     id(_8290),id(_8292),_8290@<_8292.

inputEntity(active(_7994)).
inputEntity(walking(_7994)).
inputEntity(inactive(_7994)).
inputEntity(distance(_8000,_8002,_8004)=true).
inputEntity(appear(_7994)).
inputEntity(disappear(_7994)).
inputEntity(orientation(_8000)=_7996).
inputEntity(appearance(_8000)=_7996).
inputEntity(coord(_8000,_8002,_8004)=_7996).
inputEntity(walking(_8000)=_7996).
inputEntity(active(_8000)=_7996).
inputEntity(inactive(_8000)=_7996).
inputEntity(running(_8000)=_7996).
inputEntity(abrupt(_8000)=_7996).

outputEntity(meeting(_8140,_8142)=greeting).
outputEntity(gathering(_8140,_8142)=true).
outputEntity(meeting(_8140,_8142)=interacting).
outputEntity(distance(_8140,_8142)=short).
outputEntity(distance(_8140,_8142)=mid).
outputEntity(distance(_8140,_8142)=long).

event(active(_8226)).
event(walking(_8226)).
event(inactive(_8226)).
event(appear(_8226)).
event(disappear(_8226)).

simpleFluent(meeting(_8318,_8320)=greeting).
simpleFluent(gathering(_8318,_8320)=true).
simpleFluent(meeting(_8318,_8320)=interacting).

sDFluent(distance(_8392,_8394)=short).
sDFluent(distance(_8392,_8394)=mid).
sDFluent(distance(_8392,_8394)=long).
sDFluent(distance(_8392,_8394,_8396)=true).
sDFluent(orientation(_8392)=_8388).
sDFluent(appearance(_8392)=_8388).
sDFluent(coord(_8392,_8394,_8396)=_8388).
sDFluent(walking(_8392)=_8388).
sDFluent(active(_8392)=_8388).
sDFluent(inactive(_8392)=_8388).
sDFluent(running(_8392)=_8388).
sDFluent(abrupt(_8392)=_8388).

index(active(_8466),_8466).
index(walking(_8466),_8466).
index(inactive(_8466),_8466).
index(appear(_8466),_8466).
index(disappear(_8466),_8466).
index(meeting(_8466,_8526)=greeting,_8466).
index(gathering(_8466,_8526)=true,_8466).
index(meeting(_8466,_8526)=interacting,_8466).
index(distance(_8466,_8526)=short,_8466).
index(distance(_8466,_8526)=mid,_8466).
index(distance(_8466,_8526)=long,_8466).
index(distance(_8466,_8526,_8528)=true,_8466).
index(orientation(_8466)=_8520,_8466).
index(appearance(_8466)=_8520,_8466).
index(coord(_8466,_8526,_8528)=_8520,_8466).
index(walking(_8466)=_8520,_8466).
index(active(_8466)=_8520,_8466).
index(inactive(_8466)=_8520,_8466).
index(running(_8466)=_8520,_8466).
index(abrupt(_8466)=_8520,_8466).


cachingOrder2(_8868, distance(_8868,_8870)=short) :- % level in dependency graph: 1, processing order in component: 1
     id(_8868),id(_8870),_8868@<_8870.

cachingOrder2(_8844, distance(_8844,_8846)=mid) :- % level in dependency graph: 1, processing order in component: 1
     id(_8844),id(_8846),_8844@<_8846.

cachingOrder2(_8820, distance(_8820,_8822)=long) :- % level in dependency graph: 1, processing order in component: 1
     id(_8820),id(_8822),_8820@<_8822.

cachingOrder2(_9264, meeting(_9264,_9266)=greeting) :- % level in dependency graph: 2, processing order in component: 1
     id(_9264),id(_9266),_9264@<_9266.

cachingOrder2(_9444, gathering(_9444,_9446)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_9444),id(_9446),_9444@<_9446.

cachingOrder2(_9624, meeting(_9624,_9626)=interacting) :- % level in dependency graph: 4, processing order in component: 1
     id(_9624),id(_9626),_9624@<_9626.

collectGrounds([appear(_8408), disappear(_8408), orientation(_8408)=_8422, appearance(_8408)=_8422, coord(_8408,_8428,_8430)=_8422, walking(_8408)=_8422, active(_8408)=_8422, inactive(_8408)=_8422, running(_8408)=_8422, abrupt(_8408)=_8422],id(_8408)).

dgrounded(meeting(_8778,_8780)=greeting, id(_8778)).
dgrounded(meeting(_8778,_8780)=greeting, id(_8780)).
dgrounded(gathering(_8722,_8724)=true, id(_8722)).
dgrounded(gathering(_8722,_8724)=true, id(_8724)).
dgrounded(meeting(_8666,_8668)=interacting, id(_8666)).
dgrounded(meeting(_8666,_8668)=interacting, id(_8668)).
dgrounded(distance(_8610,_8612)=short, id(_8610)).
dgrounded(distance(_8610,_8612)=short, id(_8612)).
dgrounded(distance(_8554,_8556)=mid, id(_8554)).
dgrounded(distance(_8554,_8556)=mid, id(_8556)).
dgrounded(distance(_8498,_8500)=long, id(_8498)).
dgrounded(distance(_8498,_8500)=long, id(_8500)).
