#!/bin/bash

# Author: Periklis Mantenoglou
# Script for simulating a live stream.

# Operations: reads a csv file line by line, each containing an input event, and write the line into a named pipe.
# Line format of the input csv file is specified in ../src/data\ loader/dataLoader.prolog.
# The timestamp of each event is absolute and measured in seconds. 
# If the timestamp of the current event is greater than the timestamp of the previous event,
# the script sleeps for "time(current)-time(prev)" seconds before writing the current event into the pipe.

#application=$1 # One of the supported applications. Possible values: toy, caviar, maritime, voting, netbill, ctm
input_csv=$1 # path/to/event/stream/csv
fifo=$2 # path/to/named/pipe

# stream_rate: The number of times the input stream is sped up. 
# For example, if stream_rate = 2, the input events are written into the pipe twice as fast.
[ $# -ge 3 ] && stream_rate=$3 || stream_rate=1 # if not provided, stream_rate = 1, by default.

# Create fifo, if it does not exist.
if [ ! -p "$fifo" ]; then
	mkfifo -m 0666 "$fifo" 
fi

# Set the given pipe
exec > "$fifo" #At this point, the script waits for a fifo reader. 

# First, fetch the first line of the input csv to get the time-point of the first event. 
first_line=`head -1 $input_csv`
arrLine=(${first_line//|/ })
prev_time=${arrLine[1]}

# Then, read the csv file line by line and write to a named pipe with awk, invoking the GNU sleep command when a time-stamp greater than the current one is detected.
# awk splits each line by the delimiter "|" and checks whether its timestamp ($2) is greater than the timestamp of the previous event (which is prev_time). 
# If so, the program waits for a time period equal to the temporal distance between these events in seconds. 
# Then, the input event is written into the pipe. 
# If the timestamps of consecutive events are equal, the next input event is written into the pipe immediately. 
awk -v stream_rate="$stream_rate" -v prev_time="$prev_time" 'BEGIN{FS = "|"} {if ($2>prev_time) {sleep_time=($2 - prev_time)/stream_rate; gsub(",",".",sleep_time); system("sleep " sleep_time); print $0} else {print $0} } {prev_time=$2}' $input_csv

