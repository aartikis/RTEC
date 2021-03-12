
agent(1).
agent(2).
agent(3).
agent(4).
agent(5).
agent(6).

role(chair).
role(voter).

% the two lines below should be used when using the small, static data stream
role_of(Ag,chair) :- agent(Ag).
role_of(Ag,voter) :- agent(Ag).

% motion/1 is used for data generation; 
% queryMotion/1 is the subset of motion/1 used for narrative assimilation 

motion(1).
queryMotion(1).
