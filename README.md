# RTEC
RTEC: Run-Time Event Calculus.

RTEC is an extension of the [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) that supports highly-scalable stream processing. It is written in Prolog and has been tested under [YAP 6.2](http://www.dcc.fc.up.pt/~vsc/Yap/).

# License

RTEC comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions; see the [GNU Lesser General Public License v3 for more details](http://www.gnu.org/licenses/lgpl-3.0.html).

# Features
- Interval-based.
- Sliding window reasoning.
- Interval manipulation constructs for non-inertial fluents.
- Caching for hierarchical knowledge bases.
- Support for out-of-order data streams.
- Indexing for robustness to irrelevant data.

# File Description

To run RTEC you need the files in the /src directory.

The /examples directory is **optional** and includes CE patterns and sample datasets from the applications of RTEC.  

# Documentation

- User manual of RTEC.
- Artikis A., Sergot M. and Paliouras G. [An Event Calculus for Event Recognition](http://dx.doi.org/10.1109/TKDE.2014.2356476). IEEE Transactions on Knowledge and Data Engineering (TKDE), 27(4):895-908, 2015.

# Applications

RTEC has been used for event recogniton for:
- City transport & traffic management.
- Public space surveillance.
- Maritime surveillance.

Complete datasets for some of these applications are available from [my site](http://users.iit.demokritos.gr/~a.artikis/EC.html).

# Related Software
- [OLED](https://github.com/nkatzz/OLED): Online Learning of Event Definitions. OLED automatically constructs Event Calculus rules, such as complex event patterns, from annotated data streams.
- [LoMRF](https://github.com/anskarl/LoMRF):  Library for Markov Logic Networks. LoMRF supports Event Calculus reasoning under uncertainty.
- [ScaRTEC](https://github.com/ioannis-kon/ScaRTEC):  A Scala implementation of RTEC.


