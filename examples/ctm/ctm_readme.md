# Application

Event recognition for City Transport Management (CTM).

Documentation about this application may be found in this paper:

Artikis A., Sergot M. and Paliouras G. [An Event Calculus for Event Recognition](http://cer.iit.demokritos.gr/publications/papers/2015/artikis-TKDE14.pdf). IEEE Transactions on Knowledge and Data Engineering (TKDE), 27(4):895-908, 2015.

# Directory Structure
- **resources.** Original and compiled patterns along with declarations and auxiliary domain knowledge.
- **dataset.** This folder contains a sample synthetic dataset for CTM in RTEC format. The dataset concerns 100 public transport vehicles from the EU-funded PRONTO project. 
- **results.** Directory of the execution logs.


# Execution Examples
- ```.\run_rtec.sh --app=ctm --window-size=5000 --step=5000``` runs RTEC on the city transport management application for a window and step size equal to 5000 time-points.
