# Assumptions

RTEC computes all the maximal intervals of a fluent, and no other interval, when:

- The window size and the step remain constant.
- The delays in the stream may be tolerated by the window size.
- The intervals ending before the window are not revised.
- There are no cyclic dependencies with statically determined fluents.

For more information on the windowing mechanism of RTEC, see Section 3.2 of the [manual of RTEC](../RTEC_manual.pdf).

[🠔](contents.md)
