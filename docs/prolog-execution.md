## Execution in Prolog

### Requirements

- [SWI-Prolog 8.2+](https://www.swi-prolog.org/download/stable) or [YAP 6.3](https://github.com/aartikis/RTEC/blob/master/docs/yap_installation.md).

### Parameter tuning

 1. ``` cd execution\ scripts ``` and open the "handleApplication.prolog" file with your preferred text editor. This file contains multiple definitions for the handleApplication/10 predicate, the second argument of which is the name of an existing application. At this moment, the available applications are "caviar", "ctm" and "toy".
 2. The body of each handleApplication/10 rule includes parameter assignments.  For example, WM=30 and Step=30, in the case of the "toy" example, set up the window size and the step of RTEC, respectively.  A more thorough description of the available parameters is outlined at the top of the file. We encourage you to examine various parameter values in your experiments.
 3. Save your changes and close "handleApplication.prolog".

### Running an Existing Application

 1. While in /execution scripts, run ``` swipl -l continuousQueries.prolog ```  or ``` yap -l continuousQueries.prolog ```, depending on the Prolog distribution installed in your system.
 2. ``` continuousQueries(applicationName). ```, where "applicationName" is the name of an existing application, under /examples, and may either be "caviar", "ctm" or "toy".
 3. ``` cd ../examples/applicationName/results ```, using the same "applicationName" as in the previous step. This folder should contain the output file of the execution.
