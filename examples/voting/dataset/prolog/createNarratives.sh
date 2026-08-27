#!/bin/bash

#Agent_List='1000 2000 4000 8000'
Agent_List='1000' 
Seed_List='1' #'1 2 3 4 5'
Duration_List='20 40 80 160'
Start=0
End=500

for Agent in $Agent_List; do
	for Seed in $Seed_List; do
		for Duration in $Duration_List; do
			echo "Creating Narrative for ${Agent} agents, Seed ${Seed}, Voting duration ${Duration}"
			swipl -l voting_csv_data_generator.prolog -q -g "createNarrative(${Start},${End},${Agent},${Duration},${Seed}),halt."
            sort -k2 -n -t"|" ../csv/voting-${Agent}-${Seed}-${Duration}-unsrt.csv > ../csv/voting-${Agent}-${Seed}-${Duration}.csv
            rm ../csv/voting-${Agent}-${Seed}-${Duration}-unsrt.csv
		done
	done
done
