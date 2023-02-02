## Execution in Prolog

For existing applications, the patterns are already compiled. The compilation process is described Section 4.3 of this documentation.

### Running an Existing Application

  1. **Consult the execution script with Prolog.**  While in the "execution scripts" directory , run ```swipl -l continuousQueries.prolog```  or ```yap -l continuousQueries.prolog```, depending on the Prolog distribution installed in your system.

  2. **Run RTEC with default input and execution parameters.** The query ```continuousQueries(<applicationName>).``` runs RTEC for an existing application named \<applicationName\> for the default execution parameters, datasets and event descriptions specified in "execution scripts/handleApplication.prolog". The supported application names are: toy, caviar, maritime, voting, netbill and ctm. As an example, you may run ```continuousQueries(caviar).``` to run RTEC for human activity recognition using the default execution parameters for this application, and the default event description and datasets included in the directory "examples/caviar". 
  
  3. **Run RTEC with custom input and execution parameters.** In order to run RTEC with custom execution parameters, datasets or event descriptions, you may use the continuousQueries/2 predicate. Its second argument is a list of key value pairs in the form of \<parameterName=parameterValue\>. Some of the supported parameters are: window_size, step, start_time, end_time, input_mode and stream_rate. For the full list of the supported parameters, see the comments in "execution scripts/handleApplication.prolog". As an example, the query ```continuousQueries(maritime, [window_size=3600, step=3600]).``` runs RTEC on the maritime situational awareness application for a window and step size equal to 1 hour (3600 seconds). The remaining parameters are assigned their default values.

  4. **Get execution results and logs.** Unless another directory was provided, execution logs and results are written in "examples/\<applicationName\>/results". ```cd ../examples/<applicationName>/results```, using the same \<applicationName\> as in the previous step. This folder should contain the output files of the execution. As an example, ```cd ../examples/caviar/results``` and open the log file created by the execution of RTEC on the activity recognition application.

### Execution examples

  1. ```continuousQueries(maritime, [window_size=7200, step=3600]).``` runs RTEC on the maritime domain for a window size of 2 hours and a step size equal to 1 hour. In this case, we have overlapping windows.
  2. ```continuousQueries(caviar, [window_size=200, step=200]).``` runs RTEC on the activity recognition application for a window and step size equal to 200 time-points.
  3. ```continuousQueries(voting, [start_time=20, end_time=80]).``` runs RTEC on our multi-agent voting protocol. Reasoning starts from time-point 20 and ends at time-point 80. 

#### The execution parameter: input_mode 

RTEC may process streams of input events from three sources: csv files, Prolog files or named pipes. One input provider type is used per RTEC execution, i.e., it is not possible to process two event streams from different types of sources, e.g., csv and Prolog files, in the same execution. The execution parameter input_mode is set to "csv" when the input providers are csv files, "dynamic_predicates" for Prolog files and "fifo" for named pipes. If the input mode is not set, then it defaults to "csv", i.e., the default behaviour of RTEC is to expect that input events are provided in csv files.

1. **input_mode = csv.** The execution parameter input_providers is a list of csv files. For example, the default csv file which provides the input events in the toy application is "examples/toy/dataset/csv/toy_data.csv". The format of these csv files is described in "src/data loader/dataLoader.prolog".

2. **input_mode = dynamic_predicates.** The execution parameter input_providers is a list of Prolog files. These files include rules defining the updateSDE/2 predicate, which has two arguments, \<StartTime\> and \<EndTime\>. The bodies of such rules include assertions of events whose time-stamp is in the interval (\<StartTime\>, \<EndTime\>] . The length of this interval must be the same for all updateSDE/2 rules and must be specified using the parameter ``` sde_batch ```. This parameter is only used when the input mode is dynamic_predicates. For example, the default Prolog file which provides the input events in the toy application is "examples/toy/dataset/prolog/toy_data.prolog". 

3. **input_mode = fifo.** *This execution mode has been tested only with SWI Prolog.* The execution parameter input_providers is a list of named pipes. The format of the input events written in these pipes is the same as the format of the csv files of the csv input mode and is specified in "src/data loader/dataLoader.prolog". We provide two shell scripts relevant to this input mode: "execution scripts/stream_provider.sh" and "execution scripts/live_stream_reasoning.sh". The former script takes as input a csv file with input events and writes its events in real-time to a given named pipe, assuming that event timestamps are measured in seconds. The latter script integrates the former one with RTEC, i.e., it invokes a stream provider for each input csv file and executes RTEC with the input mode "fifo" and a list of input providers containing the named pipes created by the stream providers. Both scripts may utilise the ```stream_rate``` parameter which adjusts the velocity of input streams. For instance, if the stream rate is set to 2, then the input events are written to the corresponding named pipes twice as fast. In this mode, RTEC sleeps between window executions for a number of seconds specified by the window size, the step size and the stream rate parameters. For more information on using these scripts, you may consult the comments in the corresponding files.

