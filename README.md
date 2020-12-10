# RTEC: Run-Time Event Calculus

RTEC is an open-source [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) dialect optimised for data stream reasoning. It is written in Prolog and has been tested under [YAP](https://en.wikipedia.org/wiki/YAP_(Prolog)) and [SWI Prolog](https://www.swi-prolog.org/).

#### YAP Installation Instructions

[YAP 6.3](https://github.com/vscosta/yap-6.3) is the latest stable version of YAP; installation and execution instructions may be found in this [manual](https://www.dcc.fc.up.pt/~vsc/yap/index.html).

In case the installation of YAP fails (we have noticed this in Ubuntu 20 LTS), please download YAP 6.3 from the "threads" branch of the [repository]((https://github.com/vscosta/yap-6.3)). To do this from the command line, please type:

``` git clone -b threads https://github.com/vscosta/yap-6.3 yap```

where ```-b threads``` specifies that YAP will be downloaded from the "threads" branch.

# License

RTEC comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions; see the [GNU Lesser General Public License v3 for more details](http://www.gnu.org/licenses/lgpl-3.0.html).

# Features
- Interval-based.
- Sliding window reasoning.
- Interval manipulation constructs for non-inertial fluents.
- Caching for hierarchical knowledge bases.
- Support for out-of-order data streams.
- Indexing for handling efficiently irrelevant data.

# File Description

To run RTEC you need the files in the /src directory.

The /examples directory is **optional** and includes patterns and sample datasets for experimentation. 

# Documentation

- Artikis A., Sergot M. and Paliouras G. [An Event Calculus for Event Recognition](http://dx.doi.org/10.1109/TKDE.2014.2356476). IEEE Transactions on Knowledge and Data Engineering (TKDE), 27(4):895-908, 2015.
- Pitsikalis M., Artikis A., Dreo R., Ray C., Camossi E., and Jousselme A., [Composite Event Recognition for Maritime Monitoring.](http://cer.iit.demokritos.gr/publications/papers/2019/pitsikalis-CERMM.pdf)
In 13th International Conference on Distributed and Event-Based Systems (DEBS), pp. 163–174, 2019.
- [User manual of RTEC](https://github.com/aartikis/RTEC/blob/master/RTEC_manual.pdf).

# Applications

RTEC has been used for:
- [Maritime monitoring.](http://cer.iit.demokritos.gr/blog/applications/maritime_surveillance/)
- [Activity recognition.](http://cer.iit.demokritos.gr/blog/applications/activity_recognition/)
- [Fleet management.](http://cer.iit.demokritos.gr/blog/applications/fleet_management/)
- City transport & traffic management.


# Related Software
- [OLED](https://github.com/nkatzz/OLED): Online Learning of Event Definitions. OLED is a supervised machine learning tool for constructing Event Calculus rules, such as complex event patterns, from annotated data streams.
- [LoMRF](https://github.com/anskarl/LoMRF):  Library for Markov Logic Networks. LoMRF supports Event Calculus reasoning and learning under uncertainty.
- [oPIEC](https://github.com/Periklismant/oPIEC): Online Probabilistic Interval-Based Event Calculus. oPIEC supports Event Calculus reasoning over data streams under uncertainty.
- [Wayeb](https://github.com/ElAlev/Wayeb): Wayeb is a Complex Event Processing and Forecasting (CEP/F) engine written in Scala. It is based on symbolic automata and Markov models.


