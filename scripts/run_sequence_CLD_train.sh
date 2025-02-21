#!/bin/bash

####################################################################################################
HOMEDIR=${1} # path to where it's ran from e.g. /afs/cern.ch/user/f/fmokhtar/MLPF_datageneration
GUNCARD=${2}  
NEV=${3}
SEED=${4}
OUTPUTDIR=${5}
DIR=${6}
SAMPLE=${7} # can be "gun" or "p8_ee_tt_ecm365"
CLDGEO=${8} # default is CLD_o2_v06 (CLD+ARC is CLD_o3_v01 https://github.com/key4hep/k4geo/blob/main/FCCee/CLD/compact/CLD_o3_v01/CLD_o3_v01.xml)

if [ -z "$CLDGEO" ]; then
    echo "Will use default CLD geometry version CLD_o2_v06"
    CLDGEO=CLD_o2_v06
else
    echo "Will use CLD geometry version $CLDGEO"
fi

PATH_CLDCONFIG=/afs/cern.ch/user/f/fmokhtar/MLPF_datageneration/CLDConfig/CLDConfig

####################################################################################################

mkdir -p ${DIR}/${SEED}
cd ${DIR}/${SEED}


wrapperfunction() {
    source /cvmfs/sw.hsf.org/key4hep/setup.sh -r 2025-01-28
}
wrapperfunction



# Build gun 
if [[ "${SAMPLE}" == "gun" ]] 
then 
    cp -r ${HOMEDIR}/gun/gun.cpp .
    cp -r ${HOMEDIR}/gun/CMakeLists.txt . 
    PATH_GUN_CONFIG=${HOMEDIR}/gun/config_files/${GUNCARD} 
    mkdir build install
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=../install
    make install -j 8
    cd ..
    ./build/gun ${PATH_GUN_CONFIG} 
fi

if [[ "${SAMPLE}" == "p8_ee_tt_ecm365" ]]
then
    xrdcp ${HOMEDIR}/pythia/${SAMPLE}.cmd card.cmd
    echo "Random:seed=${SEED}" >> card.cmd
    cat card.cmd
    k4run ${HOMEDIR}/pythia/pythia.py -n $NEV --Dumper.Filename out.hepmc --Pythia8.PythiaInterface.pythiacard card.cmd
    cp out.hepmc events.hepmc
fi



ddsim --compactFile $K4GEO/FCCee/CLD/compact/$CLDGEO/$CLDGEO.xml --outputFile out_sim_edm4hep.root --steeringFile ${PATH_CLDCONFIG}/cld_steer.py --inputFiles events.hepmc --numberOfEvents ${NEV} --random.seed ${SEED}

# copy large input files via xrootd (recommended)
xrdcp -r ${PATH_CLDCONFIG}/* .
k4run CLDReconstruction.py -n ${NEV}  --inputFiles out_sim_edm4hep.root --outputBasename out_reco



mkdir -p ${OUTPUTDIR}
xrdcp ${DIR}/${SEED}/out_reco_REC.edm4hep.root ${OUTPUTDIR}/reco_${SAMPLE}_${SEED}.root
