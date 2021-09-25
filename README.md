# RTEC: Run-Time Event Calculus

RTEC is an open-source [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) dialect optimised for data stream reasoning. It is written in Prolog and has been tested under [SWI-Prolog](https://www.swi-prolog.org/) and [YAP](https://en.wikipedia.org/wiki/YAP_(Prolog)) in Linux, MacOS and Windows.

# License

RTEC comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions; see the [GNU Lesser General Public License v3 for more details](http://www.gnu.org/licenses/lgpl-3.0.html).

# Documentation Contents

1. [Features](docs/features.md)
2. [Applications](docs/applications.md)
    1. [Activity Recognition](examples/caviar/README.md)
    2. [City Transport & Traffic Management.](examples/ctm/README.md)
    3. [A Toy Example](examples/toy/README.md) 
3. [File Description](docs/file-description.md)
4. Running RTEC in Prolog
    1. [Requirements](docs/prolog-requirements.md)
    2. [Parameter Tuning](docs/prolog-parameters.md)
    3. [Running an Existing Application](docs/prolog-existing-apps.md) 
      \(Note: the patterns are already compiled; for the compilation process see Section 4.iv\)
    4. [Running a New Application](docs/prolog-new-apps.md) 
5. [Feedback](docs/feedback.md)
6. [Documentation](docs/documentation.md)

# Related Software
- [iRTEC](https://github.com/eftsilio/Incremental_RTEC): Incremental RTEC. iRTEC supports incremental reasoning, handling efficiently the delays and retractions in data streams.
- [oPIEC](https://github.com/Periklismant/oPIEC): Online Probabilistic Interval-Based Event Calculus. oPIEC supports Event Calculus reasoning over data streams under uncertainty.
- [OLED](https://github.com/nkatzz/ORL): Online Learning of Event Definitions. OLED is a supervised machine learning tool for constructing Event Calculus rules, such as complex event patterns, from annotated data streams.
- [LoMRF](https://github.com/anskarl/LoMRF):  Library for Markov Logic Networks. LoMRF supports Event Calculus reasoning and learning under uncertainty.
- [Wayeb](https://github.com/ElAlev/Wayeb): Wayeb is a Complex Event Processing and Forecasting (CEP/F) engine written in Scala. It is based on symbolic automata and Markov models.

