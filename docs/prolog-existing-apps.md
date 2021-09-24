## Execution in Prolog

### Running an Existing Application

  1. While in /execution scripts, run ``` swipl -l continuousQueries.prolog ```  or ``` yap -l continuousQueries.prolog ```, depending on the Prolog distribution installed in your system.
  2. ``` continuousQueries(applicationName). ```, where "applicationName" is the name of an existing application, under /examples, and may either be "caviar", "ctm" or "toy". As an example, run ``` continuousQueries(caviar). ```
  3. ``` cd ../examples/applicationName/results ```, using the same "applicationName" as in the previous step. This folder should contain the output file of the execution. As an example, ``` cd ../examples/caviar/results ``` and open the log file created by the execution of RTEC on the activity recognition application.