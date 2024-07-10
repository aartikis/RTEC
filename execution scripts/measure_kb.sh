#!/bin/bash
FILE=$1 # output log file
if [ $# -eq 0 ]
then 
    echo "No output log file supplied in \$1"
    exit 1
fi

rm -f ${FILE}


swipl -l measure_kb.prolog -g "count_rules(caviar,rules_sf)." -g "halt." >> ${FILE}
swipl -l measure_kb.prolog -g "count_rules(caviar,rules_opt)." -g "halt." >> ${FILE}
swipl -l measure_kb.prolog -g "count_rules(maritime,rules_sf)." -g "halt." >> ${FILE}
swipl -l measure_kb.prolog -g "count_rules(maritime,rules_opt)." -g "halt." >> ${FILE}
