#!/bin/bash

# Directory for logs
OUTDIR="recognitionprints"
mkdir -p "$OUTDIR"


echo "Starting FM RTEC runs..."
echo "Logs will be saved in: $OUTDIR"
echo "-------------------------------------"
LOGFILE="$OUTDIR/rec_print_fm_o.log"
CMD="./run_rtec.sh --rtecs --app=fm_orig"

echo "Running: $CMD"
$CMD > "$LOGFILE"
   
echo "Finished FM (log: $LOGFILE)"
echo "-------------------------------------"

echo "All runs completed."

