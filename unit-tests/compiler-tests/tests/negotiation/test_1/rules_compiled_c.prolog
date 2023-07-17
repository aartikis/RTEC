:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
initiatedAt(quote(_3162,_3164,_3166)=true, _3186, _3134, _3192) :-
     happensAtIE(present_quote(_3162,_3164,_3166,_3176),_3134),
     _3186=<_3134,
     _3134<_3192.

initiatedAt(quote(_3162,_3164,_3166)=false, _3184, _3134, _3190) :-
     happensAtIE(accept_quote(_3164,_3162,_3166),_3134),
     _3184=<_3134,
     _3134<_3190.

initiatedAt(contract(_3162,_3164,_3166)=true, _3272, _3134, _3278) :-
     happensAtIE(accept_quote(_3164,_3162,_3166),_3134),_3272=<_3134,_3134<_3278,
     holdsAtProcessedSimpleFluent(_3162,quote(_3162,_3164,_3166)=true,_3134),
     \+holdsAtCyclic(_3162,suspended(_3162,merchant)=true,_3134),
     \+holdsAtCyclic(_3164,suspended(_3164,consumer)=true,_3134).

initiatedAt(per(present_quote(_3166,_3168))=false, _3188, _3134, _3194) :-
     happensAtIE(present_quote(_3166,_3168,_3176,_3178),_3134),
     _3188=<_3134,
     _3134<_3194.

initiatedAt(per(present_quote(_3166,_3168))=true, _3186, _3134, _3192) :-
     happensAtIE(request_quote(_3168,_3166,_3176),_3134),
     _3186=<_3134,
     _3134<_3192.

initiatedAt(obl(send_EPO(_3166,iServer,_3170))=false, _3208, _3134, _3214) :-
     happensAtIE(send_EPO(_3166,iServer,_3170,_3180),_3134),_3208=<_3134,_3134<_3214,
     price(_3170,_3180).

initiatedAt(obl(send_goods(_3166,iServer,_3170))=false, _3224, _3134, _3230) :-
     happensAtIE(send_goods(_3166,iServer,_3170,_3180,_3182),_3134),_3224=<_3134,_3134<_3230,
     decrypt(_3180,_3182,_3196),
     meets(_3196,_3170).

initiatedAt(suspended(_3162,merchant)=true, _3218, _3134, _3224) :-
     happensAtIE(present_quote(_3162,_3170,_3172,_3174),_3134),_3218=<_3134,_3134<_3224,
     holdsAtProcessedSimpleFluent(_3162,per(present_quote(_3162,_3170))=false,_3134).

initiatedAt(obl(send_EPO(_3174,iServer,_3178))=true, _3134, _3136, _3138) :-
     initiatedAt(contract(_3188,_3174,_3178)=true,_3134,_3136,_3138).

initiatedAt(obl(send_goods(_3174,iServer,_3178))=true, _3134, _3136, _3138) :-
     initiatedAt(contract(_3174,_3190,_3178)=true,_3134,_3136,_3138).

initiatedAt(obl(send_EPO(_3174,iServer,_3178))=false, _3134, _3136, _3138) :-
     initiatedAt(contract(_3188,_3174,_3178)=false,_3134,_3136,_3138).

initiatedAt(obl(send_goods(_3174,iServer,_3178))=false, _3134, _3136, _3138) :-
     initiatedAt(contract(_3174,_3190,_3178)=false,_3134,_3136,_3138).

initiatedAt(suspended(_3170,merchant)=true, _3134, _3136, _3138) :-
     initiatedAt(contract(_3170,_3184,_3186)=false,_3134,_3136,_3138),
     holdsAtCyclic(_3170,obl(send_goods(_3170,iServer,_3186))=true,_3136).

initiatedAt(suspended(_3170,consumer)=true, _3134, _3136, _3138) :-
     initiatedAt(contract(_3182,_3170,_3186)=false,_3134,_3136,_3138),
     holdsAtCyclic(_3170,obl(send_EPO(_3170,iServer,_3186))=true,_3136).

holdsForSDFluent(pow(accept_quote(_3166,_3168,_3170))=true,_3134) :-
     holdsForProcessedSimpleFluent(_3168,quote(_3168,_3166,_3170)=true,_3190),
     holdsForProcessedSimpleFluent(_3166,suspended(_3166,consumer)=true,_3208),
     holdsForProcessedSimpleFluent(_3168,suspended(_3168,merchant)=true,_3226),
     relative_complement_all(_3190,[_3208,_3226],_3134).

cachingOrder2(_3138, quote(_3138,_3140,_3142)=true) :-
     role_of(_3138,merchant),role_of(_3140,consumer),\+_3138=_3140,queryGoodsDescription(_3142).

cachingOrder2(_3142, per(present_quote(_3142,_3144))=false) :-
     role_of(_3142,merchant),role_of(_3144,consumer),\+_3144=_3142.

cachingOrder2(_3138, contract(_3138,_3140,_3142)=true) :-
     role_of(_3138,merchant),role_of(_3140,consumer),\+_3138=_3140,queryGoodsDescription(_3142).

cachingOrder2(_3142, obl(send_EPO(_3142,iServer,_3146))=true) :-
     role_of(_3142,consumer),queryGoodsDescription(_3146).

cachingOrder2(_3142, obl(send_goods(_3142,iServer,_3146))=true) :-
     role_of(_3142,merchant),queryGoodsDescription(_3146).

cachingOrder2(_3138, suspended(_3138,_3140)=true) :-
     role_of(_3138,_3140).

cachingOrder2(_3142, pow(accept_quote(_3142,_3144,_3146))=true) :-
     role_of(_3144,merchant),role_of(_3142,consumer),\+_3142=_3144,queryGoodsDescription(_3146).

maxDuration(contract(_3402,_3404,_3406)=true,contract(_3402,_3404,_3406)=false,5) :- 
     grounding(contract(_3402,_3404,_3406)=true).

maxDurationUE(quote(_3402,_3404,_3406)=true,quote(_3402,_3404,_3406)=false,5) :- 
     grounding(quote(_3402,_3404,_3406)=true).

maxDurationUE(per(present_quote(_3406,_3408))=false,per(present_quote(_3406,_3408))=true,10) :- 
     grounding(per(present_quote(_3406,_3408))=false).

maxDurationUE(suspended(_3402,_3404)=true,suspended(_3402,_3404)=false,3) :- 
     grounding(suspended(_3402,_3404)=true).
