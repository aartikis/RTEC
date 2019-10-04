# Toy example

This example is illustrated in the [manual of RTEC](https://github.com/aartikis/RTEC/blob/master/RTEC_manual.pdf).

# Directory Structure
- /experiments/data. A toy dataset in RTEC format.
- /experiments/execution log files. Directory of the execution logs.
- /patterns. Original and compiled patterns along with declarations.

# Execution Instructions

Go to the directory 

```
../../src/execution scripts/

```

Launch Prolog and load the execution script;
for YAP type:


```
yap -s 0 -h 0 -t 0 -l continuousQueries.prolog
```

while for SWI Prolog type:


```
swipl -L0 -G0 -T0 -l continuousQueries.prolog
```

Run the execution script; when operating in YAP type:

```prolog
continuousER(yap, toy).
```

while when operating in SWI Prolog type:

```prolog
continuousER(swi, toy).
```


The parameters of the event recognition task may be set by editing the 

```
handleApplication.prolog
```

file, which is at the same directory as the execution script:


```
continuousQueries.prolog
```



To see the intervals of the fluents in the last window, type in Prolog:

```prolog
holdsFor(U,I).
```

