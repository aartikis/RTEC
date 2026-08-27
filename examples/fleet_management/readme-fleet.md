# Application

Event recognition for [Fleet Management](http://cer.iit.demokritos.gr/blog/applications/fleet_management/).

# File Description

- ./patterns_compiled_inc.prolog: The composite event definitions.
- ./declarations.prolog: The declarations file.
- ./mass-queries.prolog: The application execution file. When recognition finishes, it outputs the recognized composite events along with various statistics concerning recognition.
- ./data/dynamic_data/Fleet_Management_dataset_download.txt: A link to download synthetic versions of the original dataset. We provide five versions where each time 5%, 10%, 20%, 40% and 80% of the input events have been delayed. Note that the datasets have to be placed in the data/dynamic_data folder.
- ./data/loadFiles.prolog: A prolog file that loads all the necessary data.
- ./data/static_data/vehiclesInfo.prolog: A prolog file that loads all the necessary static data. 
- Vehicle static information such as speed and tank size per vehicle type and vehicle types:
	- data/static_data/vehiclesSpeed.prolog
	- data/static_data/vehiclesTanks.prolog
	- data/static_data/vehiclesType.prolog
- ./utils/compare.prolog: Auxiliary functions.
- ./utils/dynamic-grounding.prolog: This file is responsible for grounding only the necessary vehicle entities in each temporal window.
- ./utils/globals.prolog: Initialization of global variables.
