## CLI Tools

### Running an Existing Application

While in the root folder of RTEC, open a terminal and follow the instructions below:

1. **Install RTEC to your system.** Type ``` source install.sh ```. Note that for some operating systems, e.g., for some versions of MacOS, running this script requires superuser privileges. Therefore, in MacOS run ``` sudo -s ``` beforehand. In Windows, run ``` ./install.sh ```. Check if the script terminated correctly. If so, RTEC is installed in your system as a command line tool.

2. **Execute RTEC from the command line.** Some execution examples of the command line interface (CLI) of RTEC are presented below.

    - ``` RTEC2 ``` or ``` RTEC2 --help ``` prints usage instructions for RTEC.
    - ``` RTEC2 --use-case voting --path examples/voting ``` runs RTEC on a dataset concerning a multi-agent voting precedure. The folder specified with the "path" argument, "examples/voting", contains a collection of ".csv" and ".prolog" files. The former contain the input data streams of RTEC, while the latter include the event description of the application, declarations which assist the caching and indexing of RTEC and possibly auxiliary knowledege which describes the domain of interest. Examples of such files are provided for various applications under "examples".
    - ``` RTEC2 --use-case toy --path examples/toy --window 20 --step 20 ``` runs RTEC on our toy example, where the window and the step of RTEC have been set to 20 time-points.
    - ``` RTEC2 --use-case toy --path examples/toy --live-stream-simulation ``` executes RTEC in fifo mode, i.e., live stream reasoning mode where the input event streams are provided through named pipes. Because the "live stream simulation" flag is set, the CLI also invokes the shell script "live_stream_reasoning.sh" in "execution scripts", which writes events incrementally in the input named pipes of RTEC. See Section 4.2 for more information on the input modes of RTEC.  Additionall, the flag ``` --stream-rate <X> ``` may be added to speed up the input streams of events by a factor of \<X\>. As an example, ``` RTEC2 --use-case toy --path examples/toy --live-stream-simulation --stream-rate 2 ``` speeds up the input streams by a factor of two, while the sleep time of RTEC between windows is halved. 

For more information on these parameters, as well as the remaining arguments of the CLI, consult the [user manual of RTEC](../RTEC_manual.pdf) and the help page of the CLI.

3. **Uninstall RTEC.** To remove RTEC from your system, run ``` pip3 uninstall RTEC2 ```. In Windows, run ``` py -m pip uninstall RTEC2```.
