# Application

Event recognition for maritime situational awareness.

Documentation about this application may be found in the paper below:

Pitsikalis M., Artikis A., Dreo R., Ray C., Camossi E., and Jousselme A., [Composite Event Recognition for Maritime Monitoring.](http://cer.iit.demokritos.gr/publications/papers/2019/pitsikalis-CERMM.pdf)
In 13th International Conference on Distributed and Event-Based Systems (DEBS), pp. 163–174, 2019.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a download link for a dataset which includes vessels sailing the area near the port of Brest for six months. After download the ".csv" file containing the dataset, place it in this folder. 
- **results.** Directory of the execution logs.


# Execution Examples
- ```.\run_rtec.sh --app=maritime --window-size=7200 --step=3600``` runs RTEC on the maritime application for a window size of 2 hours (7200 seconds) and a step size equal to 1 hour. In this, case RTEC is executed with overlapping windows, in order to accommodate delayed events.
