:- dynamic id/1.

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(running(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(active(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=true, _156, _80, _162) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_156=<_80,_80<_162,
     \+happensAtIE(disappear(_110),_80).

initiatedAt(person(_110)=false, _126, _80, _132) :-
     happensAtIE(disappear(_110),_80),
     _126=<_80,
     _80<_132.

initiatedAt(leaving_object(_110,_112)=true, _196, _80, _202) :-
     happensAtIE(appear(_112),_80),_196=<_80,_80<_202,
     holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     holdsAtProcessedSimpleFluent(_110,person(_110)=true,_80),
     holdsAtProcessedSimpleFluent(_110,closeSymmetric30(_110,_112)=true,_80).

initiatedAt(leaving_object(_110,_112)=false, _128, _80, _134) :-
     happensAtIE(disappear(_112),_80),
     _128=<_80,
     _80<_134.

initiatedAt(close24(_110,_112)=true, _148, _80, _154) :-
     happensAtProcessedIE(_110,start(distance(_110,_112,24)=true),_80),_148=<_80,_80<_154.

initiatedAt(close25(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_146=<_80,_80<_152.

initiatedAt(close25(_110,_112)=true, _148, _80, _154) :-
     happensAtProcessedIE(_110,start(distance(_110,_112,25)=true),_80),_148=<_80,_80<_154.

initiatedAt(close30(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_146=<_80,_80<_152.

initiatedAt(close30(_110,_112)=true, _148, _80, _154) :-
     happensAtProcessedIE(_110,start(distance(_110,_112,30)=true),_80),_148=<_80,_80<_154.

initiatedAt(close34(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_110,start(close30(_110,_112)=true),_80),_146=<_80,_80<_152.

initiatedAt(close34(_110,_112)=true, _148, _80, _154) :-
     happensAtProcessedIE(_110,start(distance(_110,_112,34)=true),_80),_148=<_80,_80<_154.

initiatedAt(closeSymmetric30(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_110,start(close30(_110,_112)=true),_80),_146=<_80,_80<_152.

initiatedAt(closeSymmetric30(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_112,start(close30(_112,_110)=true),_80),_146=<_80,_80<_152.

initiatedAt(activeOrInactivePerson(_110)=true, _142, _80, _148) :-
     happensAtProcessedIE(_110,start(active(_110)=true),_80),_142=<_80,_80<_148.

initiatedAt(activeOrInactivePerson(_110)=true, _168, _80, _174) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_168=<_80,_80<_174,
     happensAtProcessedSimpleFluent(_110,start(person(_110)=true),_80).

initiatedAt(activeOrInactivePerson(_110)=true, _194, _80, _200) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_194=<_80,_80<_200,
     holdsAtProcessedSimpleFluent(_110,person(_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(person(_110)=true),_80).

initiatedAt(activeOrInactivePerson(_110)=true, _194, _80, _200) :-
     happensAtProcessedSimpleFluent(_110,start(person(_110)=true),_80),_194=<_80,_80<_200,
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     holdsAtProcessedIE(_110,inactive(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _250, _80, _256) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_250=<_80,_80<_256,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _280, _80, _286) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_280=<_80,_80<_286,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _280, _80, _286) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_280=<_80,_80<_286,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _310, _80, _316) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_310=<_80,_80<_316,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _276, _80, _282) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_276=<_80,_80<_282,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _306, _80, _312) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_306=<_80,_80<_312,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _306, _80, _312) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_306=<_80,_80<_312,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _336, _80, _342) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_336=<_80,_80<_342,
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _278, _80, _284) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_278=<_80,_80<_284,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _308, _80, _314) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_308=<_80,_80<_314,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _308, _80, _314) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_308=<_80,_80<_314,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _338, _80, _344) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_338=<_80,_80<_344,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _304, _80, _310) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_304=<_80,_80<_310,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _334, _80, _340) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_334=<_80,_80<_340,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _334, _80, _340) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_334=<_80,_80<_340,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _364, _80, _370) :-
     happensAtProcessedSimpleFluent(_110,start(activeOrInactivePerson(_110)=true),_80),_364=<_80,_80<_370,
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

initiatedAt(greeting1(_110,_112)=true, _276, _80, _282) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_276=<_80,_80<_282,
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _306, _80, _312) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_306=<_80,_80<_312,
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _306, _80, _312) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_306=<_80,_80<_312,
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _336, _80, _342) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_336=<_80,_80<_342,
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _302, _80, _308) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_302=<_80,_80<_308,
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _332, _80, _338) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_332=<_80,_80<_338,
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _332, _80, _338) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_332=<_80,_80<_338,
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _362, _80, _368) :-
     happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),_362=<_80,_80<_368,
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _304, _80, _310) :-
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),_304=<_80,_80<_310,
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _334, _80, _340) :-
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),_334=<_80,_80<_340,
     happensAtProcessedIE(_112,end(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _334, _80, _340) :-
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),_334=<_80,_80<_340,
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _364, _80, _370) :-
     happensAtProcessedSimpleFluent(_112,start(person(_112)=true),_80),_364=<_80,_80<_370,
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _330, _80, _336) :-
     happensAtProcessedIE(_112,end(running(_112)=true),_80),_330=<_80,_80<_336,
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _360, _80, _366) :-
     happensAtProcessedIE(_112,end(running(_112)=true),_80),_360=<_80,_80<_366,
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting1(_110,_112)=true, _360, _80, _366) :-
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),_360=<_80,_80<_366,
     \+happensAtProcessedIE(_112,start(running(_112)=true),_80),
     \+holdsAtProcessedIE(_112,running(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,person(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),
     holdsAtProcessedSimpleFluent(_110,activeOrInactivePerson(_110)=true,_80).

initiatedAt(greeting2(_110,_112)=true, _198, _80, _204) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_198=<_80,_80<_204,
     happensAtProcessedSimpleFluent(_112,start(activeOrInactivePerson(_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(close25(_112,_110)=true),_80).

initiatedAt(greeting2(_110,_112)=true, _226, _80, _232) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_226=<_80,_80<_232,
     happensAtProcessedSimpleFluent(_112,start(activeOrInactivePerson(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,close25(_112,_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(close25(_112,_110)=true),_80).

initiatedAt(greeting2(_110,_112)=true, _224, _80, _230) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_224=<_80,_80<_230,
     holdsAtProcessedSimpleFluent(_112,activeOrInactivePerson(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(activeOrInactivePerson(_112)=true),_80),
     happensAtProcessedSimpleFluent(_112,start(close25(_112,_110)=true),_80).

initiatedAt(greeting2(_110,_112)=true, _252, _80, _258) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_252=<_80,_80<_258,
     holdsAtProcessedSimpleFluent(_112,activeOrInactivePerson(_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(activeOrInactivePerson(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,close25(_112,_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(close25(_112,_110)=true),_80).

initiatedAt(greeting2(_110,_112)=true, _224, _80, _230) :-
     happensAtProcessedSimpleFluent(_112,start(activeOrInactivePerson(_112)=true),_80),_224=<_80,_80<_230,
     happensAtProcessedSimpleFluent(_112,start(close25(_112,_110)=true),_80),
     \+happensAtProcessedIE(_110,end(walking(_110)=true),_80),
     holdsAtProcessedIE(_110,walking(_110)=true,_80).

initiatedAt(greeting2(_110,_112)=true, _252, _80, _258) :-
     happensAtProcessedSimpleFluent(_112,start(activeOrInactivePerson(_112)=true),_80),_252=<_80,_80<_258,
     holdsAtProcessedSimpleFluent(_112,close25(_112,_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,end(close25(_112,_110)=true),_80),
     \+happensAtProcessedIE(_110,end(walking(_110)=true),_80),
     holdsAtProcessedIE(_110,walking(_110)=true,_80).

initiatedAt(greeting2(_110,_112)=true, _250, _80, _256) :-
     happensAtProcessedSimpleFluent(_112,start(close25(_112,_110)=true),_80),_250=<_80,_80<_256,
     \+happensAtProcessedSimpleFluent(_112,end(activeOrInactivePerson(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_112,activeOrInactivePerson(_112)=true,_80),
     \+happensAtProcessedIE(_110,end(walking(_110)=true),_80),
     holdsAtProcessedIE(_110,walking(_110)=true,_80).

initiatedAt(moving(_110,_112)=true, _198, _80, _204) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_198=<_80,_80<_204,
     happensAtProcessedIE(_112,start(walking(_112)=true),_80),
     happensAtProcessedSimpleFluent(_110,start(close34(_110,_112)=true),_80).

initiatedAt(moving(_110,_112)=true, _226, _80, _232) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_226=<_80,_80<_232,
     happensAtProcessedIE(_112,start(walking(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close34(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close34(_110,_112)=true),_80).

initiatedAt(moving(_110,_112)=true, _224, _80, _230) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_224=<_80,_80<_230,
     holdsAtProcessedIE(_112,walking(_112)=true,_80),
     \+happensAtProcessedIE(_112,end(walking(_112)=true),_80),
     happensAtProcessedSimpleFluent(_110,start(close34(_110,_112)=true),_80).

initiatedAt(moving(_110,_112)=true, _252, _80, _258) :-
     happensAtProcessedIE(_110,start(walking(_110)=true),_80),_252=<_80,_80<_258,
     holdsAtProcessedIE(_112,walking(_112)=true,_80),
     \+happensAtProcessedIE(_112,end(walking(_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close34(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close34(_110,_112)=true),_80).

initiatedAt(moving(_110,_112)=true, _224, _80, _230) :-
     happensAtProcessedIE(_112,start(walking(_112)=true),_80),_224=<_80,_80<_230,
     happensAtProcessedSimpleFluent(_110,start(close34(_110,_112)=true),_80),
     \+happensAtProcessedIE(_110,end(walking(_110)=true),_80),
     holdsAtProcessedIE(_110,walking(_110)=true,_80).

initiatedAt(moving(_110,_112)=true, _252, _80, _258) :-
     happensAtProcessedIE(_112,start(walking(_112)=true),_80),_252=<_80,_80<_258,
     holdsAtProcessedSimpleFluent(_110,close34(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close34(_110,_112)=true),_80),
     \+happensAtProcessedIE(_110,end(walking(_110)=true),_80),
     holdsAtProcessedIE(_110,walking(_110)=true,_80).

initiatedAt(moving(_110,_112)=true, _250, _80, _256) :-
     happensAtProcessedSimpleFluent(_110,start(close34(_110,_112)=true),_80),_250=<_80,_80<_256,
     \+happensAtProcessedIE(_112,end(walking(_112)=true),_80),
     holdsAtProcessedIE(_112,walking(_112)=true,_80),
     \+happensAtProcessedIE(_110,end(walking(_110)=true),_80),
     holdsAtProcessedIE(_110,walking(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _224, _80, _230) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_224=<_80,_80<_230,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _254, _80, _260) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_254=<_80,_80<_260,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _254, _80, _260) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_254=<_80,_80<_260,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _284, _80, _290) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_284=<_80,_80<_290,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _252, _80, _258) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_252=<_80,_80<_258,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _282, _80, _288) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_282=<_80,_80<_288,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _282, _80, _288) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_282=<_80,_80<_288,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _312, _80, _318) :-
     happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),_312=<_80,_80<_318,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _250, _80, _256) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_250=<_80,_80<_256,
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),
     holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _280, _80, _286) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_280=<_80,_80<_286,
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),
     holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _280, _80, _286) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_280=<_80,_80<_286,
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),
     holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _310, _80, _316) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_310=<_80,_80<_316,
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),
     holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _278, _80, _284) :-
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),_278=<_80,_80<_284,
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),
     holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _308, _80, _314) :-
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),_308=<_80,_80<_314,
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),
     holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _308, _80, _314) :-
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),_308=<_80,_80<_314,
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),
     holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

initiatedAt(fighting(_110,_112)=true, _224, _80, _230) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_224=<_80,_80<_230,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _254, _80, _260) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_254=<_80,_80<_260,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _254, _80, _260) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_254=<_80,_80<_260,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _284, _80, _290) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_284=<_80,_80<_290,
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _252, _80, _258) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_252=<_80,_80<_258,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _282, _80, _288) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_282=<_80,_80<_288,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _282, _80, _288) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_282=<_80,_80<_288,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _312, _80, _318) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_312=<_80,_80<_318,
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

initiatedAt(fighting(_110,_112)=true, _250, _80, _256) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_250=<_80,_80<_256,
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     holdsAtProcessedIE(_112,abrupt(_112)=true,_80).

initiatedAt(fighting(_110,_112)=true, _280, _80, _286) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_280=<_80,_80<_286,
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     holdsAtProcessedIE(_112,abrupt(_112)=true,_80).

initiatedAt(fighting(_110,_112)=true, _280, _80, _286) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_280=<_80,_80<_286,
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     holdsAtProcessedIE(_112,abrupt(_112)=true,_80).

initiatedAt(fighting(_110,_112)=true, _310, _80, _316) :-
     happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),_310=<_80,_80<_316,
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80),
     \+happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     holdsAtProcessedIE(_112,abrupt(_112)=true,_80).

initiatedAt(fighting(_110,_112)=true, _278, _80, _284) :-
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),_278=<_80,_80<_284,
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     holdsAtProcessedIE(_112,abrupt(_112)=true,_80).

initiatedAt(fighting(_110,_112)=true, _308, _80, _314) :-
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),_308=<_80,_80<_314,
     \+holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(inactive(_112)=true),_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     holdsAtProcessedIE(_112,abrupt(_112)=true,_80).

initiatedAt(fighting(_110,_112)=true, _308, _80, _314) :-
     happensAtProcessedIE(_112,end(inactive(_112)=true),_80),_308=<_80,_80<_314,
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80),
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),
     holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),
     holdsAtProcessedIE(_112,abrupt(_112)=true,_80).

terminatedAt(close24(_110,_112)=true, _148, _80, _154) :-
     happensAtProcessedIE(_110,end(distance(_110,_112,24)=true),_80),_148=<_80,_80<_154.

terminatedAt(close25(_110,_112)=true, _176, _80, _182) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_176=<_80,_80<_182,
     happensAtProcessedIE(_110,end(distance(_110,_112,25)=true),_80).

terminatedAt(close25(_110,_112)=true, _210, _80, _216) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_210=<_80,_80<_216,
     \+holdsAtProcessedIE(_110,distance(_110,_112,25)=true,_80),
     \+happensAtProcessedIE(_110,start(distance(_110,_112,25)=true),_80).

terminatedAt(close25(_110,_112)=true, _208, _80, _214) :-
     happensAtProcessedIE(_110,end(distance(_110,_112,25)=true),_80),_208=<_80,_80<_214,
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80).

terminatedAt(close30(_110,_112)=true, _176, _80, _182) :-
     happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),_176=<_80,_80<_182,
     happensAtProcessedIE(_110,end(distance(_110,_112,30)=true),_80).

terminatedAt(close30(_110,_112)=true, _210, _80, _216) :-
     happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),_210=<_80,_80<_216,
     \+holdsAtProcessedIE(_110,distance(_110,_112,30)=true,_80),
     \+happensAtProcessedIE(_110,start(distance(_110,_112,30)=true),_80).

terminatedAt(close30(_110,_112)=true, _208, _80, _214) :-
     happensAtProcessedIE(_110,end(distance(_110,_112,30)=true),_80),_208=<_80,_80<_214,
     \+happensAtProcessedSimpleFluent(_110,start(close25(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close25(_110,_112)=true,_80).

terminatedAt(close34(_110,_112)=true, _176, _80, _182) :-
     happensAtProcessedSimpleFluent(_110,end(close30(_110,_112)=true),_80),_176=<_80,_80<_182,
     happensAtProcessedIE(_110,end(distance(_110,_112,34)=true),_80).

terminatedAt(close34(_110,_112)=true, _210, _80, _216) :-
     happensAtProcessedSimpleFluent(_110,end(close30(_110,_112)=true),_80),_210=<_80,_80<_216,
     \+holdsAtProcessedIE(_110,distance(_110,_112,34)=true,_80),
     \+happensAtProcessedIE(_110,start(distance(_110,_112,34)=true),_80).

terminatedAt(close34(_110,_112)=true, _208, _80, _214) :-
     happensAtProcessedIE(_110,end(distance(_110,_112,34)=true),_80),_208=<_80,_80<_214,
     \+happensAtProcessedSimpleFluent(_110,start(close30(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close30(_110,_112)=true,_80).

terminatedAt(closeSymmetric30(_110,_112)=true, _174, _80, _180) :-
     happensAtProcessedSimpleFluent(_110,end(close30(_110,_112)=true),_80),_174=<_80,_80<_180,
     happensAtProcessedSimpleFluent(_112,end(close30(_112,_110)=true),_80).

terminatedAt(closeSymmetric30(_110,_112)=true, _206, _80, _212) :-
     happensAtProcessedSimpleFluent(_110,end(close30(_110,_112)=true),_80),_206=<_80,_80<_212,
     \+holdsAtProcessedSimpleFluent(_112,close30(_112,_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_112,start(close30(_112,_110)=true),_80).

terminatedAt(closeSymmetric30(_110,_112)=true, _206, _80, _212) :-
     happensAtProcessedSimpleFluent(_112,end(close30(_112,_110)=true),_80),_206=<_80,_80<_212,
     \+happensAtProcessedSimpleFluent(_110,start(close30(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close30(_110,_112)=true,_80).

terminatedAt(activeOrInactivePerson(_110)=true, _168, _80, _174) :-
     happensAtProcessedIE(_110,end(active(_110)=true),_80),_168=<_80,_80<_174,
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80).

terminatedAt(activeOrInactivePerson(_110)=true, _198, _80, _204) :-
     happensAtProcessedIE(_110,end(active(_110)=true),_80),_198=<_80,_80<_204,
     \+holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,start(inactive(_110)=true),_80).

terminatedAt(activeOrInactivePerson(_110)=true, _198, _80, _204) :-
     happensAtProcessedIE(_110,end(inactive(_110)=true),_80),_198=<_80,_80<_204,
     \+happensAtProcessedIE(_110,start(active(_110)=true),_80),
     \+holdsAtProcessedIE(_110,active(_110)=true,_80).

terminatedAt(activeOrInactivePerson(_110)=true, _168, _80, _174) :-
     happensAtProcessedIE(_110,end(active(_110)=true),_80),_168=<_80,_80<_174,
     happensAtProcessedSimpleFluent(_110,end(person(_110)=true),_80).

terminatedAt(activeOrInactivePerson(_110)=true, _198, _80, _204) :-
     happensAtProcessedIE(_110,end(active(_110)=true),_80),_198=<_80,_80<_204,
     \+holdsAtProcessedSimpleFluent(_110,person(_110)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,start(person(_110)=true),_80).

terminatedAt(activeOrInactivePerson(_110)=true, _198, _80, _204) :-
     happensAtProcessedSimpleFluent(_110,end(person(_110)=true),_80),_198=<_80,_80<_204,
     \+happensAtProcessedIE(_110,start(active(_110)=true),_80),
     \+holdsAtProcessedIE(_110,active(_110)=true,_80).

terminatedAt(greeting1(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedSimpleFluent(_110,end(activeOrInactivePerson(_110)=true),_80),_144=<_80,_80<_150.

terminatedAt(greeting1(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_110,end(close25(_110,_112)=true),_80),_146=<_80,_80<_152.

terminatedAt(greeting1(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedSimpleFluent(_112,end(person(_112)=true),_80),_144=<_80,_80<_150.

terminatedAt(greeting1(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedIE(_112,start(running(_112)=true),_80),_144=<_80,_80<_150.

terminatedAt(greeting1(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedIE(_112,start(abrupt(_112)=true),_80),_144=<_80,_80<_150.

terminatedAt(greeting2(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedIE(_110,end(walking(_110)=true),_80),_144=<_80,_80<_150.

terminatedAt(greeting2(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedSimpleFluent(_112,end(activeOrInactivePerson(_112)=true),_80),_144=<_80,_80<_150.

terminatedAt(greeting2(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_112,end(close25(_112,_110)=true),_80),_146=<_80,_80<_152.

terminatedAt(moving(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedIE(_110,end(walking(_110)=true),_80),_144=<_80,_80<_150.

terminatedAt(moving(_110,_112)=true, _144, _80, _150) :-
     happensAtProcessedIE(_112,end(walking(_112)=true),_80),_144=<_80,_80<_150.

terminatedAt(moving(_110,_112)=true, _146, _80, _152) :-
     happensAtProcessedSimpleFluent(_110,end(close34(_110,_112)=true),_80),_146=<_80,_80<_152.

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _200, _80, _206) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_200=<_80,_80<_206,
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _200, _80, _206) :-
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),_200=<_80,_80<_206,
     \+happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),
     \+holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _172, _80, _178) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_172=<_80,_80<_178,
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _204, _80, _210) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_204=<_80,_80<_210,
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _202, _80, _208) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_202=<_80,_80<_208,
     \+happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),
     \+holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_196=<_80,_80<_202,
     holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _200, _80, _206) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_200=<_80,_80<_206,
     \+happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),
     \+holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_110,end(abrupt(_110)=true),_80),_196=<_80,_80<_202,
     holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _200, _80, _206) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_200=<_80,_80<_206,
     \+happensAtProcessedIE(_110,start(abrupt(_110)=true),_80),
     \+holdsAtProcessedIE(_110,abrupt(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _172, _80, _178) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_172=<_80,_80<_178,
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _202, _80, _208) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_202=<_80,_80<_208,
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _204, _80, _210) :-
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),_204=<_80,_80<_210,
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80).

terminatedAt(fighting(_110,_112)=true, _174, _80, _180) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_174=<_80,_80<_180,
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _206, _80, _212) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_206=<_80,_80<_212,
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _206, _80, _212) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_206=<_80,_80<_212,
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80).

terminatedAt(fighting(_110,_112)=true, _172, _80, _178) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_172=<_80,_80<_178,
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _198, _80, _204) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_198=<_80,_80<_204,
     holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _204, _80, _210) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_204=<_80,_80<_210,
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80).

terminatedAt(fighting(_110,_112)=true, _172, _80, _178) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_172=<_80,_80<_178,
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _198, _80, _204) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_198=<_80,_80<_204,
     holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _204, _80, _210) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_204=<_80,_80<_210,
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80),
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _200, _80, _206) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_200=<_80,_80<_206,
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),_196=<_80,_80<_202,
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     holdsAtProcessedIE(_110,inactive(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _172, _80, _178) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_172=<_80,_80<_178,
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _204, _80, _210) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_204=<_80,_80<_210,
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _198, _80, _204) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_198=<_80,_80<_204,
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     holdsAtProcessedIE(_110,inactive(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_196=<_80,_80<_202,
     holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_196=<_80,_80<_202,
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     holdsAtProcessedIE(_110,inactive(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_196=<_80,_80<_202,
     holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_196=<_80,_80<_202,
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80),
     holdsAtProcessedIE(_110,inactive(_110)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _200, _80, _206) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_200=<_80,_80<_206,
     \+holdsAtProcessedIE(_112,abrupt(_112)=true,_80),
     \+happensAtProcessedIE(_112,start(abrupt(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_112,end(abrupt(_112)=true),_80),_196=<_80,_80<_202,
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     holdsAtProcessedIE(_112,inactive(_112)=true,_80).

terminatedAt(fighting(_110,_112)=true, _172, _80, _178) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_172=<_80,_80<_178,
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _204, _80, _210) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_204=<_80,_80<_210,
     \+holdsAtProcessedSimpleFluent(_110,close24(_110,_112)=true,_80),
     \+happensAtProcessedSimpleFluent(_110,start(close24(_110,_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _198, _80, _204) :-
     happensAtProcessedSimpleFluent(_110,end(close24(_110,_112)=true),_80),_198=<_80,_80<_204,
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     holdsAtProcessedIE(_112,inactive(_112)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_196=<_80,_80<_202,
     holdsAtProcessedIE(_110,inactive(_110)=true,_80),
     \+happensAtProcessedIE(_110,end(inactive(_110)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_110,start(inactive(_110)=true),_80),_196=<_80,_80<_202,
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     holdsAtProcessedIE(_112,inactive(_112)=true,_80).

terminatedAt(fighting(_110,_112)=true, _170, _80, _176) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_170=<_80,_80<_176,
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_196=<_80,_80<_202,
     holdsAtProcessedIE(_112,inactive(_112)=true,_80),
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80).

terminatedAt(fighting(_110,_112)=true, _196, _80, _202) :-
     happensAtProcessedIE(_112,start(inactive(_112)=true),_80),_196=<_80,_80<_202,
     \+happensAtProcessedIE(_112,end(inactive(_112)=true),_80),
     holdsAtProcessedIE(_112,inactive(_112)=true,_80).

buildFromPoints2(_84, walking(_84)=true) :-
     id(_84).

buildFromPoints2(_84, active(_84)=true) :-
     id(_84).

buildFromPoints2(_84, inactive(_84)=true) :-
     id(_84).

buildFromPoints2(_84, running(_84)=true) :-
     id(_84).

buildFromPoints2(_84, abrupt(_84)=true) :-
     id(_84).

points(orientation(_406)=_402).

points(appearance(_406)=_402).

points(coord(_406,_408,_410)=true).

points(walking(_406)=true).

points(active(_406)=true).

points(inactive(_406)=true).

points(running(_406)=true).

points(abrupt(_406)=true).

grounding(appear(_406)) :- 
     id(_406).

grounding(disappear(_406)) :- 
     id(_406).

grounding(orientation(_412)=_408) :- 
     id(_412).

grounding(appearance(_412)=_408) :- 
     id(_412).

grounding(coord(_412,_414,_416)=_408) :- 
     id(_412).

grounding(walking(_412)=_408) :- 
     id(_412).

grounding(active(_412)=_408) :- 
     id(_412).

grounding(inactive(_412)=_408) :- 
     id(_412).

grounding(running(_412)=_408) :- 
     id(_412).

grounding(abrupt(_412)=_408) :- 
     id(_412).

grounding(close24(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(close25(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(close30(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(close34(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(closeSymmetric30(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(walking(_412)=true) :- 
     id(_412).

grounding(active(_412)=true) :- 
     id(_412).

grounding(inactive(_412)=true) :- 
     id(_412).

grounding(abrupt(_412)=true) :- 
     id(_412).

grounding(running(_412)=true) :- 
     id(_412).

grounding(person(_412)=true) :- 
     id(_412).

grounding(activeOrInactivePerson(_412)=true) :- 
     id(_412).

grounding(greeting1(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(greeting2(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(leaving_object(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(moving(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

grounding(fighting(_412,_414)=true) :- 
     id(_412),id(_414),_412@<_414.

inputEntity(walking(_140)=true).
inputEntity(disappear(_134)).
inputEntity(running(_140)=true).
inputEntity(active(_140)=true).
inputEntity(abrupt(_140)=true).
inputEntity(appear(_134)).
inputEntity(inactive(_140)=true).
inputEntity(distance(_140,_142,_144)=true).
inputEntity(orientation(_140)=_136).
inputEntity(appearance(_140)=_136).
inputEntity(coord(_140,_142,_144)=_136).

outputEntity(person(_262)=true).
outputEntity(person(_262)=false).
outputEntity(leaving_object(_262,_264)=true).
outputEntity(leaving_object(_262,_264)=false).
outputEntity(close24(_262,_264)=true).
outputEntity(close25(_262,_264)=true).
outputEntity(close30(_262,_264)=true).
outputEntity(close34(_262,_264)=true).
outputEntity(closeSymmetric30(_262,_264)=true).
outputEntity(greeting1(_262,_264)=true).
outputEntity(greeting2(_262,_264)=true).
outputEntity(activeOrInactivePerson(_262)=true).
outputEntity(moving(_262,_264)=true).
outputEntity(fighting(_262,_264)=true).

event(disappear(_396)).
event(appear(_396)).

simpleFluent(person(_470)=true).
simpleFluent(person(_470)=false).
simpleFluent(leaving_object(_470,_472)=true).
simpleFluent(leaving_object(_470,_472)=false).
simpleFluent(close24(_470,_472)=true).
simpleFluent(close25(_470,_472)=true).
simpleFluent(close30(_470,_472)=true).
simpleFluent(close34(_470,_472)=true).
simpleFluent(closeSymmetric30(_470,_472)=true).
simpleFluent(activeOrInactivePerson(_470)=true).
simpleFluent(greeting1(_470,_472)=true).
simpleFluent(greeting2(_470,_472)=true).
simpleFluent(moving(_470,_472)=true).
simpleFluent(fighting(_470,_472)=true).

sDFluent(walking(_610)=true).
sDFluent(running(_610)=true).
sDFluent(active(_610)=true).
sDFluent(abrupt(_610)=true).
sDFluent(inactive(_610)=true).
sDFluent(distance(_610,_612,_614)=true).
sDFluent(orientation(_610)=_606).
sDFluent(appearance(_610)=_606).
sDFluent(coord(_610,_612,_614)=_606).

index(disappear(_666),_666).
index(appear(_666),_666).
index(person(_666)=true,_666).
index(person(_666)=false,_666).
index(leaving_object(_666,_726)=true,_666).
index(leaving_object(_666,_726)=false,_666).
index(close24(_666,_726)=true,_666).
index(close25(_666,_726)=true,_666).
index(close30(_666,_726)=true,_666).
index(close34(_666,_726)=true,_666).
index(closeSymmetric30(_666,_726)=true,_666).
index(activeOrInactivePerson(_666)=true,_666).
index(greeting1(_666,_726)=true,_666).
index(greeting2(_666,_726)=true,_666).
index(moving(_666,_726)=true,_666).
index(fighting(_666,_726)=true,_666).
index(walking(_666)=true,_666).
index(running(_666)=true,_666).
index(active(_666)=true,_666).
index(abrupt(_666)=true,_666).
index(inactive(_666)=true,_666).
index(distance(_666,_726,_728)=true,_666).
index(orientation(_666)=_720,_666).
index(appearance(_666)=_720,_666).
index(coord(_666,_726,_728)=_720,_666).


cachingOrder2(_1120, person(_1120)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1120).

cachingOrder2(_1050, close24(_1050,_1052)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_1050),id(_1052),_1050@<_1052.

cachingOrder2(_1414, close25(_1414,_1416)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1414),id(_1416),_1414@<_1416.

cachingOrder2(_1392, activeOrInactivePerson(_1392)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1392).

cachingOrder2(_1368, fighting(_1368,_1370)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_1368),id(_1370),_1368@<_1370.

cachingOrder2(_1820, close30(_1820,_1822)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1820),id(_1822),_1820@<_1822.

cachingOrder2(_1796, greeting1(_1796,_1798)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1796),id(_1798),_1796@<_1798.

cachingOrder2(_1772, greeting2(_1772,_1774)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_1772),id(_1774),_1772@<_1774.

cachingOrder2(_2240, close34(_2240,_2242)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2240),id(_2242),_2240@<_2242.

cachingOrder2(_2216, closeSymmetric30(_2216,_2218)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_2216),id(_2218),_2216@<_2218.

cachingOrder2(_2552, leaving_object(_2552,_2554)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2552),id(_2554),_2552@<_2554.

cachingOrder2(_2528, moving(_2528,_2530)=true) :- % level in dependency graph: 5, processing order in component: 1
     id(_2528),id(_2530),_2528@<_2530.

collectGrounds([walking(_738)=true, walking(_738)=true, disappear(_738), running(_738)=true, running(_738)=true, active(_738)=true, active(_738)=true, abrupt(_738)=true, abrupt(_738)=true, appear(_738), inactive(_738)=true, inactive(_738)=true, orientation(_738)=_752, appearance(_738)=_752, coord(_738,_758,_760)=_752],id(_738)).

dgrounded(person(_1420)=true, id(_1420)).
dgrounded(leaving_object(_1364,_1366)=true, id(_1364)).
dgrounded(leaving_object(_1364,_1366)=true, id(_1366)).
dgrounded(close24(_1308,_1310)=true, id(_1308)).
dgrounded(close24(_1308,_1310)=true, id(_1310)).
dgrounded(close25(_1252,_1254)=true, id(_1252)).
dgrounded(close25(_1252,_1254)=true, id(_1254)).
dgrounded(close30(_1196,_1198)=true, id(_1196)).
dgrounded(close30(_1196,_1198)=true, id(_1198)).
dgrounded(close34(_1140,_1142)=true, id(_1140)).
dgrounded(close34(_1140,_1142)=true, id(_1142)).
dgrounded(closeSymmetric30(_1084,_1086)=true, id(_1084)).
dgrounded(closeSymmetric30(_1084,_1086)=true, id(_1086)).
dgrounded(greeting1(_1028,_1030)=true, id(_1028)).
dgrounded(greeting1(_1028,_1030)=true, id(_1030)).
dgrounded(greeting2(_972,_974)=true, id(_972)).
dgrounded(greeting2(_972,_974)=true, id(_974)).
dgrounded(activeOrInactivePerson(_940)=true, id(_940)).
dgrounded(moving(_884,_886)=true, id(_884)).
dgrounded(moving(_884,_886)=true, id(_886)).
dgrounded(fighting(_828,_830)=true, id(_828)).
dgrounded(fighting(_828,_830)=true, id(_830)).
