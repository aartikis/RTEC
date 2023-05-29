#!/bin/bash


function get_all_defaults (){
	# input: a supported application
	# effects: the parameters of RTEC that were not provided by the user have been assigned their default values 
	application=$1
	[ -z $window_size ] && window_size=`get_default_param $application window_size`
	[ -z $step ] && step=`get_default_param $application step`
	[ -z $start_time ] && start_time=`get_default_param $application start_time`
	[ -z $end_time ] && end_time=`get_default_param $application end_time`
	[ -z $clock_tick ] && clock_tick=`get_default_param $application clock_tick`
	[ -z $results_directory ] && results_directory=`get_default_param $application results_directory`
	[ -z $goals ] && goals=`get_default_param $application goals`
	[ -z $event_description ] && event_description=`get_default_param $application event_description`
	[ -z $background_knowledge ] && background_knowledge=(`get_default_param $application background_knowledge`)
	[ -z $input_mode ] && input_mode=`get_default_param $application input_mode`
	[ -z $stream_rate ] && stream_rate=`get_default_param $application stream_rate`
	[ -z $input ] && input_providers=(`get_default_param $application input_providers`)
	#[ "$input_mode" == "csv" ] && [ -z $input ] && input_providers=`get_default_param $application input_providers.csv`
	#[ "$input_mode" == "fifo" ] && [ -z $input ] && input_providers=`get_default_param $application input_providers.fifo`
	[ -z $dependency_graph ] &&  [ `get_default_param $application dependency_graph_flag` == "true" ] && dependency_graph="true" 
	[ -z $dependency_graph_directory ] && dependency_graph_directory=`get_default_param $application dependency_graph_directory`
	[ -z $include_input ] &&  [ `get_default_param $application include_input` == "true" ] && include_input="true" 
}

function input_parser (){
	# input: the list of arguments of the run_rtec.sh script
	# effects: the values of the parameters of RTEC that were provided by the user have been updated
	input=()
	goal=()
	background_knowledge=()
	
	# Loop over input parameters.
	for arg in $@ ; do
	  case "$arg" in
	    --help)
		  help
		  ;;
		--interactive)
		  interactive_mode="true"
		  ;;
	    --app=*)
		  application="${arg#*=}" # "#*=" fetches all characters from the last occurrence of "=" until the end of the string
		  ;;
		# the following parameters are compiler flags.
		--dependency-graph)
		  dependency_graph="true"
		  ;;
		--dependency-graph-directory=*)
		  dependency_graph_directory="${arg#*=}"
		  ;;
		--include-input)
		  include_input="true"
		  ;;
		# the following parameters concern the execution of RTEC 
		--input-mode=*)
		  input_mode="${arg#*=}"
		  ;;
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
	    --clock-tick=*)
	      clock_tick="${arg#*=}"
	      ;;
		--event-description=*)
		  event_description="${arg#=}"
		  ;;
	    --results-directory=*)
	      results_directory="'${arg#*=}'"
	      ;;
		# the following flags are RTEC parameters that may be used multiple times in one execution. 
		# e.g. ./run_rtec.sh --app=caviar --input=path/to/first/event/stream --input=path/to/second/event/stream
		# runs RTEC on the CAVIAR application with two input providers.
	    --goal=*)
	      goal+=("'${arg#*=}'")
	      ;;
	    --background-knowledge=*)
	      background_knowledge+=("'${arg#*=}'")
	      ;;
		--input=*)
		  input_providers+=("'${arg#*=}'")
		  ;;
	  esac
	done
}

function set_prolog_command() {
	# This function is called after compilation. So, the compiled event description is available in the following file:
	compiled_event_description=${event_description%/*}/compiled_rules.prolog # "%/*" fetches all characters of string until the last occurrence of "/"
	background_knowledge+=("${compiled_event_description}")
	# Construct an RTEC query corresponding to the provided parameters
	printf -v event_description_files "'%s'," "${background_knowledge[@]}"
	second_argument="[event_description_files=[${event_description_files%,}]"
	[ -z $window_size ] || second_argument+=",window_size=$window_size" 
	[ -z $step ] || second_argument+=",step=$step" 
	[ -z $start_time ] || second_argument+=",start_time=$start_time" 
	[ -z $end_time ] || second_argument+=",end_time=$end_time" 
	[ -z $input_mode ] || second_argument+=",input_mode=$input_mode" 
	[ -z $stream_rate ] || second_argument+=",stream_rate=$stream_rate" 
	[ -z $clock_tick ] || second_argument+=",clock_tick=$clock_tick" 
	[ -z $results_directory ] || second_argument+=",results_directory='$results_directory'" 
	# event_description and input_providers are are comma-separated strings. 
	[ ${#input_providers[@]} -gt 0 ] && printf -v input_providers "'%s'," "${input_providers[@]}" &&  second_argument+=",input_providers=[${input_providers%,}]"
	[ ${#goal[@]} -gt 0 ] &&  printf -v goal '%s,' "${goal[@]}" 
	[ ${#goal[@]} -gt 0 ] &&  second_argument+=",goal=[${goal%,}]"
	second_argument+="]"
	[ -z $interactive_mode ] && prolog_command="swipl -l continuousQueries.prolog -g continuousQueries(${application},${second_argument}),halt." || prolog_command="swipl -l continuousQueries.prolog -g continuousQueries(${application},${second_argument})."
}

function exit_func () {
	# invoked on early exit because of incorrect input.
    # input: a flag indicating a problem with the provided input.	
	case $1 in
		noApp)
			printf "No application provided.\n\n" && help_rtec_script && exit 1
		;;
		wrongApp)
			printf "Provided application: '$2' is not the name of a dictionary in 'defaults.toml'.\n\n" && help_rtec_script && exit 1
		;;
		wrongInputMode)
			printf "Provided input mode: '$2' is not supported. Please select 'csv' or 'fifo'.\n\n" && help_rtec_script && exit 1
		;;
		noEventDescriptionCompiler)
			printf "No event description provided to the compiler of RTEC" && help_rtec_script && exit 1
		;;
		noDependencyGraphDirectoryCompiler)
			printf "The dependency graph flag is set but no directory for the dependency graph has been provided.\n\n" && help_rtec_script && exit 1
		;;
		*)
			help_rtec_script && exit 1
		;;	
	esac
}

function help_rtec_script {
	# help message
	printf "General usage instructions:\n"
	printf "This script instructs RTEC to reason over the provided event description.\n"
	printf "\tThe <app> parameter is mandatory and has to be the name of an application under '/examples'.\n"
    printf "\t\tApplications packed with RTEC: toy, caviar, ctm, maritime, voting, netbill.\n"
    printf "\t\tExamples: './run_rtec.sh --app=toy' and './run_rtec.sh --app=maritime'.\n\n"
    printf "Moreover, this script supports the following options: \n"
    printf "\t'--dependency-graph': the compiler of RTEC stores the dependency graph of the application in '/examples/<app>/resources/graphs'.\n"
    printf "\t'--no-events': the constructed dependency graph does not include input entities.\n"
    printf "\t\tMore examples: './compile.sh --app=toy --dependency-graph' and './compile.sh --app=maritime --dependency-graph --no-events'.\n"
    printf "Lastly, parameter '--help' prints this message.\n"
}

function delete_fifos { 
# Delete all named pipes created by the stream providers. 
# Should be used after the execution of RTEC has finished or when it is killed.
	for fifo in ${fifos[@]}; do rm $fifo; done
}

function cleanup {
# Kill all stream providers and then delete their corresponding pipes.
# Should be used if RTEC is killed before terminating.
	for id in ${ids[@]}; do kill $id; done
	delete_fifos
}

function stream_provider (){
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
	awk -v stream_rate="$stream_rate" -v prev_time="$prev_time" '
		BEGIN{FS = "|"} 
		{if ($2>prev_time) {sleep_time=($2 - prev_time)/stream_rate; gsub(",",".",sleep_time); system("sleep " sleep_time); print $0} else {print $0} }
	   	{prev_time=$2}
		' $input_csv
}

function start_fifos() {
	fifos=()
	#ids=()
	# Create one live stream provider for each input csv file
	for i in "${!input_providers[@]}"; do
		fifo_name=fifo"$( expr $i + 1 )"
		# Run stream providers in the background
		stream_provider ${input_providers["$i"]} $fifo_name ${stream_rate:-} & 
		fifos+=("$fifo_name")
		#ids+=($!)
	done
	trap cleanup INT # After this point, in case of SIGINT, kill stream providers and delete named pipes.
	input_providers=("${fifos[@]}")
}

function get_default_param (){
	# inputs: an application supported by RTEC and an execution parameter
	# output: the default value of the parameter, as specified in defaults.toml
	application=$1
	parameter=$2
	awk -v app="$application" -v param="$parameter" '
	BEGIN {curr_app=0; pat="^"param} 
	{if($0 ~ /'^\\['/){gsub("\\[","");gsub("\\]","");curr_app=$0;}} 
	{if($0 ~ pat && curr_app==app){print $0;}}
	' defaults.toml | awk -F'=|#' '{gsub(/[ \t\\"]/, "", $2); gsub(",", " ", $2); print $2}' | tr -d '[]\047'
}

function find_app_in_toml (){
	app=$1
	awk -v app="$app" '
	{if($0 ~ /'^\\['/){gsub("\\[","");gsub("\\]",""); if(app==$0){ code_reversed=1; }}}
    END{ exit !code_reversed }
	' defaults.toml
}

