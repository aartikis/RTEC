import click
import os
import sys
from zipfile import ZipFile # for Windows OS` 
import pkg_resources

if sys.platform=="win32":
	sep = "\\"
	doubleSep="\\\\"
else:
	sep = "/"
	doubleSep = "/"

use_case_enum = ['caviar','ctm', 'maritime', 'netbill', 'voting', 'toy']

### Helper functions ###

def safe_mkdir(directory):
	'''Make dir if it doesnt exist'''
	if not os.path.exists(directory):
		os.mkdir(directory)

def doubleSeperate(path):
	pathNew = path.replace(sep, doubleSep)
	return pathNew

def pathsToList(paths):
	listStr = "["
	for path in paths:
		listStr += "'" + path + "'"
		if path!=paths[-1]:
			listStr += ","
	listStr += "]"
	return listStr

def addFilesWithSuffixFromDirs(files_list, directories, suffix):
		for directory in directories:
			addFilesWithSuffixInDir(files_list, directory, suffix)
		return pathsToList(files_list)

def addFilesWithSuffixInDir(files_list, directory, suffix):
	if os.path.isdir(directory):	
		for file in os.listdir(directory):
			if file.endswith(suffix):
				files_list.append(directory + doubleSep + file)
	return 

def addParameterListLiveStream(parameter_string, parameter_name, parameter_values_list):
	if len(parameter_values_list)>0:
		for parameter_value in parameter_values_list:
			parameter_string+=parameter_name + "=" + parameter_value + " "
	return parameter_string

def addParameterLiveStream(parameter_string, parameter_name, parameter_value):
	if parameter_value:
		parameter_string+=parameter_name + "=" + parameter_value + " "
	return parameter_string

def addParameter(parameter_string, parameter_name, parameter_value):
	'''Append the given parameter declaration to the input string containing the current parameter declarations.'''
	if parameter_value:
		parameter_declaration_string = parameter_name + "=" + str(parameter_value)
		parameter_string += ", " + parameter_declaration_string if len(parameter_string)>0 else parameter_declaration_string
	return parameter_string

def addParameterNameless(parameter_string, parameter_value):
	'''Two argument variant of addParameter/3 for nameless parameters (e.g., dynamic grounding flag).'''
	if parameter_value:
		parameter_string += ", " + str(parameter_value) if len(parameter_string)>0 else str(parameter_value)
	return parameter_string

## CLI configurations and parameters.
@click.group(invoke_without_command=True, no_args_is_help=True)
@click.option('--use-case', required=True, help='The supported use cases are: toy, caviar, maritime, voting, netbill and ctm.')
@click.option('--path', required=True, help='The path to the folder containing the event description (".prolog" files) and the input event stream (".csv" file). Starting from the given directory, event description files may be located in the directories: resources/patterns, resources/auxiliary or dataset/auxiliary, while input stream providers are located in:dataset/csv') 
@click.option('--prolog', default="swipl", help='Select the Prolog language for running RTEC. The available options are: "swipl" (default) and "yap".')
@click.option('--start-time', default=None, help='The timestamp of the stream from which reasoning starts. Default value differs depending on the use case.')
@click.option('--end-time', default=None, help='The timestamp of the stream at which reasoning ends. Default value differs depending on the use case.')
@click.option('--window', default=None, help='The size of the temporal windows in which RTEC processes the input event streams. Default value differs depending on the use case.')
@click.option('--step', default=None, help='The temporal distance between two consecutive query times. Default value differs depending on the use case.')
@click.option('--dynamic-grounding', default=False, help='Enable dynamic grounding? "True"/"False".')
@click.option('--stream-rate', default='1', help='In live stream mode, expect the input streams to arrive this many times faster than their normal speed.')
@click.option('--input-mode', default="csv", help='Choose input mode. Options: csv, fifo, dynamic_predicates.')
@click.option('--input-providers', multiple=True, default=[], help='Input Providers: named pipes, csv files or prolog files, depending on the input mode')
@click.option('--event-description', multiple=True, default=[], help='Event Description: Prolog files to consult')
@click.option('--live-stream-simulation', is_flag=True, help='Provide the input events to RTEC in real time (seconds)?')

# This is the function called when invoking the CLI.
def cli(use_case, path, prolog, start_time, end_time, window, step, dynamic_grounding, stream_rate, input_mode, input_providers, event_description, live_stream_simulation):
	
	# The cli may only be used for supported applications.	
	if use_case not in use_case_enum:
		print("Error: Invalid use-case/application name.")
		print("The available use-cases are: " + str(use_case_enum))
		exit(1)
	filesPath = doubleSeperate(os.path.abspath(path))
	
	# If the filesPath is provided, create a directory for RTEC's logs and results in filesPath/results.
	# Else, resort to the default directory.
	# Currently, the filesPath is *not* optional.
	resultsPath = filesPath + doubleSep + "results" if len(filesPath)>0 else ""
	
	# Find the event description of the application in the provided path.
	# Looks for Prolog files containing domain knowledge, e.g., complex event definitions and declarations,
	# in the following directories: 
	# 	provided/path/resources/patterns 
	# 	provided/path/resources/auxiliary 
	# 	provided/path/dataset/auxiliary 
	# RTEC will consult these Prolog files before execution.
	
	# Currently, the filesPath is *not* optional.
	if len(filesPath)>0 and len(event_description)==0: # if the Prolog files have not been explicitly provided by the user.
		default_event_description_directories = [filesPath + doubleSep + 'resources' + doubleSep + 'auxiliary', filesPath + doubleSep + 'dataset' + doubleSep + 'auxiliary'] # filesPath + doubleSep + 'resources' + doubleSep + 'patterns'
		event_description=[filesPath + doubleSep + 'resources' + doubleSep + 'patterns' + doubleSep + 'compiled_rules.prolog']
		addFilesWithSuffixFromDirs(event_description, default_event_description_directories, '.prolog')
	elif len(event_description)>0: 
		event_description=list(event_description)

	# Find the input providers (files or named pipes) of the application in the provided path.
	# Looks for Prolog files, csv files or named pipes containing input events, depending on the selected input_mode.
	# in the following directories: 
	# 	provided/path/resources/patterns 
	# 	provided/path/resources/auxiliary 
	# 	provided/path/dataset/auxiliary 

	if len(filesPath)>0 and len(input_providers)==0:
		input_providers=list()
		if input_mode=='csv':
			default_input_provider_directories = [filesPath + doubleSep + 'dataset' + doubleSep + 'csv']
			addFilesWithSuffixFromDirs(input_providers, default_input_provider_directories, '.csv')
		if input_mode=='dynamic_predicates':
			default_input_provider_directories = [filesPath + doubleSep + 'dataset' + doubleSep + 'prolog']
			addFilesWithSuffixFromDirs(input_providers, default_input_provider_directories, '.prolog')
	else:
		input_providers=list(input_providers)

	# If the live stream simulation flag is active, simply pass the input parameters to the "live_stream_reasoning.sh" script and return 
	if live_stream_simulation:
		stream_provider = doubleSeperate(pkg_resources.resource_filename("RTECv2", "scripts/stream_provider.sh")) 
		prolog_script = doubleSeperate(pkg_resources.resource_filename("RTECv2", "scripts/continuousQueries.prolog"))
		live_stream_reasoning_command = doubleSeperate(pkg_resources.resource_filename("RTECv2", "scripts/live_stream_reasoning.sh")) +\
			" " + use_case + " " 
		for input_provider in input_providers:
			live_stream_reasoning_command += input_provider + " "
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--window-size", window)
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--step", step)	
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--start-time", start_time)	
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--end-time", end_time)	
		live_stream_reasoning_command=addParameterListLiveStream(live_stream_reasoning_command, "--event-description-files", event_description)
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--results-directory", resultsPath) 
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--stream-rate", stream_rate)
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--stream-provider-script", stream_provider) 
		live_stream_reasoning_command=addParameterLiveStream(live_stream_reasoning_command, "--prolog-script", prolog_script) 
		os.system(live_stream_reasoning_command)
		return 0
		
	dgString = "dynamicgrounding" if dynamic_grounding else "nodynamicgrounding"
	safe_mkdir(resultsPath)
	
	parameter_string=""
	parameter_string=addParameter(parameter_string, "window_size", window)
	parameter_string=addParameter(parameter_string, "step", step)	
	parameter_string=addParameter(parameter_string, "start_time", start_time)
	parameter_string=addParameter(parameter_string, "end_time", end_time)	
	parameter_string=addParameter(parameter_string, "event_description_files", event_description)
	parameter_string=addParameter(parameter_string, "input_mode", input_mode) 
	parameter_string=addParameter(parameter_string, "input_providers", input_providers)
	parameter_string=addParameter(parameter_string, "results_directory", "'" + resultsPath + "'") 
	parameter_string=addParameterNameless(parameter_string, dgString)
	parameter_string=addParameter(parameter_string, "stream_rate", stream_rate)
	
	continuousQueriesPath = '"' + doubleSeperate(pkg_resources.resource_filename("RTECv2", "scripts/continuousQueries.prolog")) + '"'
	if prolog=="swipl":	
		prologCommand = prolog + " -l " + continuousQueriesPath + \
				' -g "continuousQueries(' + use_case + ',[' + parameter_string + ']),halt."'
	elif prolog=="yap":
		prologCommand = prolog + " -s 0 -h 0 -t 0 -l " + continuousQueriesPath + \
				' -g "continuousQueries(' + use_case + ',[' + parameter_string + ']),halt."'
	os.system(prologCommand)
	return 0
