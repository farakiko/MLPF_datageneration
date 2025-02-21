#!/bin/bash

python3 submit_jobs_train.py --sample p8_ee_tt_ecm365 --cldgeo CLD_o3_v01 --outdir /eos/user/f/fmokhtar/mlpf/CLD/Feb21/ --condordir /eos/user/f/fmokhtar/mlpf/condor/Feb21/p8_ee_tt_ecm365/ --njobs 10 --nev 100 --queue workday

