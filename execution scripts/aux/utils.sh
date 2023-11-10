#!/bin/bash
function get_all_defaults (){
	# Input: An application name
	# Effects: For each parameter, if a value was not provided by the user, we assign to it its default value.
	application=$1
        # Execution Parameters
	[ -z $window_size ] && window_size=`get_default_param $application window_size`
	[ -z $step ] && step=`get_default_param $application step`
	[ -z $start_time ] && start_time=`get_default_param $application start_time`
	[ -z $end_time ] && end_time=`get_default_param $application end_time`
	[ -z $clock_tick ] && clock_tick=`get_default_param $application clock_tick`
        # Input Specification Parameters
	[ -z $input_mode ] && input_mode=`get_default_param $application input_mode`
	[ -z $input_providers ] && input_providers=(`get_default_param $application input_providers`)
	[ -z $stream_rate ] && stream_rate=`get_default_param $application stream_rate`
        # Knowledge Base
	[ -z $event_description ] && event_description=`get_default_param $application event_description`
	[ -z $background_knowledge ] && background_knowledge=(`get_default_param $application background_knowledge`)
        # Output Specification Parameters
	[ -z $output_mode ] && output_mode=`get_default_param $application output_mode`
	[ -z $results_directory ] && results_directory=`get_default_param $application results_directory`
        # Compiler Parameters
	[ -z $dependency_graph ] &&  [ `get_default_param $application dependency_graph_flag` == "true" ] && dependency_graph="true" 
	[ -z $dependency_graph_directory ] && dependency_graph_directory=`get_default_param $application dependency_graph_directory`
	[ -z $include_input ] &&  [ `get_default_param $application include_input` == "true" ] && include_input="true" 
}

function input_parser (){
	# Input: the list of arguments of the run_rtec.sh script
	# Effects: the values of the parameters of RTEC that were provided by the user have been updated
	input=()
	goal=()
	background_knowledge=()
	
	# Loop over input parameters.
        # The flags "--input" and "--background-knowledge" are RTEC parameters that may be used multiple times in one execution. 
        # This is because we may have a multiple input providers (e.g., csv files) and multiple files containing background knowledge.
        # e.g., ./run_rtec.sh --app=caviar --input=path/to/first/event/stream --input=path/to/second/event/stream
        # runs RTEC on the human activity recognition application (caviar dataset) with two input providers.
	for arg in $@ ; do
	  case "$arg" in
            # Application Name
	    --app=*)
              application="${arg#*=}" # "#*=" fetches all characters from the last occurrence of "=" until the end of the string
              ;;
            # Execution parameters
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
	    --clock-tick=*)
	      clock_tick="${arg#*=}"
	      ;;
            # Input Specification Parameters
            --input-mode=*)
              input_mode="${arg#*=}"
              ;;
            --input=*)
              input_providers+=("${arg#*=}")
              ;;
	    --stream-rate=*)
	      stream_rate="${arg#*=}"
	      ;;
            # Knowledge Base
            --event-description=*)
              event_description="${arg#*=}"
              ;;
	    --background-knowledge=*)
	      background_knowledge+=("${arg#*=}")
	      ;;
            # Output Specification Parameters
            --output-mode=*)
              output_mode="${arg#*=}"
              ;;
	    --results-directory=*)
	      results_directory="${arg#*=}"
	      ;;
            # Compiler Parameters
            --dependency-graph)
              dependency_graph="true"
              ;;
            --dependency-graph-directory=*)
              dependency_graph_directory="${arg#*=}"
              ;;
            --include-input)
              include_input="true"
              ;;
            # Utilities
	    --help)
	        help
	        ;;
	    --interactive)
	        interactive_mode="true"
                ;;
	  esac
	done
}


function set_prolog_command() {
        # Effects: <prolog_command> contains the execution command for running RTEC in SWI Prolog for the chosen application and execution parameters.
        # Knowledge Base
	# This function is called after compilation. So, the compiled event description is available in the following file:
	compiled_event_description=${event_description%/*}/compiled_rules.prolog # "%/*" fetches all characters of string until the last occurrence of "/"
	background_knowledge+=("${compiled_event_description}")
	# Construct an RTEC query corresponding to the provided parameters
	printf -v event_description_files "'%s'," "${background_knowledge[@]}"
	second_argument="[event_description_files=[${event_description_files%,}]"
        # Execution Parameters
	[ -z $window_size ] || second_argument+=",window_size=$window_size" 
	[ -z $step ] || second_argument+=",step=$step" 
	[ -z $start_time ] || second_argument+=",start_time=$start_time" 
	[ -z $end_time ] || second_argument+=",end_time=$end_time" 
	[ -z $clock_tick ] || second_argument+=",clock_tick=$clock_tick" 
        # Input Specification Parameters
	[ -z $input_mode ] || second_argument+=",input_mode=$input_mode" 
	[ ${#input_providers[@]} -gt 0 ] && printf -v input_providers "'%s'," "${input_providers[@]}" &&  second_argument+=",input_providers=[${input_providers%,}]"
	[ -z $stream_rate ] || second_argument+=",stream_rate=$stream_rate" 
        # Output Specification Parameters
	[ -z $output_mode ] || second_argument+=",output_mode=$output_mode" 
	[ -z $results_directory ] || second_argument+=",results_directory='$results_directory'" 
	second_argument+="]"
        # In interactive mode, we do not halt after execution, in order to allow the user to pose queries to the system.
	[ -z $interactive_mode ] && prolog_command="swipl -l continuousQueries.prolog -g continuousQueries(${application},${second_argument}),halt." || prolog_command="swipl -l continuousQueries.prolog -g continuousQueries(${application},${second_argument})."
}

function error_message() {
    printf "Error!\n"
}

function help_rtec_script {
    printf "For instructions on how to run RTEC, you may consult:\n" 
    printf "\t1. The user manual of RTEC: https://github.com/aartikis/RTEC/blob/allen/RTEC_manual.pdf\n"
    printf "\t2. The online documentation: https://github.com/aartikis/RTEC/blob/allen/docs/contents.md\n"
}

function exit_func () {
    # invoked on early exit because of incorrect input.
    # input: a flag indicating a problem with the provided input.	
    error_message
    case $1 in
        noApp)
            printf "No application provided (the --app flag is mandatory).\n" && 
            printf "When using \"--app=<App>\", there must be a dictionary for application <App> in \"defaults.toml\".\n" 
        ;;
        wrongApp)
            printf "Application $2 is not specified."
            printf "When using \"--app=<App>\", there must be a dictionary for application <App> in \"defaults.toml\".\n" 
        ;;
        wrongInputMode)
            printf "Provided input mode: '$2' is not supported. Please select \"csv\", \"fifo\" or \"socket\".\n\n" 
        ;;
        noEventDescriptionCompiler)
            printf "No event description provided to the compiler of RTEC" && help_rtec_script && exit 1
        ;;
        noDependencyGraphDirectoryCompiler)
            printf "The dependency graph flag is set but no directory for the dependency graph has been provided.\n\n" && help_rtec_script && exit 1
        ;;
    esac
    help_rtec_script
    exit 1
}


function delete_fifos { 
# Delete all named pipes created by the stream providers. 
# Should be used after the execution of RTEC has finished or when it is killed.
	for fifo in ${fifos[@]}; do rm $fifo; done
}

function cleanup_fifos {
# Kill all stream providers and then delete their corresponding pipes.
# Should be used if RTEC is killed before terminating.
	for id in ${ids[@]}; do kill $id; done
	delete_fifos
}

function cleanup_socket {
# Delete the socket created by RTEC.
# Should be used if RTEC is killed before terminating.
        quote_removed=${input_providers#\'}
        rm ${quote_removed%\',}
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

function socket_writer (){
    input_csv=$1 # path/to/event/stream/csv
    socket=$2 # path/to/socket
    # stream_rate: The number of times the input stream is sped up. 
    # For example, if stream_rate = 2, the input events are written into the pipe twice as fast.
    [ $# -ge 3 ] && stream_rate=$3 || stream_rate=1 # if not provided, stream_rate = 1, by default.

    echo "Writing to socket $socket the contents of the csv file $input_csv"

    # First, fetch the first line of the input csv to get the time-point of the first event. 
    first_line=`head -1 $input_csv`
    arrLine=(${first_line//|/ })
    prev_time=${arrLine[1]}
    
    # Loop until a socket appear in path <socket>
    until [ -S $socket ]
    do 
        :
    done

    # Then, read the csv file line by line and write to the socket with awk, invoking the GNU sleep command when a time-stamp greater than the current one is detected.
    # awk splits each line by the delimiter "|" and checks whether its timestamp ($2) is greater than the timestamp of the previous event (which is prev_time). 
    # If so, the program waits for a time period equal to the temporal distance between these events in seconds. 
    # Then, the input event is written into the socket. 
    # If the timestamps of consecutive events are equal, the next input event is written into the socket immediately. 
    awk -v stream_rate="$stream_rate" -v prev_time="$prev_time" '
            BEGIN{FS = "|"} 
            {if ($2>prev_time) {sleep_time=($2 - prev_time)/stream_rate; gsub(",",".",sleep_time); system("sleep " sleep_time); print $0} else {print $0} }
            {prev_time=$2}
            ' $input_csv | nc -U $socket | exit
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
	trap cleanup_fifos INT # After this point, in case of SIGINT, kill stream providers and delete named pipes.
	input_providers=("${fifos[@]}")
}

# When the input_mode is "socket" and the input_providers are csv files,
# the socket client read from the csv files and write the events into the socket,
# while the input_provider of RTEC should be that socket.
function fix_rtec_and_socket_client_input() {
    csv_input_files=(${input_providers[@]})
    input_providers=(../examples/${application}/${application}.socket)
}

# After setting the csv_input_files parameters to the csv files given to RTEC, 
# we start a new process in the background for each csv file.
# The process writes the events of the file into the socket.
function start_socket_writers() {
    fix_rtec_and_socket_client_input
    for i in "${!csv_input_files[@]}"; do
            # Run socket writer in the background
            socket_writer ${csv_input_files["$i"]} ${input_providers[0]} ${stream_rate:-} & 
    done
    trap cleanup_socket INT # After this point, in case of SIGINT, delete the socket.
}

function get_default_param (){
	# Inputs: An application name.
	# Output: The default value of the parameter, as specified in defaults.toml
	application=$1
	parameter=$2
        # The following awk script parses the defaults.toml file and looks the value given to <parameter> for <application>
        # <curr_app> keeps track of the "app" string found in the most recent "[app]" line of the file.
        # If, for some line of defaults.toml, <curr_app> matches <application> and line starts with <parameter>,
        # then we pass that line to the next awk script, which separates the line by = and #, and fetches the second field (i.e., the value).
        # We remove spaces, tabs, backslashes and double quotes, and substitute commas with spaces, in order to have a bash list.
        # Finally, tr removes single quotes (\047), and bracket characters from the value string.
	awk -v app="$application" -v param="$parameter" '
	BEGIN {curr_app=0; pat="^"param} 
	{if($0 ~ /'^\\['/){gsub("\\[","");gsub("\\]","");curr_app=$0;}} 
	{if($0 ~ pat && curr_app==app){print $0;}}
	' defaults.toml | awk -F'=|#' '{gsub(/[ \t\\"]/, "", $2); gsub(",", " ", $2); print $2}' | tr -d '[]\047'
}

function check_if_app_in_toml (){
    # Inputs: An application name
    # Outputs: 0 if there is a dictionary for <app> in "defaults.toml", and 1 otherwise.
    app=$1
    awk -v app="$app" '
    {if($0 ~ /'^\\['/){gsub("\\[","");gsub("\\]",""); if(app==$0){ code_reversed=1; }}}
END{ exit !code_reversed }
    ' defaults.toml
}

