#!/bin/bash

TESTSPATH="src"
TESTSFILE='tests.prolog'

echo "---------------------------Data Loader Tests-----------------------------";
echo "------------------------------SWI Prolog:-----------------------------";
cd $TESTSPATH
swipl -q -l $TESTSFILE -g "run_tests, halt"
