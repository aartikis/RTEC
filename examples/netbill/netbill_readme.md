# Application

NetBill is an e-commerce prodecure in which consumers and merchants negotiate over digital goods. The task of RTEC is to compute the maximal intervals during which a set of normative positions, e.g. institutionalised power, obligation, etc., of agents hold.

Documentations about this application may be found in the paper below:

Artikis A. and Sergot M. [Executable specification of open multi-agent systems](http://cer.iit.demokritos.gr/publications/papers/2010/artikis-IGPL.pdf) Logic Journal of IGPL, 18(1):31-65, 2010.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a download link for several datasets for NetBill with a varying number of participating agents in ".csv" format. An example dataset with 1000 agents is packed with this repository. 
- **results.** Directory of the execution logs.

# Execution Examples on NetBill
- ```./run_rtec.sh --app=netbill --window-size=20 --step=10```: runs RTEC with a window size equal to 20 time-points and a step size equal to 10 time-points. RTEC is executed with overlapping windows in order to accommodate delayed events.
- ```./run_rtec.sh --app=netbill --start-time=10 --end-time=90```: reasoning starts from time-point 10 and ends at time-point 90. 
- ```./run_rtec.sh --app=netbill --input-mode=fifo --input-providers=../examples/netbill/dataset/csv/netbill.csv --stream-rate=1```: simulates a live stream from the records stored in the file specified as the input provider. Input entities are consumed at the velocity implied by their time-stamps. 
- ```./run_rtec.sh --app=netbill --event-description=../examples/netbill/resources/patterns/rules.prolog --background-knowledge=../examples/netbill/dataset/auxiliary/netbill_static_generator.prolog```: runs RTEC using the patterns and the auxiliary definitions in the provided event description and background knowledge parameters, respectively.
- ```./run_rtec.sh --app=netbill --dependency-graph --dependency-graph-directory=../examples/netbill/resources/graphs --include-input```: runs RTEC with the default execution parameters. Additionally, the script instructs the compiler of RTEC to construct the dependency graph of the application and store in the provided directory. This process requires [GraphViz](https://graphviz.org/). The flag include-input instructs the compiler to include input entities in the dependency graph.

[🠔](/docs/contents.md)
