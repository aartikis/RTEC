#!/bin/bash


for i in ./tests/*.prolog; 
do echo "---------------------------Running test file: $i-----------------------------";
yap -quiet -l $i -g runtests_yap -- $i; 
done
