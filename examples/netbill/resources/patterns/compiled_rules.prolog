:- dynamic person/1, person_pair/2.

initiatedAt(quote(_5044,_5046,_5048)=true, _5070, _5014, _5076) :-
     happensAtIE(present_quote(_5044,_5046,_5048,_5058),_5014),
     _5070=<_5014,
     _5014<_5076.

initiatedAt(contract(_5044,_5044,_5048)=true, _5156, _5014, _5162) :-
     happensAtIE(accept_quote(_5044,_5044,_5048),_5014),_5156=<_5014,_5014<_5162,
     holdsAtProcessedSimpleFluent(_5044,quote(_5044,_5044,_5048)=true,_5014),
     \+holdsAtCyclic(_5044,suspended(_5044,merchant)=true,_5014),
     \+holdsAtCyclic(_5044,suspended(_5044,consumer)=true,_5014).

initiatedAt(per(present_quote(_5048,_5050))=false, _5072, _5014, _5078) :-
     happensAtIE(present_quote(_5048,_5050,_5058,_5060),_5014),
     _5072=<_5014,
     _5014<_5078.

initiatedAt(per(present_quote(_5048,_5050))=true, _5070, _5014, _5076) :-
     happensAtIE(request_quote(_5050,_5048,_5058),_5014),
     _5070=<_5014,
     _5014<_5076.

initiatedAt(obl(send_EPO(_5048,iServer,_5052))=false, _5086, _5014, _5092) :-
     happensAtIE(send_EPO(_5048,iServer,_5052,_5062),_5014),_5086=<_5014,_5014<_5092,
     price(_5052,_5062).

initiatedAt(obl(send_goods(_5048,iServer,_5052))=false, _5102, _5014, _5108) :-
     happensAtIE(send_goods(_5048,iServer,_5052,_5062,_5064),_5014),_5102=<_5014,_5014<_5108,
     decrypt(_5062,_5064,_5078),
     meets(_5078,_5052).

initiatedAt(suspended(_5044,merchant)=true, _5102, _5014, _5108) :-
     happensAtIE(present_quote(_5044,_5052,_5054,_5056),_5014),_5102=<_5014,_5014<_5108,
     holdsAtProcessedSimpleFluent(_5044,per(present_quote(_5044,_5052))=false,_5014).

initiatedAt(obl(send_EPO(_5056,iServer,_5060))=true, _5014, _5016, _5018) :-
     initiatedAt(contract(_5070,_5056,_5060)=true,_5014,_5016,_5018).

initiatedAt(obl(send_goods(_5056,iServer,_5060))=true, _5014, _5016, _5018) :-
     initiatedAt(contract(_5056,_5072,_5060)=true,_5014,_5016,_5018).

initiatedAt(obl(send_EPO(_5056,iServer,_5060))=false, _5014, _5016, _5018) :-
     initiatedAt(contract(_5070,_5056,_5060)=false,_5014,_5016,_5018).

initiatedAt(obl(send_goods(_5056,iServer,_5060))=false, _5014, _5016, _5018) :-
     initiatedAt(contract(_5056,_5072,_5060)=false,_5014,_5016,_5018).

initiatedAt(suspended(_5052,merchant)=true, _5014, _5016, _5018) :-
     initiatedAt(contract(_5052,_5066,_5068)=false,_5014,_5016,_5018),
     holdsAtCyclic(_5052,obl(send_goods(_5052,iServer,_5068))=true,_5016).

initiatedAt(suspended(_5052,consumer)=true, _5014, _5016, _5018) :-
     initiatedAt(contract(_5064,_5052,_5068)=false,_5014,_5016,_5018),
     holdsAtCyclic(_5052,obl(send_EPO(_5052,iServer,_5068))=true,_5016).

terminatedAt(quote(_5044,_5046,_5048)=true, _5068, _5014, _5074) :-
     happensAtIE(accept_quote(_5046,_5044,_5048),_5014),
     _5068=<_5014,
     _5014<_5074.

holdsForSDFluent(pow(accept_quote(_5048,_5050,_5052))=true,_5014) :-
     holdsForProcessedSimpleFluent(_5050,quote(_5050,_5048,_5052)=true,_5072),
     holdsForProcessedSimpleFluent(_5048,suspended(_5048,consumer)=true,_5090),
     holdsForProcessedSimpleFluent(_5050,suspended(_5050,merchant)=true,_5108),
     relative_complement_all(_5072,[_5090,_5108],_5014).

maxDuration(contract(_5048,_5050,_5052)=true,contract(_5048,_5050,_5052)=false,5):-
     grounding(contract(_5048,_5050,_5052)=true),
     grounding(contract(_5048,_5050,_5052)=false).

maxDurationUE(quote(_5048,_5050,_5052)=true,quote(_5048,_5050,_5052)=false,5):-
     grounding(quote(_5048,_5050,_5052)=true),
     grounding(quote(_5048,_5050,_5052)=false).

maxDurationUE(per(present_quote(_5052,_5054))=false,per(present_quote(_5052,_5054))=true,10):-
     grounding(per(present_quote(_5052,_5054))=false),
     grounding(per(present_quote(_5052,_5054))=true).

maxDurationUE(suspended(_5048,_5050)=true,suspended(_5048,_5050)=false,3):-
     grounding(suspended(_5048,_5050)=true),
     grounding(suspended(_5048,_5050)=false).

grounding(request_quote(_5388,_5390,_5392)) :- 
     person_pair(_5390,_5388).

grounding(present_quote(_5388,_5390,_5392,_5394)) :- 
     person_pair(_5388,_5390).

grounding(accept_quote(_5388,_5390,_5392)) :- 
     person_pair(_5390,_5388).

grounding(send_EPO(_5388,_5390,_5392,_5394)) :- 
     person(_5388).

grounding(send_goods(_5388,_5390,_5392,_5394,_5396)) :- 
     person(_5388).

grounding(suspended(_5394,_5396)=true) :- 
     person(_5394),role_of(_5394,_5396).

grounding(suspended(_5394,_5396)=false) :- 
     person(_5394),role_of(_5394,_5396).

grounding(quote(_5394,_5396,_5398)=true) :- 
     person_pair(_5394,_5396),role_of(_5396,consumer),role_of(_5394,merchant),\+_5394=_5396,queryGoodsDescription(_5398).

grounding(quote(_5394,_5396,_5398)=false) :- 
     person_pair(_5394,_5396),role_of(_5396,consumer),role_of(_5394,merchant),\+_5394=_5396,queryGoodsDescription(_5398).

grounding(contract(_5394,_5396,_5398)=true) :- 
     person_pair(_5394,_5396),role_of(_5394,merchant),role_of(_5396,consumer),\+_5394=_5396,queryGoodsDescription(_5398).

grounding(contract(_5394,_5396,_5398)=false) :- 
     person_pair(_5394,_5396),role_of(_5394,merchant),role_of(_5396,consumer),\+_5394=_5396,queryGoodsDescription(_5398).

grounding(pow(accept_quote(_5398,_5400,_5402))=true) :- 
     person_pair(_5400,_5398),role_of(_5400,merchant),role_of(_5398,consumer),\+_5398=_5400,queryGoodsDescription(_5402).

grounding(per(present_quote(_5398,_5400))=false) :- 
     person_pair(_5398,_5400),role_of(_5398,merchant),role_of(_5400,consumer),\+_5400=_5398.

grounding(per(present_quote(_5398,_5400))=true) :- 
     person_pair(_5398,_5400),role_of(_5398,merchant),role_of(_5400,consumer),\+_5400=_5398.

grounding(obl(send_EPO(_5398,iServer,_5402))=true) :- 
     person(_5398),role_of(_5398,consumer),queryGoodsDescription(_5402).

grounding(obl(send_goods(_5398,iServer,_5402))=true) :- 
     person(_5398),role_of(_5398,merchant),queryGoodsDescription(_5402).

grounding(obl(send_EPO(_5398,iServer,_5402))=false) :- 
     person(_5398),role_of(_5398,consumer),queryGoodsDescription(_5402).

grounding(obl(send_goods(_5398,iServer,_5402))=false) :- 
     person(_5398),role_of(_5398,merchant),queryGoodsDescription(_5402).

inputEntity(present_quote(_5068,_5070,_5072,_5074)).
inputEntity(accept_quote(_5068,_5070,_5072)).
inputEntity(request_quote(_5068,_5070,_5072)).
inputEntity(send_EPO(_5068,_5070,_5072,_5074)).
inputEntity(send_goods(_5068,_5070,_5072,_5074,_5076)).

outputEntity(quote(_5160,_5162,_5164)=true).
outputEntity(contract(_5160,_5162,_5164)=true).
outputEntity(per(present_quote(_5164,_5166))=false).
outputEntity(per(present_quote(_5164,_5166))=true).
outputEntity(obl(send_EPO(_5164,_5166,_5168))=false).
outputEntity(obl(send_goods(_5164,_5166,_5168))=false).
outputEntity(suspended(_5160,_5162)=true).
outputEntity(obl(send_EPO(_5164,_5166,_5168))=true).
outputEntity(obl(send_goods(_5164,_5166,_5168))=true).
outputEntity(contract(_5160,_5162,_5164)=false).
outputEntity(quote(_5160,_5162,_5164)=false).
outputEntity(suspended(_5160,_5162)=false).
outputEntity(pow(accept_quote(_5164,_5166,_5168))=true).

event(present_quote(_5288,_5290,_5292,_5294)).
event(accept_quote(_5288,_5290,_5292)).
event(request_quote(_5288,_5290,_5292)).
event(send_EPO(_5288,_5290,_5292,_5294)).
event(send_goods(_5288,_5290,_5292,_5294,_5296)).

simpleFluent(quote(_5380,_5382,_5384)=true).
simpleFluent(contract(_5380,_5382,_5384)=true).
simpleFluent(per(present_quote(_5384,_5386))=false).
simpleFluent(per(present_quote(_5384,_5386))=true).
simpleFluent(obl(send_EPO(_5384,_5386,_5388))=false).
simpleFluent(obl(send_goods(_5384,_5386,_5388))=false).
simpleFluent(suspended(_5380,_5382)=true).
simpleFluent(obl(send_EPO(_5384,_5386,_5388))=true).
simpleFluent(obl(send_goods(_5384,_5386,_5388))=true).
simpleFluent(contract(_5380,_5382,_5384)=false).
simpleFluent(quote(_5380,_5382,_5384)=false).
simpleFluent(suspended(_5380,_5382)=false).

sDFluent(pow(accept_quote(_5512,_5514,_5516))=true).

index(present_quote(_5516,_5570,_5572,_5574),_5516).
index(accept_quote(_5516,_5570,_5572),_5516).
index(request_quote(_5516,_5570,_5572),_5516).
index(send_EPO(_5516,_5570,_5572,_5574),_5516).
index(send_goods(_5516,_5570,_5572,_5574,_5576),_5516).
index(quote(_5516,_5576,_5578)=true,_5516).
index(contract(_5516,_5576,_5578)=true,_5516).
index(per(present_quote(_5516,_5580))=false,_5516).
index(per(present_quote(_5516,_5580))=true,_5516).
index(obl(send_EPO(_5516,_5580,_5582))=false,_5516).
index(obl(send_goods(_5516,_5580,_5582))=false,_5516).
index(suspended(_5516,_5576)=true,_5516).
index(obl(send_EPO(_5516,_5580,_5582))=true,_5516).
index(obl(send_goods(_5516,_5580,_5582))=true,_5516).
index(contract(_5516,_5576,_5578)=false,_5516).
index(quote(_5516,_5576,_5578)=false,_5516).
index(suspended(_5516,_5576)=false,_5516).
index(pow(accept_quote(_5516,_5580,_5582))=true,_5516).

cyclic(contract(_5798,_5798,_5802)=true).
cyclic(suspended(_5798,_5800)=true).
cyclic(obl(send_EPO(_5802,_5804,_5806))=true).
cyclic(obl(send_goods(_5802,_5804,_5806))=true).
cyclic(contract(_5798,_5798,_5802)=false).

cachingOrder2(_5980, quote(_5980,_5982,_5984)=true) :- % level: 1
     person_pair(_5980,_5982),role_of(_5982,consumer),role_of(_5980,merchant),\+_5980=_5982,queryGoodsDescription(_5984).

cachingOrder2(_5962, per(present_quote(_5962,_5964))=false) :- % level: 1
     person_pair(_5962,_5964),role_of(_5962,merchant),role_of(_5964,consumer),\+_5964=_5962.

cachingOrder2(_6344, contract(_6344,_6344,_6348)=true) :- % level: 2
     person_pair(_6344,_6344),role_of(_6344,merchant),role_of(_6344,consumer),\+_6344=_6344,queryGoodsDescription(_6348).

cachingOrder2(_6326, per(present_quote(_6326,_6328))=true) :- % level: 2
     person_pair(_6326,_6328),role_of(_6326,merchant),role_of(_6328,consumer),\+_6328=_6326.

cachingOrder2(_6304, suspended(_6304,_6306)=true) :- % level: 2
     person(_6304),role_of(_6304,_6306).

cachingOrder2(_6284, obl(send_EPO(_6284,iServer,_6288))=true) :- % level: 2
     person(_6284),role_of(_6284,consumer),queryGoodsDescription(_6288).

cachingOrder2(_6260, obl(send_goods(_6260,iServer,_6264))=true) :- % level: 2
     person(_6260),role_of(_6260,merchant),queryGoodsDescription(_6264).

cachingOrder2(_6236, contract(_6236,_6236,_6240)=false) :- % level: 2
     person_pair(_6236,_6236),role_of(_6236,merchant),role_of(_6236,consumer),\+_6236=_6236,queryGoodsDescription(_6240).

cachingOrder2(_6216, quote(_6216,_6218,_6220)=false) :- % level: 2
     person_pair(_6216,_6218),role_of(_6218,consumer),role_of(_6216,merchant),\+_6216=_6218,queryGoodsDescription(_6220).

cachingOrder2(_6996, obl(send_EPO(_6996,iServer,_7000))=false) :- % level: 3
     person(_6996),role_of(_6996,consumer),queryGoodsDescription(_7000).

cachingOrder2(_6972, obl(send_goods(_6972,iServer,_6976))=false) :- % level: 3
     person(_6972),role_of(_6972,merchant),queryGoodsDescription(_6976).

cachingOrder2(_6950, suspended(_6950,_6952)=false) :- % level: 3
     person(_6950),role_of(_6950,_6952).

cachingOrder2(_6930, pow(accept_quote(_6930,_6932,_6934))=true) :- % level: 3
     person_pair(_6932,_6930),role_of(_6932,merchant),role_of(_6930,consumer),\+_6930=_6932,queryGoodsDescription(_6934).

collectGrounds([send_EPO(_5316,_5330,_5332,_5334), send_goods(_5316,_5330,_5332,_5334,_5336)],person(_5316)).

collectGrounds([present_quote(_5304,_5306,_5332,_5334), accept_quote(_5306,_5304,_5332), request_quote(_5306,_5304,_5332)],person_pair(_5304,_5306)).

dgrounded(quote(_6262,_6264,_6266)=true, person_pair(_6262,_6264)).
dgrounded(contract(_6174,_6176,_6178)=true, person_pair(_6174,_6176)).
dgrounded(per(present_quote(_6098,_6100))=false, person_pair(_6098,_6100)).
dgrounded(per(present_quote(_6018,_6020))=true, person_pair(_6018,_6020)).
dgrounded(obl(send_EPO(_5956,iServer,_5960))=false, person(_5956)).
dgrounded(obl(send_goods(_5894,iServer,_5898))=false, person(_5894)).
dgrounded(suspended(_5844,_5846)=true, person(_5844)).
dgrounded(obl(send_EPO(_5786,iServer,_5790))=true, person(_5786)).
dgrounded(obl(send_goods(_5724,iServer,_5728))=true, person(_5724)).
dgrounded(contract(_5632,_5634,_5636)=false, person_pair(_5632,_5634)).
dgrounded(quote(_5544,_5546,_5548)=false, person_pair(_5544,_5546)).
dgrounded(suspended(_5498,_5500)=false, person(_5498)).
dgrounded(pow(accept_quote(_5410,_5412,_5414))=true, person_pair(_5412,_5410)).
