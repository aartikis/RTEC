% -----------------------------------------------
% GENERAL INFO
% -----------------------------------------------
%

simplEC is a simplified Event Calculus dialect. An event description in simplEC can be compiled into the RTEC format and subsequently used for narrative assimilation.

% -----------------------------------------------
% COMPILING
% -----------------------------------------------
%

To compile a set of simplEC rules into the compiled RTEC format, the user must execute the corresponding bash script, as follows:

	user@machine:your/working/directory$ bash compile.sh sample_rules.txt

SimplEC needs 1 argument as input: The input rules in simplEC. The procedure produces 5 output files:

1) RTEC-compatible action descriptions.

2) RTEC-compatible declarations.

3) Text file representing the dependencies between the various actions within the domain.

4) Compiled version of the action descriptions.

5) Log file reporting any compilation errors.
