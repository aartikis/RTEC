# Assumptions

RTEC computes all the maximal intervals of a fluent, and no other interval, when:

- The window size and the step remain constant.
- The delays in the stream may be tolerated by the window size.
- The computed intervals ending before the window are not revised.
- There are no cyclic dependencies with statically determined fluents.

[🠔](contents.md)
