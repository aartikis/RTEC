# Application

Event recognition for maritime situational awareness.

Documentation about this application may be found in the paper below:

Pitsikalis M., Artikis A., Dreo R., Ray C., Camossi E., and Jousselme A., [Composite Event Recognition for Maritime Monitoring.](http://cer.iit.demokritos.gr/publications/papers/2019/pitsikalis-CERMM.pdf)
In 13th International Conference on Distributed and Event-Based Systems (DEBS), pp. 163–174, 2019.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a download link for a dataset which includes vessels sailing the area near the port of Brest for six months. After downloading the ".csv" file containing the dataset, place it in this folder. 
- **results.** Directory of the execution logs.

# Execution Examples on Maritime Situational Awareness

Before running the following examples, make sure to download the dataset mentioned above.

- ```./run_rtec.sh --app=maritime --window-size=7200 --step=3600``` runs RTEC on the maritime application for a window size of 2 hours (7200 seconds) and a step size equal to 1 hour. In this case, RTEC is executed with overlapping windows, in order to accommodate delayed events.
- ```./run_rtec.sh --app=maritime --start-time=1443657600 --end-time=1443697200```: reasoning starts from epoch 1443657600 and ends at epoch 1443697200. 
- ```./run_rtec.sh --app=maritime --input-mode=fifo --input-providers=../examples/maritime/dataset/csv/preprocessed_dataset_RTEC_critical_nd.csv --stream-rate=180```: simulates a live stream from the records stored in the file specified as the input provider. The stream rate dictates that 3 three minutes of data are consumed each second.
- ```./run_rtec.sh --app=maritime --event-description=../examples/maritime/resources/patterns/rules.prolog --background-knowledge=../examples/maritime/resources/auxiliary/compare.prolog --background-knowledge=../examples/maritime/resources/auxiliary/loadStaticData.prolog```: runs RTEC using the patterns and the auxiliary definitions in the provided event description and background knowledge parameters, respectively.
- ```./run_rtec.sh --app=maritime --dependency-graph --dependency-graph-directory=../examples/maritime/resources/graphs --include-input```: runs RTEC with the default execution parameters. Additionally, the script instructs the compiler of RTEC to construct the dependency graph of the application and store in the provided directory. This process requires [GraphViz](https://graphviz.org/). The flag include-input instructs the compiler to include input entities in the dependency graph.


[🠔](/docs/contents.md)
