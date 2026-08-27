cat log-swi-3600-3600-csv-file-recognised-intervals.txt |grep "stopped2\|high2" |sed '/\[\]/d'| sed 's/)\],.*)\./)])./g' |sed 's/plus(\([0-9]\+\)/\1/g' >gt.csv 
