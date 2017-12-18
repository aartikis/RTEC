#!/bin/bash

if [ $# != 1 ];
then
	printf "Please provide 1 argument with the name of the input SimplEC file.\n\n"
	exit 100
fi

simplec=$1

swipl -l simplEC.prolog -g "simplEC('$1', 'event_description.prolog', 'declarations.prolog', 'dependency_graph.txt', false)" -g "halt"
swipl -l RTEC.prolog -g "compileEventDescription('declarations.prolog', 'event_description.prolog', 'tmp.pl')" -g "halt"
printf ":- ['RTEC.prolog'].\n:- ['declarations.prolog'].\n\n" > event_description_compiled.prolog
cat tmp.pl >> event_description_compiled.prolog
rm -f tmp.pl

exit 0

