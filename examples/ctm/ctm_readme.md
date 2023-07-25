# Application

Event recognition for City Transport Management (CTM).

Documentation about this application may be found in this paper:

Artikis A., Sergot M. and Paliouras G. [An Event Calculus for Event Recognition](http://cer.iit.demokritos.gr/publications/papers/2015/artikis-TKDE14.pdf). IEEE Transactions on Knowledge and Data Engineering (TKDE), 27(4):895-908, 2015.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a sample synthetic dataset for CTM in RTEC format. The dataset concerns 100 public transport vehicles from the EU-funded PRONTO project. 
- **results.** Directory of the execution logs.

# Execution Examples on City Transport Management
- ```./run_rtec.sh --app=ctm --window-size=5000 --step=5000``` runs RTEC for a window and step size equal to 5000 time-points.
- ```./run_rtec.sh --app=ctm --start-time=10000 --end-time=40000```: reasoning starts from time-point 10000 and ends at time-point 40000. 
- ```./run_rtec.sh --app=ctm --input-mode=fifo --stream-rate=5000```: simulates a live stream from the records stored in the files specified by the default input providers list. The stream rate dictates that 5000 event time-stamps express 1 wall time second. 
- ```./run_rtec.sh --app=ctm --event-description=../examples/ctm/resources/patterns/rules.prolog --background-knowledge=../examples/ctm/dataset/auxiliary/vehicles.prolog```: runs RTEC using the patterns and the auxiliary definitions in the provided event description and background knowledge parameters, respectively.
- ```./run_rtec.sh --app=ctm --dependency-graph --dependency-graph-directory=../examples/ctm/resources/graphs --include-input```: runs RTEC with the default execution parameters. Additionally, the script instructs the compiler of RTEC to construct the dependency graph of the application and store in the provided directory. This process requires [GraphViz](https://graphviz.org/). The flag include-input instructs the compiler to include input entities in the dependency graph.

[🠔](/docs/contents.md)
