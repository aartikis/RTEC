# Execution Scripts

This directory contains execution scripts which provide a quick and intuitive way of running RTEC for continuous query processing. The files included in this directory are described below. 


# Directory Structure
- "handleApplication.prolog". In this file, the user of RTEC may provide the required domain knowledge for his/her experiments, as well as set up the parameters of RTEC, e.g. window size.   
- "continuousQueries.prolog" is a script which employs the information provided by the user in "handleApplication.prolog" to run RTEC for continuous query processing. 
- "RTEC_cli.py". This file contains code which is required for the command line interface of RTEC.  

# Execution Instructions

For more information on run RTEC using the command line interface or by manually setting up a "handleApplication" rule, please refer to these [instructions](../README.md) and the [manual of RTEC](../RTEC_manual.pdf).