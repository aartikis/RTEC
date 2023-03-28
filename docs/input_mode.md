## Reasoning over Historical Data vs a Live Stream

RTEC may process streams of input events from: 
- **csv files**.
- **named pipes**.

Csv files contain historical data concerning event streams that have concluded. In contrast, named pipes are being updated in real time with new records of the input event streams. We use the execution parameter input_mode to inform RTEC about the type of input providers we use. When input_mode is "csv", RTEC reads the input event streams from csv files, whereas, when input_mode is "fifo", RTEC receives the input event streams incrementally as their records are written in named pipes.

RTEC supports the following options:

1. **input_mode="csv"** and the parameter **input_providers is a list of csv files**.
2. **input_mode="fifo"** and **input_providers is a list of named pipes**.
3. **input_mode="fifo"** and **input_providers is a list of csv files**.

Case 3 may be selected in order to *simulate* a live stream using historical data. To do this, the script "run_rtec.sh" opens a new named pipe for each input csv files and creates a new process that writes the records of each csv file into the corresponding named pipe incrementally, according to the timestamp of each record. Subsequently, RTEC is executed in "fifo" mode, having as input the aforementioned named pipes.

Note that each execution of RTEC uses the same file type for all input providers, i.e., it is not possible to process one live stream and one csv file with historical data in the same execution of RTEC. 

The format of the input records is described in Section 3 of the [user manual of RTEC](../user_manual.pdf).
