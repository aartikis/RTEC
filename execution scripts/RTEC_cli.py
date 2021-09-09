import click
import os
import sys

if sys.platform=="win32":
	sep = "\\"
	doubleSep="\\\\"
else:
	sep = "/"
	doubleSep = "/"

use_case_enum = ['caviar','ctm', 'maritime', 'netbill', 'voting', 'toy']
default_window_values = {"voting": 10, "netbill": 10, "maritime": 86400, "ctm": 10000, "caviar": 100000, "toy": 30}
default_step_values = default_window_values
default_dynamic_grounding_values = {"voting": True, "netbill": True, "maritime": True, "ctm": False, "caviar": False, "toy": False}
default_start_values = {"voting": 0, "netbill": 0, "maritime": 1443650400, "ctm": 0, "caviar": 0, "toy": 0}
default_end_values = {"voting": 100, "netbill": 100, "maritime": 1448834400, "ctm": 50000, "caviar": 1007000, "toy": 30}

script_folder = os.path.dirname(__file__) + doubleSep + 'execution scripts'
print(script_folder)

### Helper functions ###

def safe_mkdir(directory):
	'''Make dir if it doesnt exist'''
	if not os.path.exists(directory):
		os.mkdir(directory)

def doubleSeperate(path):
	pathNew = path.replace(sep, doubleSep)
	return pathNew


def prologFilesStr(path, prologFiles):
	prologStr = ""
	for prologFile in prologFiles:
		prologStr += "'" + path + doubleSep + prologFile + "'" + ","
	return prologStr

def FilesToList(path, files):
	listStr = "["
	for file in files:
		listStr += "'" + path + doubleSep + file + "'"
		if file!=files[-1]:
			listStr += ","
	listStr += "]"
	return listStr

### CLI ###
class Config(object):
	# Parameters of general group are passed to subgroups via the config object
	def __init__(self):
		self.use_case=''
		self.filesPath=''
		self.prolog=''
		self.start=0
		self.end=0
		self.window=0
		self.step=0
		self.agents=1000
		self.dynamic_grounding=True


pass_config = click.make_pass_decorator(Config, ensure=True)

@click.group() # The cli passes the usecase and dataset parameters to the specified subgroup.
@click.option('--use-case', required=True, help='The supported use cases are: "maritime", "caviar", "ctm", "voting" and "netbill".')
@click.option('--path', required=True, help='The relative path to the folder containing the event description (".prolog" files) and the input event stream (".csv" file).') #Folder must be in RTEC repo.
@click.option('--prolog', default="swipl", help='Select the Prolog language for running RTEC. The available options are: "swipl" (default) and "yap".')
@click.option('--start', default=-1, help='The timestamp of the stream from which reasoning starts.')
@click.option('--end', default=-1, help='The timestamp of the stream at which reasoning ends.')
@click.option('--window', default=-1, help='The time period before the current query time on which RTEC operates.') # Default should vary in the real-data applications
@click.option('--step', default=-1, help='The size of the data batches processed by oPIEC.')
@click.option('--agents', default=1000, help='The number of agents (only used for Multi-Agent Systems).')
#@click.option('--dynamic-grounding', default=True, help='Enable dynamic grounding? "True"/"False".')
#@click.option('--agents', default=1000, help='Number of Agents for Multi-Agent Systems applications.')
#@click.option('--seed', default=1, help="Dataset id number for Multi-Agent Systems applications.")
@pass_config
def cli(config, use_case, path, prolog, start, end, window, step, agents):
	print()
	print('Selected use case: ' + use_case)
	if use_case not in use_case_enum:
		print("Error: Invalid use-case/application name.")
		print("The available use-cases are: " + str(use_case_enum))
		exit(1)
	config.use_case=use_case
	filesPath = os.path.abspath(path)
	print('Reading files from path: ' + filesPath)
	config.filesPath=filesPath
	config.prolog=prolog
	## If the following parameters are not given by the user, fetch their application-specific default value.
	config.start=start if start>-1 else default_start_values[use_case]
	config.end=end if end>-1 else default_end_values[use_case]
	config.window=window if window>-1 else default_window_values[use_case]
	config.step=step if step>-1 else default_step_values[use_case]
	# Only used for MAS protocols
	config.agents=agents
	# Dynamic grounding is currently application-specific
	config.dynamic_grounding=default_dynamic_grounding_values[use_case]

@cli.command()
@pass_config
def continuousCER(config):
	"""Run continuousQueries with the given parameters."""
	if config.dynamic_grounding:
		dgString="dynamicgrounding"
	else:
		dgString="nodynamicgrounding"
	
	prologFiles=list() 
	csvFiles=list()
	for file in os.listdir(config.filesPath + doubleSep + 'resources'):
		if file.endswith(".prolog"):
			prologFiles.append(file)
	for file in os.listdir(config.filesPath + doubleSep + 'dataset'): # There may only be one ".csv" file in the input folder.
		if file.endswith(".csv"):
			csvFiles.append(file)

	#print(prologFiles)	
	#print(csvFiles)
	#print(script_folder)

	folderPath = doubleSeperate(config.filesPath)
	resultsPath = folderPath + doubleSep + 'results' 
	resourcesPath = folderPath + doubleSep + 'resources'
	datasetPath = folderPath + doubleSep + 'dataset'
	safe_mkdir(resultsPath)
									
	prolog = config.prolog
	print("Execution Command: ")
	if prolog=="swipl":
		prologCommand = config.prolog + " -l " + '"'+ script_folder + doubleSep + \
				'continuousQueries.prolog" -g "continuousQueriesCLI(' + config.use_case + "CLI" + "," + \
				str(config.start) + "," + str(config.end) + "," + str(config.window) + "," + str(config.step) + "," + \
				 str(config.agents) + "," + dgString + ",'" + resultsPath + "'," + FilesToList(resourcesPath, prologFiles) + "," + \
				 FilesToList(datasetPath, csvFiles) + '),halt."'
	elif prolog=="yap":
		prologCommand = config.prolog + " -s 0 -h 0 -t 0 -l " + '"'+ script_folder + doubleSep + \
				'continuousQueries.prolog" -g "continuousQueriesCLI(' + config.use_case + "CLI" + "," + \
				str(config.start) + "," + str(config.end) + "," + str(config.window) + "," + str(config.step) + "," + \
				 str(config.agents) + "," + dgString + ",'" + resultsPath + "'," + FilesToList(resourcesPath, prologFiles) + "," + \
				 FilesToList(datasetPath, csvFiles) + '),halt."'
	print(prologCommand)
	os.system(prologCommand)
