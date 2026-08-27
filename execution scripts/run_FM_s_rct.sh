##!/bin/bash

# Directory for logs
OUTDIR="recognitionprints"
mkdir -p "$OUTDIR"


echo "Starting FM RTEC runs..."
echo "Logs will be saved in: $OUTDIR"
echo "-------------------------------------"
LOGFILE="$OUTDIR/rec_print_fm_rct.log"
CMD="./run_rtec.sh --app=fm_rct"

echo "Running: $CMD"
$CMD > "$LOGFILE"
   
echo "Finished FM (log: $LOGFILE)"
echo "-------------------------------------"

echo "All runs completed."

