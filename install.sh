#!/bin/bash
### RTEC installation steps ###

## Create RTECv2 package by changing the file structure *temporarily*.

mkdir RTECv2
touch RTECv2/__init__.py
mv src RTECv2
mv execution\ scripts RTECv2/scripts

## Install RTEC via setuptools.
machine="$(uname -s)"
if [[ "$machine" == "Linux"* ]] || [[ "$machine" == "Darwin"* ]]; then
	pip3 install .
elif [[ "$machine" == "CYGWIN"* ]] || [[ "$machine" == "MINGW"* ]]; then
	py -m pip install .
fi

## Add the installation path of RTEC to $PATH. 
#echo $PATH
#NewPath=`python3 -m site --user-base`/bin
if [[ "$machine" == "Linux"* ]] || [[ "$machine" == "Darwin"* ]];  then
	NewPath=`python3 -m site --user-base`/bin
elif [[ "$machine" == "CYGWIN"* ]] || [[ "$machine" == "MINGW"* ]]; then
	NewPath=`py -m site --user-base`/bin
fi

#echo $NewPath
case :$PATH:
	in *:$NewPath:*) ;;
		*) export PATH=$PATH:$NewPath;;
esac
#if [[ $PATH == ?(*:)$NewPath?(:*) ]]; then
#	echo "Path already present."
#else
#	export PATH=$PATH:$NewPath
#	echo "Path updated."
#fi
#echo $PATH

## Revert the changes in the file structure.
mv RTECv2/src .
mv RTECv2/scripts execution\ scripts
rm RTECv2/__init__.py
rmdir RTECv2
