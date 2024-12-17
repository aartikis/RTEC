:- dynamic id/1.

initiatedAt(person(_116)=true, _162, _86, _168) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_162=<_86,_86<_168,
     \+happensAtIE(disappear(_116),_86).

initiatedAt(person(_116)=true, _162, _86, _168) :-
     happensAtProcessedIE(_116,start(running(_116)=true),_86),_162=<_86,_86<_168,
     \+happensAtIE(disappear(_116),_86).

initiatedAt(person(_116)=true, _162, _86, _168) :-
     happensAtProcessedIE(_116,start(active(_116)=true),_86),_162=<_86,_86<_168,
     \+happensAtIE(disappear(_116),_86).

initiatedAt(person(_116)=true, _162, _86, _168) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_162=<_86,_86<_168,
     \+happensAtIE(disappear(_116),_86).

initiatedAt(person(_116)=false, _132, _86, _138) :-
     happensAtIE(disappear(_116),_86),
     _132=<_86,
     _86<_138.

initiatedAt(leaving_object(_116,_118)=true, _202, _86, _208) :-
     happensAtIE(appear(_118),_86),_202=<_86,_86<_208,
     holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     holdsAtProcessedSimpleFluent(_116,person(_116)=true,_86),
     holdsAtProcessedSimpleFluent(_116,closeSymmetric30(_116,_118)=true,_86).

initiatedAt(leaving_object(_116,_118)=false, _134, _86, _140) :-
     happensAtIE(disappear(_118),_86),
     _134=<_86,
     _86<_140.

initiatedAt(close24(_116,_118)=true, _148, _86, _154) :-
     happensAtProcessedIE(_116,start(distance(_116,_118,24)=true),_86),
     _148=<_86,
     _86<_154.

initiatedAt(close25(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     _146=<_86,
     _86<_152.

initiatedAt(close25(_116,_118)=true, _148, _86, _154) :-
     happensAtProcessedIE(_116,start(distance(_116,_118,25)=true),_86),
     _148=<_86,
     _86<_154.

initiatedAt(close30(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     _146=<_86,
     _86<_152.

initiatedAt(close30(_116,_118)=true, _148, _86, _154) :-
     happensAtProcessedIE(_116,start(distance(_116,_118,30)=true),_86),
     _148=<_86,
     _86<_154.

initiatedAt(close34(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_116,start(close30(_116,_118)=true),_86),
     _146=<_86,
     _86<_152.

initiatedAt(close34(_116,_118)=true, _148, _86, _154) :-
     happensAtProcessedIE(_116,start(distance(_116,_118,34)=true),_86),
     _148=<_86,
     _86<_154.

initiatedAt(closeSymmetric30(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_116,start(close30(_116,_118)=true),_86),
     _146=<_86,
     _86<_152.

initiatedAt(closeSymmetric30(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_118,start(close30(_118,_116)=true),_86),
     _146=<_86,
     _86<_152.

initiatedAt(activeOrInactivePerson(_116)=true, _142, _86, _148) :-
     happensAtProcessedIE(_116,start(active(_116)=true),_86),
     _142=<_86,
     _86<_148.

initiatedAt(activeOrInactivePerson(_116)=true, _168, _86, _174) :-
     happensAtProcessedIE(_116,start(inactive(_116)=true),_86),_168=<_86,_86<_174,
     happensAtProcessedSimpleFluent(_116,start(person(_116)=true),_86).

initiatedAt(activeOrInactivePerson(_116)=true, _194, _86, _200) :-
     happensAtProcessedIE(_116,start(inactive(_116)=true),_86),_194=<_86,_86<_200,
     holdsAtProcessedSimpleFluent(_116,person(_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(person(_116)=true),_86).

initiatedAt(activeOrInactivePerson(_116)=true, _194, _86, _200) :-
     happensAtProcessedSimpleFluent(_116,start(person(_116)=true),_86),_194=<_86,_86<_200,
     \+happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     holdsAtProcessedIE(_116,inactive(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _250, _86, _256) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_250=<_86,_86<_256,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _280, _86, _286) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_280=<_86,_86<_286,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _280, _86, _286) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_280=<_86,_86<_286,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _310, _86, _316) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_310=<_86,_86<_316,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _276, _86, _282) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_276=<_86,_86<_282,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _306, _86, _312) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_306=<_86,_86<_312,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _306, _86, _312) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_306=<_86,_86<_312,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _336, _86, _342) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_336=<_86,_86<_342,
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _278, _86, _284) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_278=<_86,_86<_284,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _308, _86, _314) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_308=<_86,_86<_314,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _308, _86, _314) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_308=<_86,_86<_314,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _338, _86, _344) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_338=<_86,_86<_344,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _304, _86, _310) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_304=<_86,_86<_310,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _334, _86, _340) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_334=<_86,_86<_340,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _334, _86, _340) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_334=<_86,_86<_340,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _364, _86, _370) :-
     happensAtProcessedSimpleFluent(_116,start(activeOrInactivePerson(_116)=true),_86),_364=<_86,_86<_370,
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

initiatedAt(greeting1(_116,_118)=true, _276, _86, _282) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_276=<_86,_86<_282,
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _306, _86, _312) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_306=<_86,_86<_312,
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _306, _86, _312) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_306=<_86,_86<_312,
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _336, _86, _342) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_336=<_86,_86<_342,
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _302, _86, _308) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_302=<_86,_86<_308,
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _332, _86, _338) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_332=<_86,_86<_338,
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _332, _86, _338) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_332=<_86,_86<_338,
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _362, _86, _368) :-
     happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),_362=<_86,_86<_368,
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _304, _86, _310) :-
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),_304=<_86,_86<_310,
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _334, _86, _340) :-
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),_334=<_86,_86<_340,
     happensAtProcessedIE(_118,end(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _334, _86, _340) :-
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),_334=<_86,_86<_340,
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _364, _86, _370) :-
     happensAtProcessedSimpleFluent(_118,start(person(_118)=true),_86),_364=<_86,_86<_370,
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _330, _86, _336) :-
     happensAtProcessedIE(_118,end(running(_118)=true),_86),_330=<_86,_86<_336,
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _360, _86, _366) :-
     happensAtProcessedIE(_118,end(running(_118)=true),_86),_360=<_86,_86<_366,
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting1(_116,_118)=true, _360, _86, _366) :-
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),_360=<_86,_86<_366,
     \+happensAtProcessedIE(_118,start(running(_118)=true),_86),
     \+holdsAtProcessedIE(_118,running(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,person(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     holdsAtProcessedSimpleFluent(_116,activeOrInactivePerson(_116)=true,_86).

initiatedAt(greeting2(_116,_118)=true, _198, _86, _204) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_198=<_86,_86<_204,
     happensAtProcessedSimpleFluent(_118,start(activeOrInactivePerson(_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(close25(_118,_116)=true),_86).

initiatedAt(greeting2(_116,_118)=true, _226, _86, _232) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_226=<_86,_86<_232,
     happensAtProcessedSimpleFluent(_118,start(activeOrInactivePerson(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,close25(_118,_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(close25(_118,_116)=true),_86).

initiatedAt(greeting2(_116,_118)=true, _224, _86, _230) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_224=<_86,_86<_230,
     holdsAtProcessedSimpleFluent(_118,activeOrInactivePerson(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(activeOrInactivePerson(_118)=true),_86),
     happensAtProcessedSimpleFluent(_118,start(close25(_118,_116)=true),_86).

initiatedAt(greeting2(_116,_118)=true, _252, _86, _258) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_252=<_86,_86<_258,
     holdsAtProcessedSimpleFluent(_118,activeOrInactivePerson(_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(activeOrInactivePerson(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,close25(_118,_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(close25(_118,_116)=true),_86).

initiatedAt(greeting2(_116,_118)=true, _224, _86, _230) :-
     happensAtProcessedSimpleFluent(_118,start(activeOrInactivePerson(_118)=true),_86),_224=<_86,_86<_230,
     happensAtProcessedSimpleFluent(_118,start(close25(_118,_116)=true),_86),
     \+happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     holdsAtProcessedIE(_116,walking(_116)=true,_86).

initiatedAt(greeting2(_116,_118)=true, _252, _86, _258) :-
     happensAtProcessedSimpleFluent(_118,start(activeOrInactivePerson(_118)=true),_86),_252=<_86,_86<_258,
     holdsAtProcessedSimpleFluent(_118,close25(_118,_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,end(close25(_118,_116)=true),_86),
     \+happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     holdsAtProcessedIE(_116,walking(_116)=true,_86).

initiatedAt(greeting2(_116,_118)=true, _250, _86, _256) :-
     happensAtProcessedSimpleFluent(_118,start(close25(_118,_116)=true),_86),_250=<_86,_86<_256,
     \+happensAtProcessedSimpleFluent(_118,end(activeOrInactivePerson(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_118,activeOrInactivePerson(_118)=true,_86),
     \+happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     holdsAtProcessedIE(_116,walking(_116)=true,_86).

initiatedAt(moving(_116,_118)=true, _198, _86, _204) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_198=<_86,_86<_204,
     happensAtProcessedIE(_118,start(walking(_118)=true),_86),
     happensAtProcessedSimpleFluent(_116,start(close34(_116,_118)=true),_86).

initiatedAt(moving(_116,_118)=true, _226, _86, _232) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_226=<_86,_86<_232,
     happensAtProcessedIE(_118,start(walking(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close34(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close34(_116,_118)=true),_86).

initiatedAt(moving(_116,_118)=true, _224, _86, _230) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_224=<_86,_86<_230,
     holdsAtProcessedIE(_118,walking(_118)=true,_86),
     \+happensAtProcessedIE(_118,end(walking(_118)=true),_86),
     happensAtProcessedSimpleFluent(_116,start(close34(_116,_118)=true),_86).

initiatedAt(moving(_116,_118)=true, _252, _86, _258) :-
     happensAtProcessedIE(_116,start(walking(_116)=true),_86),_252=<_86,_86<_258,
     holdsAtProcessedIE(_118,walking(_118)=true,_86),
     \+happensAtProcessedIE(_118,end(walking(_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close34(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close34(_116,_118)=true),_86).

initiatedAt(moving(_116,_118)=true, _224, _86, _230) :-
     happensAtProcessedIE(_118,start(walking(_118)=true),_86),_224=<_86,_86<_230,
     happensAtProcessedSimpleFluent(_116,start(close34(_116,_118)=true),_86),
     \+happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     holdsAtProcessedIE(_116,walking(_116)=true,_86).

initiatedAt(moving(_116,_118)=true, _252, _86, _258) :-
     happensAtProcessedIE(_118,start(walking(_118)=true),_86),_252=<_86,_86<_258,
     holdsAtProcessedSimpleFluent(_116,close34(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close34(_116,_118)=true),_86),
     \+happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     holdsAtProcessedIE(_116,walking(_116)=true,_86).

initiatedAt(moving(_116,_118)=true, _250, _86, _256) :-
     happensAtProcessedSimpleFluent(_116,start(close34(_116,_118)=true),_86),_250=<_86,_86<_256,
     \+happensAtProcessedIE(_118,end(walking(_118)=true),_86),
     holdsAtProcessedIE(_118,walking(_118)=true,_86),
     \+happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     holdsAtProcessedIE(_116,walking(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _224, _86, _230) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_224=<_86,_86<_230,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _254, _86, _260) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_254=<_86,_86<_260,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _254, _86, _260) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_254=<_86,_86<_260,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _284, _86, _290) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_284=<_86,_86<_290,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _252, _86, _258) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_252=<_86,_86<_258,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _282, _86, _288) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_282=<_86,_86<_288,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _282, _86, _288) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_282=<_86,_86<_288,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _312, _86, _318) :-
     happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),_312=<_86,_86<_318,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _250, _86, _256) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_250=<_86,_86<_256,
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),
     holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _280, _86, _286) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_280=<_86,_86<_286,
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),
     holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _280, _86, _286) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_280=<_86,_86<_286,
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),
     holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _310, _86, _316) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_310=<_86,_86<_316,
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),
     holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _278, _86, _284) :-
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),_278=<_86,_86<_284,
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),
     holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _308, _86, _314) :-
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),_308=<_86,_86<_314,
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),
     holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _308, _86, _314) :-
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),_308=<_86,_86<_314,
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),
     holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

initiatedAt(fighting(_116,_118)=true, _224, _86, _230) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_224=<_86,_86<_230,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _254, _86, _260) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_254=<_86,_86<_260,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _254, _86, _260) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_254=<_86,_86<_260,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _284, _86, _290) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_284=<_86,_86<_290,
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _252, _86, _258) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_252=<_86,_86<_258,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _282, _86, _288) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_282=<_86,_86<_288,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _282, _86, _288) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_282=<_86,_86<_288,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _312, _86, _318) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),_312=<_86,_86<_318,
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86).

initiatedAt(fighting(_116,_118)=true, _250, _86, _256) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_250=<_86,_86<_256,
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     holdsAtProcessedIE(_118,abrupt(_118)=true,_86).

initiatedAt(fighting(_116,_118)=true, _280, _86, _286) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_280=<_86,_86<_286,
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     holdsAtProcessedIE(_118,abrupt(_118)=true,_86).

initiatedAt(fighting(_116,_118)=true, _280, _86, _286) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_280=<_86,_86<_286,
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     holdsAtProcessedIE(_118,abrupt(_118)=true,_86).

initiatedAt(fighting(_116,_118)=true, _310, _86, _316) :-
     happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),_310=<_86,_86<_316,
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86),
     \+happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     holdsAtProcessedIE(_118,abrupt(_118)=true,_86).

initiatedAt(fighting(_116,_118)=true, _278, _86, _284) :-
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),_278=<_86,_86<_284,
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     holdsAtProcessedIE(_118,abrupt(_118)=true,_86).

initiatedAt(fighting(_116,_118)=true, _308, _86, _314) :-
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),_308=<_86,_86<_314,
     \+holdsAtProcessedIE(_118,inactive(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(inactive(_118)=true),_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     holdsAtProcessedIE(_118,abrupt(_118)=true,_86).

initiatedAt(fighting(_116,_118)=true, _308, _86, _314) :-
     happensAtProcessedIE(_118,end(inactive(_118)=true),_86),_308=<_86,_86<_314,
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86),
     \+happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),
     holdsAtProcessedIE(_118,abrupt(_118)=true,_86).

terminatedAt(close24(_116,_118)=true, _148, _86, _154) :-
     happensAtProcessedIE(_116,end(distance(_116,_118,24)=true),_86),
     _148=<_86,
     _86<_154.

terminatedAt(close25(_116,_118)=true, _176, _86, _182) :-
     happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),_176=<_86,_86<_182,
     happensAtProcessedIE(_116,end(distance(_116,_118,25)=true),_86).

terminatedAt(close25(_116,_118)=true, _210, _86, _216) :-
     happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),_210=<_86,_86<_216,
     \+holdsAtProcessedIE(_116,distance(_116,_118,25)=true,_86),
     \+happensAtProcessedIE(_116,start(distance(_116,_118,25)=true),_86).

terminatedAt(close25(_116,_118)=true, _208, _86, _214) :-
     happensAtProcessedIE(_116,end(distance(_116,_118,25)=true),_86),_208=<_86,_86<_214,
     \+happensAtProcessedSimpleFluent(_116,start(close24(_116,_118)=true),_86),
     \+holdsAtProcessedSimpleFluent(_116,close24(_116,_118)=true,_86).

terminatedAt(close30(_116,_118)=true, _176, _86, _182) :-
     happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),_176=<_86,_86<_182,
     happensAtProcessedIE(_116,end(distance(_116,_118,30)=true),_86).

terminatedAt(close30(_116,_118)=true, _210, _86, _216) :-
     happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),_210=<_86,_86<_216,
     \+holdsAtProcessedIE(_116,distance(_116,_118,30)=true,_86),
     \+happensAtProcessedIE(_116,start(distance(_116,_118,30)=true),_86).

terminatedAt(close30(_116,_118)=true, _208, _86, _214) :-
     happensAtProcessedIE(_116,end(distance(_116,_118,30)=true),_86),_208=<_86,_86<_214,
     \+happensAtProcessedSimpleFluent(_116,start(close25(_116,_118)=true),_86),
     \+holdsAtProcessedSimpleFluent(_116,close25(_116,_118)=true,_86).

terminatedAt(close34(_116,_118)=true, _176, _86, _182) :-
     happensAtProcessedSimpleFluent(_116,end(close30(_116,_118)=true),_86),_176=<_86,_86<_182,
     happensAtProcessedIE(_116,end(distance(_116,_118,34)=true),_86).

terminatedAt(close34(_116,_118)=true, _210, _86, _216) :-
     happensAtProcessedSimpleFluent(_116,end(close30(_116,_118)=true),_86),_210=<_86,_86<_216,
     \+holdsAtProcessedIE(_116,distance(_116,_118,34)=true,_86),
     \+happensAtProcessedIE(_116,start(distance(_116,_118,34)=true),_86).

terminatedAt(close34(_116,_118)=true, _208, _86, _214) :-
     happensAtProcessedIE(_116,end(distance(_116,_118,34)=true),_86),_208=<_86,_86<_214,
     \+happensAtProcessedSimpleFluent(_116,start(close30(_116,_118)=true),_86),
     \+holdsAtProcessedSimpleFluent(_116,close30(_116,_118)=true,_86).

terminatedAt(closeSymmetric30(_116,_118)=true, _174, _86, _180) :-
     happensAtProcessedSimpleFluent(_116,end(close30(_116,_118)=true),_86),_174=<_86,_86<_180,
     happensAtProcessedSimpleFluent(_118,end(close30(_118,_116)=true),_86).

terminatedAt(closeSymmetric30(_116,_118)=true, _206, _86, _212) :-
     happensAtProcessedSimpleFluent(_116,end(close30(_116,_118)=true),_86),_206=<_86,_86<_212,
     \+holdsAtProcessedSimpleFluent(_118,close30(_118,_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_118,start(close30(_118,_116)=true),_86).

terminatedAt(closeSymmetric30(_116,_118)=true, _206, _86, _212) :-
     happensAtProcessedSimpleFluent(_118,end(close30(_118,_116)=true),_86),_206=<_86,_86<_212,
     \+happensAtProcessedSimpleFluent(_116,start(close30(_116,_118)=true),_86),
     \+holdsAtProcessedSimpleFluent(_116,close30(_116,_118)=true,_86).

terminatedAt(activeOrInactivePerson(_116)=true, _168, _86, _174) :-
     happensAtProcessedIE(_116,end(active(_116)=true),_86),_168=<_86,_86<_174,
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86).

terminatedAt(activeOrInactivePerson(_116)=true, _198, _86, _204) :-
     happensAtProcessedIE(_116,end(active(_116)=true),_86),_198=<_86,_86<_204,
     \+holdsAtProcessedIE(_116,inactive(_116)=true,_86),
     \+happensAtProcessedIE(_116,start(inactive(_116)=true),_86).

terminatedAt(activeOrInactivePerson(_116)=true, _198, _86, _204) :-
     happensAtProcessedIE(_116,end(inactive(_116)=true),_86),_198=<_86,_86<_204,
     \+happensAtProcessedIE(_116,start(active(_116)=true),_86),
     \+holdsAtProcessedIE(_116,active(_116)=true,_86).

terminatedAt(activeOrInactivePerson(_116)=true, _168, _86, _174) :-
     happensAtProcessedIE(_116,end(active(_116)=true),_86),_168=<_86,_86<_174,
     happensAtProcessedSimpleFluent(_116,end(person(_116)=true),_86).

terminatedAt(activeOrInactivePerson(_116)=true, _198, _86, _204) :-
     happensAtProcessedIE(_116,end(active(_116)=true),_86),_198=<_86,_86<_204,
     \+holdsAtProcessedSimpleFluent(_116,person(_116)=true,_86),
     \+happensAtProcessedSimpleFluent(_116,start(person(_116)=true),_86).

terminatedAt(activeOrInactivePerson(_116)=true, _198, _86, _204) :-
     happensAtProcessedSimpleFluent(_116,end(person(_116)=true),_86),_198=<_86,_86<_204,
     \+happensAtProcessedIE(_116,start(active(_116)=true),_86),
     \+holdsAtProcessedIE(_116,active(_116)=true,_86).

terminatedAt(greeting1(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedSimpleFluent(_116,end(activeOrInactivePerson(_116)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(greeting1(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedSimpleFluent(_118,end(person(_118)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(greeting1(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_116,end(close25(_116,_118)=true),_86),
     _146=<_86,
     _86<_152.

terminatedAt(greeting1(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedIE(_118,start(running(_118)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(greeting1(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedIE(_118,start(abrupt(_118)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(greeting2(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(greeting2(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedSimpleFluent(_118,end(activeOrInactivePerson(_118)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(greeting2(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_118,end(close25(_118,_116)=true),_86),
     _146=<_86,
     _86<_152.

terminatedAt(moving(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedIE(_116,end(walking(_116)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(moving(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedIE(_118,end(walking(_118)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(moving(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_116,end(close34(_116,_118)=true),_86),
     _146=<_86,
     _86<_152.

terminatedAt(fighting(_116,_118)=true, _170, _86, _176) :-
     happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),_170=<_86,_86<_176,
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86).

terminatedAt(fighting(_116,_118)=true, _200, _86, _206) :-
     happensAtProcessedIE(_116,end(abrupt(_116)=true),_86),_200=<_86,_86<_206,
     \+holdsAtProcessedIE(_118,abrupt(_118)=true,_86),
     \+happensAtProcessedIE(_118,start(abrupt(_118)=true),_86).

terminatedAt(fighting(_116,_118)=true, _200, _86, _206) :-
     happensAtProcessedIE(_118,end(abrupt(_118)=true),_86),_200=<_86,_86<_206,
     \+happensAtProcessedIE(_116,start(abrupt(_116)=true),_86),
     \+holdsAtProcessedIE(_116,abrupt(_116)=true,_86).

terminatedAt(fighting(_116,_118)=true, _146, _86, _152) :-
     happensAtProcessedSimpleFluent(_116,end(close24(_116,_118)=true),_86),
     _146=<_86,
     _86<_152.

terminatedAt(fighting(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedIE(_116,start(inactive(_116)=true),_86),
     _144=<_86,
     _86<_150.

terminatedAt(fighting(_116,_118)=true, _144, _86, _150) :-
     happensAtProcessedIE(_118,start(inactive(_118)=true),_86),
     _144=<_86,
     _86<_150.

buildFromPoints2(_90, walking(_90)=true) :-
     id(_90).

buildFromPoints2(_90, active(_90)=true) :-
     id(_90).

buildFromPoints2(_90, inactive(_90)=true) :-
     id(_90).

buildFromPoints2(_90, running(_90)=true) :-
     id(_90).

buildFromPoints2(_90, abrupt(_90)=true) :-
     id(_90).

points(orientation(_412)=_408).

points(appearance(_412)=_408).

points(coord(_412,_414,_416)=true).

points(walking(_412)=true).

points(active(_412)=true).

points(inactive(_412)=true).

points(running(_412)=true).

points(abrupt(_412)=true).

grounding(appear(_412)) :- 
     id(_412).

grounding(disappear(_412)) :- 
     id(_412).

grounding(orientation(_418)=_414) :- 
     id(_418).

grounding(appearance(_418)=_414) :- 
     id(_418).

grounding(coord(_418,_420,_422)=_414) :- 
     id(_418).

grounding(walking(_418)=_414) :- 
     id(_418).

grounding(active(_418)=_414) :- 
     id(_418).

grounding(inactive(_418)=_414) :- 
     id(_418).

grounding(running(_418)=_414) :- 
     id(_418).

grounding(abrupt(_418)=_414) :- 
     id(_418).

grounding(close24(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(close25(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(close30(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(close34(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(closeSymmetric30(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(walking(_418)=true) :- 
     id(_418).

grounding(active(_418)=true) :- 
     id(_418).

grounding(inactive(_418)=true) :- 
     id(_418).

grounding(abrupt(_418)=true) :- 
     id(_418).

grounding(running(_418)=true) :- 
     id(_418).

grounding(person(_418)=true) :- 
     id(_418).

grounding(activeOrInactivePerson(_418)=true) :- 
     id(_418).

grounding(greeting1(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(greeting2(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(leaving_object(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(moving(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

grounding(fighting(_418,_420)=true) :- 
     id(_418),id(_420),_418@<_420.

inputEntity(walking(_146)=true).
inputEntity(disappear(_140)).
inputEntity(running(_146)=true).
inputEntity(active(_146)=true).
inputEntity(abrupt(_146)=true).
inputEntity(appear(_140)).
inputEntity(inactive(_146)=true).
inputEntity(distance(_146,_148,_150)=true).
inputEntity(orientation(_146)=_142).
inputEntity(appearance(_146)=_142).
inputEntity(coord(_146,_148,_150)=_142).

outputEntity(person(_268)=true).
outputEntity(person(_268)=false).
outputEntity(leaving_object(_268,_270)=true).
outputEntity(leaving_object(_268,_270)=false).
outputEntity(close24(_268,_270)=true).
outputEntity(close25(_268,_270)=true).
outputEntity(close30(_268,_270)=true).
outputEntity(close34(_268,_270)=true).
outputEntity(closeSymmetric30(_268,_270)=true).
outputEntity(activeOrInactivePerson(_268)=true).
outputEntity(greeting1(_268,_270)=true).
outputEntity(greeting2(_268,_270)=true).
outputEntity(moving(_268,_270)=true).
outputEntity(fighting(_268,_270)=true).

event(disappear(_402)).
event(appear(_402)).

simpleFluent(person(_476)=true).
simpleFluent(person(_476)=false).
simpleFluent(leaving_object(_476,_478)=true).
simpleFluent(leaving_object(_476,_478)=false).
simpleFluent(close24(_476,_478)=true).
simpleFluent(close25(_476,_478)=true).
simpleFluent(close30(_476,_478)=true).
simpleFluent(close34(_476,_478)=true).
simpleFluent(closeSymmetric30(_476,_478)=true).
simpleFluent(activeOrInactivePerson(_476)=true).
simpleFluent(greeting1(_476,_478)=true).
simpleFluent(greeting2(_476,_478)=true).
simpleFluent(moving(_476,_478)=true).
simpleFluent(fighting(_476,_478)=true).


sDFluent(walking(_672)=true).
sDFluent(running(_672)=true).
sDFluent(active(_672)=true).
sDFluent(abrupt(_672)=true).
sDFluent(inactive(_672)=true).
sDFluent(distance(_672,_674,_676)=true).
sDFluent(orientation(_672)=_668).
sDFluent(appearance(_672)=_668).
sDFluent(coord(_672,_674,_676)=_668).

index(disappear(_728),_728).
index(appear(_728),_728).
index(person(_728)=true,_728).
index(person(_728)=false,_728).
index(leaving_object(_728,_788)=true,_728).
index(leaving_object(_728,_788)=false,_728).
index(close24(_728,_788)=true,_728).
index(close25(_728,_788)=true,_728).
index(close30(_728,_788)=true,_728).
index(close34(_728,_788)=true,_728).
index(closeSymmetric30(_728,_788)=true,_728).
index(activeOrInactivePerson(_728)=true,_728).
index(greeting1(_728,_788)=true,_728).
index(greeting2(_728,_788)=true,_728).
index(moving(_728,_788)=true,_728).
index(fighting(_728,_788)=true,_728).
index(walking(_728)=true,_728).
index(running(_728)=true,_728).
index(active(_728)=true,_728).
index(abrupt(_728)=true,_728).
index(inactive(_728)=true,_728).
index(distance(_728,_788,_790)=true,_728).
index(orientation(_728)=_782,_728).
index(appearance(_728)=_782,_728).
index(coord(_728,_788,_790)=_782,_728).


cachingOrder2(_1152, person(_1152)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1152).

cachingOrder2(_1112, close24(_1112,_1114)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1112),id(_1114),_1112@<_1114.

cachingOrder2(_1446, close25(_1446,_1448)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1446),id(_1448),_1446@<_1448.

cachingOrder2(_1424, activeOrInactivePerson(_1424)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1424).

cachingOrder2(_1400, fighting(_1400,_1402)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1400),id(_1402),_1400@<_1402.

cachingOrder2(_1852, close30(_1852,_1854)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1852),id(_1854),_1852@<_1854.

cachingOrder2(_1828, greeting1(_1828,_1830)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1828),id(_1830),_1828@<_1830.

cachingOrder2(_1804, greeting2(_1804,_1806)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1804),id(_1806),_1804@<_1806.

cachingOrder2(_2272, close34(_2272,_2274)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2272),id(_2274),_2272@<_2274.

cachingOrder2(_2248, closeSymmetric30(_2248,_2250)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2248),id(_2250),_2248@<_2250.

cachingOrder2(_2602, leaving_object(_2602,_2604)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2602),id(_2604),_2602@<_2604.

cachingOrder2(_2560, moving(_2560,_2562)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2560),id(_2562),_2560@<_2562.

collectGrounds([walking(_744)=true, walking(_744)=true, disappear(_744), running(_744)=true, running(_744)=true, active(_744)=true, active(_744)=true, abrupt(_744)=true, abrupt(_744)=true, appear(_744), inactive(_744)=true, inactive(_744)=true, orientation(_744)=_758, appearance(_744)=_758, coord(_744,_764,_766)=_758],id(_744)).

dgrounded(person(_1426)=true, id(_1426)).
dgrounded(leaving_object(_1370,_1372)=true, id(_1370)).
dgrounded(leaving_object(_1370,_1372)=true, id(_1372)).
dgrounded(close24(_1314,_1316)=true, id(_1314)).
dgrounded(close24(_1314,_1316)=true, id(_1316)).
dgrounded(close25(_1258,_1260)=true, id(_1258)).
dgrounded(close25(_1258,_1260)=true, id(_1260)).
dgrounded(close30(_1202,_1204)=true, id(_1202)).
dgrounded(close30(_1202,_1204)=true, id(_1204)).
dgrounded(close34(_1146,_1148)=true, id(_1146)).
dgrounded(close34(_1146,_1148)=true, id(_1148)).
dgrounded(closeSymmetric30(_1090,_1092)=true, id(_1090)).
dgrounded(closeSymmetric30(_1090,_1092)=true, id(_1092)).
dgrounded(activeOrInactivePerson(_1058)=true, id(_1058)).
dgrounded(greeting1(_1002,_1004)=true, id(_1002)).
dgrounded(greeting1(_1002,_1004)=true, id(_1004)).
dgrounded(greeting2(_946,_948)=true, id(_946)).
dgrounded(greeting2(_946,_948)=true, id(_948)).
dgrounded(moving(_890,_892)=true, id(_890)).
dgrounded(moving(_890,_892)=true, id(_892)).
dgrounded(fighting(_834,_836)=true, id(_834)).
dgrounded(fighting(_834,_836)=true, id(_836)).
