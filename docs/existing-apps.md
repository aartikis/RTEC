## Running RTEC with a bash execution script

### Running an Existing Application
  1. **See the supported applications.** RTEC currently supports the applications that appear as table names in the file "execution scripts/defaults.toml". This is the configuration file of RTEC where we list the default execution parameters for each of the supported applications. For instance, see the table corresponding to the "toy" application that we use as a running example in the [manual of RTEC](../RTEC_manual.pdf) below:

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
&emsp;&ensp; According to the key-value pairs of the above table, the event description of the toy application is in the file "../examples/toy/resources/patterns/rules.prolog", while the input stream is in "../examples/toy/dataset/csv/toy_data.csv" and the results of RTEC are written in the directory "../examples/toy/results". See the [manual](../RTEC_manual.pdf) for the grammar of an event description, the supported format for the input providers, and the complete documentation of the parameters in the above table.

  2. **Run RTEC.** 

- **default parameters**: We run RTEC with the bash script "execution scripts/run_rtec.sh". Open a terminal, ```cd execution\ scripts``` and execute the command ```./run_rtec.sh --app=toy```. This command runs RTEC for the toy application and the default parameters specified in the TOML file.

- **custom parameters**: One way to change the execution parameters of RTEC is to modify the key-value pairs in the TOML file. This may not be practical, however, in certain cases, such as when RTEC is being invoked by another program. To address this issue, the user may pass custom key-value pairs as parameters in "run_rtec.sh", overriding the default value of the corresponding parameters. For example, the command ```./run_rtec.sh --app=toy --window-size=20``` runs RTEC for the toy application using windows of 20 time-points. The remaining parameters are set to their default values, as specified in the TOML file. The names of the parameters passed to "run_rtec.sh" are the same as in the TOML file, after replacing "_" with "-".

3. **See the execution results.** The specified results directory includes a log file with statistics concerning the execution of RTEC and a file containing intervals recognised by RTEC in each window. 

[🠔](contents.md)
