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

sDFluent(pow(accept_quote(_574,_576,_578))=true).

index(accept_quote(_578,_632,_634),_578).
index(present_quote(_578,_632,_634,_636),_578).
index(request_quote(_578,_632,_634),_578).
index(send_EPO(_578,_632,_634,_636),_578).
index(send_goods(_578,_632,_634,_636,_638),_578).
index(quote(_578,_638,_640)=false,_578).
index(quote(_578,_638,_640)=true,_578).
index(contract(_578,_638,_640)=true,_578).
index(per(present_quote(_578,_642))=true,_578).
index(per(present_quote(_578,_642))=false,_578).
index(obl(send_EPO(_578,_642,_644))=false,_578).
index(obl(send_goods(_578,_642,_644))=false,_578).
index(suspended(_578,_638)=true,_578).
index(obl(send_EPO(_578,_642,_644))=true,_578).
index(obl(send_goods(_578,_642,_644))=true,_578).
index(contract(_578,_638,_640)=false,_578).
index(suspended(_578,_638)=false,_578).
index(pow(accept_quote(_578,_642,_644))=true,_578).

cyclic(contract(_860,_862,_864)=true).
cyclic(suspended(_860,_862)=true).
cyclic(obl(send_EPO(_864,_866,_868))=true).
cyclic(obl(send_goods(_864,_866,_868))=true).
cyclic(contract(_860,_862,_864)=false).
cyclic(suspended(_860,_862)=false).

cachingOrder2(_1094, quote(_1094,_1096,_1098)=true) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_1094,_1096),role_of(_1096,consumer),role_of(_1094,merchant),\+_1094=_1096,queryGoodsDescription(_1098).

cachingOrder2(_1094, quote(_1094,_1096,_1098)=false) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_1094,_1096),role_of(_1096,consumer),role_of(_1094,merchant),\+_1094=_1096,queryGoodsDescription(_1098).

cachingOrder2(_1048, per(present_quote(_1048,_1050))=false) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_1048,_1050),role_of(_1048,merchant),role_of(_1050,consumer),\+_1050=_1048.

cachingOrder2(_1048, per(present_quote(_1048,_1050))=true) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_1048,_1050),role_of(_1048,merchant),role_of(_1050,consumer),\+_1050=_1048.

cachingOrder2(_1824, obl(send_goods(_1824,_2060,_1828))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1824),role_of(_1824,merchant),queryGoodsDescription(_1828).

cachingOrder2(_1848, obl(send_EPO(_1848,_2218,_1852))=true) :- % level in dependency graph: 2, processing order in component: 2
     person(_1848),role_of(_1848,consumer),queryGoodsDescription(_1852).

cachingOrder2(_1868, suspended(_1868,_1870)=true) :- % level in dependency graph: 2, processing order in component: 3
     person(_1868),role_of(_1868,_1870).

cachingOrder2(_1886, suspended(_1886,_1888)=false) :- % level in dependency graph: 2, processing order in component: 4
     person(_1886),role_of(_1886,_1888).

cachingOrder2(_1904, contract(_1904,_1906,_1908)=true) :- % level in dependency graph: 2, processing order in component: 5
     person_pair(_1904,_1906),role_of(_1904,merchant),role_of(_1906,consumer),\+_1904=_1906,queryGoodsDescription(_1908).

cachingOrder2(_1924, contract(_1924,_1926,_1928)=false) :- % level in dependency graph: 2, processing order in component: 6
     person_pair(_1924,_1926),role_of(_1924,merchant),role_of(_1926,consumer),\+_1924=_1926,queryGoodsDescription(_1928).

cachingOrder2(_2882, obl(send_EPO(_2882,_3018,_2886))=false) :- % level in dependency graph: 3, processing order in component: 1
     person(_2882),role_of(_2882,consumer),queryGoodsDescription(_2886).

cachingOrder2(_2852, obl(send_goods(_2852,_3176,_2856))=false) :- % level in dependency graph: 3, processing order in component: 1
     person(_2852),role_of(_2852,merchant),queryGoodsDescription(_2856).

cachingOrder2(_2822, pow(accept_quote(_2822,_2824,_2826))=true) :- % level in dependency graph: 3, processing order in component: 1
     person_pair(_2824,_2822),role_of(_2824,merchant),role_of(_2822,consumer),\+_2822=_2824,queryGoodsDescription(_2826).

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
