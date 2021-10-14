#!/bin/bash

### RTEC installation steps ###

## Create RTECv1 package by changing the file structure *temporarily*.

mkdir RTECv1
touch RTECv1/__init__.py
mv src RTECv1
mv execution\ scripts RTECv1

## Install RTEC via setuptools.
pip3 install .

## Add the installation path of RTEC to $PATH. 
echo $PATH
NewPath=`python3 -m site --user-base`/bin #$(dirname $(which RTEC))
echo $NewPath
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
echo $PATH

## Revert the changes in the file structure.
mv RTECv1/src .
mv RTECv1/execution\ scripts .
rm RTECv1/__init__.py
rmdir RTECv1