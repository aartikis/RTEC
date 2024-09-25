:- dynamic person/1, person_pair/2.

initiatedAt(quote(_106,_108,_110)=false, _130, _76, _136) :-
     happensAtIE(accept_quote(_108,_106,_110),_76),
     _130=<_76,
     _76<_136.

initiatedAt(quote(_106,_108,_110)=true, _132, _76, _138) :-
     happensAtIE(present_quote(_106,_108,_110,_120),_76),
     _132=<_76,
     _76<_138.

initiatedAt(contract(_106,_108,_110)=true, _218, _76, _224) :-
     happensAtIE(accept_quote(_108,_106,_110),_76),_218=<_76,_76<_224,
     holdsAtProcessedSimpleFluent(_106,quote(_106,_108,_110)=true,_76),
     \+holdsAtCyclic(_106,suspended(_106,merchant)=true,_76),
     \+holdsAtCyclic(_108,suspended(_108,consumer)=true,_76).

initiatedAt(per(present_quote(_110,_112))=true, _132, _76, _138) :-
     happensAtIE(request_quote(_112,_110,_120),_76),
     _132=<_76,
     _76<_138.

initiatedAt(per(present_quote(_110,_112))=false, _134, _76, _140) :-
     happensAtIE(present_quote(_110,_112,_120,_122),_76),
     _134=<_76,
     _76<_140.

initiatedAt(obl(send_EPO(_110,iServer,_114))=false, _148, _76, _154) :-
     happensAtIE(send_EPO(_110,iServer,_114,_124),_76),_148=<_76,_76<_154,
     price(_114,_124).

initiatedAt(obl(send_goods(_110,iServer,_114))=false, _164, _76, _170) :-
     happensAtIE(send_goods(_110,iServer,_114,_124,_126),_76),_164=<_76,_76<_170,
     decrypt(_124,_126,_140),
     meets(_140,_114).

initiatedAt(suspended(_106,merchant)=true, _164, _76, _170) :-
     happensAtIE(present_quote(_106,_114,_116,_118),_76),_164=<_76,_76<_170,
     holdsAtProcessedSimpleFluent(_106,per(present_quote(_106,_114))=false,_76).

initiatedAt(obl(send_EPO(_118,iServer,_122))=true, _76, _78, _80) :-
     initiatedAt(contract(_132,_118,_122)=true,_76,_78,_80).

initiatedAt(obl(send_goods(_118,iServer,_122))=true, _76, _78, _80) :-
     initiatedAt(contract(_118,_134,_122)=true,_76,_78,_80).

initiatedAt(obl(send_EPO(_118,iServer,_122))=false, _76, _78, _80) :-
     initiatedAt(contract(_132,_118,_122)=false,_76,_78,_80).

initiatedAt(obl(send_goods(_118,iServer,_122))=false, _76, _78, _80) :-
     initiatedAt(contract(_118,_134,_122)=false,_76,_78,_80).

initiatedAt(suspended(_114,merchant)=true, _76, _78, _80) :-
     initiatedAt(contract(_114,_128,_130)=false,_76,_78,_80),
     holdsAtCyclic(_114,obl(send_goods(_114,iServer,_130))=true,_78).

initiatedAt(suspended(_114,consumer)=true, _76, _78, _80) :-
     initiatedAt(contract(_126,_114,_130)=false,_76,_78,_80),
     holdsAtCyclic(_114,obl(send_EPO(_114,iServer,_130))=true,_78).

holdsForSDFluent(pow(accept_quote(_110,_112,_114))=true,_76) :-
     holdsForProcessedSimpleFluent(_112,quote(_112,_110,_114)=true,_134),
     holdsForProcessedSimpleFluent(_110,suspended(_110,consumer)=true,_152),
     holdsForProcessedSimpleFluent(_112,suspended(_112,merchant)=true,_170),
     relative_complement_all(_134,[_152,_170],_76).

fi(quote(_110,_112,_114)=true,quote(_110,_112,_114)=false,5):-
     grounding(quote(_110,_112,_114)=true),
     grounding(quote(_110,_112,_114)=false).

fi(contract(_110,_112,_114)=true,contract(_110,_112,_114)=false,5):-
     grounding(contract(_110,_112,_114)=true),
     grounding(contract(_110,_112,_114)=false).

fi(per(present_quote(_114,_116))=false,per(present_quote(_114,_116))=true,10):-
     grounding(per(present_quote(_114,_116))=false),
     grounding(per(present_quote(_114,_116))=true).

fi(suspended(_110,_112)=true,suspended(_110,_112)=false,3):-
     grounding(suspended(_110,_112)=true),
     grounding(suspended(_110,_112)=false).

grounding(request_quote(_428,_430,_432)) :- 
     person_pair(_430,_428).

grounding(present_quote(_428,_430,_432,_434)) :- 
     person_pair(_428,_430).

grounding(accept_quote(_428,_430,_432)) :- 
     person_pair(_430,_428).

grounding(send_EPO(_428,_430,_432,_434)) :- 
     person(_428).

grounding(send_goods(_428,_430,_432,_434,_436)) :- 
     person(_428).

grounding(suspended(_434,_436)=true) :- 
     person(_434),role_of(_434,_436).

grounding(suspended(_434,_436)=false) :- 
     person(_434),role_of(_434,_436).

grounding(quote(_434,_436,_438)=true) :- 
     person_pair(_434,_436),role_of(_436,consumer),role_of(_434,merchant),\+_434=_436,queryGoodsDescription(_438).

grounding(quote(_434,_436,_438)=false) :- 
     person_pair(_434,_436),role_of(_436,consumer),role_of(_434,merchant),\+_434=_436,queryGoodsDescription(_438).

grounding(contract(_434,_436,_438)=true) :- 
     person_pair(_434,_436),role_of(_434,merchant),role_of(_436,consumer),\+_434=_436,queryGoodsDescription(_438).

grounding(contract(_434,_436,_438)=false) :- 
     person_pair(_434,_436),role_of(_434,merchant),role_of(_436,consumer),\+_434=_436,queryGoodsDescription(_438).

grounding(pow(accept_quote(_438,_440,_442))=true) :- 
     person_pair(_440,_438),role_of(_440,merchant),role_of(_438,consumer),\+_438=_440,queryGoodsDescription(_442).

grounding(per(present_quote(_438,_440))=false) :- 
     person_pair(_438,_440),role_of(_438,merchant),role_of(_440,consumer),\+_440=_438.

grounding(per(present_quote(_438,_440))=true) :- 
     person_pair(_438,_440),role_of(_438,merchant),role_of(_440,consumer),\+_440=_438.

grounding(obl(send_EPO(_438,iServer,_442))=true) :- 
     person(_438),role_of(_438,consumer),queryGoodsDescription(_442).

grounding(obl(send_goods(_438,iServer,_442))=true) :- 
     person(_438),role_of(_438,merchant),queryGoodsDescription(_442).

grounding(obl(send_EPO(_438,iServer,_442))=false) :- 
     person(_438),role_of(_438,consumer),queryGoodsDescription(_442).

grounding(obl(send_goods(_438,iServer,_442))=false) :- 
     person(_438),role_of(_438,merchant),queryGoodsDescription(_442).

p(quote(_428,_430,_432)=true).

p(per(present_quote(_432,_434))=false).

p(suspended(_428,_430)=true).

inputEntity(accept_quote(_130,_132,_134)).
inputEntity(present_quote(_130,_132,_134,_136)).
inputEntity(request_quote(_130,_132,_134)).
inputEntity(send_EPO(_130,_132,_134,_136)).
inputEntity(send_goods(_130,_132,_134,_136,_138)).

outputEntity(quote(_222,_224,_226)=false).
outputEntity(quote(_222,_224,_226)=true).
outputEntity(contract(_222,_224,_226)=true).
outputEntity(per(present_quote(_226,_228))=true).
outputEntity(per(present_quote(_226,_228))=false).
outputEntity(obl(send_EPO(_226,_228,_230))=false).
outputEntity(obl(send_goods(_226,_228,_230))=false).
outputEntity(suspended(_222,_224)=true).
outputEntity(obl(send_EPO(_226,_228,_230))=true).
outputEntity(obl(send_goods(_226,_228,_230))=true).
outputEntity(contract(_222,_224,_226)=false).
outputEntity(suspended(_222,_224)=false).
outputEntity(pow(accept_quote(_226,_228,_230))=true).

event(accept_quote(_350,_352,_354)).
event(present_quote(_350,_352,_354,_356)).
event(request_quote(_350,_352,_354)).
event(send_EPO(_350,_352,_354,_356)).
event(send_goods(_350,_352,_354,_356,_358)).

simpleFluent(quote(_442,_444,_446)=false).
simpleFluent(quote(_442,_444,_446)=true).
simpleFluent(contract(_442,_444,_446)=true).
simpleFluent(per(present_quote(_446,_448))=true).
simpleFluent(per(present_quote(_446,_448))=false).
simpleFluent(obl(send_EPO(_446,_448,_450))=false).
simpleFluent(obl(send_goods(_446,_448,_450))=false).
simpleFluent(suspended(_442,_444)=true).
simpleFluent(obl(send_EPO(_446,_448,_450))=true).
simpleFluent(obl(send_goods(_446,_448,_450))=true).
simpleFluent(contract(_442,_444,_446)=false).
simpleFluent(suspended(_442,_444)=false).


sDFluent(pow(accept_quote(_630,_632,_634))=true).

index(accept_quote(_634,_688,_690),_634).
index(present_quote(_634,_688,_690,_692),_634).
index(request_quote(_634,_688,_690),_634).
index(send_EPO(_634,_688,_690,_692),_634).
index(send_goods(_634,_688,_690,_692,_694),_634).
index(quote(_634,_694,_696)=false,_634).
index(quote(_634,_694,_696)=true,_634).
index(contract(_634,_694,_696)=true,_634).
index(per(present_quote(_634,_698))=true,_634).
index(per(present_quote(_634,_698))=false,_634).
index(obl(send_EPO(_634,_698,_700))=false,_634).
index(obl(send_goods(_634,_698,_700))=false,_634).
index(suspended(_634,_694)=true,_634).
index(obl(send_EPO(_634,_698,_700))=true,_634).
index(obl(send_goods(_634,_698,_700))=true,_634).
index(contract(_634,_694,_696)=false,_634).
index(suspended(_634,_694)=false,_634).
index(pow(accept_quote(_634,_698,_700))=true,_634).

cyclic(contract(_916,_918,_920)=true).
cyclic(suspended(_916,_918)=true).
cyclic(obl(send_EPO(_920,_922,_924))=true).
cyclic(obl(send_goods(_920,_922,_924))=true).
cyclic(contract(_916,_918,_920)=false).
cyclic(suspended(_916,_918)=false).

cachingOrder2(_1150, quote(_1150,_1152,_1154)=true) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_1150,_1152),role_of(_1152,consumer),role_of(_1150,merchant),\+_1150=_1152,queryGoodsDescription(_1154).

cachingOrder2(_1150, quote(_1150,_1152,_1154)=false) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_1150,_1152),role_of(_1152,consumer),role_of(_1150,merchant),\+_1150=_1152,queryGoodsDescription(_1154).

cachingOrder2(_1104, per(present_quote(_1104,_1106))=false) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_1104,_1106),role_of(_1104,merchant),role_of(_1106,consumer),\+_1106=_1104.

cachingOrder2(_1104, per(present_quote(_1104,_1106))=true) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_1104,_1106),role_of(_1104,merchant),role_of(_1106,consumer),\+_1106=_1104.

cachingOrder2(_1876, contract(_1876,_1878,_1880)=true) :- % level in dependency graph: 2, processing order in component: 1
     person_pair(_1876,_1878),role_of(_1876,merchant),role_of(_1878,consumer),\+_1876=_1878,queryGoodsDescription(_1880).

cachingOrder2(_1896, contract(_1896,_1898,_1900)=false) :- % level in dependency graph: 2, processing order in component: 2
     person_pair(_1896,_1898),role_of(_1896,merchant),role_of(_1898,consumer),\+_1896=_1898,queryGoodsDescription(_1900).

cachingOrder2(_1920, obl(send_EPO(_1920,_2472,_1924))=false) :- % level in dependency graph: 2, processing order in component: 3
     person(_1920),role_of(_1920,consumer),queryGoodsDescription(_1924).

cachingOrder2(_1944, obl(send_EPO(_1944,_2630,_1948))=true) :- % level in dependency graph: 2, processing order in component: 4
     person(_1944),role_of(_1944,consumer),queryGoodsDescription(_1948).

cachingOrder2(_1968, obl(send_goods(_1968,_2788,_1972))=false) :- % level in dependency graph: 2, processing order in component: 5
     person(_1968),role_of(_1968,merchant),queryGoodsDescription(_1972).

cachingOrder2(_1992, obl(send_goods(_1992,_2946,_1996))=true) :- % level in dependency graph: 2, processing order in component: 6
     person(_1992),role_of(_1992,merchant),queryGoodsDescription(_1996).

cachingOrder2(_2012, suspended(_2012,_2014)=true) :- % level in dependency graph: 2, processing order in component: 7
     person(_2012),role_of(_2012,_2014).

cachingOrder2(_2030, suspended(_2030,_2032)=false) :- % level in dependency graph: 2, processing order in component: 8
     person(_2030),role_of(_2030,_2032).

cachingOrder2(_3242, pow(accept_quote(_3242,_3244,_3246))=true) :- % level in dependency graph: 3, processing order in component: 1
     person_pair(_3244,_3242),role_of(_3244,merchant),role_of(_3242,consumer),\+_3242=_3244,queryGoodsDescription(_3246).

collectGrounds([send_EPO(_378,_392,_394,_396), send_goods(_378,_392,_394,_396,_398)],person(_378)).

collectGrounds([accept_quote(_368,_366,_394), present_quote(_366,_368,_394,_396), request_quote(_368,_366,_394)],person_pair(_366,_368)).

dgrounded(quote(_1324,_1326,_1328)=false, person_pair(_1324,_1326)).
dgrounded(quote(_1236,_1238,_1240)=true, person_pair(_1236,_1238)).
dgrounded(contract(_1148,_1150,_1152)=true, person_pair(_1148,_1150)).
dgrounded(per(present_quote(_1072,_1074))=true, person_pair(_1072,_1074)).
dgrounded(per(present_quote(_992,_994))=false, person_pair(_992,_994)).
dgrounded(obl(send_EPO(_930,iServer,_934))=false, person(_930)).
dgrounded(obl(send_goods(_868,iServer,_872))=false, person(_868)).
dgrounded(suspended(_818,_820)=true, person(_818)).
dgrounded(obl(send_EPO(_760,iServer,_764))=true, person(_760)).
dgrounded(obl(send_goods(_698,iServer,_702))=true, person(_698)).
dgrounded(contract(_606,_608,_610)=false, person_pair(_606,_608)).
dgrounded(suspended(_560,_562)=false, person(_560)).
dgrounded(pow(accept_quote(_472,_474,_476))=true, person_pair(_474,_472)).
