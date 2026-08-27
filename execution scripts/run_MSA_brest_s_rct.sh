#!/bin/bash

# Directory for logs
OUTDIR="recognitionprints"
mkdir -p "$OUTDIR"

# Array of vessel sizes
FRAC=(1000 2000 3000 4000 5000)

echo "Starting maritime RTEC runs..."
echo "Logs will be saved in: $OUTDIR"
echo "-------------------------------------"

for W in "${FRAC[@]}"; do
    LOGFILE="$OUTDIR/rec_print_maritime_fixed${W}_rct.log"
    CMD="./run_rtec.sh --app=maritime_${W}"

    echo "Running: $CMD"
    $CMD > "$LOGFILE"

    
    echo "Finished maritime_${W} (log: $LOGFILE)"

    echo "-------------------------------------"
done

echo "All runs completed."

