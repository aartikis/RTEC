/************************************************************************************************

****************************************DATA LOADER:*********************************************
% This file includes predicates for processing CSV files
% that do NOT exist in YAP, but exist in SWI Prolog
*************************************************************************************************
********************************
Written by: Manolis Pitsikalis
********************************

*************************************************************************************************/

:- use_module(library(csv)).
:- dynamic pipe_csv_opts/1.

:- initialization(init_pipe_csv_opts).

init_pipe_csv_opts :-
    csv_options(Opts,
                [ separator(0'|),    % '|' separator
                  convert(true)      % auto number conversion
                ]),
    asserta(pipe_csv_opts(Opts)).
                
                
get_row_from_line(Stream, Row) :-
    pipe_csv_opts(Opts),
    csv_read_row(Stream, Parsed, Opts),
    (   Parsed == end_of_file
    ->  Row = []
    ;   Row = Parsed
    ).


% Base case: if we're already at EOF, do nothing.
get_row_from_line(_Stream, [], end_of_file, end_of_file) :- !.

get_row_from_line(Stream, Row, StreamPosition, NewStreamPosition) :-
    % Reposition if we have a saved position
    (   
        StreamPosition \== [],
        StreamPosition \== end_of_file
    ->  set_stream_position(Stream, StreamPosition)
    ;   true
    ),
    pipe_csv_opts(Opts),
    csv_read_row(Stream, Row0, Opts),

    (   Row0 == end_of_file
    ->  Row = [],
        NewStreamPosition = end_of_file
    ;   Row = Row0,  % already row(...) with numbers where possible
        stream_property(Stream, position(NewStreamPosition))
    ).

