## Running RTEC with a bash execution script

### Running an Existing Application
  1. **See the supported applications.** RTEC currently supports the applications that appear as table names in the file "execution scripts/defaults.toml". This is the configuration file of RTEC where we list the default execution parameters for each of the supported applications. For example, see the table corresponding to the "toy" application that we use as a running example in the [manual of RTEC](../RTEC_manual.pdf) below:

```
 [toy]
 event_description = '../examples/toy/resources/patterns/rules.prolog'
 input_mode = "csv"
 input_providers = ['../examples/toy/dataset/csv/toy_data.csv']
 results_directory = "../examples/toy/results"
 window_size = 10
 step = 10
 start_time = 0
 end_time = 50
 clock_tick = 1
 goals = []
 background_knowledge = ['../examples/toy/dataset/auxiliary/toy_var_domain.prolog']
 stream_rate = 1
 dependency_graph_flag = true
 dependency_graph_directory = '../examples/toy/resources/graphs'
 include_input = false
```
&emsp;&ensp; According to the key-value pairs of the above table, the event description of the toy application is in the file "../examples/toy/resources/patterns/rules.prolog", while the input stream is in "../examples/toy/dataset/csv/toy_data.csv" and the results of RTEC are written in the directory "../examples/toy/results". See Sections 4 and 5 of the [user manual](../RTEC_manual.pdf) for the grammar of an event description and the supported format for the input providers. Moreover, the complete documentation of the parameters in the above table is provided in Section 6.

  2. **Run RTEC.** 

- **default parameters**: We run RTEC with the bash script "execution scripts/run_rtec.sh". Open a terminal, ```cd execution\ scripts``` and execute the command ```.\run_rtec.sh --app=toy```. This command runs RTEC for the toy application and the default parameters specified in the TOML file.

- **custom parameters**: One way to change the execution parameters of RTEC is to modify the key-value pairs in the TOML file. This may not be practical, however, in certain cases, such as when RTEC is being invoked by another program. To address this issue, the user may pass custom key-value pairs as parameters in "run_rtec.sh", overriding the default value of the corresponding parameters. For example, the command ```.\run_rtec.sh --app=toy --window-size=20``` runs RTEC for the toy application using windows of 20 time-points. The remaining parameters are set to their default values, as specified in the TOML file. The names of the parameters passed to the "run_rtec.sh" are the same as in the TOML file, after replacing "_" with "-".

3. **See the execution results.** The specified results directory includes a log file with statistics concerning the execution of RTEC and a file containing intervals recognised by RTEC in each window. 

### Execution examples

  1. ```.\run_rtec.sh --window-size=7200 --step=3600``` runs RTEC on the maritime domain for a window size of 2 hours (7200 seconds) and a step size equal to 1 hour. In this, case RTEC is executed with overlapping windows, in order to accommodate delayed events.
  2. ```.\run_rtec.sh --window-size=200 --step=200``` runs RTEC on the activity recognition application for a window and step size equal to 200 time-points.
  3. ```.\run_rtec.sh --start_time=20 --end_time=80``` runs RTEC on our multi-agent voting protocol. Reasoning starts from time-point 20 and ends at time-point 80. 

