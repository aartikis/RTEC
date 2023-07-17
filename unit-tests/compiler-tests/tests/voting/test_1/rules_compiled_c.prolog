:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(status(_4656)=null, _4666, -1, _4674) :-
     _4666=< -1,
     -1<_4674.

initiatedAt(status(_3162)=proposed, _3208, _3134, _3214) :-
     happensAtIE(propose(_3166,_3162),_3134),_3208=<_3134,_3134<_3214,
     holdsAtCyclic(_3162,status(_3162)=null,_3134).

initiatedAt(status(_3162)=voting, _3208, _3134, _3214) :-
     happensAtIE(second(_3166,_3162),_3134),_3208=<_3134,_3134<_3214,
     holdsAtCyclic(_3162,status(_3162)=proposed,_3134).

initiatedAt(status(_3162)=voted, _3220, _3134, _3226) :-
     happensAtIE(close_ballot(_3166,_3162),_3134),_3220=<_3134,_3134<_3226,
     role_of(_3166,chair),
     holdsAtCyclic(_3162,status(_3162)=voting,_3134).

initiatedAt(status(_3162)=null, _3222, _3134, _3228) :-
     happensAtIE(declare(_3166,_3162,_3170),_3134),_3222=<_3134,_3134<_3228,
     role_of(_3166,chair),
     holdsAtCyclic(_3162,status(_3162)=voted,_3134).

initiatedAt(voted(_3162,_3164)=_3140, _3204, _3134, _3210) :-
     happensAtIE(vote(_3162,_3164,_3140),_3134),_3204=<_3134,_3134<_3210,
     holdsAtProcessedSimpleFluent(_3164,status(_3164)=voting,_3134).

initiatedAt(voted(_3162,_3164)=null, _3188, _3134, _3194) :-
     happensAtProcessedSimpleFluent(_3164,start(status(_3164)=null),_3134),
     _3188=<_3134,
     _3134<_3194.

initiatedAt(outcome(_3162)=_3140, _3214, _3134, _3220) :-
     happensAtIE(declare(_3166,_3162,_3140),_3134),_3214=<_3134,_3134<_3220,
     holdsAtProcessedSimpleFluent(_3162,status(_3162)=voted,_3134),
     role_of(_3166,chair).

initiatedAt(auxPerCloseBallot(_3162)=true, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(status(_3162)=voting),_3134),
     _3186=<_3134,
     _3134<_3192.

initiatedAt(auxPerCloseBallot(_3162)=false, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(status(_3162)=proposed),_3134),
     _3186=<_3134,
     _3134<_3192.

initiatedAt(per(close_ballot(_3166,_3168))=true, _3214, _3134, _3220) :-
     happensAtProcessedSimpleFluent(_3168,end(auxPerCloseBallot(_3168)=true),_3134),_3214=<_3134,_3134<_3220,
     holdsAtProcessedSimpleFluent(_3168,status(_3168)=voting,_3134).

initiatedAt(per(close_ballot(_3166,_3168))=false, _3192, _3134, _3198) :-
     happensAtProcessedSimpleFluent(_3168,start(status(_3168)=voted),_3134),
     _3192=<_3134,
     _3134<_3198.

initiatedAt(obl(declare(_3166,_3168,carried))=true, _3294, _3134, _3300) :-
     happensAtProcessedSimpleFluent(_3168,start(status(_3168)=voted),_3134),_3294=<_3134,_3134<_3300,
     findall(_3206,holdsAtProcessedSimpleFluent(_3206,voted(_3206,_3168)=aye,_3134),_3216),
     length(_3216,_3222),
     findall(_3206,holdsAtProcessedSimpleFluent(_3206,voted(_3206,_3168)=nay,_3134),_3248),
     length(_3248,_3254),
     _3222>=_3254.

initiatedAt(obl(declare(_3166,_3168,carried))=false, _3194, _3134, _3200) :-
     happensAtProcessedSimpleFluent(_3168,start(status(_3168)=null),_3134),
     _3194=<_3134,
     _3134<_3200.

initiatedAt(sanctioned(_3162)=true, _3210, _3134, _3216) :-
     happensAtIE(close_ballot(_3162,_3168),_3134),_3210=<_3134,_3134<_3216,
     \+holdsAtProcessedSimpleFluent(_3162,per(close_ballot(_3162,_3168))=true,_3134).

initiatedAt(sanctioned(_3162)=true, _3240, _3134, _3246) :-
     happensAtProcessedSimpleFluent(_3176,end(status(_3176)=voted),_3134),_3240=<_3134,_3134<_3246,
     \+happensAtIE(declare(_3162,_3176,carried),_3134),
     holdsAtProcessedSimpleFluent(_3162,obl(declare(_3162,_3176,carried))=true,_3134).

initiatedAt(sanctioned(_3162)=true, _3244, _3134, _3250) :-
     happensAtProcessedSimpleFluent(_3176,end(status(_3176)=voted),_3134),_3244=<_3134,_3134<_3250,
     \+happensAtIE(declare(_3162,_3176,not_carried),_3134),
     \+holdsAtProcessedSimpleFluent(_3162,obl(declare(_3162,_3176,carried))=true,_3134).

terminatedAt(outcome(_3162)=_3140, _3186, _3134, _3192) :-
     happensAtProcessedSimpleFluent(_3162,start(status(_3162)=proposed),_3134),
     _3186=<_3134,
     _3134<_3192.

holdsForSDFluent(pow(propose(_3166,_3168))=true,_3134) :-
     holdsForProcessedSimpleFluent(_3168,status(_3168)=null,_3134).

holdsForSDFluent(pow(second(_3166,_3168))=true,_3134) :-
     holdsForProcessedSimpleFluent(_3168,status(_3168)=proposed,_3134).

holdsForSDFluent(pow(vote(_3166,_3168))=true,_3134) :-
     holdsForProcessedSimpleFluent(_3168,status(_3168)=voting,_3134).

holdsForSDFluent(pow(close_ballot(_3166,_3168))=true,_3134) :-
     holdsForProcessedSimpleFluent(_3168,status(_3168)=voting,_3134).

holdsForSDFluent(pow(declare(_3166,_3168))=true,_3134) :-
     holdsForProcessedSimpleFluent(_3168,status(_3168)=voted,_3134).

cachingOrder2(_3138, status(_3138)=null) :-
     queryMotion(_3138).

cachingOrder2(_3138, status(_3138)=proposed) :-
     queryMotion(_3138).

cachingOrder2(_3138, status(_3138)=voting) :-
     queryMotion(_3138).

cachingOrder2(_3138, status(_3138)=voted) :-
     queryMotion(_3138).

cachingOrder2(_3138, voted(_3138,_3140)=aye) :-
     role_of(_3138,voter),queryMotion(_3140).

cachingOrder2(_3138, voted(_3138,_3140)=nay) :-
     role_of(_3138,voter),queryMotion(_3140).

cachingOrder2(_3138, outcome(_3138)=carried) :-
     queryMotion(_3138).

cachingOrder2(_3138, outcome(_3138)=not_carried) :-
     queryMotion(_3138).

cachingOrder2(_3138, auxPerCloseBallot(_3138)=true) :-
     queryMotion(_3138).

cachingOrder2(_3142, per(close_ballot(_3142,_3144))=true) :-
     role_of(_3142,chair),queryMotion(_3144).

cachingOrder2(_3142, obl(declare(_3142,_3144,carried))=true) :-
     role_of(_3142,chair),queryMotion(_3144).

cachingOrder2(_3138, sanctioned(_3138)=true) :-
     role_of(_3138,chair).

maxDuration(status(_3394)=proposed,status(_3394)=null,10) :- 
     motion(_3394).

maxDuration(status(_3394)=voting,status(_3394)=voted,10) :- 
     motion(_3394).

maxDuration(status(_3394)=voted,status(_3394)=null,10) :- 
     motion(_3394).

maxDuration(auxPerCloseBallot(_3394)=true,auxPerCloseBallot(_3394)=false,8) :- 
     motion(_3394).

maxDuration(sanctioned(_3394)=true,sanctioned(_3394)=false,4) :- 
     role_of(_3394,chair).
