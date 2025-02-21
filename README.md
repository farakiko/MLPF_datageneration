In order to use the repo:
`git clone https://github.com/key4hep/CLDConfig/tree/main/CLDConfig`
update the path in `scripts/run_sequence_CLD_train.sh`. 

The script `script_create_dataset_train_gun.sh` can be used to create condor jobs, by default for the gun there are 100 events, configure in the config. 
The gun config in `gun/config_files/*.gun` includes:
`npart_range 10,15 %range of number of particles`
`eta_range -0.5,0.5   %eta range`
`mom_range 0.5,50  %momentum range`
`drmax 0.5  %if dr max is larger than 0 it generates particles with sqrt((eta)**2+(phi)**2)<drmax, if it's 0 then it create random angles `
`pid_list 211,-211,130,130,2112,2112,-2112,-2112,22,22,22,22,22,22,11,-11,11,-11,11,-11,13,-13,13,-13,13,-13,-321,321,2212,-2212 %pdg of particles (they need to be available in the gun definition otherwise the mass is 0)`
`nevents 100`

The script `script_create_dataset_train_ttbar.sh` can be used to create condor jobs for `p8_ee_tt_ecm365` events, by default there are 100 events, configure in the config. 