## CLI Tools

### Running an Existing Application

While in the root folder of RTEC, open a terminal and follow the instructions below:

1. **Install RTEC to your system.** Type ``` source install.sh ```. Note that for some operating systems, e.g., for some versions of MacOS, running this script requires superuser privileges. Therefore, in MacOS run ``` sudo -s ``` beforehand. In Windows, run ``` ./install.sh ```. Check if the script terminated correctly. If so, RTEC is installed in your system as a command line tool.

2. **Execute RTEC from the command line.** Some execution examples of the command line interface (CLI) of RTEC are presented below.

    - ``` RTEC2 ``` or ``` RTEC2 --help ``` prints usage instructions for RTEC.
    - ``` RTEC2 --use-case voting --path examples/voting ``` runs RTEC on a dataset concerning a multi-agent voting procedure. The folder specified with the "path" argument, i.e. "examples/voting", contains a collection of ".csv" and ".prolog" files. The csv files contain the input data streams, while the prolog files include the event description of the application and possibly auxiliary knowledege. 


To remove RTEC from your system, run ``` pip3 uninstall RTEC2 ```. In Windows, run ``` py -m pip uninstall RTEC2```.

[🠔](contents.md)
