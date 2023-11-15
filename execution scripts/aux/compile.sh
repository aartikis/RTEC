#!/bin/bash


# Author: Periklis Mantenoglou
# Compile the event description of one of the supported applications.

. $(dirname "$0")/utils.sh

for arg in $@ ; do
  case "$arg" in
	--help)
	  help
	  exit 0
	  ;;
	--event-description=*)
	  event_description="${arg#*=}"
	  ;;
    --dependency-graph)
      dependency_graph="true"
      ;;
    --dependency-graph-directory=*)
      dependency_graph_directory="${arg#*=}"
      ;;
    --no-events)
      no_events="true"
      ;;
  esac
done

[ -z $event_description ] && exit_func "noEventDescriptionCompiler"
#AppPath=../examples/${Application}
[ ! -z $dependency_graph ] && [ -z $dependency_graph_directory ] && exit_func "noDependencyGraphDirectoryCompiler"

#GraphsPath=${AppPath}/resources/graphs
#mkdir -p ${GraphsPath}
if [ ! -z $dependency_graph ]; then 
	dependency_graph_dot_file=${dependency_graph_directory}/dependency_graph.dot
	dependency_graph_png_file=${dependency_graph_directory}/dependency_graph.png
fi

Compiler=../src/compiler.prolog

if [ -z $dependency_graph ]
then
	swipl -l ${Compiler} -g "compileED('${event_description}'),halt." # && echo "Compiled event description: ${event_description}."
elif [ -z ${no_events} ]
then
	swipl -l ${Compiler} -g "compileED('${event_description}','${dependency_graph_dot_file}',withEvents),halt." # && echo "Compiled event description: ${event_description}."
	dot -o $dependency_graph_png_file -T png $dependency_graph_dot_file # && echo "Dependency graph: ${dependency_graph_png_file}."
else
	swipl -l ${Compiler} -g "compileED('${event_description}','${dependency_graph_dot_file}',withoutEvents),halt." # && echo "Compiled event description: ${event_description}."
	dot -o $dependency_graph_png_file -T png $dependency_graph_dot_file # && echo "Dependency graph without input entities: ${dependency_graph_png_file}."
fi 

