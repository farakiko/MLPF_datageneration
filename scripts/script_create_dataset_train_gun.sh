#!/bin/bash

python3 submit_jobs_train.py --sample gun --config config_spread_031224_fair.gun --outdir /eos/user/f/fmokhtar/mlpf/CLD/Feb21/  --condordir /eos/user/f/fmokhtar/mlpf/condor/Feb21/gun/ --njobs 4 --nev 2 --queue workday

