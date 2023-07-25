
% the goods_description is static

:- use_module(library(random)).

updateSDE(Start, End) :-
	% sanity check:
	Start<End,
	%%%%%%%%%%% count the agents occupying various roles %%%%%%%%%%%%%%%%%%
	findall(Ag, (agent(Ag),\+role_of(Ag,consumer),\+role_of(Ag,merchant)), NoRoleList),
	length(NoRoleList, NoRoleNo), 
	findall(C, role_of(C,consumer), ConsumersList),
	length(ConsumersList, ConsumersNo), 
	findall(M, role_of(M,merchant), MerchantsList),
	length(MerchantsList, MerchantsNo), 
	findall(C, (role_of(C,consumer),\+role_of(C,merchant)), ConsumersOnlyList),
	length(ConsumersOnlyList, ConsumersOnlyNo), 
	findall(M, (role_of(M,merchant),\+role_of(M,consumer)), MerchantsOnlyList),
	length(MerchantsOnlyList, MerchantsOnlyNo), 
	findall(CM, (role_of(CM,merchant),role_of(CM,consumer)), ConsumersMerchantsList),
	length(ConsumersMerchantsList, ConsumersMerchantsListNo),
	%%%%%%%%%%% request quotes for books %%%%%%%%%%%%%%%%%% 
	% consumers request quotes from merchants
	handleMsg(ConsumersList, ConsumersNo, 0.5, MerchantsList, MerchantsNo, request_quote, book, Start),
	% agents with no role request quotes from merchants (to consider entering the market)
	handleMsg(NoRoleList, NoRoleNo, 0.2, MerchantsList, MerchantsNo, request_quote, book, Start),
	% merchants request quotes from merchants (to see the competition)
	handleMsg(MerchantsList, MerchantsNo, 0.1, MerchantsList, MerchantsNo, request_quote, book, Start),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus1 is Start+1,
	%%%%%%%%%%% present quotes for books %%%%%%%%%%%%%%%%%%
	%% merchants present quotes to consumers
	% when the percentage is greater than 1, ie 5, then senders send more than one message
	handleMsg(MerchantsList, MerchantsNo, 5, ConsumersList, ConsumersNo, present_quote, [book,10], StartPlus1),
	%% merchants present quotes to agents without roles
	handleMsg(MerchantsList, MerchantsNo, 0.3, NoRoleList, NoRoleNo, present_quote, [book,10], StartPlus1),
	%% agents without roles present quotes to consumers (with the aim of deception)
	handleMsg(NoRoleList, NoRoleNo, 0.1, ConsumersList, ConsumersNo, present_quote, [book,10], StartPlus1),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus2 is Start+2,
	%%%%%%%%%%% present quotes for music %%%%%%%%%%%%%%%%%%
	%% merchants present quotes to consumers
	handleMsg(MerchantsList, MerchantsNo, 13, ConsumersList, ConsumersNo, present_quote, [music,10], StartPlus2),
	%% merchants present quotes to agents without roles
	handleMsg(MerchantsList, MerchantsNo, 1.3, NoRoleList, NoRoleNo, present_quote, [music,10], StartPlus2),
	%% agents without roles present quotes to consumers (with the aim of deception)
	handleMsg(NoRoleList, NoRoleNo, 1.1, ConsumersList, ConsumersNo, present_quote, [music,10], StartPlus2),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus3 is Start+3,
	%%%%%%%%%%% request quotes for music %%%%%%%%%%%%%%%%%%
	% consumers request quotes from merchants
	handleMsg(ConsumersList, ConsumersNo, 1.3, MerchantsList, MerchantsNo, request_quote, music, StartPlus3),
	% agents with no role request quotes from merchants (to consider entering the market)
	handleMsg(NoRoleList, NoRoleNo, 1.2, MerchantsList, MerchantsNo, request_quote, music, StartPlus3),
	% merchants request quotes from merchants (to see the competition)
	handleMsg(MerchantsList, MerchantsNo, 1.1, MerchantsList, MerchantsNo, request_quote, music, StartPlus3),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus4 is Start+4,
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus5 is Start+5,
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus6 is Start+6,
	%%%%%%%%%%% accept quotes for books %%%%%%%%%%%%%%%%%%
	%% consumers accepting quotes of merchants (but we are agnostic wrt the existence of quotes)
	handleMsg(ConsumersList, ConsumersNo, 2, MerchantsList, MerchantsNo, accept_quote, book, StartPlus6),
	handleMsg(ConsumersList, ConsumersNo, 4, MerchantsList, MerchantsNo, accept_quote, music, StartPlus6),
	%% agents without roles accepting quotes of merchants (but we are agnostic wrt the existence of quotes)
	handleMsg(NoRoleList, NoRoleNo, 0.3, MerchantsList, MerchantsNo, accept_quote, book, StartPlus6),
	handleMsg(NoRoleList, NoRoleNo, 4.3, MerchantsList, MerchantsNo, accept_quote, music, StartPlus6),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus7 is Start+7,
	%%%%%%%%%%%%%%%%%%% send EPOs %%%%%%%%%%%%%%%%%%%%%%%%%%%
	handleMsg(ConsumersList, ConsumersNo, 0.5, [iServer], 1, send_EPO, [book,10], StartPlus7),
	handleMsg(ConsumersList, ConsumersNo, 4.5, [iServer], 1, send_EPO, [music,10], StartPlus7),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus8 is Start+8,
	%%%%%%%%%%%%%%%%%%% send goods %%%%%%%%%%%%%%%%%%%%%%%%%%%
	handleMsg(MerchantsList, MerchantsNo, 0.5, [iServer], 1, send_goods, [book,key,dec], StartPlus8),
	handleMsg(MerchantsList, MerchantsNo, 4.5, [iServer], 1, send_goods, [music,key,dec], StartPlus8).

% Agents from the SenderList send messages to agents from RecipientsList
% handleMsg(+SenderList, +SenderListLength, +SenderLimitPercentage, +RecipientList, +RecipientListLength, +MessageHeader, +MessageTopic,+MessageTime)
handleMsg(SenderList, SenderNo, SenderPercentage, RecipientList, RecipientNo, Header, Topic, Time) :-
	TempPercent is SenderNo*SenderPercentage,		
	random_subset(SenderList, SenderNo, TempPercent, [], SenderSubset),
	assertMsg(SenderSubset, RecipientList, RecipientNo, Header, Topic, Time).

% compute a random subset of a list when Limit<1 and a superset otherwise
% random_subset(+List, +ListLength, +ListSubsetLimit, [], -ListSubset)
random_subset(_List, _Length, Limit, ListSubset, ListSubset) :-
	length(ListSubset, ListSubsetLength),
	ListSubsetLength >= Limit, !.
random_subset(List, Length, Limit, InitialListSubset, ListSubset) :-
	Temp is random(Length),
	nth0(Temp, List, RandomElement),
	random_subset(List, Length, Limit, [RandomElement|InitialListSubset], ListSubset).

% assert request_quote messages
% assertMsg(+SenderList, +RecipientList, +RecipientListLength, +MessageHeader, +MessageTopic,+MessageTime)
assertMsg([], _, _, _, _, _).
assertMsg([H|Tail], RecipientList, RecipientNo, MessageHeader, Topic, Time) :-
	Temp is random(RecipientNo),
	nth0(Temp, RecipientList, RandomRecipient),
	flatten([MessageHeader, H, RandomRecipient, Topic], FlatMsg),
	Message =.. FlatMsg,
	assertz(happensAtIE(Message, Time)),
	assertMsg(Tail, RecipientList, RecipientNo, MessageHeader, Topic, Time).

/*
updateSDE(Start, End) :-
	%%%%%%%%%%%%%%%%%%%%%%%% request books %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% requesting quotes from merchants; non-consumers and merchants also make requests
	findall((C,M),	(agent(C), role_of(M,merchant), \+M=C, random(R), R>0.9, assertz(happensAtIE(request_quote(C,M,book), Start))), _),
	%%%%%%%%%%%%%%%%%%% present quotes for books %%%%%%%%%%%%%%%%%%%%%%% 
	StartPlus1 is Start+1,	
	%% merchants present quotes to consumers
	findall((M,C),	(role_of(C,consumer), role_of(M,merchant), \+M=C, random(R), R>0.7, assertz(happensAtIE(present_quote(M,C,book,10), StartPlus1))), _),
	%% merchants present quotes to non-consumers
	findall((M,C),	(agent(C), \+role_of(C,consumer), \+role_of(C,merchant), role_of(M,merchant), \+M=C, random(R), R>0.9, assertz(happensAtIE(present_quote(M,C,book,10), StartPlus1))), _),
	%% unexpected behaviour: non-merchants present quotes to consumers (with the aim of deception)
	findall((M,C),	(role_of(C,consumer), agent(M), \+role_of(M,merchant), \+M=C, random(R), R>0.95, assertz(happensAtIE(present_quote(M,C,book,10), StartPlus1))), _),	
	%%%%%%%%%%%%%%%%% present quotes for music %%%%%%%%%%%%%%%%%%%%%%%%%
	StartPlus2 is Start+2,
	%% merchants present quotes to consumers
	findall((M,C),	(role_of(C,consumer), role_of(M,merchant), \+M=C, random(R), R>0.7, assertz(happensAtIE(present_quote(M,C,music,10), StartPlus2))), _),
	%% merchants present quotes to non-consumers
	findall((M,C),	(agent(C), \+role_of(C,consumer), \+role_of(C,merchant), role_of(M,merchant), \+M=C, random(R), R>0.9, assertz(happensAtIE(present_quote(M,C,music,10), StartPlus2))), _),
	%% unexpected behaviour: non-merchants present quotes to consumers (with the aim of deception)
	findall((M,C),	(role_of(C,consumer), agent(M), \+role_of(M,merchant), \+M=C, random(R), R>0.95, assertz(happensAtIE(present_quote(M,C,music,10), StartPlus2))), _),
	%%%%%%%%%%%%%%%%%%%%%% request music %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	StartPlus3 is Start+3,	
	%% requesting quotes from merchants; non-consumers and merchants also make requests
	findall((C,M),	(agent(C), role_of(M,merchant), \+M=C, random(R), R>0.9, assertz(happensAtIE(request_quote(C,M,music), StartPlus3))), _),
	%%%%%%%%%%%%%%%%%%%%% accept quotes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	StartPlus6 is Start+6,   
	%% consumers accepting quotes (but we are agnostic wrt the existence of quotes)
	findall((C,M),	(role_of(C,consumer), role_of(M,merchant), \+M=C, random(R), R>0.8, assertz(happensAtIE(accept_quote(C,M,book), StartPlus6))), _),
	findall((C,M),	(role_of(C,consumer), role_of(M,merchant), \+M=C, random(R), R>0.8, assertz(happensAtIE(accept_quote(C,M,music), StartPlus6))), _),
	%% unexpected behaviour: non-consumers accept quotes
	findall((C,M),	(agent(C), \+role_of(C,consumer), role_of(M,merchant), \+M=C, random(R), R>0.95, assertz(happensAtIE(accept_quote(C,M,book), StartPlus6))), _),
	findall((C,M),	(agent(C), \+role_of(C,consumer), role_of(M,merchant), \+M=C, random(R), R>0.95, assertz(happensAtIE(accept_quote(C,M,music), StartPlus6))), _),
	%%%%%%%%%%%%%%%%%%% send EPOs and goods %%%%%%%%%%%%%%%%%%%%%%%%%%%
	StartPlus7 is Start+7, 	
	findall(C,	(role_of(C,consumer), random(R), R>0.8, assertz(happensAtIE(send_EPO(C,iServer,book,10), StartPlus7))), _),
	findall(C,	(role_of(C,consumer), random(R), R>0.8, assertz(happensAtIE(send_EPO(C,iServer,music,10), StartPlus7))), _),
	StartPlus8 is Start+8,
	findall(M,	(role_of(M,merchant), random(R), R>0.7, assertz(happensAtIE(send_goods(M,iServer,book,key,dec), StartPlus8))), _),
	findall(M,	(role_of(M,merchant), random(R), R>0.7, assertz(happensAtIE(send_goods(M,iServer,music,key,dec), StartPlus8))), _).


*/
