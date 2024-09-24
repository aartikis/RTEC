#!/bin/bash
TestsPath="tests_allen.prolog"
swipl -l $TestsPath -g "run_tests,halt."

