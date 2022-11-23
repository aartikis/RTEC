#!/bin/bash

# Author: Periklis Mantenoglou
# Script for simulating live event streams and performing real-time reasoning on these stream with RTEC.

# Mandatory input parameters: 
	application=$1 # One of the supported applications. Possible values: toy, caviar, maritime, voting, netbill, ctm
	# At least one input csv file 

# The first parameter of the script is the name of the application.
# Afterwards, all nameless parameters are csv files including input events in the format specified in '../src/data\ loader/dataLoader.prolog'
# Named parameters are optional. The following optional parameters are currently supported:
#	--window-size, --step, --start-time, --end-time, --stream-rate
# WARNING: the named parameters should be provided as: --parameter-name=value, and not in the common way: --parameter-name value. See the examples below.

# Example executions (the values of unspecified parameters default to the values declared in 'handleApplication.prolog'): 
# 	"toy" use case, end_time=40, stream_rate=2:
# 		./live_stream_reasoning.sh toy ../examples/toy/dataset/csv/toy_data.csv --end-time=40 --stream-rate=2
# 	"netbill" use case, window_size=20, step=20:
# 		./live_stream_reasoning.sh netbill ../examples/netbill/dataset/csv/netbill.csv --window-size=20 --step=20
# 	"caviar" use case, window_size=200, step=200, two input csv files:  
# 		./live_stream_reasoning.sh caviar ../examples/caviar/dataset/csv/appearance.csv ../examples/caviar/dataset/csv/movementB.csv --window-size=200 --step=200

input_csv_files=()
event_description_files=()
# Loop over the all input parameters, except the first one.
# Nameless parameters are added to the input_csv_files array.
# Named parameters are assigned to their corresponding variable.
for arg in ${@:2} ; do
  case "$arg" in
    --window-size=*)
      window_size="${arg#*=}"
      ;;
    --step=*)
      step="${arg#*=}"
      ;;
    --start-time=*)
      start_time="${arg#*=}"
      ;;
    --end-time=*)
      end_time="${arg#*=}"
      ;;
    --stream-rate=*)
      stream_rate="${arg#*=}"
      ;;
    --results-directory=*)
      results_directory="'${arg#*=}'"
      ;;
    --stream-provider-script=*)
      stream_provider_script="${arg#*=}"
      ;;
    --prolog-script=*)
      prolog_script="${arg#*=}"
      ;;
    --event-description-files=*)
      event_description+=("'${arg#*=}'")
      ;;
	*)
	  input_csv_files+=($arg)
	  ;;
  esac
done

[ -z $stream_provider_script ] && stream_provider_script="./stream_provider.sh" 
[ -z $prolog_script ] && prolog_script="continuousQueries.prolog" 

echo $input_csv_files
fifos=()
ids=()
# Create one live stream provider for each input csv file
for i in "${!input_csv_files[@]}"; do
	fifo_name=fifo"$( expr $i + 1 )"
	# Run stream providers in the background
	$stream_provider_script ${input_csv_files["$i"]} $fifo_name ${stream_rate:-} & 
	fifos+=("$fifo_name")
	ids+=($!)
done

# Delete all named pipes created by the stream providers. 
# Should be used after the execution of RTEC has finished or when it is killed.
function delete_fifos { 
	for fifo in ${fifos[@]}; do rm $fifo; done
}

# Kill all stream providers and then delete their corresponding pipes.
# Should be used if RTEC is killed before terminating.
function cleanup {
	for id in ${ids[@]}; do kill $id; done
	delete_fifos
}

trap cleanup INT # After this point, in case of SIGINT, kill stream providers and delete named pipes.

# Each stream provider has created a named pipe for the corresponding csv file and will write events into the pipe in real-time.
# The temporal distance between events is interpreted as a number of seconds.

# Construct an RTEC query corresponding to the provided parameters
printf -v providers '%s,' "${fifos[@]}" # providers is comma-separated string containing the names of the fifos.

second_argument="[input_mode=fifo,input_providers=[${providers%,}]"
[ -z $window_size ] || second_argument+=",window_size=$window_size" 
[ -z $step ] || second_argument+=",step=$step" 
[ -z $start_time ] || second_argument+=",start_time=$start_time" 
[ -z $end_time ] || second_argument+=",end_time=$end_time" 
[ -z $stream_rate ] || second_argument+=",stream_rate=$stream_rate" 
[ -z $results_directory ] || second_argument+=",results_directory=$results_directory" 
[ ${#event_description[@]} -gt 0 ] &&  printf -v event_description '%s,' "${event_description[@]}"  
[ ${#event_description[@]} -gt 0 ] &&  second_argument+=",event_description_files=[${event_description%,}]"
second_argument+="]"

prolog_query="continuousQueries(${application}, ${second_argument}), halt." 

# Run RTEC for prolog_query
# The input mode has been set to 'fifo', i.e., RTEC reads from the named pipes of the stream providers and not from the input csv files 
swipl -l $prolog_script -g "$prolog_query" && delete_fifos # delete named pipes after RTEC terminates.
