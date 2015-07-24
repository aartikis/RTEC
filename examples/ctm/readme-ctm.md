# Application

Event recognition for City Transport Management (CTM).

Artikis A., Sergot M. and Paliouras G. [An Event Calculus for Event Recognition](http://dx.doi.org/10.1109/TKDE.2014.2356476). IEEE Transactions on Knowledge and Data Engineering (TKDE), 27(4):895-908, 2015.


# Directory Structure
- /CE patterns. Original and compiled CE patterns along with declarations.
- /data. A sample synthetic dataset concerning 100 public transport vehicles from the [PRONTO](http://www.ict-pronto.org/) project.
- /execution scripts. 

# Execution Instructions

Unzip the compressed dataset in the /data/100_vehicles/ directory.

Go to the /execution scripts/100_vehicles/ directory.

Launch Prolog.

Load continuousQueries.prolog:
```prolog
['continuousQueries.prolog'].
```

Invoke continuousER(TimesFile, Window, Step, LastTime) with appropriate values for the 3 arguments. Eg:

```prolog
continuousER('times.txt', 10000, 1000, 50000).
```
instructs RTEC to perform continuous queries where window=10000, step=1000, the event recognition times per query are recorded in times.txt, and querying ends when time-point 50000 is reached.

To see the intervals of the fluents in the last window, type:

```prolog
holdsFor(U,I).
```

