## CLI Tools

### Running an Existing Application

While in the root folder of RTEC, which contains "install.sh", open a terminal and follow the instructions below:

1. Install RTEC to your system. Type ``` source install.sh ```. Note that for some operating systems, e.g. for some versions of MacOS, running this script requires superuser privileges. Therefore, In MacOS run ``` sudo -s ``` beforehand. In Windows, run ``` ./install.sh ```.
2. The CLI of RTEC has been installed. Some usage examples follow. Open a terminal and type:

- ``` RTEC ``` or ``` RTEC --help ``` prints the usage instructions for RTEC.
- ``` RTEC --use-case caviar --path ./examples/caviar ``` runs RTEC on [CAVIAR](https://homepages.inf.ed.ac.uk/rbf/CAVIARDATA1/), a dataset used for human activity recognition. The folder specified with the "path" argument, "./examples/caviar", contains a collection of ".prolog" files. These files contain the event description of the application, declarations which assist the caching and indexing of RTEC and possibly auxiliary knowledge which describes the domain of interest. Examples of such files are provided for various applications under "/examples". Apart from "use-case" and "path", RTEC uses some additional execution parameters, like the size its temporal windows, which are optional. For more information on the remaining arguments of the CLI, consult the help page of the CLI.

To remove RTEC from your system, run ``` pip3 uninstall RTEC ```. In Windows, run ``` py -m pip uninstall RTEC```.