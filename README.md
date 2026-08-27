# RTEC_s^RCT: Run-Time Event Calculus

**RTEC_s^RCT** is an extension of RTEC, an open-source [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) dialect optimised for data stream reasoning, with sequence support.  
It is written in Prolog and has been tested under [SWI-Prolog](https://www.swi-prolog.org/) on Linux.

---

# License

RTEC_s^RCT comes with **ABSOLUTELY NO WARRANTY**.  
This is free software, and you are welcome to redistribute it under certain conditions; see the  
[GNU Lesser General Public License v3](http://www.gnu.org/licenses/lgpl-3.0.html) for more details.

---

# Related Software

- [RTEC](https://github.com/aartikis/RTEC): Original version of RTEC.
- [iRTEC](https://github.com/eftsilio/Incremental_RTEC): Incremental RTEC. iRTEC supports incremental reasoning, efficiently handling delays and retractions in data streams.
- [oPIEC](https://github.com/Periklismant/oPIEC): Online Probabilistic Interval-Based Event Calculus. Supports reasoning over data streams under uncertainty.
- [Wayeb](https://github.com/ElAlev/Wayeb): Complex Event Processing and Forecasting (CEP/F) engine written in Scala, based on symbolic automata and Markov models.

---

# Experiments

## Dataset setup

1. Download the maritime, voting and fleet managements datasets using the links in files:
```text
   RTECsRCT/examples/{maritime,voting,fleet_management}/dataset/csv/data.txt
```  


2. Place the CSV files in:
```text
   RTECsRCT/examples/{maritime,voting,fleet_management}/dataset/csv/
```

---

### Running experiments

Navigate to:
```text
/RTECsRCT/execution_scripts
```

Then run the appropriate script:

- **MSA-synth**
  - `run_MSA_synth_s_rct.sh` (for RTEC_s^RCT)
  - `run_MSA_synth_s.sh` (for RTEC_s)

- **MSA-Brest**
  - `run_MSA_brest_s_rct.sh` (for RTEC_s^RCT)
  - `run_MSA_brest_s.sh` (for RTEC_s)

- **MAS-Voting**
  - `run_voting_s_rct.sh` (for RTEC_s^RCT)
  - `run_voting_s.sh` (for RTEC_s)
  
- **FM**
  - `run_FM_s_rct.sh` (for RTEC_s^RCT)
  - `run_FM_s.sh` (for RTEC_s)

---

## Results

Results can be found in:
```text
/RTECsRCT/examples/{maritime,voting,fleet_management}/results/
```

---

## Summarising results

After running the maritime and voting experiments, call the extraction script from the corresponding results folder to get a summary of all the experiments.

Example:
```text
/RTECsRCT/examples/maritime/results/synth/extract_data.sh
```

---

## Computing eagerness

To compute avg eagerness for an experiment:

1. Navigate to:
   ```text
   /RTECsRCT/execution_scripts/
   ```

2. Run `compute.py` on the results and dataset (call with `--help` for help). Note: For fleet management, to exclude long vehicle gaps run with the --fm flag.

### Example (MAS 1000 agents - sequence length 20 timepoints)

```bash
python3 compute.py \
  --rec ../../examples/voting/results/1000_20/log-swi-10-10-csv-file-recognised-intervals.txt \
  --dt  ../../examples/voting/dataset/csv/voting-1000-1-20.csv
```


