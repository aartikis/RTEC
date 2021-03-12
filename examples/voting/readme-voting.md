# Application

Event recognition for voting procedures.

# Directory Structure
- /experiments/data/prolog. 
    - 'voting-csv_data_generator.prolog' creates an event narrative and stores it in csv format. 
    - 'voting-data_generator.prolog' is used by 'handleApplication.prolog' to generate and directly load an event narrative to RTEC. 
- /experiments/data/csv. Our event narratives for voting procedures. Download these datasets by following the link we provide in this folder. They were created automatically by our synthetic dataset generator and include scenarios with 1000, 2000, 4000 or 8000 agents.
- /experiments/execution log files. Directory of the execution logs.
- /patterns. Original and compiled patterns along with declarations.

# Execution Instructions

Go to the directory 

```
../../execution scripts/

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

We provide various execution scripts for the voting protocol (see handleApplication.prolog for more details). As an example, type:

```prolog
continuousQueries(votingBig).
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

