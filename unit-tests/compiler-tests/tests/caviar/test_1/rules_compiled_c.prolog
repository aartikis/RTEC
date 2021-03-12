:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(person(_3162)=true, _3206, _3134, _3212) :-
     happensAtProcessedIE(_3162,start(walking(_3162)=true),_3134),_3206=<_3134,_3134<_3212,
     \+happensAtIE(disappear(_3162),_3134).

initiatedAt(person(_3162)=true, _3206, _3134, _3212) :-
     happensAtProcessedIE(_3162,start(running(_3162)=true),_3134),_3206=<_3134,_3134<_3212,
     \+happensAtIE(disappear(_3162),_3134).

initiatedAt(person(_3162)=true, _3206, _3134, _3212) :-
     happensAtProcessedIE(_3162,start(active(_3162)=true),_3134),_3206=<_3134,_3134<_3212,
     \+happensAtIE(disappear(_3162),_3134).

initiatedAt(person(_3162)=true, _3206, _3134, _3212) :-
     happensAtProcessedIE(_3162,start(abrupt(_3162)=true),_3134),_3206=<_3134,_3134<_3212,
     \+happensAtIE(disappear(_3162),_3134).

initiatedAt(person(_3162)=false, _3176, _3134, _3182) :-
     happensAtIE(disappear(_3162),_3134),
     _3176=<_3134,
     _3134<_3182.

initiatedAt(leaving_object(_3162,_3164)=true, _3248, _3134, _3254) :-
     happensAtIE(appear(_3164),_3134),_3248=<_3134,_3134<_3254,
     holdsAtProcessedIE(_3164,inactive(_3164)=true,_3134),
     holdsAtProcessedSimpleFluent(_3162,person(_3162)=true,_3134),
     holdsAtProcessedSDFluent(_3162,closeSymmetric(_3162,_3164,30)=true,_3134).

initiatedAt(leaving_object(_3162,_3164)=false, _3178, _3134, _3184) :-
     happensAtIE(disappear(_3164),_3134),
     _3178=<_3134,
     _3134<_3184.

initiatedAt(meeting(_3162,_3164)=true, _3230, _3134, _3236) :-
     happensAtProcessedSDFluent(_3162,start(greeting1(_3162,_3164)=true),_3134),_3230=<_3134,_3134<_3236,
     \+happensAtIE(disappear(_3162),_3134),
     \+happensAtIE(disappear(_3164),_3134).

initiatedAt(meeting(_3162,_3164)=true, _3230, _3134, _3236) :-
     happensAtProcessedSDFluent(_3162,start(greeting2(_3162,_3164)=true),_3134),_3230=<_3134,_3134<_3236,
     \+happensAtIE(disappear(_3162),_3134),
     \+happensAtIE(disappear(_3164),_3134).

initiatedAt(meeting(_3162,_3164)=false, _3188, _3134, _3194) :-
     happensAtProcessedIE(_3162,start(running(_3162)=true),_3134),
     _3188=<_3134,
     _3134<_3194.

initiatedAt(meeting(_3162,_3164)=false, _3188, _3134, _3194) :-
     happensAtProcessedIE(_3164,start(running(_3164)=true),_3134),
     _3188=<_3134,
     _3134<_3194.

initiatedAt(meeting(_3162,_3164)=false, _3188, _3134, _3194) :-
     happensAtProcessedIE(_3162,start(abrupt(_3162)=true),_3134),
     _3188=<_3134,
     _3134<_3194.

initiatedAt(meeting(_3162,_3164)=false, _3188, _3134, _3194) :-
     happensAtProcessedIE(_3164,start(abrupt(_3164)=true),_3134),
     _3188=<_3134,
     _3134<_3194.

initiatedAt(meeting(_3162,_3164)=false, _3192, _3134, _3198) :-
     happensAtProcessedSDFluent(_3162,start(close(_3162,_3164,34)=false),_3134),
     _3192=<_3134,
     _3134<_3198.

holdsForSDFluent(close(_3162,_3164,24)=true,_3134) :-
     holdsForProcessedIE(_3162,distance(_3162,_3164,24)=true,_3134).

holdsForSDFluent(close(_3162,_3164,25)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,24)=true,_3186),
     holdsForProcessedIE(_3162,distance(_3162,_3164,25)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(close(_3162,_3164,30)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,25)=true,_3186),
     holdsForProcessedIE(_3162,distance(_3162,_3164,30)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(close(_3162,_3164,34)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,30)=true,_3186),
     holdsForProcessedIE(_3162,distance(_3162,_3164,34)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(close(_3162,_3164,_3166)=false,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,_3166)=true,_3186),
     complement_all([_3186],_3134).

holdsForSDFluent(closeSymmetric(_3162,_3164,_3166)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,_3166)=true,_3186),
     holdsForProcessedSDFluent(_3164,close(_3164,_3162,_3166)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(greeting1(_3162,_3164)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,activeOrInactivePerson(_3162)=true,_3180),
     \+_3180=[],
     holdsForProcessedSimpleFluent(_3164,person(_3164)=true,_3206),
     \+_3206=[],
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,25)=true,_3236),
     \+_3236=[],
     intersect_all([_3180,_3236,_3206],_3270),
     \+_3270=[],
     !,
     holdsForProcessedIE(_3164,running(_3164)=true,_3296),
     holdsForProcessedIE(_3164,abrupt(_3164)=true,_3312),
     relative_complement_all(_3270,[_3296,_3312],_3134).

holdsForSDFluent(greeting1(_3156,_3158)=true,[]).

holdsForSDFluent(greeting2(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,walking(_3162)=true,_3180),
     \+_3180=[],
     holdsForProcessedSDFluent(_3164,activeOrInactivePerson(_3164)=true,_3206),
     \+_3206=[],
     holdsForProcessedSDFluent(_3164,close(_3164,_3162,25)=true,_3236),
     \+_3236=[],
     !,
     intersect_all([_3180,_3206,_3236],_3134).

holdsForSDFluent(greeting2(_3156,_3158)=true,[]).

holdsForSDFluent(activeOrInactivePerson(_3162)=true,_3134) :-
     holdsForProcessedIE(_3162,active(_3162)=true,_3178),
     holdsForProcessedIE(_3162,inactive(_3162)=true,_3194),
     holdsForProcessedSimpleFluent(_3162,person(_3162)=true,_3210),
     intersect_all([_3194,_3210],_3228),
     union_all([_3178,_3228],_3134).

holdsForSDFluent(moving(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,walking(_3162)=true,_3180),
     holdsForProcessedIE(_3164,walking(_3164)=true,_3196),
     intersect_all([_3180,_3196],_3214),
     \+_3214=[],
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,34)=true,_3244),
     \+_3244=[],
     !,
     intersect_all([_3214,_3244],_3134).

holdsForSDFluent(moving(_3156,_3158)=true,[]).

holdsForSDFluent(fighting(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,abrupt(_3162)=true,_3180),
     holdsForProcessedIE(_3164,abrupt(_3164)=true,_3196),
     union_all([_3180,_3196],_3214),
     \+_3214=[],
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,24)=true,_3244),
     \+_3244=[],
     intersect_all([_3214,_3244],_3272),
     \+_3272=[],
     !,
     holdsForProcessedIE(_3162,inactive(_3162)=true,_3298),
     holdsForProcessedIE(_3164,inactive(_3164)=true,_3314),
     union_all([_3298,_3314],_3332),
     relative_complement_all(_3272,[_3332],_3134).

holdsForSDFluent(fighting(_3156,_3158)=true,[]).

cachingOrder2(_3138, close(_3138,_3140,24)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, close(_3138,_3140,25)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, close(_3138,_3140,30)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, close(_3138,_3140,34)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, close(_3138,_3140,34)=false) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, closeSymmetric(_3138,_3140,30)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, person(_3138)=true) :-
     list_of_ids(_3138).

cachingOrder2(_3138, activeOrInactivePerson(_3138)=true) :-
     list_of_ids(_3138).

cachingOrder2(_3138, greeting1(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, greeting2(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, leaving_object(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, leaving_object(_3138,_3140)=true) :-
     symmetric_id_pair(_3138,_3140).

cachingOrder2(_3138, meeting(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, moving(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, fighting(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

buildFromPoints2(_3138, walking(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, active(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, inactive(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, running(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, abrupt(_3138)=true) :-
     list_of_ids(_3138).
