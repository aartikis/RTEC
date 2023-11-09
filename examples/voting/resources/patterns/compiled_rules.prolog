:- dynamic person/1.

initiatedAt(status(_5032)=null, _5042, -1, _5050) :-
     _5042=< -1,
     -1<_5050.

initiatedAt(status(_5042)=proposed, _5088, _5012, _5094) :-
     happensAtIE(propose(_5046,_5042),_5012),_5088=<_5012,_5012<_5094,
     holdsAtCyclic(_5042,status(_5042)=null,_5012).

initiatedAt(status(_5042)=voting, _5088, _5012, _5094) :-
     happensAtIE(second(_5046,_5042),_5012),_5088=<_5012,_5012<_5094,
     holdsAtCyclic(_5042,status(_5042)=proposed,_5012).

initiatedAt(status(_5042)=voted, _5100, _5012, _5106) :-
     happensAtIE(close_ballot(_5046,_5042),_5012),_5100=<_5012,_5012<_5106,
     role_of(_5046,chair),
     holdsAtCyclic(_5042,status(_5042)=voting,_5012).

initiatedAt(status(_5042)=null, _5102, _5012, _5108) :-
     happensAtIE(declare(_5046,_5042,_5050),_5012),_5102=<_5012,_5012<_5108,
     role_of(_5046,chair),
     holdsAtCyclic(_5042,status(_5042)=voted,_5012).

initiatedAt(voted(_5042,_5044)=_5018, _5086, _5012, _5092) :-
     happensAtIE(vote(_5042,_5044,_5018),_5012),_5086=<_5012,_5012<_5092,
     holdsAtProcessedSimpleFluent(_5044,status(_5044)=voting,_5012).

initiatedAt(voted(_5042,_5044)=null, _5070, _5012, _5076) :-
     happensAtProcessedSimpleFluent(_5044,start(status(_5044)=null),_5012),
     _5070=<_5012,
     _5012<_5076.

initiatedAt(outcome(_5042)=_5018, _5096, _5012, _5102) :-
     happensAtIE(declare(_5046,_5042,_5018),_5012),_5096=<_5012,_5012<_5102,
     holdsAtProcessedSimpleFluent(_5042,status(_5042)=voted,_5012),
     role_of(_5046,chair).

initiatedAt(auxPerCloseBallot(_5042)=true, _5068, _5012, _5074) :-
     happensAtProcessedSimpleFluent(_5042,start(status(_5042)=voting),_5012),
     _5068=<_5012,
     _5012<_5074.

initiatedAt(auxPerCloseBallot(_5042)=false, _5068, _5012, _5074) :-
     happensAtProcessedSimpleFluent(_5042,start(status(_5042)=proposed),_5012),
     _5068=<_5012,
     _5012<_5074.

initiatedAt(per(close_ballot(_5046,_5048))=true, _5096, _5012, _5102) :-
     happensAtProcessedSimpleFluent(_5048,end(auxPerCloseBallot(_5048)=true),_5012),_5096=<_5012,_5012<_5102,
     holdsAtProcessedSimpleFluent(_5048,status(_5048)=voting,_5012).

initiatedAt(per(close_ballot(_5046,_5048))=false, _5074, _5012, _5080) :-
     happensAtProcessedSimpleFluent(_5048,start(status(_5048)=voted),_5012),
     _5074=<_5012,
     _5012<_5080.

initiatedAt(obl(declare(_5046,_5048,carried))=true, _5068, _5012, _5074) :-
     happensAtProcessed(_5048,auxMotionOutcomeEvent(_5048,carried),_5012),
     _5068=<_5012,
     _5012<_5074.

initiatedAt(obl(declare(_5046,_5048,carried))=false, _5076, _5012, _5082) :-
     happensAtProcessedSimpleFluent(_5048,start(status(_5048)=null),_5012),
     _5076=<_5012,
     _5012<_5082.

initiatedAt(sanctioned(_5042)=true, _5092, _5012, _5098) :-
     happensAtIE(close_ballot(_5042,_5048),_5012),_5092=<_5012,_5012<_5098,
     \+holdsAtProcessedSimpleFluent(_5042,per(close_ballot(_5042,_5048))=true,_5012).

initiatedAt(sanctioned(_5042)=true, _5122, _5012, _5128) :-
     happensAtProcessedSimpleFluent(_5056,end(status(_5056)=voted),_5012),_5122=<_5012,_5012<_5128,
     \+happensAtIE(declare(_5042,_5056,carried),_5012),
     holdsAtProcessedSimpleFluent(_5042,obl(declare(_5042,_5056,carried))=true,_5012).

initiatedAt(sanctioned(_5042)=true, _5126, _5012, _5132) :-
     happensAtProcessedSimpleFluent(_5056,end(status(_5056)=voted),_5012),_5126=<_5012,_5012<_5132,
     \+happensAtIE(declare(_5042,_5056,not_carried),_5012),
     \+holdsAtProcessedSimpleFluent(_5042,obl(declare(_5042,_5056,carried))=true,_5012).

terminatedAt(outcome(_5042)=_5018, _5068, _5012, _5074) :-
     happensAtProcessedSimpleFluent(_5042,start(status(_5042)=proposed),_5012),
     _5068=<_5012,
     _5012<_5074.

holdsForSDFluent(pow(propose(_5046,_5048))=true,_5012) :-
     holdsForProcessedSimpleFluent(_5048,status(_5048)=null,_5012).

holdsForSDFluent(pow(second(_5046,_5048))=true,_5012) :-
     holdsForProcessedSimpleFluent(_5048,status(_5048)=proposed,_5012).

holdsForSDFluent(pow(vote(_5046,_5048))=true,_5012) :-
     holdsForProcessedSimpleFluent(_5048,status(_5048)=voting,_5012).

holdsForSDFluent(pow(close_ballot(_5046,_5048))=true,_5012) :-
     holdsForProcessedSimpleFluent(_5048,status(_5048)=voting,_5012).

holdsForSDFluent(pow(declare(_5046,_5048))=true,_5012) :-
     holdsForProcessedSimpleFluent(_5048,status(_5048)=voted,_5012).

happensAtEv(auxMotionOutcomeEvent(_5030,carried),_5012) :-
     happensAtProcessedSimpleFluent(_5030,start(status(_5030)=voted),_5012),
     findall(_5068,holdsAtProcessedSimpleFluent(_5068,voted(_5068,_5030)=aye,_5012),_5078),
     length(_5078,_5084),
     findall(_5068,holdsAtProcessedSimpleFluent(_5068,voted(_5068,_5030)=nay,_5012),_5110),
     length(_5110,_5116),
     _5084>=_5116.

maxDuration(status(_5046)=proposed,status(_5046)=null,10):-
     grounding(status(_5046)=proposed),
     grounding(status(_5046)=null).

maxDuration(status(_5046)=voting,status(_5046)=voted,10):-
     grounding(status(_5046)=voting),
     grounding(status(_5046)=voted).

maxDuration(status(_5046)=voted,status(_5046)=null,10):-
     grounding(status(_5046)=voted),
     grounding(status(_5046)=null).

maxDuration(auxPerCloseBallot(_5046)=true,auxPerCloseBallot(_5046)=false,8):-
     grounding(auxPerCloseBallot(_5046)=true),
     grounding(auxPerCloseBallot(_5046)=false).

maxDuration(sanctioned(_5046)=true,sanctioned(_5046)=false,4):-
     grounding(sanctioned(_5046)=true),
     grounding(sanctioned(_5046)=false).

grounding(propose(_5378,_5380)) :- 
     person(_5378),motion(_5380).

grounding(second(_5378,_5380)) :- 
     person(_5378),motion(_5380).

grounding(vote(_5378,_5380,_5382)) :- 
     person(_5378),motion(_5380).

grounding(close_ballot(_5378,_5380)) :- 
     person(_5378),motion(_5380).

grounding(declare(_5378,_5380,_5382)) :- 
     person(_5378),motion(_5380).

grounding(status(_5384)=null) :- 
     queryMotion(_5384).

grounding(status(_5384)=proposed) :- 
     queryMotion(_5384).

grounding(status(_5384)=voting) :- 
     queryMotion(_5384).

grounding(status(_5384)=voted) :- 
     queryMotion(_5384).

grounding(voted(_5384,_5386)=aye) :- 
     person(_5384),role_of(_5384,voter),queryMotion(_5386).

grounding(voted(_5384,_5386)=nay) :- 
     person(_5384),role_of(_5384,voter),queryMotion(_5386).

grounding(auxMotionOutcomeEvent(_5378,_5380)) :- 
     queryMotion(_5378).

grounding(outcome(_5384)=carried) :- 
     queryMotion(_5384).

grounding(outcome(_5384)=not_carried) :- 
     queryMotion(_5384).

grounding(auxPerCloseBallot(_5384)=true) :- 
     queryMotion(_5384).

grounding(per(close_ballot(_5388,_5390))=true) :- 
     person(_5388),role_of(_5388,chair),queryMotion(_5390).

grounding(obl(declare(_5388,_5390,carried))=true) :- 
     person(_5388),role_of(_5388,chair),queryMotion(_5390).

grounding(sanctioned(_5384)=true) :- 
     person(_5384),role_of(_5384,chair).

grounding(auxPerCloseBallot(_5384)=false) :- 
     queryMotion(_5384).

grounding(per(close_ballot(_5388,_5390))=false) :- 
     person(_5388),role_of(_5388,chair),queryMotion(_5390).

grounding(obl(declare(_5388,_5390,carried))=false) :- 
     person(_5388),role_of(_5388,chair),queryMotion(_5390).

grounding(sanctioned(_5384)=false) :- 
     person(_5384),role_of(_5384,chair).

inputEntity(propose(_5066,_5068)).
inputEntity(second(_5066,_5068)).
inputEntity(close_ballot(_5066,_5068)).
inputEntity(declare(_5066,_5068,_5070)).
inputEntity(vote(_5066,_5068,_5070)).

outputEntity(status(_5158)=proposed).
outputEntity(status(_5158)=voting).
outputEntity(status(_5158)=voted).
outputEntity(status(_5158)=null).
outputEntity(voted(_5158,_5160)=aye).
outputEntity(voted(_5158,_5160)=nay).
outputEntity(voted(_5158,_5160)=null).
outputEntity(outcome(_5158)=carried).
outputEntity(outcome(_5158)=not_carried).
outputEntity(auxPerCloseBallot(_5158)=true).
outputEntity(auxPerCloseBallot(_5158)=false).
outputEntity(per(close_ballot(_5162,_5164))=true).
outputEntity(per(close_ballot(_5162,_5164))=false).
outputEntity(obl(declare(_5162,_5164,_5166))=true).
outputEntity(obl(declare(_5162,_5164,_5166))=false).
outputEntity(sanctioned(_5158)=true).
outputEntity(sanctioned(_5158)=false).
outputEntity(pow(propose(_5162,_5164))=true).
outputEntity(pow(second(_5162,_5164))=true).
outputEntity(pow(vote(_5162,_5164))=true).
outputEntity(pow(close_ballot(_5162,_5164))=true).
outputEntity(pow(declare(_5162,_5164))=true).
outputEntity(auxMotionOutcomeEvent(_5152,_5154)).

event(auxMotionOutcomeEvent(_5346,_5348)).
event(propose(_5346,_5348)).
event(second(_5346,_5348)).
event(close_ballot(_5346,_5348)).
event(declare(_5346,_5348,_5350)).
event(vote(_5346,_5348,_5350)).

simpleFluent(status(_5444)=proposed).
simpleFluent(status(_5444)=voting).
simpleFluent(status(_5444)=voted).
simpleFluent(status(_5444)=null).
simpleFluent(voted(_5444,_5446)=aye).
simpleFluent(voted(_5444,_5446)=nay).
simpleFluent(voted(_5444,_5446)=null).
simpleFluent(outcome(_5444)=carried).
simpleFluent(outcome(_5444)=not_carried).
simpleFluent(auxPerCloseBallot(_5444)=true).
simpleFluent(auxPerCloseBallot(_5444)=false).
simpleFluent(per(close_ballot(_5448,_5450))=true).
simpleFluent(per(close_ballot(_5448,_5450))=false).
simpleFluent(obl(declare(_5448,_5450,_5452))=true).
simpleFluent(obl(declare(_5448,_5450,_5452))=false).
simpleFluent(sanctioned(_5444)=true).
simpleFluent(sanctioned(_5444)=false).

sDFluent(pow(propose(_5606,_5608))=true).
sDFluent(pow(second(_5606,_5608))=true).
sDFluent(pow(vote(_5606,_5608))=true).
sDFluent(pow(close_ballot(_5606,_5608))=true).
sDFluent(pow(declare(_5606,_5608))=true).

index(auxMotionOutcomeEvent(_5634,_5688),_5634).
index(propose(_5634,_5688),_5634).
index(second(_5634,_5688),_5634).
index(close_ballot(_5634,_5688),_5634).
index(declare(_5634,_5688,_5690),_5634).
index(vote(_5634,_5688,_5690),_5634).
index(status(_5634)=proposed,_5634).
index(status(_5634)=voting,_5634).
index(status(_5634)=voted,_5634).
index(status(_5634)=null,_5634).
index(voted(_5634,_5694)=aye,_5634).
index(voted(_5634,_5694)=nay,_5634).
index(voted(_5634,_5694)=null,_5634).
index(outcome(_5634)=carried,_5634).
index(outcome(_5634)=not_carried,_5634).
index(auxPerCloseBallot(_5634)=true,_5634).
index(auxPerCloseBallot(_5634)=false,_5634).
index(per(close_ballot(_5634,_5698))=true,_5634).
index(per(close_ballot(_5634,_5698))=false,_5634).
index(obl(declare(_5634,_5698,_5700))=true,_5634).
index(obl(declare(_5634,_5698,_5700))=false,_5634).
index(sanctioned(_5634)=true,_5634).
index(sanctioned(_5634)=false,_5634).
index(pow(propose(_5634,_5698))=true,_5634).
index(pow(second(_5634,_5698))=true,_5634).
index(pow(vote(_5634,_5698))=true,_5634).
index(pow(close_ballot(_5634,_5698))=true,_5634).
index(pow(declare(_5634,_5698))=true,_5634).

cyclic(status(_5976)=proposed).
cyclic(status(_5976)=voting).
cyclic(status(_5976)=voted).
cyclic(status(_5976)=null).

cachingOrder2(_6142, status(_6142)=proposed) :- % level: 1
     queryMotion(_6142).

cachingOrder2(_6126, status(_6126)=voting) :- % level: 1
     queryMotion(_6126).

cachingOrder2(_6110, status(_6110)=voted) :- % level: 1
     queryMotion(_6110).

cachingOrder2(_6094, status(_6094)=null) :- % level: 1
     queryMotion(_6094).

cachingOrder2(_6586, voted(_6586,_6588)=aye) :- % level: 2
     person(_6586),role_of(_6586,voter),queryMotion(_6588).

cachingOrder2(_6568, voted(_6568,_6570)=nay) :- % level: 2
     person(_6568),role_of(_6568,voter),queryMotion(_6570).

cachingOrder2(_6550, voted(_6550,_6552)=null). % level: 2
cachingOrder2(_6534, outcome(_6534)=carried) :- % level: 2
     queryMotion(_6534).

cachingOrder2(_6518, outcome(_6518)=not_carried) :- % level: 2
     queryMotion(_6518).

cachingOrder2(_6502, auxPerCloseBallot(_6502)=true) :- % level: 2
     queryMotion(_6502).

cachingOrder2(_6484, per(close_ballot(_6484,_6486))=false) :- % level: 2
     person(_6484),role_of(_6484,chair),queryMotion(_6486).

cachingOrder2(_6460, obl(declare(_6460,_6462,carried))=false) :- % level: 2
     person(_6460),role_of(_6460,chair),queryMotion(_6462).

cachingOrder2(_6438, pow(propose(_6438,_6440))=true). % level: 2
cachingOrder2(_6416, pow(second(_6416,_6418))=true). % level: 2
cachingOrder2(_6394, pow(vote(_6394,_6396))=true). % level: 2
cachingOrder2(_6372, pow(close_ballot(_6372,_6374))=true). % level: 2
cachingOrder2(_6350, pow(declare(_6350,_6352))=true). % level: 2
cachingOrder2(_6328, auxMotionOutcomeEvent(_6328,_6330)) :- % level: 2
     queryMotion(_6328).

cachingOrder2(_7068, auxPerCloseBallot(_7068)=false) :- % level: 3
     queryMotion(_7068).

cachingOrder2(_7050, per(close_ballot(_7050,_7052))=true) :- % level: 3
     person(_7050),role_of(_7050,chair),queryMotion(_7052).

cachingOrder2(_7026, obl(declare(_7026,_7028,carried))=true) :- % level: 3
     person(_7026),role_of(_7026,chair),queryMotion(_7028).

cachingOrder2(_7286, sanctioned(_7286)=true) :- % level: 4
     person(_7286),role_of(_7286,chair).

cachingOrder2(_7394, sanctioned(_7394)=false) :- % level: 5
     person(_7394),role_of(_7394,chair).

collectGrounds([propose(_5332,_5346), second(_5332,_5346), close_ballot(_5332,_5346), declare(_5332,_5346,_5348), vote(_5332,_5346,_5348)],person(_5332)).

dgrounded(voted(_5966,_5968)=aye, person(_5966)).
dgrounded(voted(_5910,_5912)=nay, person(_5910)).
dgrounded(per(close_ballot(_5726,_5728))=true, person(_5726)).
dgrounded(per(close_ballot(_5666,_5668))=false, person(_5666)).
dgrounded(obl(declare(_5604,_5606,carried))=true, person(_5604)).
dgrounded(obl(declare(_5542,_5544,carried))=false, person(_5542)).
dgrounded(sanctioned(_5494)=true, person(_5494)).
dgrounded(sanctioned(_5450)=false, person(_5450)).
