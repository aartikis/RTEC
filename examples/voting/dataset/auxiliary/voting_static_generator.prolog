

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

role(chair).
role(voter).

% the two lines below should be used when using the data generator
% 91% voters, 10% chairs, 9% both roles, 8% no role
role_of(Ag,chair) :- person(Ag), Temp is Ag mod 10, Temp=0.
role_of(Ag,voter) :- person(Ag), Temp is Ag mod 11, Temp>0.

% motion/1 is used for data generation; 
% queryMotion/1 is the subset of motion/1 used for narrative assimilation 

motion(1).
motion(2).
motion(3).
motion(4).
motion(5).
motion(6).
motion(7).
motion(8).
motion(9).
motion(10).

queryMotion(M) :-
	motion(M), Temp is M mod 3, Temp=0.
