import click
import os
import sys
from zipfile import ZipFile
import pkg_resources

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

def PathsToList(paths):
	listStr = "["
	for path in paths:
		listStr += "'" + path + "'"
		if path!=paths[-1]:
			listStr += ","
	listStr += "]"
	return listStr

## Script Path ## 
if sys.platform=="win32":
	egg_folder = doubleSeperate(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
	#print(egg_folder.split(doubleSep)[-1])
	if "egg"==egg_folder.split(doubleSep)[-1].split('.')[-1]: ## Compare suffix
		zip = ZipFile(egg_folder, 'r')
		#zip.printdir()
		# extracting all the files
		#print('Extracting all the files now...')
		zip.extractall(doubleSeperate(os.path.dirname(egg_folder)))
		script_folder = doubleSeperate(os.path.dirname(egg_folder) + sep + 'bin' + sep + "RTEC2-files" + sep + 'execution scripts') ##
	else:
		script_folder = doubleSeperate(os.path.dirname(os.path.dirname(__file__)) + sep + 'bin' + sep + "RTEC2-files" + sep + 'execution scripts') ##
elif "linux" in sys.platform:
	script_folder = doubleSeperate(os.path.dirname(__file__) + sep + "RTEC2-files" + sep + 'execution scripts')
elif sys.platform=="darwin":
	script_folder = doubleSeperate(os.path.dirname(__file__) + sep + "RTEC2-files" + sep + 'execution scripts')
#print(script_folder)

### CLI ###
'''
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
'''

#pass_config = click.make_pass_decorator(Config, ensure=True)

@click.group(invoke_without_command=True, no_args_is_help=True) # The cli passes the usecase and dataset parameters to the specified subgroup.
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
#@pass_config
def cli(use_case, path, prolog, start, end, window, step, agents):
	print()
	print('Selected use case: ' + use_case)
	if use_case not in use_case_enum:
		print("Error: Invalid use-case/application name.")
		print("The available use-cases are: " + str(use_case_enum))
		exit(1)
	#config.use_case=use_case
	filesPath = doubleSeperate(os.path.abspath(path))
	print('Reading files from path: ' + filesPath)
	#config.filesPath=filesPath
	#config.prolog=prolog
	## If the following parameters are not given by the user, fetch their application-specific default value.
	start=start if start>-1 else default_start_values[use_case]
	end=end if end>-1 else default_end_values[use_case]
	window=window if window>-1 else default_window_values[use_case]
	step=step if step>-1 else default_step_values[use_case]
	# Only used for MAS protocols
	agents=agents
	# Dynamic grounding is currently application-specific
	dynamic_grounding=default_dynamic_grounding_values[use_case]

#@cli.command()
#@pass_config
#def continuousCER(config):
	"""Run continuousQueries with the given parameters."""
	if dynamic_grounding:
		dgString="dynamicgrounding"
	else:
		dgString="nodynamicgrounding"
	
	prologFiles=list() 
	csvFiles=list()

	# Collect ".prolog" files from the subfolders of resources\
	consultPath = filesPath + doubleSep + 'resources' + doubleSep + 'patterns'
	for file in os.listdir(consultPath):
		if file.endswith(".prolog"):
			prologFiles.append(consultPath + doubleSep + file)

	consultPath = filesPath + doubleSep + 'resources' + doubleSep + 'auxiliary'
	if os.path.exists(consultPath):
		for file in os.listdir(consultPath):
			if file.endswith(".prolog"):
				prologFiles.append(consultPath + doubleSep + file)

	consultPath = filesPath + doubleSep + 'dataset' + doubleSep + 'auxiliary'
	if os.path.exists(consultPath):
		for file in os.listdir(consultPath):
			if file.endswith(".prolog"):
				prologFiles.append(consultPath + doubleSep + file)

	# Collect csv files from dataset/csv
	consultPath = filesPath + doubleSep + 'dataset' + doubleSep + 'csv' #These files are not directly "consulted"
	for file in os.listdir(consultPath): # There may only be one ".csv" file in the input folder.
		if file.endswith(".csv"):
			csvFiles.append(consultPath + doubleSep + file)

	#print(prologFiles)	
	#print(csvFiles)
	#print(script_folder)

	folderPath = filesPath
	resultsPath = folderPath + doubleSep + 'results' 
	#resourcesPath = folderPath + doubleSep + 'resources'
	#datasetPath = folderPath + doubleSep + 'dataset'
	safe_mkdir(resultsPath)
				
	continuousQueriesPath = '"' + doubleSeperate(pkg_resources.resource_filename("RTECv2", "execution scripts/continuousQueries.prolog")) + '"'
	print(continuousQueriesPath)
	if prolog=="swipl":
		prologCommand = prolog + " -l " + continuousQueriesPath + \
				' -g "continuousQueriesCLI(' + use_case + "CLI" + "," + \
				str(start) + "," + str(end) + "," + str(window) + "," + str(step) + "," + \
				 str(agents) + "," + dgString + ",'" + resultsPath + "'," + PathsToList(prologFiles) + "," + \
				 PathsToList(csvFiles) + '),halt."'
	elif prolog=="yap":
		prologCommand = prolog + " -s 0 -h 0 -t 0 -l " + continuousQueriesPath + \
				' -g "continuousQueriesCLI(' + use_case + "CLI" + "," + \
				str(start) + "," + str(end) + "," + str(window) + "," + str(step) + "," + \
				 str(agents) + "," + dgString + ",'" + resultsPath + "'," + PathsToList(prologFiles) + "," + \
				 PathsToList(csvFiles) + '),halt."'
	#print(prologCommand)
	os.system(prologCommand)
