% -----------------------------------------------
% GENERAL INFO
% -----------------------------------------------
%

simplEC is a simplified Event Calculus dialect. An event description in simplEC can be compiled into the RTEC format and subsequently used for narrative assimilation.

% -----------------------------------------------
% COMPILING
% -----------------------------------------------
%

To compile a set of simplEC rules into the RTEC format, the user must start a new SWI Prolog session in the command line, as follows:

	user@machine:your/working/directory$ swipl

Then, load and run the compiler as follows:

	?- ['simplEC.prolog'].
	true.
	
	?- simplEC('sample_rules.txt','event_description.prolog','declarations.prolog', 'dependency_graph.txt').
    true.

simplEC needs 4 arguments as input:

1) The input rules in simplEC.

2) A name for the output Event Description file.

3) A name for the output Declarations file.

4) A name for the output dependency graph text file. This file will later be used as input to GraphViz (http://www.graphviz.org/) to visualize these dependencies.

If Prolog answers "true." in the two commands above, then everything went well and the rules have been successfully compiled into RTEC and GraphViz compatible formats. 4 files are produced as output:

1) RTEC-compatible action descriptions.

2) RTEC-compatible declarations.

3) Text file representing the dependencies between the various actions within the domain.

4) Log file reporting any compilation errors.
