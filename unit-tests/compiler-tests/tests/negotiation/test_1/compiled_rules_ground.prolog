
/************************************************
 * 						*
 * Compiler unit test: NetBill protocol		* 
 *                                              *
 ************************************************/

:- discontiguous initiatedAt/4, terminatedAt/4, holdsForSDFluent/2, fi/3, p/1, cyclic/1.

/***************
 *    quote    *
 ***************/

% ----- a quote enables the consumer to create a contract by accepting it
initiatedAt(quote(Merch,Cons,GD)=true, T1, T, T2) :-
	happensAtIE(present_quote(Merch,Cons,GD,_Price), T),
	T1 =<T, T<T2.
initiatedAt(quote(Merch,Cons,GD)=false, T1, T, T2) :-
	happensAtIE(accept_quote(Cons,Merch,GD), T),
	T1 =<T, T<T2.
% ----- a quote is terminated 5 time-points after initiated
fi(quote(Merch,Cons,GD)=true, quote(Merch,Cons,GD)=false, 5) :-
	grounding(quote(Merch,Cons,GD)=true), grounding(quote(Merch,Cons,GD)=false).
p(quote(_Merch,_Cons,_GD)=true).

/*****************
 *   contract	 *
 *****************/

% ----- accepting a quote initiates a contract 
initiatedAt(contract(Merch,Cons,GD)=true, T1, T, T2) :-
	happensAtIE(accept_quote(Cons,Merch,GD), T),
	T1 =<T, T<T2,
	holdsAtProcessedSimpleFluent(Merch, quote(Merch,Cons,GD)=true, T),
	% contracts may be established only between (non-suspended) consumers and merchants
	\+ holdsAtCyclic(Merch, suspended(Merch,merchant)=true, T),
	\+ holdsAtCyclic(Cons, suspended(Cons,consumer)=true, T). 
% ----- a contract is terminated 10 time-points after initiated 
fi(contract(Merch,Cons,GD)=true, contract(Merch,Cons,GD)=false, 5)  :-
	grounding(contract(Merch,Cons,GD)=true), grounding(contract(Merch,Cons,GD)=false).

/*********************
  INSTITUTIONAL POWER
 *********************/

holdsForSDFluent(pow(accept_quote(Cons,Merch,GD))=true, I) :-
	holdsForProcessedSimpleFluent(Merch, quote(Merch,Cons,GD)=true, I1),
	holdsForProcessedSimpleFluent(Cons, suspended(Cons,consumer)=true, I2),
	holdsForProcessedSimpleFluent(Merch, suspended(Merch,merchant)=true, I3),
	relative_complement_all(I1, [I2,I3], I).
	
% ----- we do not define institutional power for the remaining actions

/***********************
 *     PERMISSION      *
 ***********************/

/*
% initially:
initiatedAt(per(present_quote(Merch,Cons))=true, T1, -1, T2) :- 
	T1=<(-1), -1<T2.
*/

% permitted by default; thus we only model (and ground) prohibitions
initiatedAt(per(present_quote(Merch,Cons))=false, T1, T, T2) :-
	happensAtIE(present_quote(Merch,Cons,_GD,_Price), T),
	T1 =<T, T<T2.
initiatedAt(per(present_quote(Merch,Cons))=true, T1, T, T2) :-
	happensAtIE(request_quote(Cons,Merch,_GD), T),
	T1 =<T, T<T2.
fi(per(present_quote(Merch,Cons))=false, per(present_quote(Merch,Cons))=true, 10)  :-
	grounding(per(present_quote(Merch,Cons))=false), grounding(per(present_quote(Merch,Cons))=true).
p(per(present_quote(_Merch,_Cons))=false).

/***********************
 *     OBLIGATION      *
 ***********************/

% ----- establishing a contract initiates obligations for the contracting parties
initiatedAt(obl(send_EPO(Cons,iServer,GD))=true, T1, T, T2) :-
	% start(F=V) events are not supported for cyclic fluents F
	initiatedAt(contract(_Merch,Cons,GD)=true, T1, T, T2).
initiatedAt(obl(send_goods(Merch,iServer,GD))=true, T1, T, T2) :-
	% start(F=V) events are not supported for cyclic fluents F
	initiatedAt(contract(Merch,_Cons,GD)=true, T1, T, T2).

% ----- discharging the obligations
initiatedAt(obl(send_EPO(Cons,iServer,GD))=false, T1, T, T2) :-
	happensAtIE(send_EPO(Cons,iServer,GD,Price), T),
	T1 =<T, T<T2,
	% below is an atemporal fact indicating the price of GD
	% facts of this type should be defined along with the agents of protocol
	price(GD,Price).
initiatedAt(obl(send_goods(Merch,iServer,GD))=false, T1, T, T2) :-
	happensAtIE(send_goods(Merch,iServer,GD,G,Key), T),
	T1 =<T, T<T2,
	% below are atemporal facts whether the decrypted goods are the ones promised
	% facts of this type should be defined along with the agents of protocol
	decrypt(G,Key,Decrypted_G), meets(Decrypted_G,GD).	

% ----- the end of the contract terminates the obligations of the contracting parties
initiatedAt(obl(send_EPO(Cons,iServer,GD))=false, T1, T, T2) :-
	% end(F=V) events are not supported for cyclic fluents F
	initiatedAt(contract(_Merch,Cons,GD)=false, T1, T, T2).
initiatedAt(obl(send_goods(Merch,iServer,GD))=false, T1, T, T2) :-
	% end(F=V) events are not supported for cyclic fluents F
	initiatedAt(contract(Merch,_Cons,GD)=false, T1, T, T2).

/***********************
 *      SANCTION       *
 ***********************/

% ----- if a merchant sends unsolicited quotes 'too frequently', which is forbidden, 
% ----- then it will be suspended
initiatedAt(suspended(Merch,merchant)=true, T1, T, T2) :-
	happensAtIE(present_quote(Merch,Cons,_GD,_Price), T),
	T1 =<T, T<T2,
	holdsAtProcessedSimpleFluent(Merch, per(present_quote(Merch,Cons))=false, T).
% ----- failure to discharge the obligation to send an EPO by the end of the contract 
% ----- suspends the merchant 
initiatedAt(suspended(Merch,merchant)=true, T1, T, T2) :-
	% end(F=V) events are not supported for cyclic fluents F
	initiatedAt(contract(Merch,_Cons,GD)=false, T1, T, T2),
	holdsAtCyclic(Merch, obl(send_goods(Merch,iServer,GD))=true, T).
% ----- failure to discharge the obligation to send an EPO by the end of the contract 
% ----- suspends the consumer 
initiatedAt(suspended(Cons,consumer)=true, T1, T, T2) :-
	% end(F=V) events are not supported for cyclic fluents F
	initiatedAt(contract(_Merch,Cons,GD)=false, T1, T, T2),
	holdsAtCyclic(Cons, obl(send_EPO(Cons,iServer,GD))=true, T).	
% ----- a suspension is terminated 10 time-points after initiated, 
% ----- unless re-initiated in the meantime
fi(suspended(Ag,Role)=true, suspended(Ag,Role)=false, 3) :- 
	grounding(suspended(Ag,Role)=true), grounding(suspended(Ag,Role)=false).
p(suspended(_Ag,_Role)=true).

grounding(request_quote(C,M,_)):-
    person_pair(M, C).
grounding(present_quote(M,C,_,_)):-
    person_pair(M, C).
grounding(accept_quote(C,M,_)):-
    person_pair(M, C).
grounding(send_EPO(Ag,_,_,_)):-
    person(Ag).
grounding(send_goods(Ag,_,_,_,_)):-
    person(Ag).
grounding(suspended(Ag,Role)=true):-
    person(Ag),role_of(Ag,Role).
grounding(suspended(Ag,Role)=false):-
    person(Ag),role_of(Ag,Role).
grounding(quote(M,C,GD)=true):- 
    person_pair(M,C), role_of(C, consumer), role_of(M, merchant), \+ M=C, queryGoodsDescription(GD).
grounding(quote(M,C,GD)=false):- 
    person_pair(M,C), role_of(C, consumer), role_of(M, merchant), \+ M=C, queryGoodsDescription(GD).
grounding(contract(M,C,GD)=true):-
    person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ M=C, queryGoodsDescription(GD).
grounding(contract(M,C,GD)=false):-
    person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ M=C, queryGoodsDescription(GD).
grounding(pow(accept_quote(C,M,GD))=true):-
    person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ C=M, queryGoodsDescription(GD).
grounding(per(present_quote(M,C))=false):-
    person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ C=M.
grounding(per(present_quote(M,C))=true):-
    person_pair(M,C),role_of(M,merchant), role_of(C,consumer), \+ C=M.
grounding(obl(send_EPO(C,iServer,GD))=true):-
    person(C),role_of(C,consumer), queryGoodsDescription(GD).
grounding(obl(send_goods(M,iServer,GD))=true):-
    person(M),role_of(M,merchant), queryGoodsDescription(GD).
grounding(obl(send_EPO(C,iServer,GD))=false):-
    person(C),role_of(C,consumer), queryGoodsDescription(GD).
grounding(obl(send_goods(M,iServer,GD))=false):-
    person(M),role_of(M,merchant), queryGoodsDescription(GD).

inputEntity(present_quote(_M,_C,_5040,_5042)).
inputEntity(accept_quote(_C,_M,_5040)).
inputEntity(request_quote(_C,_M,_5040)).
inputEntity(send_EPO(_Ag,_5038,_5040,_5042)).
inputEntity(send_goods(_Ag,_5038,_5040,_5042,_5044)).

outputEntity(quote(_5128,_5130,_5132)=true).
outputEntity(quote(_5128,_5130,_5132)=false).
outputEntity(contract(_5128,_5130,_5132)=true).
outputEntity(per(present_quote(_5132,_5134))=false).
outputEntity(per(present_quote(_5132,_5134))=true).
outputEntity(obl(send_EPO(_5132,_5134,_5136))=false).
outputEntity(obl(send_goods(_5132,_5134,_5136))=false).
outputEntity(suspended(_5128,_5130)=true).
outputEntity(obl(send_EPO(_5132,_5134,_5136))=true).
outputEntity(obl(send_goods(_5132,_5134,_5136))=true).
outputEntity(contract(_5128,_5130,_5132)=false).
outputEntity(suspended(_5128,_5130)=false).
outputEntity(pow(accept_quote(_5132,_5134,_5136))=true).

event(present_quote(_5256,_5258,_5260,_5262)).
event(accept_quote(_5256,_5258,_5260)).
event(request_quote(_5256,_5258,_5260)).
event(send_EPO(_5256,_5258,_5260,_5262)).
event(send_goods(_5256,_5258,_5260,_5262,_5264)).

simpleFluent(quote(_5348,_5350,_5352)=true).
simpleFluent(quote(_5348,_5350,_5352)=false).
simpleFluent(contract(_5348,_5350,_5352)=true).
simpleFluent(per(present_quote(_5352,_5354))=false).
simpleFluent(per(present_quote(_5352,_5354))=true).
simpleFluent(obl(send_EPO(_5352,_5354,_5356))=false).
simpleFluent(obl(send_goods(_5352,_5354,_5356))=false).
simpleFluent(suspended(_5348,_5350)=true).
simpleFluent(obl(send_EPO(_5352,_5354,_5356))=true).
simpleFluent(obl(send_goods(_5352,_5354,_5356))=true).
simpleFluent(contract(_5348,_5350,_5352)=false).
simpleFluent(suspended(_5348,_5350)=false).

sDFluent(pow(accept_quote(_5480,_5482,_5484))=true).

index(present_quote(_5484,_5538,_5540,_5542),_5484).
index(accept_quote(_5484,_5538,_5540),_5484).
index(request_quote(_5484,_5538,_5540),_5484).
index(send_EPO(_5484,_5538,_5540,_5542),_5484).
index(send_goods(_5484,_5538,_5540,_5542,_5544),_5484).
index(quote(_5484,_5544,_5546)=true,_5484).
index(quote(_5484,_5544,_5546)=false,_5484).
index(contract(_5484,_5544,_5546)=true,_5484).
index(per(present_quote(_5484,_5548))=false,_5484).
index(per(present_quote(_5484,_5548))=true,_5484).
index(obl(send_EPO(_5484,_5548,_5550))=false,_5484).
index(obl(send_goods(_5484,_5548,_5550))=false,_5484).
index(suspended(_5484,_5544)=true,_5484).
index(obl(send_EPO(_5484,_5548,_5550))=true,_5484).
index(obl(send_goods(_5484,_5548,_5550))=true,_5484).
index(contract(_5484,_5544,_5546)=false,_5484).
index(suspended(_5484,_5544)=false,_5484).
index(pow(accept_quote(_5484,_5548,_5550))=true,_5484).

cyclic(contract(_5766,_5768,_5770)=true).
cyclic(suspended(_5766,_5768)=true).
cyclic(obl(send_EPO(_5770,_5772,_5774))=true).
cyclic(obl(send_goods(_5770,_5772,_5774))=true).
cyclic(contract(_5766,_5768,_5770)=false).
cyclic(suspended(_860,_862)=false).

cachingOrder2(_1094, quote(_1094,_1096,_1098)=true) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_1094,_1096),role_of(_1096,consumer),role_of(_1094,merchant),\+_1094=_1096,queryGoodsDescription(_1098).

cachingOrder2(_1094, quote(_1094,_1096,_1098)=false) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_1094,_1096),role_of(_1096,consumer),role_of(_1094,merchant),\+_1094=_1096,queryGoodsDescription(_1098).

cachingOrder2(_1048, per(present_quote(_1048,_1050))=false) :- % level in dependency graph: 1, processing order in component: 1
     person_pair(_1048,_1050),role_of(_1048,merchant),role_of(_1050,consumer),\+_1050=_1048.

cachingOrder2(_1048, per(present_quote(_1048,_1050))=true) :- % level in dependency graph: 1, processing order in component: 2
     person_pair(_1048,_1050),role_of(_1048,merchant),role_of(_1050,consumer),\+_1050=_1048.

cachingOrder2(_1528, obl(send_goods(_1528,_IServer,_1532))=true) :- % level in dependency graph: 2, processing order in component: 1
     person(_1528),role_of(_1528,merchant),queryGoodsDescription(_1532).

cachingOrder2(_1552, obl(send_EPO(_1552,_IServer,_1556))=true) :- % level in dependency graph: 2, processing order in component: 2
     person(_1552),role_of(_1552,consumer),queryGoodsDescription(_1556).

cachingOrder2(_1572, suspended(_1572,_1574)=true) :- % level in dependency graph: 2, processing order in component: 3
     person(_1572),role_of(_1572,_1574).

cachingOrder2(_1590, suspended(_1590,_1592)=false) :- % level in dependency graph: 2, processing order in component: 4
     person(_1590),role_of(_1590,_1592).

cachingOrder2(_1608, contract(_1608,_1610,_1612)=true) :- % level in dependency graph: 2, processing order in component: 5
     person_pair(_1608,_1610),role_of(_1608,merchant),role_of(_1610,consumer),\+_1608=_1610,queryGoodsDescription(_1612).

cachingOrder2(_1628, contract(_1628,_1630,_1632)=false) :- % level in dependency graph: 2, processing order in component: 6
     person_pair(_1628,_1630),role_of(_1628,merchant),role_of(_1630,consumer),\+_1628=_1630,queryGoodsDescription(_1632).

cachingOrder2(_2158, obl(send_EPO(_2158,_IServer,_2162))=false) :- % level in dependency graph: 3, processing order in component: 1
     person(_2158),role_of(_2158,consumer),queryGoodsDescription(_2162).

cachingOrder2(_2128, obl(send_goods(_2128,_IServer,_2132))=false) :- % level in dependency graph: 3, processing order in component: 1
     person(_2128),role_of(_2128,merchant),queryGoodsDescription(_2132).

cachingOrder2(_2098, pow(accept_quote(_2098,_2100,_2102))=true) :- % level in dependency graph: 3, processing order in component: 1
     person_pair(_2100,_2098),role_of(_2100,merchant),role_of(_2098,consumer),\+_2098=_2100,queryGoodsDescription(_2102).

collectGrounds([send_EPO(_5284,_5298,_5300,_5302), send_goods(_5284,_5298,_5300,_5302,_5304)],person(_5284)).

collectGrounds([accept_quote(_368,_366,_394), present_quote(_366,_368,_394,_396), request_quote(_368,_366,_394)],person_pair(_366,_368)).

dgrounded(quote(_6230,_6232,_6234)=true, person_pair(_6230,_6232)).
dgrounded(quote(_6142,_6144,_6146)=false, person_pair(_6142,_6144)).
dgrounded(contract(_6054,_6056,_6058)=true, person_pair(_6054,_6056)).
dgrounded(per(present_quote(_5978,_5980))=false, person_pair(_5978,_5980)).
dgrounded(per(present_quote(_5898,_5900))=true, person_pair(_5898,_5900)).
dgrounded(obl(send_EPO(_5836,iServer,_5840))=false, person(_5836)).
dgrounded(obl(send_goods(_5774,iServer,_5778))=false, person(_5774)).
dgrounded(suspended(_5724,_5726)=true, person(_5724)).
dgrounded(obl(send_EPO(_5666,iServer,_5670))=true, person(_5666)).
dgrounded(obl(send_goods(_5604,iServer,_5608))=true, person(_5604)).
dgrounded(contract(_5512,_5514,_5516)=false, person_pair(_5512,_5514)).
dgrounded(suspended(_5466,_5468)=false, person(_5466)).
dgrounded(pow(accept_quote(_5378,_5380,_5382))=true, person_pair(_5380,_5378)).
