# Running RTEC

## Execution Scripts

RTEC can be executed using the scripts under /execution scripts. Requirements:

- [SWI-Prolog 8.2+](https://www.swi-prolog.org/download/stable) or [YAP 6.3](docs/yap_installation.md).

Discuss execution scripts here...

## Command Line Interface

RTEC can be executed using our command line interface (CLI), which has the following requirements:

- A version of [Python 3](https://docs.python.org/3/) with [pip](https://pip.pypa.io/en/stable/installation/) and [setuptools](https://pypi.org/project/setuptools/).

- [SWI-Prolog 8.2+](https://www.swi-prolog.org/download/stable) (default option) or [YAP 6.3](docs/yap_installation.md).

- [Virtual environment](https://docs.python.org/3/tutorial/venv.html) is optional, but very useful for testing. We describe how to acquire virtual environment support and execute RTEC in a virtual environment in the instructions below.

The CLI also requires the [Click](https://click.palletsprojects.com/en/8.0.x/) package which is installed automatically via setuptools (see the instructions below). 

### Installation and Usage Instructions

We encourage the use of a [virtual environment](https://docs.python.org/3/tutorial/venv.html) to avoid potential conflicts with the packages installed in your system. Install virtual environment support with ``` pip3 install virtualenv ```. Note that, when installing Python packages, you may need to substitute ``` pip3 ``` with ``` pip ```, depending on the package installer of your system. To install and run RTEC, please follow the steps below:

Open a terminal and type:

1. ``` git clone https://github.com/aartikis/RTEC``` in the folder of your preference. 

2. ``` cd RTEC ```

Set up and activate a virtual environment for installing the required Python packages as follows:

3. ``` virtualenv venv ``` creates a virtual environment named "venv". In Windows, run ``` python3 -m venv ./venv ```.

4. ``` . venv/bin/activate ``` activates "venv". You may check the Python version used by venv with ``` python3 --version ```. Also, the output of ``` pip3 freeze ```, which prints the list of installed python packages, should be an empty list. In Windows, run ``` venv\Scripts\activate.bat ``` instead. 

5. ``` pip3 install . ``` installs the python packages specified in the setup.py file. Now, the output of ``` pip3 freeze ``` should include these packages.  In Windows, run ``` python3 setup.py install ```

6. The CLI of RTEC has been installed. Some usage examples follow. Open a terminal and type: 

- ``` RTEC ``` or ``` RTEC --help ``` prints the usage instructions for RTEC.

- ``` RTEC --use-case caviar --path ./examples/caviar continuouscer ``` runs RTEC on [CAVIAR](https://homepages.inf.ed.ac.uk/rbf/CAVIARDATA1/), a dataset used for human activity recognition. The folder specified with the "path" argument, "./examples/caviar", contains a collection of ".prolog" files. These files contain the event description of the application, declarations which assist the caching and indexing of RTEC and possibly auxiliary knowledege which describes the domain of interest. Examples of such files are provided for various applications under "/examples". Apart from "use-case" and "path", RTEC uses some additional execution parameters, like the size its temporal windows, which are optional. For more information on the remaining arguments of the CLI, consult the [user manual of RTEC](RTEC_manual.pdf).

7. After you finish experimenting, do not forget to ``` deactivate ``` the virtual environment.

After experimenting with RTEC in a virtual environment, you may consider installing RTEC as a python package in your system. To do so, follow the above instructions, ignoring steps 3, 4 and 7.

## Running RTEC on Custom Applications

In order to create a new application for RTEC, you need to construct at least two ".prolog" files: the former is the event description expressing the domain of interest, while the latter is a set of declarations which aid the compilation. For more information on creating custom patterns and declarations for an application, consult the [manual of RTEC](RTEC_manual.pdf). Furthermore, please refer to the pattern and declaration files under "/examples/". Apart from the pattern and declaration files, additional ".prolog" files which include input event narratives and contextual information describing the domain of interest, may be included.

To run RTEC on a custom application, follow these steps: 

1. ``` cd examples && mkdir customApplicationName ```. Create a folder under "/examples" for your custom application. 
2. ``` cd customApplicationName && mkdir resources dataset results ```. Create the following sub-directories under "/examples/customApplicationName":

    - "resources" contains the ".prolog" files of the application. The files containing the patterns and the declarations of the domain must be included in this folder.

    - "results" is the folder in which RTEC stores the output files containing the computed intervals of fluents and the log files which include useful information about each execution.
3. Write the ".prolog" files of the application and store them in the "resources" folder. Remember that the file containing the patterns of the domain needs to compiled, as described in the [manual of RTEC](RTEC_manual.pdf). In brief, go to "/src", open a terminal and type ``` swipl -l compiler.prolog ``` for SWI-Prolog or ``` yap -l compiler.prolog ``` for YAP. Then, run ``` compileEventDescription('../examples/customApplicationName/resources/declarations.prolog', '../examples/customApplicationName/resources/rules.patterns', '../examples/customApplicationName/resources/compiled_rules.prolog'). ```. Check if the file was compiled successful. Note the different extension of the original rules file is intentional and is employed because RTEC consults every ".prolog" under "/resources" &mdash; the pre-compiled version of the rules file should be ignored.  
4. Go to "/execution scripts" and edit the "handleApplication.prolog" file by adding a rule with handleApplication/10 as its head which sets the parameters of your experiment. The second argument of handleApplication/10 serves as the name of your experimental setup. The body conditions specify the event description of the application, the source files for the input event streams and the parameters of RTEC (e.g. window size). We suggest following the structure of the provided rules for handleApplication/10 when constructing your own, to minimise errors. The execution parameters which are set by handleApplication/10 are described at the top of the "handleApplication.prolog" file. 
5. In "/execution scripts", run ``` swipl -l continuousQueries.prolog ```  or ``` yap -l continuousQueries.prolog ``` depending on the Prolog distribution installed in your system.
6. ``` continuousQueries(applicationName). ```, where "applicationName" matches with the second argument of the head of the rule you added in "handleApplication.prolog". "continuousQueries.prolog" invokes handleApplication/10, using the application name specified by the user, to fetch the parameters of the experiment and consult the necessary files. Afterwards, the script executes RTEC to perform continuous stream reasoning on the input event streams specified in the application's definition (handleApplication rule).
7. Go to "examples/customApplicationName/results" and see the output files of the execution.