:- dynamic person/1.

initiatedAt(status(_96)=null, _106, -1, _114) :-
     _106=< -1,
     -1<_114.

initiatedAt(status(_106)=proposed, _152, _76, _158) :-
     happensAtIE(propose(_110,_106),_76),_152=<_76,_76<_158,
     holdsAtCyclic(_106,status(_106)=null,_76).

initiatedAt(status(_106)=voting, _152, _76, _158) :-
     happensAtIE(second(_110,_106),_76),_152=<_76,_76<_158,
     holdsAtCyclic(_106,status(_106)=proposed,_76).

initiatedAt(status(_106)=voted, _164, _76, _170) :-
     happensAtIE(close_ballot(_110,_106),_76),_164=<_76,_76<_170,
     role_of(_110,chair),
     holdsAtCyclic(_106,status(_106)=voting,_76).

initiatedAt(status(_106)=null, _166, _76, _172) :-
     happensAtIE(declare(_110,_106,_114),_76),_166=<_76,_76<_172,
     role_of(_110,chair),
     holdsAtCyclic(_106,status(_106)=voted,_76).

initiatedAt(voted(_106,_108)=_82, _150, _76, _156) :-
     happensAtIE(vote(_106,_108,_82),_76),_150=<_76,_76<_156,
     holdsAtProcessedSimpleFluent(_108,status(_108)=voting,_76).

initiatedAt(voted(_106,_108)=null, _134, _76, _140) :-
     happensAtProcessedSimpleFluent(_108,start(status(_108)=null),_76),
     _134=<_76,
     _76<_140.

initiatedAt(outcome(_106)=_82, _160, _76, _166) :-
     happensAtIE(declare(_110,_106,_82),_76),_160=<_76,_76<_166,
     holdsAtProcessedSimpleFluent(_106,status(_106)=voted,_76),
     role_of(_110,chair).

initiatedAt(auxPerCloseBallot(_106)=true, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(status(_106)=voting),_76),
     _132=<_76,
     _76<_138.

initiatedAt(auxPerCloseBallot(_106)=false, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(status(_106)=proposed),_76),
     _132=<_76,
     _76<_138.

initiatedAt(per(close_ballot(_110,_112))=true, _160, _76, _166) :-
     happensAtProcessedSimpleFluent(_112,end(auxPerCloseBallot(_112)=true),_76),_160=<_76,_76<_166,
     holdsAtProcessedSimpleFluent(_112,status(_112)=voting,_76).

initiatedAt(per(close_ballot(_110,_112))=false, _138, _76, _144) :-
     happensAtProcessedSimpleFluent(_112,start(status(_112)=voted),_76),
     _138=<_76,
     _76<_144.

initiatedAt(obl(declare(_110,_112,carried))=true, _132, _76, _138) :-
     happensAtProcessed(_112,auxMotionOutcomeEvent(_112,carried),_76),
     _132=<_76,
     _76<_138.

initiatedAt(obl(declare(_110,_112,carried))=false, _140, _76, _146) :-
     happensAtProcessedSimpleFluent(_112,start(status(_112)=null),_76),
     _140=<_76,
     _76<_146.

initiatedAt(sanctioned(_106)=true, _156, _76, _162) :-
     happensAtIE(close_ballot(_106,_112),_76),_156=<_76,_76<_162,
     \+holdsAtProcessedSimpleFluent(_106,per(close_ballot(_106,_112))=true,_76).

initiatedAt(sanctioned(_106)=true, _186, _76, _192) :-
     happensAtProcessedSimpleFluent(_120,end(status(_120)=voted),_76),_186=<_76,_76<_192,
     \+happensAtIE(declare(_106,_120,carried),_76),
     holdsAtProcessedSimpleFluent(_106,obl(declare(_106,_120,carried))=true,_76).

initiatedAt(sanctioned(_106)=true, _190, _76, _196) :-
     happensAtProcessedSimpleFluent(_120,end(status(_120)=voted),_76),_190=<_76,_76<_196,
     \+happensAtIE(declare(_106,_120,not_carried),_76),
     \+holdsAtProcessedSimpleFluent(_106,obl(declare(_106,_120,carried))=true,_76).

terminatedAt(outcome(_106)=_82, _132, _76, _138) :-
     happensAtProcessedSimpleFluent(_106,start(status(_106)=proposed),_76),
     _132=<_76,
     _76<_138.

holdsForSDFluent(pow(propose(_110,_112))=true,_76) :-
     holdsForProcessedSimpleFluent(_112,status(_112)=null,_76).

holdsForSDFluent(pow(second(_110,_112))=true,_76) :-
     holdsForProcessedSimpleFluent(_112,status(_112)=proposed,_76).

holdsForSDFluent(pow(vote(_110,_112))=true,_76) :-
     holdsForProcessedSimpleFluent(_112,status(_112)=voting,_76).

holdsForSDFluent(pow(close_ballot(_110,_112))=true,_76) :-
     holdsForProcessedSimpleFluent(_112,status(_112)=voting,_76).

holdsForSDFluent(pow(declare(_110,_112))=true,_76) :-
     holdsForProcessedSimpleFluent(_112,status(_112)=voted,_76).

happensAtEv(auxMotionOutcomeEvent(_94,carried),_76) :-
     happensAtProcessedSimpleFluent(_94,start(status(_94)=voted),_76),
     findall(_132,holdsAtProcessedSimpleFluent(_132,voted(_132,_94)=aye,_76),_142),
     length(_142,_148),
     findall(_132,holdsAtProcessedSimpleFluent(_132,voted(_132,_94)=nay,_76),_174),
     length(_174,_180),
     _148>=_180.

fi(status(_110)=proposed,status(_110)=null,10):-
     grounding(status(_110)=proposed),
     grounding(status(_110)=null).

fi(status(_110)=voting,status(_110)=voted,10):-
     grounding(status(_110)=voting),
     grounding(status(_110)=voted).

fi(status(_110)=voted,status(_110)=null,10):-
     grounding(status(_110)=voted),
     grounding(status(_110)=null).

fi(auxPerCloseBallot(_110)=true,auxPerCloseBallot(_110)=false,8):-
     grounding(auxPerCloseBallot(_110)=true),
     grounding(auxPerCloseBallot(_110)=false).

fi(sanctioned(_110)=true,sanctioned(_110)=false,4):-
     grounding(sanctioned(_110)=true),
     grounding(sanctioned(_110)=false).

grounding(propose(_442,_444)) :- 
     person(_442),motion(_444).

grounding(second(_442,_444)) :- 
     person(_442),motion(_444).

grounding(vote(_442,_444,_446)) :- 
     person(_442),motion(_444).

grounding(close_ballot(_442,_444)) :- 
     person(_442),motion(_444).

grounding(declare(_442,_444,_446)) :- 
     person(_442),motion(_444).

grounding(status(_448)=null) :- 
     queryMotion(_448).

grounding(status(_448)=proposed) :- 
     queryMotion(_448).

grounding(status(_448)=voting) :- 
     queryMotion(_448).

grounding(status(_448)=voted) :- 
     queryMotion(_448).

grounding(voted(_448,_450)=aye) :- 
     person(_448),role_of(_448,voter),queryMotion(_450).

grounding(voted(_448,_450)=nay) :- 
     person(_448),role_of(_448,voter),queryMotion(_450).

grounding(auxMotionOutcomeEvent(_442,_444)) :- 
     queryMotion(_442).

grounding(outcome(_448)=carried) :- 
     queryMotion(_448).

grounding(outcome(_448)=not_carried) :- 
     queryMotion(_448).

grounding(auxPerCloseBallot(_448)=true) :- 
     queryMotion(_448).

grounding(per(close_ballot(_452,_454))=true) :- 
     person(_452),role_of(_452,chair),queryMotion(_454).

grounding(obl(declare(_452,_454,carried))=true) :- 
     person(_452),role_of(_452,chair),queryMotion(_454).

grounding(sanctioned(_448)=true) :- 
     person(_448),role_of(_448,chair).

grounding(auxPerCloseBallot(_448)=false) :- 
     queryMotion(_448).

grounding(per(close_ballot(_452,_454))=false) :- 
     person(_452),role_of(_452,chair),queryMotion(_454).

grounding(obl(declare(_452,_454,carried))=false) :- 
     person(_452),role_of(_452,chair),queryMotion(_454).

grounding(sanctioned(_448)=false) :- 
     person(_448),role_of(_448,chair).

grounding(pow(propose(_452,_454))=true) :- 
     person(_452),queryMotion(_454).

grounding(pow(second(_452,_454))=true) :- 
     person(_452),queryMotion(_454).

grounding(pow(vote(_452,_454))=true) :- 
     person(_452),queryMotion(_454).

grounding(pow(close_ballot(_452,_454))=true) :- 
     person(_452),queryMotion(_454).

grounding(pow(declare(_452,_454))=true) :- 
     person(_452),queryMotion(_454).

inputEntity(propose(_130,_132)).
inputEntity(second(_130,_132)).
inputEntity(close_ballot(_130,_132)).
inputEntity(declare(_130,_132,_134)).
inputEntity(vote(_130,_132,_134)).

outputEntity(status(_222)=proposed).
outputEntity(status(_222)=voting).
outputEntity(status(_222)=voted).
outputEntity(status(_222)=null).
outputEntity(voted(_222,_224)=aye).
outputEntity(voted(_222,_224)=nay).
outputEntity(voted(_222,_224)=null).
outputEntity(outcome(_222)=carried).
outputEntity(outcome(_222)=not_carried).
outputEntity(auxPerCloseBallot(_222)=true).
outputEntity(auxPerCloseBallot(_222)=false).
outputEntity(per(close_ballot(_226,_228))=true).
outputEntity(per(close_ballot(_226,_228))=false).
outputEntity(obl(declare(_226,_228,_230))=true).
outputEntity(obl(declare(_226,_228,_230))=false).
outputEntity(sanctioned(_222)=true).
outputEntity(sanctioned(_222)=false).
outputEntity(pow(propose(_226,_228))=true).
outputEntity(pow(second(_226,_228))=true).
outputEntity(pow(vote(_226,_228))=true).
outputEntity(pow(close_ballot(_226,_228))=true).
outputEntity(pow(declare(_226,_228))=true).
outputEntity(auxMotionOutcomeEvent(_216,_218)).

event(auxMotionOutcomeEvent(_410,_412)).
event(propose(_410,_412)).
event(second(_410,_412)).
event(close_ballot(_410,_412)).
event(declare(_410,_412,_414)).
event(vote(_410,_412,_414)).

simpleFluent(status(_508)=proposed).
simpleFluent(status(_508)=voting).
simpleFluent(status(_508)=voted).
simpleFluent(status(_508)=null).
simpleFluent(voted(_508,_510)=aye).
simpleFluent(voted(_508,_510)=nay).
simpleFluent(voted(_508,_510)=null).
simpleFluent(outcome(_508)=carried).
simpleFluent(outcome(_508)=not_carried).
simpleFluent(auxPerCloseBallot(_508)=true).
simpleFluent(auxPerCloseBallot(_508)=false).
simpleFluent(per(close_ballot(_512,_514))=true).
simpleFluent(per(close_ballot(_512,_514))=false).
simpleFluent(obl(declare(_512,_514,_516))=true).
simpleFluent(obl(declare(_512,_514,_516))=false).
simpleFluent(sanctioned(_508)=true).
simpleFluent(sanctioned(_508)=false).

sDFluent(pow(propose(_670,_672))=true).
sDFluent(pow(second(_670,_672))=true).
sDFluent(pow(vote(_670,_672))=true).
sDFluent(pow(close_ballot(_670,_672))=true).
sDFluent(pow(declare(_670,_672))=true).

index(auxMotionOutcomeEvent(_698,_752),_698).
index(propose(_698,_752),_698).
index(second(_698,_752),_698).
index(close_ballot(_698,_752),_698).
index(declare(_698,_752,_754),_698).
index(vote(_698,_752,_754),_698).
index(status(_698)=proposed,_698).
index(status(_698)=voting,_698).
index(status(_698)=voted,_698).
index(status(_698)=null,_698).
index(voted(_698,_758)=aye,_698).
index(voted(_698,_758)=nay,_698).
index(voted(_698,_758)=null,_698).
index(outcome(_698)=carried,_698).
index(outcome(_698)=not_carried,_698).
index(auxPerCloseBallot(_698)=true,_698).
index(auxPerCloseBallot(_698)=false,_698).
index(per(close_ballot(_698,_762))=true,_698).
index(per(close_ballot(_698,_762))=false,_698).
index(obl(declare(_698,_762,_764))=true,_698).
index(obl(declare(_698,_762,_764))=false,_698).
index(sanctioned(_698)=true,_698).
index(sanctioned(_698)=false,_698).
index(pow(propose(_698,_762))=true,_698).
index(pow(second(_698,_762))=true,_698).
index(pow(vote(_698,_762))=true,_698).
index(pow(close_ballot(_698,_762))=true,_698).
index(pow(declare(_698,_762))=true,_698).

cyclic(status(_1040)=proposed).
cyclic(status(_1040)=voting).
cyclic(status(_1040)=voted).
cyclic(status(_1040)=null).

cachingOrder2(_1164, status(_1164)=voting) :- % level in dependency graph: 1, processing order in component: 1
     queryMotion(_1164).

cachingOrder2(_1180, status(_1180)=voted) :- % level in dependency graph: 1, processing order in component: 2
     queryMotion(_1180).

cachingOrder2(_1196, status(_1196)=proposed) :- % level in dependency graph: 1, processing order in component: 3
     queryMotion(_1196).

cachingOrder2(_1212, status(_1212)=null) :- % level in dependency graph: 1, processing order in component: 4
     queryMotion(_1212).

cachingOrder2(_1890, voted(_1890,_1892)=aye) :- % level in dependency graph: 2, processing order in component: 1
     person(_1890),role_of(_1890,voter),queryMotion(_1892).

cachingOrder2(_1866, voted(_1866,_1868)=nay) :- % level in dependency graph: 2, processing order in component: 1
     person(_1866),role_of(_1866,voter),queryMotion(_1868).

cachingOrder2(_1820, outcome(_1820)=carried) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_1820).

cachingOrder2(_1798, outcome(_1798)=not_carried) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_1798).

cachingOrder2(_1760, auxPerCloseBallot(_1760)=true) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_1760).

cachingOrder2(_1760, auxPerCloseBallot(_1760)=false) :- % level in dependency graph: 2, processing order in component: 2
     queryMotion(_1760).

cachingOrder2(_1736, per(close_ballot(_1736,_1738))=false) :- % level in dependency graph: 2, processing order in component: 1
     person(_1736),role_of(_1736,chair),queryMotion(_1738).

cachingOrder2(_1706, obl(declare(_1706,_1708,_2668))=false) :- % level in dependency graph: 2, processing order in component: 1
     person(_1706),role_of(_1706,chair),queryMotion(_1708).

cachingOrder2(_1678, pow(propose(_1678,_1680))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1678),queryMotion(_1680).

cachingOrder2(_1650, pow(second(_1650,_1652))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1650),queryMotion(_1652).

cachingOrder2(_1622, pow(vote(_1622,_1624))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1622),queryMotion(_1624).

cachingOrder2(_1594, pow(close_ballot(_1594,_1596))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1594),queryMotion(_1596).

cachingOrder2(_1566, pow(declare(_1566,_1568))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1566),queryMotion(_1568).

cachingOrder2(_3430, per(close_ballot(_3430,_3432))=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_3430),role_of(_3430,chair),queryMotion(_3432).

cachingOrder2(_3402, auxMotionOutcomeEvent(_3402,_3404)) :- % level in dependency graph: 3, processing order in component: 1
     queryMotion(_3402).

cachingOrder2(_3722, obl(declare(_3722,_3724,_3864))=true) :- % level in dependency graph: 4, processing order in component: 1
     person(_3722),role_of(_3722,chair),queryMotion(_3724).

cachingOrder2(_3954, sanctioned(_3954)=true) :- % level in dependency graph: 5, processing order in component: 1
     person(_3954),role_of(_3954,chair).

cachingOrder2(_3954, sanctioned(_3954)=false) :- % level in dependency graph: 5, processing order in component: 2
     person(_3954),role_of(_3954,chair).

collectGrounds([propose(_396,_410), second(_396,_410), close_ballot(_396,_410), declare(_396,_410,_412), vote(_396,_410,_412)],person(_396)).

dgrounded(voted(_1270,_1272)=aye, person(_1270)).
dgrounded(voted(_1214,_1216)=nay, person(_1214)).
dgrounded(per(close_ballot(_1030,_1032))=true, person(_1030)).
dgrounded(per(close_ballot(_970,_972))=false, person(_970)).
dgrounded(obl(declare(_908,_910,carried))=true, person(_908)).
dgrounded(obl(declare(_846,_848,carried))=false, person(_846)).
dgrounded(sanctioned(_798)=true, person(_798)).
dgrounded(sanctioned(_754)=false, person(_754)).
dgrounded(pow(propose(_710,_712))=true, person(_710)).
dgrounded(pow(second(_662,_664))=true, person(_662)).
dgrounded(pow(vote(_614,_616))=true, person(_614)).
dgrounded(pow(close_ballot(_566,_568))=true, person(_566)).
dgrounded(pow(declare(_518,_520))=true, person(_518)).
