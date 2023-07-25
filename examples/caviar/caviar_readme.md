# Application

Activity recognition for public space surveillance using the [CAVIAR](http://homepages.inf.ed.ac.uk/rbf/CAVIARDATA1/) benchmark dataset.

Documentation about this application may be found in this paper:

Artikis A., Sergot M. and Paliouras G. [An Event Calculus for Event Recognition](http://cer.iit.demokritos.gr/publications/papers/2015/artikis-TKDE14.pdf). IEEE Transactions on Knowledge and Data Engineering (TKDE), 27(4):895-908, 2015.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains the CAVIAR dataset in RTEC format.
- **results.** Directory of the execution logs.

# Execution Examples on Activity Recognition
- ```./run_rtec.sh --app=caviar --window-size=200000 --step=200000``` runs RTEC for a window and step size equal to 200000 time-points. 
- ```./run_rtec.sh --app=caviar --start-time=200000 --end-time=600000```: reasoning starts from time-point 200000 and ends at time-point 600000. 
- ```./run_rtec.sh --app=caviar --input-mode=fifo --input-providers=../examples/caviar/dataset/csv/appearance.csv --input-providers=../examples/caviar/dataset/csv/movementB.csv --stream-rate=50000```: simulates live streams from the records stored in the files specified as the input providers. The stream rate dictates that 50000 event time-stamps express 1 wall time second. 
- ```./run_rtec.sh --app=caviar --event-description=../examples/caviar/resources/patterns/rules.prolog --background-knowledge=../examples/caviar/resources/auxiliary/pre-processing.prolog```: runs RTEC using the patterns and the auxiliary definitions in the provided event description and background knowledge parameters, respectively.
- ```./run_rtec.sh --app=caviar --dependency-graph --dependency-graph-directory=../examples/caviar/resources/graphs --include-input```: runs RTEC with the default execution parameters. Additionally, the script instructs the compiler of RTEC to construct the dependency graph of the application and store in the provided directory. This process requires [GraphViz](https://graphviz.org/). The flag include-input instructs the compiler to include input entities in the dependency graph.

[🠔](/docs/contents.md)
