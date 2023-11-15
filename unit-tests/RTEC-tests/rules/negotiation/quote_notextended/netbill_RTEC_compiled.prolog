
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
	grounding(quote(Merch,Cons,GD)=true).	

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
	grounding(contract(Merch,Cons,GD)=true).

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
	grounding(per(present_quote(Merch,Cons))=false).
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
	grounding(suspended(Ag,Role)=true).
p(suspended(_Ag,_Role)=true). 


cachingOrder2(_131248, quote(_131248,_131249,_131250)=true) :-
    	role_of(_131248,merchant),
	role_of(_131249,consumer),
	\+_131248=_131249,
	queryGoodsDescription(_131250).

cachingOrder2(_131250, per(present_quote(_131250,_131251))=false) :-
	role_of(_131250,merchant),
	role_of(_131251,consumer),
	\+_131251=_131250.

cachingOrder2(_131248, contract(_131248,_131249,_131250)=true) :-
	role_of(_131248,merchant),
	role_of(_131249,consumer),
	\+_131248=_131249,
	queryGoodsDescription(_131250).

cachingOrder2(_131250, obl(send_EPO(_131250,iServer,_131252))=true) :-
	role_of(_131250,consumer),
	queryGoodsDescription(_131252).

cachingOrder2(_131250, obl(send_goods(_131250,iServer,_131252))=true) :-
	role_of(_131250,merchant),
	queryGoodsDescription(_131252).

cachingOrder2(_131248, suspended(_131248,_131249)=true) :-
	role_of(_131248,_131249).

cachingOrder2(_131250, pow(accept_quote(_131250,_131251,_131252))=true) :-
	role_of(_131251,merchant),
	role_of(_131250,consumer),
	\+_131250=_131251,
	queryGoodsDescription(_131252).



