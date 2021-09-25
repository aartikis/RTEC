## Execution in Prolog

### Setting Execution Parameters

The execution parameters of RTEC may be adjust via our execution scripts. Note that these script files assign default values to the parameters of RTEC. Therefore, the following steps are *optional*.

  1. ``` cd execution\ scripts ``` and open the "handleApplication.prolog" file with your preferred text editor. This file contains multiple definitions for the handleApplication/10 predicate, the second argument of which is the name of an existing application. At this moment, the available applications are "caviar", "ctm" and "toy".
  2. The body of each handleApplication/10 rule includes parameter assignments.  For example, WM=30 and Step=30, in the case of the "toy" example, set up the window size and the step of RTEC, respectively.  A more thorough description of the available parameters is outlined at the top of the file. We encourage you to examine various parameter values in your experiments.
  3. Save your changes and close "handleApplication.prolog".

