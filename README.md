# RTEC
RTEC: Run-Time Event Calculus.

RTEC is an extension of the [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) that was proposed by [Robert Kowalski](http://www.doc.ic.ac.uk/~rak/) and [Marek Sergot](http://www.doc.ic.ac.uk/~mjs/). It is a highly-scalable logic programming language for representing and reasoning about events and their effects. 

# License

RTEC comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions; see the [GNU Lesser General Public License v3 for more details](http://www.gnu.org/licenses/lgpl-3.0.html).

# Execution Instructions

##### Version
1.0.0

##### Language
RTEC has been tested under [YAP Prolog 6.2](http://www.dcc.fc.up.pt/~vsc/Yap/).

##### Files
- RTEC.prolog. This is the main file.
- compiler.prolog. This is the compiler of RTEC. The event descriptions developed by the user are translated into a representation that allows for efficient reasoning.
- processSimpleFluents.prolog. This module processes and caches the intervals of simple fluents.
- processSDFluents.prolog. This module processes and caches the intervals of statically determined fluents.
- processEvents.prolog. This module processes and caches the time-points of events.
- inputModule.prolog. This module includes the 'forget' mechanism of RTEC and the processing mechanism of input entities (input events and fluents).
- utilities/interval-manipulation.prolog. This is the module of the interval manipulation constructs.
- utilities/amalgamate-periods.prolog. This file includes a predicate for period amalgamation.

##### Compilation
The user produces two files:
 - The event description.
 - The declarations of the event description (declaration of simple fluents, statically determined fluents, etc).

To compile the event description, load RTEC.prolog and invoke the following predicate:

```sh
$ Prolog> compileEventDescription(+Declarations, +InputDescription, -OutputDescription).
```

Reasoning should be performed on the compiled event description (see the third argument of compileEventDescription/3), along with the declarations (see the first argument of compileEventDescription/3).

More precisely, terminate the Prolog session in which compilation was performed, and start a new one loading the compiled event description, the declarations and the RTEC files.

# Applications & Datasets

RTEC has been used for event recogniton for:

- City transport management.
- Public space surveillance.
- Maritime surveillance.

Datasets for these applications are available from [my site](http://users.iit.demokritos.gr/~a.artikis/EC.html).

# Paper
Artikis A., Sergot M. and Paliouras G. [An Event Calculus for Event Recognition](http://dx.doi.org/10.1109/TKDE.2014.2356476). IEEE Transactions on Knowledge and Data Engineering (TKDE), 27(4):895-908, 2015.


