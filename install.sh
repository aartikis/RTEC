#!/bin/bash

### RTEC installation steps ###

## Create RTECv1 package by changing the file structure *temporarily*.

mkdir RTECv1
touch RTECv1/__init__.py
mv src RTECv1
mv execution\ scripts RTECv1

## Install RTEC via setuptools.
machine="$(uname -s)"
if [[ "$machine" == "Linux"* ]] || [[ "$machine" == "Darwin"* ]]; then
	pip3 install .
elif [[ "$machine" == "CYGWIN"* ]] || [[ "$machine" == "MINGW"* ]]; then
	py -m pip install .
fi

## Add the installation path of RTEC to $PATH. 
if [[ "$machine" == "Linux"* ]] || [[ "$machine" == "Darwin"* ]];  then
	NewPath=`python3 -m site --user-base`/bin
elif [[ "$machine" == "CYGWIN"* ]] || [[ "$machine" == "MINGW"* ]]; then
	NewPath=`py -m site --user-base`/bin
fi

case :$PATH:
	in *:$NewPath:*) ;;
		*) export PATH=$PATH:$NewPath;;
esac
#if [[ "$PATH" == ?(*:)"$NewPath"?(:*) ]]; then
#	echo "Path already present."
#else
#	export PATH=$PATH:$NewPath
#	echo "Path updated."
#fi
#echo $PATH

## Revert the changes in the file structure.
mv RTECv1/src .
mv RTECv1/execution\ scripts .
rm RTECv1/__init__.py
rmdir RTECv1