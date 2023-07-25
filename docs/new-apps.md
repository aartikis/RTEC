## Running RTEC with a bash execution script

### Running a New Application

To run RTEC on a new application, follow these steps: 

1. **Add a table for the new application in the configuration file.** Open the configuration file "execution scripts/defaults.toml" with your favourite text editor and add a table for your new application, following the format of the existing tables. First, specify the name of your application inside "[ ]" at the first line of the table. Then, add a default value for *all* the execution parameters. See the [manual of RTEC](../RTEC_manual.pdf) for the documentation of these parameters.

2. **Create the event description of your application.** Create a Prolog file for the event description of your application. The grammar of an event description can be found in the manual. The location of the event description file should match the path provided in the event description parameter of the TOML table of your new application.

3. **Set the input event streams.** RTEC reads input event streams from files or named pipes. See [this section of the documentation](input_mode.md) for more details on the supported types of input providers. The locations of the input providers should match the paths provided in the input providers parameter of the TOML table of your new application.

4. **Run RTEC on your new application.** We run RTEC with the bash script "execution scripts/run_rtec.sh". Open a terminal, ```cd execution\ scripts``` and execute the command ```./run_rtec.sh --app=NameOfYourApplicationInTOML```. This command runs RTEC for your new application and the default parameters specified in the TOML file.

5. **See the execution results.** The results of RTEC are written in the results directory you specified in the TOML table of your application. This includes a log file with statistics concerning the execution of RTEC and a file containing intervals recognised by RTEC in each window. 

[🠔](contents.md)
