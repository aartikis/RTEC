## Execution in Prolog

### Running a New Application

In order to create a new application for RTEC, you need to construct a ".patterns" file, which contains the event description expressing the domain of interest, and a ".prolog" file which includes a set of declarations aiding pattern compilation. For more information, consult the [manual of RTEC](https://github.com/aartikis/RTEC/blob/master/RTEC_manual.pdf). Furthermore, see the pattern and declaration files under "/examples/" for some examples. 

To run RTEC on a new application, follow these steps: 

1. ``` cd examples && mkdir newApplicationName ```. 
2. ``` cd newApplicationName && mkdir resources dataset results ```. Create the following sub-directories under "/examples/newApplicationName":
   - "resources" contains the event description, as a ".patterns" file, and the declarations as a ".prolog" file; this directory may additionally contain ".prolog" files with auxiliary domain knowledge. 
   - "dataset" contains the ".prolog" files with the input events on which the event description is evaluated. See "/examples/" for some examples.
   - "results" is the folder in which RTEC stores the log files with statistics of execution.
3. Compile the event description, as described in the [manual of RTEC](https://github.com/aartikis/RTEC/blob/master/RTEC_manual.pdf). In brief, go to "/src", open a terminal and type ``` swipl -l compiler.prolog ``` for SWI-Prolog or ``` yap -l compiler.prolog ``` for YAP. Then, run ``` compileEventDescription('../examples/newApplicationName/resources/declarations.prolog', '../examples/newApplicationName/resources/rules.patterns', '../examples/newApplicationName/resources/compiled_rules.prolog'). ```. Check if compilation was successful. Note that the compiled event description is stored as a ".prolog" file. 
4. Go to "/execution scripts" and edit the "handleApplication.prolog" file by adding a rule with handleApplication/10 as its head, setting this way the parameters of your experiment. The second argument of handleApplication/10 serves as the name of your experimental setup. The body conditions point to the event description, the files for the input events and the parameters of RTEC (e.g. window size). We suggest following the structure of the provided rules for handleApplication/10 when constructing your own. The execution parameters are described at the top of the "handleApplication.prolog" file. 
5. In "/execution scripts", run ``` swipl -l continuousQueries.prolog ```  or ``` yap -l continuousQueries.prolog ``` depending on the Prolog distribution installed in your system.
6. ``` continuousQueries(applicationName). ```, where "applicationName" matches with the second argument of the rule you added in "handleApplication.prolog". "continuousQueries.prolog" invokes handleApplication/10 to fetch the parameter values of the experiment and consult the necessary files. Afterwards, the script executes RTEC to perform continuous stream reasoning on the input events specified in the application's definition (handleApplication rule).
7. Go to "examples/newApplicationName/results" and see the log files of the execution.
