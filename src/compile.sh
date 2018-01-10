#!/bin/bash

if [ $# != 2 ];
then
	printf "Please provide 2 arguments. Sample:\n\tbash compile.sh sample_rules.txt 16.0.\nShould you need more information, please refer to the README file.\n\n"
	exit 100
fi

simplec=$1

printf "Producing event description, declarations and dependency graph source... "
swipl -l simplEC.prolog -g "simplEC('$1', 'event_description.prolog', 'declarations.prolog', 'dependency_graph.txt', $2, false)" -g "halt"

printf "Done.\nExporting dependency graph image... "
dot -o dependency_graph.png -T png dependency_graph.txt

printf "Done.\nProducing compiled event description... "
swipl -l RTEC.prolog -g "trace" -g "compileEventDescription('declarations.prolog', 'event_description.prolog', 'tmp.pl')" -g "halt"
printf ":- ['RTEC.prolog'].\n:- ['declarations.prolog'].\n\n" > event_description_compiled.prolog
cat tmp.pl >> event_description_compiled.prolog

printf "Done.\nCleaning up temporary files... "
rm -f tmp.pl

printf "Ready."
exit 0

