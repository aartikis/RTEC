# Application

Maritime Situational Awareness using the [Brest](https://zenodo.org/record/1167595) dataset.

Documentation:

- Pitsikalis et al. [Composite Event Recognition for Maritime Monitoring](http://cer.iit.demokritos.gr/publications/papers/2019/pitsikalis-CERMM.pdf). ACM International Conference on Distributed and Event-Based Systems (DEBS), 2019.
- [Maritime Situational Awareness@CER](http://cer.iit.demokritos.gr/blog/applications/maritime_surveillance/)

# Directory Structure
- /Brest/experiments/data. The Brest dataset in RTEC format. The dynamic [AIS](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjOs8XW8afvAhVOXBoKHZtZABwQFjABegQIBBAD&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FAutomatic_identification_system&usg=AOvVaw2vEOqPfXEPszyGucE9tFl7) dataset may be downloaded from [here](https://owncloud.skel.iit.demokritos.gr/index.php/s/EKJtSdvpTGCfKm1) and placed in the /Brest/experiments/data/dynamic folder.
- /Brest/experiments/execution log files. Directory of the execution logs.
- /maritime patterns. Original and compiled patterns along with declarations.

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

Run the execution script; type:

```prolog
continuousQueries(brest-critical).
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
