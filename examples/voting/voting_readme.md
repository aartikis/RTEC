# Application

This application describes a voting prodecure for multi-agent systems. The task of RTEC is to compute the maximal intervals during which a set of normative positions, e.g., institutionalised power, obligation, etc., of agents hold.

Documentation about this application may be found in the paper below:

Mantenoglou P., Pitsikalis E. and Artikis A. [Stream Reasoning with Cycles](https://cer.iit.demokritos.gr/publications/papers/2022/KR2022-final.pdf). In Proceedings of the 19th International Conference on Principles of Knowledge Representation and Reasoning (KR), 2022.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a download link for several datasets for voting with a varying number of participating agents in ".csv" format. An example dataset with 1000 agents is packed with this repository. Note that only one of these datasets should be present in this folder at the time of executing RTEC.
- **results.** Directory of the execution logs.


# Execution Examples
- ```.\run_rtec.sh --app=voting --start_time=20 --end_time=80``` runs RTEC on our multi-agent voting protocol. Reasoning starts from time-point 20 and ends at time-point 80. 