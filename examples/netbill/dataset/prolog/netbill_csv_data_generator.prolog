/*
This version of the data generator can create csv files of input data 
using the 'createNarrative/4' predicate. 
Its arguments are:
	Start -> the starting timestamp of the reasoning process.
	End -> the final timestamp of the process.
	Seed -> Used by the random package to create a unique dataset. 
		The same Seed value will always yield the same dataset (given that all other parameters are equal).
	AgentNo -> the number of agents to be asserted.
WARNING. 'createNarrative/4' asserts the appropriate number of agents. 
Agent assertions via different files should be avoided when using this predicate -> 
Comment out agent assertions in the static generator file.
*/

:- use_module(library(random)).
:- use_module(library(lists)).

% compute a random subset of a list when Limit<1 and a superset otherwise
% random_subset(+List, +ListLength, +ListSubsetLimit, [], -ListSubset)
random_subset(_List, _Length, Limit, ListSubset, ListSubset) :-
	length(ListSubset, ListSubsetLength),
	ListSubsetLength >= Limit, !.
random_subset(List, Length, Limit, InitialListSubset, ListSubset) :-
	Temp is random(Length),
	nth0(Temp, List, RandomElement),
	random_subset(List, Length, Limit, [RandomElement|InitialListSubset], ListSubset).

createNarrative(Start, End, AgentNo, Seed):-
	Start<End,
	srandom(Seed),
	consult('../negotiation-static_generator.prolog'),
	assert_n_agents(AgentNo),
	openFile(AgentNo,Seed, WriteFileStream),
	updateNarrative(Start, End, WriteFileStream),
	close(WriteFileStream), !.

updateNarrative(Start, End, _Stream):-
	Start >= End.

updateNarrative(Start, End, WriteFileStream):-
	TempEnd is Start + 10,
	updateSDE(Start, TempEnd, WriteFileStream),
	updateNarrative(TempEnd, End, WriteFileStream).

updateSDE(Start, End, WriteFileStream) :-
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
	handleMsg(ConsumersList, ConsumersNo, 0.5, MerchantsList, MerchantsNo, request_quote, book, Start, WriteFileStream),
	% agents with no role request quotes from merchants (to consider entering the market)
	handleMsg(NoRoleList, NoRoleNo, 0.2, MerchantsList, MerchantsNo, request_quote, book, Start, WriteFileStream),
	% merchants request quotes from merchants (to see the competition)
	handleMsg(MerchantsList, MerchantsNo, 0.1, MerchantsList, MerchantsNo, request_quote, book, Start, WriteFileStream),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus1 is Start+1,
	%%%%%%%%%%% present quotes for books %%%%%%%%%%%%%%%%%%
	%% merchants present quotes to consumers
	% when the percentage is greater than 1, ie 5, then senders send more than one message
	handleMsg(MerchantsList, MerchantsNo, 5, ConsumersList, ConsumersNo, present_quote, [book,10], StartPlus1, WriteFileStream),
	%% merchants present quotes to agents without roles
	handleMsg(MerchantsList, MerchantsNo, 0.3, NoRoleList, NoRoleNo, present_quote, [book,10], StartPlus1, WriteFileStream),
	%% agents without roles present quotes to consumers (with the aim of deception)
	handleMsg(NoRoleList, NoRoleNo, 0.1, ConsumersList, ConsumersNo, present_quote, [book,10], StartPlus1, WriteFileStream),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus2 is Start+2,
	%%%%%%%%%%% present quotes for music %%%%%%%%%%%%%%%%%%
	%% merchants present quotes to consumers
	handleMsg(MerchantsList, MerchantsNo, 13, ConsumersList, ConsumersNo, present_quote, [music,10], StartPlus2, WriteFileStream),
	%% merchants present quotes to agents without roles
	handleMsg(MerchantsList, MerchantsNo, 1.3, NoRoleList, NoRoleNo, present_quote, [music,10], StartPlus2, WriteFileStream),
	%% agents without roles present quotes to consumers (with the aim of deception)
	handleMsg(NoRoleList, NoRoleNo, 1.1, ConsumersList, ConsumersNo, present_quote, [music,10], StartPlus2, WriteFileStream),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus3 is Start+3,
	%%%%%%%%%%% request quotes for music %%%%%%%%%%%%%%%%%%
	% consumers request quotes from merchants
	handleMsg(ConsumersList, ConsumersNo, 1.3, MerchantsList, MerchantsNo, request_quote, music, StartPlus3, WriteFileStream),
	% agents with no role request quotes from merchants (to consider entering the market)
	handleMsg(NoRoleList, NoRoleNo, 1.2, MerchantsList, MerchantsNo, request_quote, music, StartPlus3, WriteFileStream),
	% merchants request quotes from merchants (to see the competition)
	handleMsg(MerchantsList, MerchantsNo, 1.1, MerchantsList, MerchantsNo, request_quote, music, StartPlus3, WriteFileStream),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus4 is Start+4,
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus5 is Start+5,
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus6 is Start+6,
	%%%%%%%%%%% accept quotes for books %%%%%%%%%%%%%%%%%%
	%% consumers accepting quotes of merchants (but we are agnostic wrt the existence of quotes)
	handleMsg(ConsumersList, ConsumersNo, 2, MerchantsList, MerchantsNo, accept_quote, book, StartPlus6, WriteFileStream),
	handleMsg(ConsumersList, ConsumersNo, 4, MerchantsList, MerchantsNo, accept_quote, music, StartPlus6, WriteFileStream),
	%% agents without roles accepting quotes of merchants (but we are agnostic wrt the existence of quotes)
	handleMsg(NoRoleList, NoRoleNo, 0.3, MerchantsList, MerchantsNo, accept_quote, book, StartPlus6, WriteFileStream),
	handleMsg(NoRoleList, NoRoleNo, 4.3, MerchantsList, MerchantsNo, accept_quote, music, StartPlus6, WriteFileStream),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus7 is Start+7,
	%%%%%%%%%%%%%%%%%%% send EPOs %%%%%%%%%%%%%%%%%%%%%%%%%%%
	handleMsg(ConsumersList, ConsumersNo, 0.5, [iServer], 1, send_EPO, [book,10], StartPlus7, WriteFileStream),
	handleMsg(ConsumersList, ConsumersNo, 4.5, [iServer], 1, send_EPO, [music,10], StartPlus7, WriteFileStream),
	%%%%%%%%%%% clock tick %%%%%%%%%%%	
	StartPlus8 is Start+8,
	%%%%%%%%%%%%%%%%%%% send goods %%%%%%%%%%%%%%%%%%%%%%%%%%%
	handleMsg(MerchantsList, MerchantsNo, 0.5, [iServer], 1, send_goods, [book,key,dec], StartPlus8, WriteFileStream),
	handleMsg(MerchantsList, MerchantsNo, 4.5, [iServer], 1, send_goods, [music,key,dec], StartPlus8, WriteFileStream).

% Agents from the SenderList send messages to agents from RecipientsList
% handleMsg(+SenderList, +SenderListLength, +SenderLimitPercentage, +RecipientList, +RecipientListLength, +MessageHeader, +MessageTopic,+MessageTime)
handleMsg(SenderList, SenderNo, SenderPercentage, RecipientList, RecipientNo, Header, Topic, Time, WriteFileStream) :-
	TempPercent is SenderNo*SenderPercentage,		
	random_subset(SenderList, SenderNo, TempPercent, [], SenderSubset),
	assertMsg(SenderSubset, RecipientList, RecipientNo, Header, Topic, Time, WriteFileStream).

% assert request_quote messages
% assertMsg(+SenderList, +RecipientList, +RecipientListLength, +MessageHeader, +MessageTopic,+MessageTime)
assertMsg([], _, _, _, _, _, _).
assertMsg([H|Tail], RecipientList, RecipientNo, MessageHeader, Topic, Time, WriteFileStream) :-
	Temp is random(RecipientNo),
	nth0(Temp, RecipientList, RandomRecipient),
	flatten([MessageHeader, H, RandomRecipient, Topic], FlatMsg),
	Message =.. FlatMsg,
	formatWrite(WriteFileStream, Message, Time),
	assertMsg(Tail, RecipientList, RecipientNo, MessageHeader, Topic, Time, WriteFileStream).

openFile(AgentNo,Seed,OpenFileStream):-
    number_atom(AgentNo, AgentNoAtom),
    number_atom(Seed, SeedAtom),
	atom_concat('../csv/negotiation-', AgentNoAtom, FName1),
	atom_concat(FName1, '-', FName2),
	atom_concat(FName2, SeedAtom, FName3),
	atom_concat(FName3, '.csv', FName),
	open(FName, write, OpenFileStream).

formatWrite(WriteFileStream, Message, Time):-
	Message =.. [EventName|ArgsList],
	append([EventName,Time,Time], ArgsList, WriteList),
	writeSep(WriteFileStream, WriteList).

writeSep(WriteFileStream, []):-
	write(WriteFileStream,'\n').

writeSep(WriteFileStream,[Last]):-
	write(WriteFileStream, Last),
	write(WriteFileStream, '\n').

writeSep(WriteFileStream, [H|T]):-
	write(WriteFileStream, H),
	write(WriteFileStream, '|'),
	writeSep(WriteFileStream, T).

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
