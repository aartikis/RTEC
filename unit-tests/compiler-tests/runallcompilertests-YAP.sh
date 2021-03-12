#!/bin/bash
LOAD="./src/compare.prolog"
RTECPATH="../../src/RTEC.prolog"

for testi in $(ls tests); do
    for testii in $(ls ./tests/$testi); do
        echo "--------------------------------------------------------------------"
        echo "--------------------------------------------------------------------"
        echo "Checking folder : $testi/$testii"
        PREFIX="./tests/$testi/$testii"
        DECL="$PREFIX/declarations.prolog"
        RULESC="$PREFIX/rules_compiled_c.prolog"
        RULEST="$PREFIX/rules_compiled_t.prolog"
        EVENTDESCR="$PREFIX/rules.prolog"
        DECLARATIONS="$PREFIX/declarations.prolog"
        EVENT="$PREFIX/event_description.prolog"
        RESNORMPATH="$PREFIX/$RESNORMAL"
        RESMANUPATH="$PREFIX/$RESMANUAL"
        RESCOMPPATH="$PREFIX/$COMPRESFILE"
        echo "----Compiling rules..."
        yap -quiet -l $RTECPATH -g "compileEventDescription('$DECLARATIONS','$EVENTDESCR','$RULESC'),halt"
        echo -e ":-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.\n$(cat $RULESC)" > $RULESC
        echo "----Comparing rules..."
        yap -quiet -l $LOAD -g "compiler:consult('$RULESC'),manual:consult('$RULEST'),compare_clauses,halt"
        echo "----Finished."
        echo "--------------------------------------------------------------------"
        echo "--------------------------------------------------------------------"
    done
done
