#!/bin/bash

input_csv=$1
stream_rate=$2

# First, fetch the first line of the input csv to get the time-point of the first event. 
first_line=`head -1 $input_csv`
arrLine=(${first_line//|/ })
prev_time=${arrLine[1]}

echo "Initial prev_time: $prev_time"

awk -v stream_rate="$stream_rate" -v prev_time="$prev_time" 'BEGIN{FS = "|"} 
        {if ($2>prev_time) {
            print "Prev_time: "; print prev_time;
            print "Stream_rate: "; print stream_rate; 
            sleep_time=($2 - prev_time)/stream_rate; gsub(",",".",sleep_time); 
            print "Sleep_time: "; print sleep_time; 
            system("date +%s");
            system("sleep " sleep_time);
            system("date +%s");
            print "Slept";
            print $0} else {print $0} }
        {prev_time=$2}
        ' $input_csv

