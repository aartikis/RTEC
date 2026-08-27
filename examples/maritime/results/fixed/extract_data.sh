#!/bin/bash

# Define the list of b values
#b_values=(20 40 60 80 100)
b_values=(1000 2000 3000 4000 5000)

# Output file
data_file_srct="data_rtecs_rct.csv"
times_file_srct="times_rtecs_rct.csv"

data_file_s="data_rtecs.csv"
times_file_s="times_rtecs.csv"




# Print header
echo "seq,retained_entities_avg,retained_entities_std,input_entities_avg,input_entities_std" > $data_file_srct 
echo "seq,retained_entities_avg,retained_entities_std,input_entities_avg,input_entities_std" > $data_file_s 

echo "seq,rec_avg,rec_std" > $times_file_srct 
echo "seq,rec_avg,rec_std" > $times_file_s 

# Loop through each b
for b in "${b_values[@]}"; do

  file=$(ls ${b}/log-swi-*-csv-file-log.txt 2>/dev/null |head -n 1)

  if [[ -f "$file" ]]; then
    retained_avg=$(grep "Retained entities (average number of intervals)" "$file" | awk -F':' '{print $2}' | xargs)
    retained_std=$(grep "Retained entities (standard deviation)" "$file" | awk -F':' '{print $2}' | xargs)
    input_avg=$(grep "Input Entities average" "$file" | awk -F':' '{print $2}' | xargs)
    input_std=$(grep "Input Entities standard deviation" "$file" | awk -F':' '{print $2}' | xargs)
    recognition_avg=$(grep "Recognition Time average (ms)" "$file" | awk -F':' '{print $2}' | xargs)
    recognition_std=$(grep "Recognition Time standard deviation (ms)" "$file" | awk -F':' '{print $2}' | xargs)

    echo "$b,$recognition_avg,$recognition_std" >> $times_file_srct
    echo "$b,$retained_avg,$retained_std,$input_avg,$input_std" >> $data_file_srct
  else
    echo "Warning: File not found -> $file" >&2
  fi
  
  file=$(ls ${b}_o/log-swi-*-csv-file-log.txt 2>/dev/null |head -n 1)

  if [[ -f "$file" ]]; then
    retained_avg=$(grep "Retained entities (average number of intervals)" "$file" | awk -F':' '{print $2}' | xargs)
    retained_std=$(grep "Retained entities (standard deviation)" "$file" | awk -F':' '{print $2}' | xargs)
    input_avg=$(grep "Input Entities average" "$file" | awk -F':' '{print $2}' | xargs)
    input_std=$(grep "Input Entities standard deviation" "$file" | awk -F':' '{print $2}' | xargs)
    recognition_avg=$(grep "Recognition Time average (ms)" "$file" | awk -F':' '{print $2}' | xargs)
    recognition_std=$(grep "Recognition Time standard deviation (ms)" "$file" | awk -F':' '{print $2}' | xargs)

    echo "$b,$recognition_avg,$recognition_std" >> $times_file_s
    echo "$b,$retained_avg,$retained_std,$input_avg,$input_std" >> $data_file_s
  else
    echo "Warning: File not found -> $file" >&2
  fi

done

