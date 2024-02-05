#!/bin/bash
LOAD="./src/compare.prolog"
COMPILERPATH="../../src/compiler.prolog"

for testi in $(ls tests); do
    for testii in $(ls ./tests/$testi); do
        echo "--------------------------------------------------------------------"
        echo "--------------------------------------------------------------------"
        echo "Checking folder : $testi/$testii"
        PREFIX="./tests/$testi/$testii"
        EVENTDESCR="$PREFIX/rules.prolog" # pre-compiled event description
        RULESC="$PREFIX/compiled_rules.prolog" # derived compiled event description
        RULEST="$PREFIX/compiled_rules_ground.prolog" # ground compiled event description
        echo "----Compiling rules..."
        swipl -q -l $COMPILERPATH -g "compileED('$EVENTDESCR'),halt"
        #echo -e ":-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, fi/3, p/1.\n$(cat $RULESC)" > $RULESC
        echo "----Comparing rules..."
        swipl -q -l $LOAD -g "compiler:consult('$RULESC'),manual:consult('$RULEST'),compare_clauses,halt"
        echo "----Finished."
        echo "--------------------------------------------------------------------"
        echo "--------------------------------------------------------------------"
    done
done
