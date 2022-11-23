initiatedAt(quote(_131139,_131140,_131141)=true, _131150, _131124, _131152) :-
     happensAtIE(present_quote(_131139,_131140,_131141,_131149),_131124),
     _131150=<_131124,
     _131124<_131152.

initiatedAt(quote(_131139,_131140,_131141)=false, _131149, _131124, _131151) :-
     happensAtIE(accept_quote(_131140,_131139,_131141),_131124),
     _131149=<_131124,
     _131124<_131151.

initiatedAt(contract(_131139,_131140,_131141)=true, _131193, _131124, _131195) :-
     happensAtIE(accept_quote(_131140,_131139,_131141),_131124),_131193=<_131124,_131124<_131195,
     holdsAtProcessedSimpleFluent(_131139,quote(_131139,_131140,_131141)=true,_131124),
     \+holdsAtCyclic(_131139,suspended(_131139,merchant)=true,_131124),
     \+holdsAtCyclic(_131140,suspended(_131140,consumer)=true,_131124).

initiatedAt(per(present_quote(_131141,_131142))=false, _131151, _131124, _131153) :-
     happensAtIE(present_quote(_131141,_131142,_131149,_131150),_131124),
     _131151=<_131124,
     _131124<_131153.

initiatedAt(per(present_quote(_131141,_131142))=true, _131150, _131124, _131152) :-
     happensAtIE(request_quote(_131142,_131141,_131149),_131124),
     _131150=<_131124,
     _131124<_131152.

initiatedAt(obl(send_EPO(_131141,iServer,_131143))=false, _131161, _131124, _131163) :-
     happensAtIE(send_EPO(_131141,iServer,_131143,_131154),_131124),_131161=<_131124,_131124<_131163,
     price(_131143,_131154).

initiatedAt(obl(send_goods(_131141,iServer,_131143))=false, _131169, _131124, _131171) :-
     happensAtIE(send_goods(_131141,iServer,_131143,_131154,_131155),_131124),_131169=<_131124,_131124<_131171,
     decrypt(_131154,_131155,_131162),
     meets(_131162,_131143).

initiatedAt(suspended(_131139,merchant)=true, _131166, _131124, _131168) :-
     happensAtIE(present_quote(_131139,_131149,_131150,_131151),_131124),_131166=<_131124,_131124<_131168,
     holdsAtProcessedSimpleFluent(_131139,per(present_quote(_131139,_131149))=false,_131124).

initiatedAt(obl(send_EPO(_131145,iServer,_131147))=true, _131124, _131125, _131126) :-
     initiatedAt(contract(_131157,_131145,_131147)=true,_131124,_131125,_131126).

initiatedAt(obl(send_goods(_131145,iServer,_131147))=true, _131124, _131125, _131126) :-
     initiatedAt(contract(_131145,_131158,_131147)=true,_131124,_131125,_131126).

initiatedAt(obl(send_EPO(_131145,iServer,_131147))=false, _131124, _131125, _131126) :-
     initiatedAt(contract(_131157,_131145,_131147)=false,_131124,_131125,_131126).

initiatedAt(obl(send_goods(_131145,iServer,_131147))=false, _131124, _131125, _131126) :-
     initiatedAt(contract(_131145,_131158,_131147)=false,_131124,_131125,_131126).

initiatedAt(suspended(_131143,merchant)=true, _131124, _131125, _131126) :-
     initiatedAt(contract(_131143,_131158,_131159)=false,_131124,_131125,_131126),
     holdsAtCyclic(_131143,obl(send_goods(_131143,iServer,_131159))=true,_131125).

initiatedAt(suspended(_131143,consumer)=true, _131124, _131125, _131126) :-
     initiatedAt(contract(_131157,_131143,_131159)=false,_131124,_131125,_131126),
     holdsAtCyclic(_131143,obl(send_EPO(_131143,iServer,_131159))=true,_131125).

holdsForSDFluent(pow(accept_quote(_131141,_131142,_131143))=true,_131124) :-
     holdsForProcessedSimpleFluent(_131142,quote(_131142,_131141,_131143)=true,_131149),
     holdsForProcessedSimpleFluent(_131141,suspended(_131141,consumer)=true,_131162),
     holdsForProcessedSimpleFluent(_131142,suspended(_131142,merchant)=true,_131174),
     relative_complement_all(_131149,[_131162,_131174],_131124).

cachingOrder2(_131123, quote(_131123,_131124,_131125)=true) :-
     person_pair(_131123,_131124),role_of(_131123,merchant),role_of(_131124,consumer),\+_131123=_131124,queryGoodsDescription(_131125).

cachingOrder2(_131125, per(present_quote(_131125,_131126))=false) :-
     person_pair(_131125,_131126),role_of(_131125,merchant),role_of(_131126,consumer),\+_131126=_131125.

cachingOrder2(_131123, contract(_131123,_131124,_131125)=true) :-
     person_pair(_131123,_131124),role_of(_131123,merchant),role_of(_131124,consumer),\+_131123=_131124,queryGoodsDescription(_131125).

cachingOrder2(_131125, obl(send_EPO(_131125,iServer,_131127))=true) :-
     person(_131125),role_of(_131125,consumer),queryGoodsDescription(_131127).

cachingOrder2(_131125, obl(send_goods(_131125,iServer,_131127))=true) :-
     person(_131125),role_of(_131125,merchant),queryGoodsDescription(_131127).

cachingOrder2(_131123, suspended(_131123,_131124)=true) :-
     person(_131123),role_of(_131123,_131124).

cachingOrder2(_131125, pow(accept_quote(_131125,_131126,_131127))=true) :-
     person_pair(_131126,_131125),role_of(_131126,merchant),role_of(_131125,consumer),\+_131125=_131126,queryGoodsDescription(_131127).

maxDurationUE(quote(_131176,_131177,_131178)=true,quote(_131176,_131177,_131178)=false,5) :- 
     grounding(quote(_131176,_131177,_131178)=true).

maxDurationUE(per(present_quote(_131178,_131179))=false,per(present_quote(_131178,_131179))=true,10) :- 
     grounding(per(present_quote(_131178,_131179))=false).

maxDurationUE(suspended(_131176,_131177)=true,suspended(_131176,_131177)=false,3) :- 
     grounding(suspended(_131176,_131177)=true).

maxDuration(contract(_131176,_131177,_131178)=true,contract(_131176,_131177,_131178)=false,5) :- 
     grounding(contract(_131176,_131177,_131178)=true).

