#!/bin/bash


for i in ./tests/*.prolog; 
do echo "---------------------------Running test file: $i-----------------------------";
    swipl -q -l $i -g runtests_swi -- $i; 
done
