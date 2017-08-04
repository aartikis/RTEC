% -----------------------------------------------
% GENERAL INFO
% -----------------------------------------------
%

This project is about SimplEC, a Simplified Event Calculus dialect.

SimplEC is being developed with view to making the writing of Composite Event patterns for Event Recognition purposes easier.

A set of event patterns in SimplEC can be compiled into the Run-Time Event Calculus (RTEC) format (see https://github.com/aartikis/RTEC) and be given as input to RTEC's Event Recognition mechanism.

% -----------------------------------------------
% PREREQUISITES
% -----------------------------------------------
%

1) Have SWI-Prolog installed (preferably version 7.x)

2) Download simplEC.prolog

% -----------------------------------------------
% COMPILING
% -----------------------------------------------
%

To compile a set of SimplEC rules (for example: sample_rules.txt) into the RTEC format, the user must start a new SWI-Prolog session in the command line, as follows:

	user@machine:your/working/directory$ swipl

Then, load the compiler source code and call the main routine, as follows:

	?- ['simplEC.prolog'].
	true.
	
	?- simplEC('sample_rules.txt','event_description.prolog','declarations.prolog', 'dependency_graph.txt').
    true.

The main routine simplEC needs 4 arguments as input:

1) The input rules in SimplEC

2) A name for the output Event Description file

3) A name for the output Declarations file

4) A name for the output dependency graph text file. This file will later be used as input to GraphViz (http://www.graphviz.org/) to visualize these dependencies.

If Prolog answers "true." in all commands, then everything went well and the rules have been successfully compiled into RTEC and GraphViz compatible formats.
4 files are produced as output:

1) RTEC-compatible action descriptions

2) RTEC-compatible declarations

3) Text file representing the dependencies between the various actions within the domain.

4) Log file reporting any compilation errors


