assert_n_agents(N):- N>0, N1 is N-1, N1=0, assert(agent(N1)).
assert_n_agents(N):- N>0, N1 is N-1, assert(agent(N1)), assert_n_agents(N1).
