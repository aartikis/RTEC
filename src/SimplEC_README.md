% -----------------------------------------------
% GENERAL INFO
% -----------------------------------------------
%

SimplEC is a simplified Event Calculus dialect. An event description in simplEC can be compiled into the RTEC format and subsequently used for narrative assimilation. SimplEC is being developed with view to making the writing of Composite Event patterns for Event Recognition purposes easier.

% -----------------------------------------------
% PREREQUISITES
% -----------------------------------------------
%

1) SWI-Prolog (preferably version 7.x)

2) GraphViz (http://www.graphviz.org/)

3) RTEC

4) Download simplEC.prolog, compile.sh

% -----------------------------------------------
% COMPILING
% -----------------------------------------------
%

To compile a set of simplEC rules into the compiled RTEC format, the user must execute the corresponding bash script, as follows:

	user@machine:your/working/directory$ bash compile.sh sample_rules.txt 16.0

SimplEC needs 2 arguments as input: The input rules in simplEC and the desired font size in the dependency graph. In the above example the SimplEC statements are in the "sample_rules.txt" file and the desired font size in the resulting dependency graph is 16.0. The procedure produces 6 files in the output:

1) RTEC-compatible action descriptions.

2) RTEC-compatible declarations.

3) Compiled action descriptions.

4) Dependency graph (png format).

5) Dependency graph (GraphViz source).

6) Log file reporting any compilation errors.

