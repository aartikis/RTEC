
%:- ['prolog/agent1000.prolog'].
%:- ['prolog/agent2000.prolog'].
%:- ['prolog/agent3000.prolog'].
%:- ['prolog/agent4000.prolog'].
%:- ['prolog/agent5000.prolog'].
%:- ['prolog/agent6000.prolog'].
%:- ['prolog/agent7000.prolog'].
%:- ['prolog/agent8000.prolog'].
%:- ['prolog/agent9000.prolog'].
%:- ['prolog/agent10000.prolog'].

%assert_n_agents(N):- N>0, N1 is N-1, N1=0, assertz(agent(N1)).
%assert_n_agents(N):- N>0, N1 is N-1, assertz(agent(N1)), assert_n_agents(N1).

role(merchant).
role(consumer).

% role allocation: 66% consumers, 10% merchants, 6% both roles, 30% no role
%role_of(C, consumer) :- 
%%agent(C),
%TempC is C mod 3, TempC>0.
%role_of(M, merchant) :- 
%%agent(M),
%TempM is M mod 10, TempM=0.

role_of(C, consumer) :- 
	%agent(C),
	TempC is C mod 3, TempC>0.
role_of(M, merchant) :- 
	%agent(M),
	TempM is M mod 2, TempM=0.

%queryGoodsDescription(book1).
%queryGoodsDescription(book2).
%queryGoodsDescription(book4).
%queryGoodsDescription(book6).
%queryGoodsDescription(book7).
%queryGoodsDescription(book10).
queryGoodsDescription(book).
queryGoodsDescription(music).


price(_, 10).
decrypt(_, _, _).
meets(_, _).

