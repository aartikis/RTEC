:- dynamic person/1.

initiatedAt(status(_98)=null, _108, -1, _116) :-
     _108=< -1,
     -1<_116.

initiatedAt(status(_108)=proposed, _154, _78, _160) :-
     happensAtIE(propose(_112,_108),_78),_154=<_78,_78<_160,
     holdsAtCyclic(_108,status(_108)=null,_78).

initiatedAt(status(_108)=voting, _154, _78, _160) :-
     happensAtIE(second(_112,_108),_78),_154=<_78,_78<_160,
     holdsAtCyclic(_108,status(_108)=proposed,_78).

initiatedAt(status(_108)=voted, _166, _78, _172) :-
     happensAtIE(close_ballot(_112,_108),_78),_166=<_78,_78<_172,
     role_of(_112,chair),
     holdsAtCyclic(_108,status(_108)=voting,_78).

initiatedAt(status(_108)=null, _168, _78, _174) :-
     happensAtIE(declare(_112,_108,_116),_78),_168=<_78,_78<_174,
     role_of(_112,chair),
     holdsAtCyclic(_108,status(_108)=voted,_78).

initiatedAt(voted(_108,_110)=_84, _152, _78, _158) :-
     happensAtIE(vote(_108,_110,_84),_78),_152=<_78,_78<_158,
     holdsAtProcessedSimpleFluent(_110,status(_110)=voting,_78).

initiatedAt(voted(_108,_110)=null, _136, _78, _142) :-
     happensAtProcessedSimpleFluent(_110,start(status(_110)=null),_78),
     _136=<_78,
     _78<_142.

initiatedAt(outcome(_108)=_84, _162, _78, _168) :-
     happensAtIE(declare(_112,_108,_84),_78),_162=<_78,_78<_168,
     holdsAtProcessedSimpleFluent(_108,status(_108)=voted,_78),
     role_of(_112,chair).

initiatedAt(auxPerCloseBallot(_108)=true, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(status(_108)=voting),_78),
     _134=<_78,
     _78<_140.

initiatedAt(auxPerCloseBallot(_108)=false, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(status(_108)=proposed),_78),
     _134=<_78,
     _78<_140.

initiatedAt(per(close_ballot(_112,_114))=true, _162, _78, _168) :-
     happensAtProcessedSimpleFluent(_114,end(auxPerCloseBallot(_114)=true),_78),_162=<_78,_78<_168,
     holdsAtProcessedSimpleFluent(_114,status(_114)=voting,_78).

initiatedAt(per(close_ballot(_112,_114))=false, _140, _78, _146) :-
     happensAtProcessedSimpleFluent(_114,start(status(_114)=voted),_78),
     _140=<_78,
     _78<_146.

initiatedAt(obl(declare(_112,_114,carried))=true, _134, _78, _140) :-
     happensAtProcessed(_114,auxMotionOutcomeEvent(_114,carried),_78),
     _134=<_78,
     _78<_140.

initiatedAt(obl(declare(_112,_114,carried))=false, _142, _78, _148) :-
     happensAtProcessedSimpleFluent(_114,start(status(_114)=null),_78),
     _142=<_78,
     _78<_148.

initiatedAt(sanctioned(_108)=true, _158, _78, _164) :-
     happensAtIE(close_ballot(_108,_114),_78),_158=<_78,_78<_164,
     \+holdsAtProcessedSimpleFluent(_108,per(close_ballot(_108,_114))=true,_78).

initiatedAt(sanctioned(_108)=true, _188, _78, _194) :-
     happensAtProcessedSimpleFluent(_122,end(status(_122)=voted),_78),_188=<_78,_78<_194,
     \+happensAtIE(declare(_108,_122,carried),_78),
     holdsAtProcessedSimpleFluent(_108,obl(declare(_108,_122,carried))=true,_78).

initiatedAt(sanctioned(_108)=true, _192, _78, _198) :-
     happensAtProcessedSimpleFluent(_122,end(status(_122)=voted),_78),_192=<_78,_78<_198,
     \+happensAtIE(declare(_108,_122,not_carried),_78),
     \+holdsAtProcessedSimpleFluent(_108,obl(declare(_108,_122,carried))=true,_78).

terminatedAt(outcome(_108)=_84, _134, _78, _140) :-
     happensAtProcessedSimpleFluent(_108,start(status(_108)=proposed),_78),
     _134=<_78,
     _78<_140.

holdsForSDFluent(proposed2voted(_108)=true,_78) :-
     holdsForProcessedSimpleFluent(_108,status(_108)=proposed,_124),
     holdsForProcessedSimpleFluent(_108,status(_108)=voted,_140),
     seq(_124,_140,_78).

holdsForSDFluent(powPropose2vote(_108,_110)=true,_78) :-
     holdsForProcessedSDFluent(_108,pow(propose(_108,_110))=true,_132),
     holdsForProcessedSDFluent(_108,pow(vote(_108,_110))=true,_154),
     seq(_132,_154,_78).

holdsForSDFluent(pow(propose(_112,_114))=true,_78) :-
     holdsForProcessedSimpleFluent(_114,status(_114)=null,_78).

holdsForSDFluent(pow(second(_112,_114))=true,_78) :-
     holdsForProcessedSimpleFluent(_114,status(_114)=proposed,_78).

holdsForSDFluent(pow(vote(_112,_114))=true,_78) :-
     holdsForProcessedSimpleFluent(_114,status(_114)=voting,_78).

holdsForSDFluent(pow(close_ballot(_112,_114))=true,_78) :-
     holdsForProcessedSimpleFluent(_114,status(_114)=voting,_78).

holdsForSDFluent(pow(declare(_112,_114))=true,_78) :-
     holdsForProcessedSimpleFluent(_114,status(_114)=voted,_78).

happensAtEv(auxMotionOutcomeEvent(_96,carried),_78) :-
     happensAtProcessedSimpleFluent(_96,start(status(_96)=voted),_78),
     findall(_134,holdsAtProcessedSimpleFluent(_134,voted(_134,_96)=aye,_78),_144),
     length(_144,_150),
     findall(_134,holdsAtProcessedSimpleFluent(_134,voted(_134,_96)=nay,_78),_176),
     length(_176,_182),
     _150>=_182.

fi(status(_112)=proposed,status(_112)=null,160):-
     grounding(status(_112)=proposed),
     grounding(status(_112)=null).

fi(status(_112)=voting,status(_112)=voted,160):-
     grounding(status(_112)=voting),
     grounding(status(_112)=voted).

fi(status(_112)=voted,status(_112)=null,160):-
     grounding(status(_112)=voted),
     grounding(status(_112)=null).

fi(auxPerCloseBallot(_112)=true,auxPerCloseBallot(_112)=false,8):-
     grounding(auxPerCloseBallot(_112)=true),
     grounding(auxPerCloseBallot(_112)=false).

fi(sanctioned(_112)=true,sanctioned(_112)=false,4):-
     grounding(sanctioned(_112)=true),
     grounding(sanctioned(_112)=false).

grounding(propose(_444,_446)) :- 
     person(_444),motion(_446).

grounding(second(_444,_446)) :- 
     person(_444),motion(_446).

grounding(vote(_444,_446,_448)) :- 
     person(_444),motion(_446).

grounding(close_ballot(_444,_446)) :- 
     person(_444),motion(_446).

grounding(declare(_444,_446,_448)) :- 
     person(_444),motion(_446).

grounding(status(_450)=null) :- 
     queryMotion(_450).

grounding(status(_450)=proposed) :- 
     queryMotion(_450).

grounding(status(_450)=voting) :- 
     queryMotion(_450).

grounding(status(_450)=voted) :- 
     queryMotion(_450).

grounding(pow(propose(_454,_456))=true) :- 
     person(_454),queryMotion(_456).

grounding(pow(second(_454,_456))=true) :- 
     person(_454),queryMotion(_456).

grounding(pow(vote(_454,_456))=true) :- 
     person(_454),queryMotion(_456).

grounding(pow(close_ballot(_454,_456))=true) :- 
     person(_454),queryMotion(_456).

grounding(pow(declare(_454,_456))=true) :- 
     person(_454),queryMotion(_456).

grounding(proposed2voted(_450)=true) :- 
     queryMotion(_450).

grounding(powPropose2vote(_450,_452)=true) :- 
     person(_450),queryMotion(_452).

grounding(voted(_450,_452)=aye) :- 
     person(_450),role_of(_450,voter),queryMotion(_452).

grounding(voted(_450,_452)=nay) :- 
     person(_450),role_of(_450,voter),queryMotion(_452).

grounding(aye2nay(_450)=true) :- 
     person(_450).

grounding(auxMotionOutcomeEvent(_444,_446)) :- 
     queryMotion(_444).

grounding(outcome(_450)=carried) :- 
     queryMotion(_450).

grounding(outcome(_450)=not_carried) :- 
     queryMotion(_450).

grounding(auxPerCloseBallot(_450)=true) :- 
     queryMotion(_450).

grounding(per(close_ballot(_454,_456))=true) :- 
     person(_454),role_of(_454,chair),queryMotion(_456).

grounding(obl(declare(_454,_456,carried))=true) :- 
     person(_454),role_of(_454,chair),queryMotion(_456).

grounding(sanctioned(_450)=true) :- 
     person(_450),role_of(_450,chair).

grounding(auxPerCloseBallot(_450)=false) :- 
     queryMotion(_450).

grounding(per(close_ballot(_454,_456))=false) :- 
     person(_454),role_of(_454,chair),queryMotion(_456).

grounding(obl(declare(_454,_456,carried))=false) :- 
     person(_454),role_of(_454,chair),queryMotion(_456).

grounding(sanctioned(_450)=false) :- 
     person(_450),role_of(_450,chair).

inputEntity(propose(_132,_134)).
inputEntity(second(_132,_134)).
inputEntity(close_ballot(_132,_134)).
inputEntity(declare(_132,_134,_136)).
inputEntity(vote(_132,_134,_136)).
inputEntity(aye2nay(_138)=true).

outputEntity(status(_230)=proposed).
outputEntity(status(_230)=voting).
outputEntity(status(_230)=voted).
outputEntity(status(_230)=null).
outputEntity(voted(_230,_232)=aye).
outputEntity(voted(_230,_232)=nay).
outputEntity(voted(_230,_232)=null).
outputEntity(outcome(_230)=carried).
outputEntity(outcome(_230)=not_carried).
outputEntity(auxPerCloseBallot(_230)=true).
outputEntity(auxPerCloseBallot(_230)=false).
outputEntity(per(close_ballot(_234,_236))=true).
outputEntity(per(close_ballot(_234,_236))=false).
outputEntity(obl(declare(_234,_236,_238))=true).
outputEntity(obl(declare(_234,_236,_238))=false).
outputEntity(sanctioned(_230)=true).
outputEntity(sanctioned(_230)=false).
outputEntity(proposed2voted(_230)=true).
outputEntity(pow(propose(_234,_236))=true).
outputEntity(pow(second(_234,_236))=true).
outputEntity(pow(vote(_234,_236))=true).
outputEntity(pow(close_ballot(_234,_236))=true).
outputEntity(pow(declare(_234,_236))=true).
outputEntity(powPropose2vote(_230,_232)=true).
outputEntity(auxMotionOutcomeEvent(_224,_226)).

event(auxMotionOutcomeEvent(_430,_432)).
event(propose(_430,_432)).
event(second(_430,_432)).
event(close_ballot(_430,_432)).
event(declare(_430,_432,_434)).
event(vote(_430,_432,_434)).

simpleFluent(status(_528)=proposed).
simpleFluent(status(_528)=voting).
simpleFluent(status(_528)=voted).
simpleFluent(status(_528)=null).
simpleFluent(voted(_528,_530)=aye).
simpleFluent(voted(_528,_530)=nay).
simpleFluent(voted(_528,_530)=null).
simpleFluent(outcome(_528)=carried).
simpleFluent(outcome(_528)=not_carried).
simpleFluent(auxPerCloseBallot(_528)=true).
simpleFluent(auxPerCloseBallot(_528)=false).
simpleFluent(per(close_ballot(_532,_534))=true).
simpleFluent(per(close_ballot(_532,_534))=false).
simpleFluent(obl(declare(_532,_534,_536))=true).
simpleFluent(obl(declare(_532,_534,_536))=false).
simpleFluent(sanctioned(_528)=true).
simpleFluent(sanctioned(_528)=false).


sDFluent(proposed2voted(_742)=true).
sDFluent(pow(propose(_746,_748))=true).
sDFluent(pow(second(_746,_748))=true).
sDFluent(pow(vote(_746,_748))=true).
sDFluent(pow(close_ballot(_746,_748))=true).
sDFluent(pow(declare(_746,_748))=true).
sDFluent(powPropose2vote(_742,_744)=true).
sDFluent(aye2nay(_742)=true).

index(auxMotionOutcomeEvent(_792,_846),_792).
index(propose(_792,_846),_792).
index(second(_792,_846),_792).
index(close_ballot(_792,_846),_792).
index(declare(_792,_846,_848),_792).
index(vote(_792,_846,_848),_792).
index(status(_792)=proposed,_792).
index(status(_792)=voting,_792).
index(status(_792)=voted,_792).
index(status(_792)=null,_792).
index(voted(_792,_852)=aye,_792).
index(voted(_792,_852)=nay,_792).
index(voted(_792,_852)=null,_792).
index(outcome(_792)=carried,_792).
index(outcome(_792)=not_carried,_792).
index(auxPerCloseBallot(_792)=true,_792).
index(auxPerCloseBallot(_792)=false,_792).
index(per(close_ballot(_792,_856))=true,_792).
index(per(close_ballot(_792,_856))=false,_792).
index(obl(declare(_792,_856,_858))=true,_792).
index(obl(declare(_792,_856,_858))=false,_792).
index(sanctioned(_792)=true,_792).
index(sanctioned(_792)=false,_792).
index(proposed2voted(_792)=true,_792).
index(pow(propose(_792,_856))=true,_792).
index(pow(second(_792,_856))=true,_792).
index(pow(vote(_792,_856))=true,_792).
index(pow(close_ballot(_792,_856))=true,_792).
index(pow(declare(_792,_856))=true,_792).
index(powPropose2vote(_792,_852)=true,_792).
index(aye2nay(_792)=true,_792).

cyclic(status(_1152)=proposed).
cyclic(status(_1152)=voting).
cyclic(status(_1152)=voted).
cyclic(status(_1152)=null).

cachingOrder2(_1276, status(_1276)=proposed) :- % level in dependency graph: 1, processing order in component: 1
     queryMotion(_1276).

processingLevel(1,_1276, status(_1276)=proposed).
cachingOrder2(_1292, status(_1292)=voting) :- % level in dependency graph: 1, processing order in component: 2
     queryMotion(_1292).

processingLevel(1,_1292, status(_1292)=voting).
cachingOrder2(_1308, status(_1308)=voted) :- % level in dependency graph: 1, processing order in component: 3
     queryMotion(_1308).

processingLevel(1,_1308, status(_1308)=voted).
cachingOrder2(_1324, status(_1324)=null) :- % level in dependency graph: 1, processing order in component: 4
     queryMotion(_1324).

processingLevel(1,_1324, status(_1324)=null).
cachingOrder2(_1930, voted(_1930,_1932)=nay) :- % level in dependency graph: 2, processing order in component: 1
     person(_1930),role_of(_1930,voter),queryMotion(_1932).

processingLevel(2,_1930, voted(_1930,_1932)=nay).
cachingOrder2(_1948, voted(_1948,_1950)=aye) :- % level in dependency graph: 2, processing order in component: 2
     person(_1948),role_of(_1948,voter),queryMotion(_1950).

processingLevel(2,_1948, voted(_1948,_1950)=aye).
cachingOrder2(_1874, outcome(_1874)=not_carried) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_1874).

processingLevel(2,_1874, outcome(_1874)=not_carried).
cachingOrder2(_1890, outcome(_1890)=carried) :- % level in dependency graph: 2, processing order in component: 2
     queryMotion(_1890).

processingLevel(2,_1890, outcome(_1890)=carried).
cachingOrder2(_1836, auxPerCloseBallot(_1836)=true) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_1836).

processingLevel(2,_1836, auxPerCloseBallot(_1836)=true).
cachingOrder2(_1836, auxPerCloseBallot(_1836)=false) :- % level in dependency graph: 2, processing order in component: 2
     queryMotion(_1836).

processingLevel(2,_1836, auxPerCloseBallot(_1836)=false).
cachingOrder2(_1814, proposed2voted(_1814)=true) :- % level in dependency graph: 2, processing order in component: 1
     queryMotion(_1814).

processingLevel(2,_1814, proposed2voted(_1814)=true).
cachingOrder2(_1790, pow(propose(_1790,_1792))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1790),queryMotion(_1792).

processingLevel(2,_1790, pow(propose(_1790,_1792))=true).
cachingOrder2(_1762, pow(second(_1762,_1764))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1762),queryMotion(_1764).

processingLevel(2,_1762, pow(second(_1762,_1764))=true).
cachingOrder2(_1734, pow(vote(_1734,_1736))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1734),queryMotion(_1736).

processingLevel(2,_1734, pow(vote(_1734,_1736))=true).
cachingOrder2(_1706, pow(close_ballot(_1706,_1708))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1706),queryMotion(_1708).

processingLevel(2,_1706, pow(close_ballot(_1706,_1708))=true).
cachingOrder2(_1678, pow(declare(_1678,_1680))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1678),queryMotion(_1680).

processingLevel(2,_1678, pow(declare(_1678,_1680))=true).
cachingOrder2(_3282, per(close_ballot(_3282,_3284))=false) :- % level in dependency graph: 3, processing order in component: 1
     person(_3282),role_of(_3282,chair),queryMotion(_3284).

processingLevel(3,_3282, per(close_ballot(_3282,_3284))=false).
cachingOrder2(_3304, per(close_ballot(_3304,_3306))=true) :- % level in dependency graph: 3, processing order in component: 2
     person(_3304),role_of(_3304,chair),queryMotion(_3306).

processingLevel(3,_3304, per(close_ballot(_3304,_3306))=true).
cachingOrder2(_3254, powPropose2vote(_3254,_3256)=true) :- % level in dependency graph: 3, processing order in component: 1
     person(_3254),queryMotion(_3256).

processingLevel(3,_3254, powPropose2vote(_3254,_3256)=true).
cachingOrder2(_3230, auxMotionOutcomeEvent(_3230,_3232)) :- % level in dependency graph: 3, processing order in component: 1
     queryMotion(_3230).

processingLevel(3,_3230, auxMotionOutcomeEvent(_3230,_3232)).
cachingOrder2(_3834, obl(declare(_3834,_3836,_4000))=false) :- % level in dependency graph: 4, processing order in component: 1
     person(_3834),role_of(_3834,chair),queryMotion(_3836).

processingLevel(4,_3834, obl(declare(_3834,_3836,_4000))=false).
cachingOrder2(_3858, obl(declare(_3858,_3860,_4158))=true) :- % level in dependency graph: 4, processing order in component: 2
     person(_3858),role_of(_3858,chair),queryMotion(_3860).

processingLevel(4,_3858, obl(declare(_3858,_3860,_4158))=true).
cachingOrder2(_4248, sanctioned(_4248)=true) :- % level in dependency graph: 5, processing order in component: 1
     person(_4248),role_of(_4248,chair).

processingLevel(5,_4248, sanctioned(_4248)=true).
cachingOrder2(_4248, sanctioned(_4248)=false) :- % level in dependency graph: 5, processing order in component: 2
     person(_4248),role_of(_4248,chair).

processingLevel(5,_4248, sanctioned(_4248)=false).
collectGrounds([propose(_436,_450), second(_436,_450), close_ballot(_436,_450), declare(_436,_450,_452), vote(_436,_450,_452), aye2nay(_436)=true],person(_436)).

dgrounded(voted(_1386,_1388)=aye, person(_1386)).
dgrounded(voted(_1330,_1332)=nay, person(_1330)).
dgrounded(per(close_ballot(_1146,_1148))=true, person(_1146)).
dgrounded(per(close_ballot(_1086,_1088))=false, person(_1086)).
dgrounded(obl(declare(_1024,_1026,carried))=true, person(_1024)).
dgrounded(obl(declare(_962,_964,carried))=false, person(_962)).
dgrounded(sanctioned(_914)=true, person(_914)).
dgrounded(sanctioned(_870)=false, person(_870)).
dgrounded(pow(propose(_794,_796))=true, person(_794)).
dgrounded(pow(second(_746,_748))=true, person(_746)).
dgrounded(pow(vote(_698,_700))=true, person(_698)).
dgrounded(pow(close_ballot(_650,_652))=true, person(_650)).
dgrounded(pow(declare(_602,_604))=true, person(_602)).
dgrounded(powPropose2vote(_554,_556)=true, person(_554)).
