/************************************************************************************************

****************************************DATA LOADER:*********************************************
% This file includes predicates for processing CSV files
% that do NOT exist in YAP, but exist in SWI Prolog
*************************************************************************************************
********************************
Written by: Elias Alevizos
********************************

*************************************************************************************************/

:- use_module(library(readutil)).
:- use_module(library(lists)).

get_row_from_line(Stream,Row) :-
	read_line_to_codes(Stream,Codes),
	(
	Codes = end_of_file,
	Row = [],
	!
	;
	partition_by_delim(Codes,124,[[]],PartitionedCodes),
	atom_partitions(PartitionedCodes,Atoms),
	Row =.. [row|Atoms]
	).

get_row_from_line(_Stream,[],end_of_file,end_of_file).
	
get_row_from_line(Stream,Row,StreamPosition,NewStreamPosition) :-
	(
	StreamPosition \= [],
	% In YAP 7.3, the stream flag "reposition" must be set to true before running the following predicate.
	set_stream_position(Stream,StreamPosition),
	!
	;
	StreamPosition = []
	),
	read_line_to_codes(Stream,Codes),
	(
	Codes = end_of_file,
	Row = [],
	NewStreamPosition = end_of_file,
	!
	;
	% 124 should be the code of the '|' delimeter
	partition_by_delim(Codes,124,[[]],PartitionedCodes),
	atom_partitions(PartitionedCodes,Atoms),
	%Event =.. Atoms,
	Row =.. [row|Atoms],
	stream_property(Stream,position(NewStreamPosition))
	).

% from a list of codes' partitions (e.g. [[116, 114, 110],[50, 49]], 
% see partition_by_delim predicate), create a list of atoms 
% (e.g. [[116, 114, 110],[50, 49]] --> [trx,21])
atom_partitions([Partition|[]],[Atom|[]]) :-
	atom_codes(Atom1,Partition),
	(
	check_if_number(Partition),
	attempt_to_number(Atom1,Atom),
	!
	;
	Atom=Atom1
	),
	!.
	
atom_partitions([Partition|MorePartitions],[Atom|MoreAtoms]) :-
	atom_codes(Atom1,Partition),
	(
	check_if_number(Partition),
	attempt_to_number(Atom1,Atom),
	!
	;
	Atom=Atom1
	),
	atom_partitions(MorePartitions,MoreAtoms).
	
check_if_number([]) :- fail.

check_if_number([Code|[]]) :-
	(
	(Code = 45 ; Code = 46),
	!
	;
	Code >= 48,
	Code =< 57
	).
	
check_if_number([Code|MoreCodes]) :-
	(
	(Code = 45 ; Code = 46),
	!
	;
	Code >= 48,
	Code =< 57
	),
	check_if_number(MoreCodes).
	
		
	
attempt_to_number(AtomField,Field) :-
	(
	atom_number(AtomField,Field),
	!
	;
	AtomField='',
	Field=[],
	!
	;
	Field = AtomField
	).


% for a list of codes(e.g. [116 114 110 124 50 49]), get partitions
% delimited by Delimiter (e.g. 124) and create a list of those partitions
% (e.g. [[116, 114, 110],[50, 49]])
partition_by_delim([], _Delimiter, CurrentPartitions, Partitions) :-
	reverse(CurrentPartitions, Partitions), !.

partition_by_delim([Delimiter|[]], Delimiter, CurrentPartitions, Partitions) :-
	reverse(CurrentPartitions, Partitions), !.
	
partition_by_delim([Delimiter|MoreCodes], Delimiter, CurrentPartitions, PartitionedCodes) :-
	MoreCodes = [Code|OtherCodes],
	AppendedPartitions = [[Code]|CurrentPartitions], !,
	partition_by_delim(OtherCodes, Delimiter, AppendedPartitions, PartitionedCodes).
	
partition_by_delim([Code|MoreCodes], Delimiter, [CurrentPartition|MorePartitions], PartitionedCodes) :-
	Code \= Delimiter,
	append(CurrentPartition, [Code], AppendedPartition),
	partition_by_delim(MoreCodes, Delimiter, [AppendedPartition|MorePartitions], PartitionedCodes).
	
