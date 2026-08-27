/*
This version of the data generator can create csv files of input data using the 'createNarrative/4' predicate. 
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

createNarrative(Start, End, AgentNo, VotingDuration, Seed):-
	Start<End,
	set_random(seed(Seed)),
	consult('../auxiliary/voting_static_generator.prolog'),
	assert_n_agents(AgentNo),
	openFile(AgentNo, Seed, VotingDuration, WriteFileStream),
	updateNarrative(Start, End, VotingDuration, WriteFileStream),
	close(WriteFileStream), !.

updateNarrative(Start, End, _VotingDuration, _Stream):-
	Start >= End.

updateNarrative(Start, End, VotingDuration, WriteFileStream):-
	TempEnd is Start + VotingDuration, % voting procedure duration
	updateSDE(Start, TempEnd, WriteFileStream),
	updateNarrative(TempEnd, End, VotingDuration, WriteFileStream).

updateSDE(Start, End, WriteFileStream) :-
	% sanity check:
	Start < End,
	Duration is End - Start,
    Multiplier is Duration/5,
	randset(10, Duration, [Step11, Step12, Step13, Step14, _Step15, Step16, Step17, Step18, Step19, Step110]),
	Step0 = Start,
	Step1 is Start + Step11,
	Step2 is Start + Step12,
	Step3 is Start + Step13,
	Step4 is Start + Step14,
	Step6 is Start + Step16,
	Step7 is Start + Step17,
	Step8 is Start + Step18,
	Step9 is Start + Step19,
	Step10 is Start + Step110,
	%%%%%%%%%%% count the agents occupying various roles %%%%%%%%%%%%%%%%%%
	findall(Ag, (person(Ag),\+role_of(Ag,chair),\+role_of(Ag,voter)), NoRoleList),
	length(NoRoleList, _NoRoleNo), 
	findall(V, role_of(V,voter), VotersList), length(VotersList, VotersNo), 
	findall(C, role_of(C,chair), ChairsList), length(ChairsList, ChairsNo), 
	findall(V, (role_of(V,voter),\+role_of(V,chair)), VotersOnlyList),
	length(VotersOnlyList, _VotersOnlyNo), 
	findall(C, (role_of(C,chair),\+role_of(C,voter)), ChairsOnlyList),
	length(ChairsOnlyList, _ChairsOnlyNo), 
	findall(VC, (role_of(VC,voter),role_of(VC,chair)), VotersChairsList),
	length(VotersChairsList, VotersChairsNo),
	%%%%%%%%%%% count the number of motions %%%%%%%%%%%%%%%%%%
	findall(M, motion(M), MotionsList), length(MotionsList, MotionsNo),
	%%%%%%%%%%% propose motion %%%%%%%%%%%%%%%%%% 
	%handleMsg(VotersChairsList, VotersChairsNo, 1.3, MotionsList, MotionsNo, propose, [], Step0, Step1, WriteFileStream),
    S0 is 1.3*Multiplier,
	handleMsg(VotersChairsList, VotersChairsNo, S0, MotionsList, MotionsNo, propose, [], Step0, Step1, WriteFileStream),
	%%%%%%%%%%% propose motion %%%%%%%%%%%%%%%%%% 
	%handleMsg(VotersList, VotersNo, 0.2, MotionsList, MotionsNo, propose, [], Step1, Step2, WriteFileStream),
	S1 is 0.2 *Multiplier,
    handleMsg(VotersList, VotersNo, S1, MotionsList, MotionsNo, propose, [], Step1, Step2, WriteFileStream),
	%%%%%%%%%%% close ballot %%%%%%%%%%%%%%%%%% 
	%handleMsg(VotersChairsList, VotersChairsNo, 0.1, MotionsList, MotionsNo, close_ballot, [], Step2, Step3, WriteFileStream),
    S2 is 0.1*Multiplier,
	handleMsg(VotersChairsList, VotersChairsNo, S2, MotionsList, MotionsNo, close_ballot, [], Step2, Step3, WriteFileStream),
	%%%%%%%%%%% second motion %%%%%%%%%%%%%%%%%% 
	%handleMsg(VotersChairsList, VotersChairsNo, 1.8, MotionsList, MotionsNo, second, [], Step3, Step4, WriteFileStream),
    S3 is 1.8*Multiplier,
	handleMsg(VotersChairsList, VotersChairsNo, S3, MotionsList, MotionsNo, second, [], Step3, Step4, WriteFileStream),
	%%%%%%%%%%% voting %%%%%%%%%%%%%%%%%% 
	Step6M1 is Step6 - 1,
	%handleMsg(VotersList, VotersNo, 2.3, MotionsList, MotionsNo, vote, aye, Step4, Step6M1, WriteFileStream),
    S4 is 2.3*Multiplier,
	handleMsg(VotersList, VotersNo, S4, MotionsList, MotionsNo, vote, aye, Step4, Step6M1, WriteFileStream),
	%handleMsg(VotersList, VotersNo, 2.4, MotionsList, MotionsNo, vote, nay, Step4, Step6M1, WriteFileStream),
    S5 is 2.4*Multiplier,
	handleMsg(VotersList, VotersNo, S5, MotionsList, MotionsNo, vote, nay, Step4, Step6M1, WriteFileStream),
	%%%%%%%%%%% voting %%%%%%%%%%%%%%%%%% 
	%handleMsg(VotersList, VotersNo, 2.8, MotionsList, MotionsNo, vote, aye, Step6, Step7, WriteFileStream),
    S6 is 2.8*Multiplier,
	handleMsg(VotersList, VotersNo, S6, MotionsList, MotionsNo, vote, aye, Step6, Step7, WriteFileStream),
	%handleMsg(VotersList, VotersNo, 2.7, MotionsList, MotionsNo, vote, nay, Step6, Step7, WriteFileStream),
    S7 is 2.7*Multiplier,
	handleMsg(VotersList, VotersNo, S7, MotionsList, MotionsNo, vote, nay, Step6, Step7, WriteFileStream),
	%%%%%%%%%%% close ballot %%%%%%%%%%%%%%%%%% 
	%handleMsg(ChairsList, ChairsNo, 0.4, MotionsList, MotionsNo, close_ballot, [], Step7, Step8, WriteFileStream),
    S8 is 0.4*Multiplier,
	handleMsg(ChairsList, ChairsNo, S8, MotionsList, MotionsNo, close_ballot, [], Step7, Step8, WriteFileStream),
	%%%%%%%%%%% declare result %%%%%%%%%%%%%%%%%% 
	%handleMsg(ChairsList, ChairsNo, 1.5, MotionsList, MotionsNo, declare, not_carried, Step8, Step9, WriteFileStream),
    S9 is 1.5*Multiplier,
	handleMsg(ChairsList, ChairsNo, S9, MotionsList, MotionsNo, declare, not_carried, Step8, Step9, WriteFileStream),
	%%%%%%%%%%% declare result %%%%%%%%%%%%%%%%%% 
	%handleMsg(ChairsList, ChairsNo, 1.3, MotionsList, MotionsNo, declare, carried, Step9, Step10, WriteFileStream).
    S10 is 1.3*Multiplier,
	handleMsg(ChairsList, ChairsNo, S10, MotionsList, MotionsNo, declare, carried, Step9, Step10, WriteFileStream).

% Agents from the SenderList send messages to agents from RecipientsList (time end is not inclusive)
% handleMsg(+SenderList, +SenderListLength, +SenderLimitPercentage, +RecipientList, +RecipientListLength, +MessageHeader, +MessageTopic,+MessageTimeStart, +MessageTimeEnd)
handleMsg(SenderList, SenderNo, SenderPercentage, RecipientList, RecipientNo, Header, Topic, TimeS, TimeE, WriteFileStream) :-
	TempPercent is SenderNo*SenderPercentage,		
	random_subset(SenderList, SenderNo, TempPercent, [], SenderSubset),
	assertMsg(SenderSubset, RecipientList, RecipientNo, Header, Topic, TimeS, TimeE, WriteFileStream).

% assert request_quote messages
% assertMsg(+SenderList, +RecipientList, +RecipientListLength, +MessageHeader, +MessageTopic,+MessageTime)
assertMsg([], _, _, _, _, _, _, _).
assertMsg([H|Tail], RecipientList, RecipientNo, MessageHeader, Topic, TimeS, TimeE, WriteFileStream) :-
	Temp is random(RecipientNo),
	nth0(Temp, RecipientList, RandomRecipient),
	flatten([MessageHeader, H, RandomRecipient, Topic], FlatMsg),
	Message =.. FlatMsg,
	TimeEM1 is TimeE-1,
	random_between(TimeS, TimeEM1, Time),
	formatWrite(WriteFileStream, Message, Time), !,
	assertMsg(Tail, RecipientList, RecipientNo, MessageHeader, Topic, TimeS, TimeE, WriteFileStream).

openFile(AgentNo, Seed, VotingDuration, OpenFileStream):-
    atom_number(AgentNoAtom, AgentNo),
    atom_number(SeedAtom, Seed),
    atom_number(VotingDurationAtom, VotingDuration),
	atom_concat('../csv/voting-', AgentNoAtom, FName1),
	atom_concat(FName1, '-', FName2),
	atom_concat(FName2, SeedAtom, FName3),
	atom_concat(FName3, '-', FName4),
	atom_concat(FName4, VotingDurationAtom, FName5),
	atom_concat(FName5, '-unsrt', FName6),
	atom_concat(FName6, '.csv', FName),
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

