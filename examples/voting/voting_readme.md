# Application

This application describes a voting prodecure for multi-agent systems. The task of RTEC is to compute the maximal intervals during which a set of normative positions, e.g., institutionalised power, obligation, etc., of agents hold.

Documentation about this application may be found in the paper below:

Mantenoglou P., Pitsikalis E. and Artikis A. [Stream Reasoning with Cycles](https://cer.iit.demokritos.gr/publications/papers/2022/KR2022-final.pdf). In Proceedings of the 19th International Conference on Principles of Knowledge Representation and Reasoning (KR), 2022.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a download link for several datasets for voting with a varying number of participating agents in ".csv" format. An example dataset with 1000 agents is packed with this repository. Note that only one of these datasets should be present in this folder at the time of executing RTEC.
- **results.** Directory of the execution logs.

# Execution Examples on Voting
- ```./run_rtec.sh --app=voting --window-size=30 --step=30```: runs RTEC with a window and step size equal to 30 time-points. 
- ```./run_rtec.sh --app=voting --start-time=40 --end-time=80```: reasoning starts from time-point 40 and ends at time-point 80. 
- ```./run_rtec.sh --app=voting --input-mode=fifo --input-providers=../examples/voting/dataset/csv/voting.csv --stream-rate=4```: simulates a live stream from the records stored in the file specified as the input provider. Input entities are consumed at four times the velocity implied by their time-stamps. 
- ```./run_rtec.sh --app=voting --event-description=../examples/voting/resources/patterns/rules.prolog --background-knowledge=../examples/voting/dataset/auxiliary/voting_static_generator.prolog```: runs RTEC using the patterns and the auxiliary definitions in the provided event description and background knowledge parameters, respectively.
- ```./run_rtec.sh --app=voting --dependency-graph --dependency-graph-directory=../examples/voting/resources/graphs --include-input```: runs RTEC with the default execution parameters. Additionally, the script instructs the compiler of RTEC to construct the dependency graph of the application and store in the provided directory. This process requires [GraphViz](https://graphviz.org/). The flag include-input instructs the compiler to include input entities in the dependency graph.

[🠔](/docs/contents.md)
