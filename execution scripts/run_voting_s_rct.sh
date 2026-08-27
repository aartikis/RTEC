#!/bin/bash

a_values=(1000)
b_values=(20 40 80 160)

filename="../examples/voting/resources/patterns/rules.prolog"

cp "$filename" "${filename}.bak"

for a in "${a_values[@]}"; do
  for b in "${b_values[@]}"; do
    
      
    echo "Preparing for voting_${a}_${b}"

    # Restore original before replacing
    cp "${filename}.bak" "$filename"

    sed -i "s/fi(status(M)=proposed, status(M)=null, .*)/fi(status(M)=proposed, status(M)=null, ${b})/" "$filename"
    sed -i "s/fi(status(M)=voting, status(M)=voted, .*)/fi(status(M)=voting, status(M)=voted, ${b})/" "$filename"
    sed -i "s/fi(status(M)=voted, status(M)=null, .*)/fi(status(M)=voted, status(M)=null, ${b})/" "$filename"

    # Run command  
    app_name="voting_${a}_${b}"
    echo "Running: ./run_rtec.sh --app=${app_name}" 
    ./run_rtec.sh --app="${app_name}"  > ./recognitionprints/rec_print_${app_name}.log
  done
done

mv "${filename}.bak" "$filename"
