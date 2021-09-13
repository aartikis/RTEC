import click
import os
import sys

if sys.platform=="win32":
	sep = "\\"
	doubleSep="\\\\"
else:
	sep = "/"
	doubleSep = "/"

use_case_enum = ['caviar','ctm', 'toy']
default_window_values = {"ctm": 10000, "caviar": 100000, "toy": 30}
default_step_values = default_window_values
default_start_values = {"ctm": 0, "caviar": 0, "toy": 0}
default_end_values = {"ctm": 50000, "caviar": 1007000, "toy": 30}

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

def PathsToList(paths):
	listStr = "["
	for path in paths:
		listStr += "'" + path + "'"
		if path!=paths[-1]:
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
		self.end=0
		self.window=0
		self.step=0


pass_config = click.make_pass_decorator(Config, ensure=True)

@click.group() # The cli passes the usecase and dataset parameters to the specified subgroup.
@click.option('--use-case', required=True, help='The supported use cases are: "caviar", "ctm" and "toy".')
@click.option('--path', required=True, help='The relative path to the folder containing the event description and domain knowledge (".prolog" files).') #Folder must be in RTEC repo.
@click.option('--prolog', default="swipl", help='Select the Prolog language for running RTEC. The available options are: "swipl" (default) and "yap".')
@click.option('--end', default=-1, help='The timestamp of the stream at which reasoning ends.')
@click.option('--window', default=-1, help='The time period before the current query time on which RTEC operates.') # Default should vary in the real-data applications
@click.option('--step', default=-1, help='The size of the data batches processed by oPIEC.')
@pass_config
def cli(config, use_case, path, prolog, end, window, step):
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
	config.end=end if end>-1 else default_end_values[use_case]
	config.window=window if window>-1 else default_window_values[use_case]
	config.step=step if step>-1 else default_step_values[use_case]

@cli.command()
@pass_config
def continuousCER(config):
	"""Run continuousQueries with the given parameters."""
	prologFiles=list() 
	
	# Consult ".prolog" files from the resources/ folder
	consultPath = config.filesPath + doubleSep + 'resources' + doubleSep + 'patterns'
	for file in os.listdir(consultPath):
		if file.endswith(".prolog"):
			prologFiles.append(consultPath + doubleSep + file)

	consultPath = config.filesPath + doubleSep + 'resources' + doubleSep + 'auxiliary'
	if os.path.exists(consultPath):
		for file in os.listdir(consultPath):
			if file.endswith(".prolog"):
				prologFiles.append(consultPath + doubleSep + file)

	# Consult ".prolog" files from the dataset/ folder. 
	consultPath = config.filesPath + doubleSep + 'dataset'
	for file in os.listdir(consultPath):
		if file.endswith(".prolog"):
			prologFiles.append(consultPath + doubleSep + file)

	folderPath = doubleSeperate(config.filesPath)
	resultsPath = folderPath + doubleSep + 'results' 
	#resourcesPath = folderPath + doubleSep + 'resources'
	#datasetPath = folderPath + doubleSep + 'dataset'
	safe_mkdir(resultsPath)

	prolog = config.prolog
	print("Execution Command: ")
	if prolog=="swipl":
		prologCommand = config.prolog + " -l " + '"' + script_folder + doubleSep + \
				'continuousQueries.prolog" -g "continuousER(' + config.use_case + "CLI" + "," + \
				 str(config.end) + "," + str(config.window) + "," + str(config.step) + ",'" + \
				 resultsPath + "'," + PathsToList(prologFiles) + '),halt."'
	elif prolog=="yap":
		prologCommand = config.prolog + " -s 0 -h 0 -t 0 -l " + '"' + script_folder + doubleSep + \
				'continuousQueries.prolog" -g "continuousER(' + config.use_case + "CLI" + "," + \
				 str(config.end) + "," + str(config.window) + "," + str(config.step) + ",'" + \
				 resultsPath + "'," + PathsToList(prologFiles) + '),halt."'
	print(prologCommand)
	os.system(prologCommand)
