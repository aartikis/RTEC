# Directory Structure
- /CE patterns. Original and compiled CE patterns along with declarations.
- /data. The complete [CAVIAR](http://homepages.inf.ed.ac.uk/rbf/CAVIARDATA1/) dataset in RTEC format.
- /execution scripts. 

# Execution Instructions

Unzip the compressed dataset in the /data/complete caviar/ directory.

Go to the /execution scripts/complete caviar/ directory.

Launch Prolog.

Load continuousQueries.prolog:
```prolog
['continuousQueries.prolog'].
```

Invoke continuousER(TimesFile, InputFile, Window, Step, LastTime) with appropriate values for the 4 arguments. Eg:

```prolog
continuousER('times.txt', 'input.txt',10000,10000,1007000).
```
instructs RTEC to perform continuous queries where window=step=10000, the event recognition times per query are recorded in times.txt, the number of input events per window are recorded in input.txt, and querying ends when time-point 1007000 is reached.

To see the intervals of the fluents in the last window, type:

```prolog
holdsFor(U,I).
```

