# Toy Application

This example is illustrated in the [manual of RTEC](../../RTEC_manual.pdf).

# Directory Structure
- **resources.** Original and compiled patterns of a toy example, along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a dataset for the toy example in RTEC format.
- **results.** Directory of the execution logs.

# Execution Examples on the Toy Application
- ```./run_rtec.sh --app=toy --window-size=20 --step=20```: runs RTEC with a window and step size equal to 20 time-points. 
- ```./run_rtec.sh --app=toy --start-time=20 --end-time=40```: reasoning starts from time-point 20 and ends at time-point 40. 
- ```./run_rtec.sh --app=toy --input-mode=fifo --input-providers=../examples/toy/dataset/csv/toy_data.csv --stream-rate=2```: simulates a live stream from the records stored in the file specified as the input provider. Input entities are consumed at twice the velocity implied by their time-stamps. 
- ```./run_rtec.sh --app=toy --event-description=../examples/toy/resources/patterns/rules.prolog --background-knowledge=../examples/toy/dataset/auxiliary/toy_var_domain.prolog```: runs RTEC using the patterns and the auxiliary definitions in the provided event description and background knowledge parameters, respectively.
- ```./run_rtec.sh --app=toy --dependency-graph --dependency-graph-directory=../examples/toy/resources/graphs --include-input```: runs RTEC with the default execution parameters. Additionally, the script instructs the compiler of RTEC to construct the dependency graph of the application and store in the provided directory. This process requires [GraphViz](https://graphviz.org/). The flag include-input instructs the compiler to include input entities in the dependency graph.

[🠔](/docs/contents.md)
