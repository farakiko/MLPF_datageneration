#!/bin/bash

python submit_jobs_train.py --config config_spread_031224_fair.gun --outdir /eos/experiment/fcc/users/m/mgarciam/mlpf/CLD/train/gun_dr_log_logE_v0_290125/  --condordir /eos/experiment/fcc/users/m/mgarciam/mlpf/condor/gun_dr_log_logE_v0_290125/  --njobs 8000 --nev 100 --queue workday

