## Reasoning over Historical Data vs a Live Stream

RTEC may consume input entities from:
- **files**, or
- **named pipes**.

Files contain historical data concerning event streams that have concluded. In contrast, named pipes are being updated in real time with new records. We use the execution parameter **input_mode** to inform RTEC about the type of input providers we use. When **input_mode** is **csv**, RTEC consumes input entities from files, whereas, when **input_mode** is **fifo**, RTEC consumes input entities incrementally as their records are written in named pipes.

More precisely, RTEC supports the following options:

1. **input_mode=csv** and the parameter **input_providers** is a list of files.
2. **input_mode=fifo** and **input_providers** is a list of named pipes.
3. **input_mode=fifo** and **input_providers** is a list of files.

Case 3 may be selected in order to *simulate* a live stream using historical data. To do this, the script **run_rtec.sh** opens a new named pipe for each input file and creates a new process that writes the records of each file into the corresponding named pipe incrementally. Between writing consecutive input entities into the named pipe, the process waits for a number of seconds that is equal to the difference between the time-stamps of these entities. Subsequently, RTEC is executed in **fifo** mode, having as input the aforementioned named pipes. The **stream_rate** parameter allows RTEC to replay the input stream in various velocities. For instance, when **stream_rate=2**, RTEC processes input entities that arrive at double the velocity implied by their time-stamps.

In **fifo** mode, RTEC sleeps between consecutive query times for a number of seconds that is equal to the value of the **window_size** parameter, waiting for all input entities that fall within the current window to have arrived to RTEC before computing output entities.

The format of the input records is described in the [manual of RTEC](../RTEC_manual.pdf).

[🠔](contents.md)
