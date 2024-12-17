#!/bin/bash

# Author: Periklis Mantenoglou
# Compile the event description of one of the supported applications.
if [[ "$OSTYPE" == "win32" ]] || [[ "OSTYPE" == "msys" ]]; then 
    sep="\\"
else
    sep="/"
fi

. $(dirname "$0")${sep}utils.sh

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
    --definition-optimisation)
      definition_optimisation="true"
      ;;
  esac
done

[ -z $no_events ] && events_flag="withEvents" || events_flag="withoutEvents" 
[ -z $definition_optimisation ] && optimisation_flag="withoutOptimisation" || optimisation_flag="withOptimisation" 

[ -z $event_description ] && exit_func "noEventDescriptionCompiler"
#AppPath=../examples/${Application}
[ ! -z $dependency_graph ] && [ -z $dependency_graph_directory ] && exit_func "noDependencyGraphDirectoryCompiler"

#GraphsPath=${AppPath}/resources/graphs
#mkdir -p ${GraphsPath}
if [ ! -z $dependency_graph ]; then 
	dependency_graph_dot_file=${dependency_graph_directory}${sep}dependency_graph.dot
	dependency_graph_png_file=${dependency_graph_directory}${sep}dependency_graph.png
fi

Compiler=..${sep}src${sep}compiler.prolog

if [ -z $dependency_graph ]
then
	swipl -l ${Compiler} -g "compileED('${event_description}',$optimisation_flag),halt." # && echo "Compiled event description: ${event_description}."
else 
	swipl -l ${Compiler} -g "compileED('${event_description}','${dependency_graph_dot_file}',$events_flag,$optimisation_flag),halt." # && echo "Compiled event description: ${event_description}."
	dot -o $dependency_graph_png_file -T png $dependency_graph_dot_file # && echo "Dependency graph: ${dependency_graph_png_file}."
fi

