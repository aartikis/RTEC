#!/bin/bash

# Run tests
 for i in ./tests/*.prolog; 
 do echo "---------------------------Running test file: $i-----------------------------";
    echo "swipl -q -l $i -g runtests_swi -- $i; "
     swipl -q -l $i -g runtests_swi -- $i; 
 done

# Run allen tests
for i in ./tests/allen/*.prolog; 
do echo "---------------------------Running test file: $i-----------------------------";
    swipl -q -l $i -g runtests_swi -- $i; 
done
