## CLI Tools

### Running an Existing Application

While in the root folder of RTEC, which contains "install.sh", open a terminal and follow the instructions below:

1. Install RTEC to your system. Type ``` source install.sh ```. Note that for some operating systems, e.g. for some versions of MacOS, running this script requires superuser privileges. Therefore, In MacOS run ``` sudo -s ``` beforehand. In Windows, run ``` ./install.sh ```.
2. The CLI of RTEC has been installed. Some usage examples follow. Open a terminal and type:

- ``` RTEC ``` or ``` RTEC --help ``` prints the usage instructions for RTEC.
- ``` RTEC2 --use-case voting --path ./examples/voting continuouscer ``` runs RTEC on a dataset concerning a multi-agent voting precedure. The folder specified with the "path" argument, "./examples/voting", contains a collection of ".csv" and ".prolog" files. The former contain the input data streams of RTEC, while the latter include the event description of the application, declarations which assist the caching and indexing of RTEC and possibly auxiliary knowledege which describes the domain of interest. Examples of such files are provided for various applications under "/examples".
- ``` RTEC2 --use-case maritime --path ./examples/maritime --window 86400 --step 86400 continuouscer ``` runs RTEC for maritime situational awareness. In this example, the window and the step of RTEC have been set to 86400 seconds (1 day). For more information on these parameters, as well as the remaining arguments of the CLI, consult the [user manual of RTEC](https://github.com/aartikis/RTEC/blob/RTECv2/RTEC_manual.pdf) and the help page of the CLI.

To remove RTEC from your system, run ``` pip3 uninstall RTEC ```. In Windows, run ``` py -m pip uninstall RTEC```.