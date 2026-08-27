#!/bin/bash

# Directory for logs
OUTDIR="recognitionprints"
mkdir -p "$OUTDIR"

# Array of window sizes
FRAC=(1000 2000 3000 4000 5000)


echo "Starting maritime RTEC runs..."
echo "Logs will be saved in: $OUTDIR"
echo "-------------------------------------"

for W in "${FRAC[@]}"; do
    LOGFILE="$OUTDIR/rec_print_maritime_fixed${W}_o.log"
    CMD="./run_rtec.sh --rtecs --app=maritime_${W}_o"

    echo "Running: $CMD"
    $CMD > "$LOGFILE"

    
    echo "Finished maritime_${W} (log: $LOGFILE)"

    echo "-------------------------------------"
done

echo "All runs completed."

