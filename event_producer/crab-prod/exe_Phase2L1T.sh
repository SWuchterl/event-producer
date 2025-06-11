#!/bin/bash -x


# https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_setup/TSG-Phase2Spring24DIGIRECOMiniAOD-00107
# https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_setup/TSG-Phase2Spring24wmLHEGS-00038
# https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_setup/TSG-Phase2Spring24wmLHEGS-00003

## NOTE: difference made w.r.t. common exe script
## 3. seeds have width 100

JOBINDEX=${1##*=} # hard coded by crab
NEVENTS=${2##*=}  # ordered by crab.py script
NTHREAD=${3##*=}  # ordered by crab.py script
NAME=${4##*=}     # ordered by crab.py script
BEGINSEED=${5##*=}

LUMISTART=$((${BEGINSEED} + ${JOBINDEX}))
EVENTSTART=$(((${BEGINSEED} + ${JOBINDEX}) * NEVENTS))
SEED=$((((${BEGINSEED} + ${JOBINDEX})) * NTHREAD * 4 + 1001)) # Space out seeds; Madgraph concurrent mode adds idx(thread) to random seed

WORKDIR=$(pwd)

############ LHEGEN ############
export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
export RELEASE=CMSSW_14_0_21
if [ -r $RELEASE/src ]; then
  echo release $RELEASE already exists
else
  scram p CMSSW $RELEASE
fi
cd $RELEASE/src
eval $(scram runtime -sh)

# copy the fragment
mkdir -pv $CMSSW_BASE/src/Configuration/GenProduction/python
cp $WORKDIR/inputs/${NAME}.py $CMSSW_BASE/src/Configuration/GenProduction/python/${NAME}.py
sed "s@__GRIDPACKDIR__@$WORKDIR@g" -i $CMSSW_BASE/src/Configuration/GenProduction/python/${NAME}.py
if [ ! -f "$CMSSW_BASE/src/Configuration/GenProduction/python/${NAME}.py" ]; then
  echo "Fragment copy failed"
  exit 1
fi
scram b -j $NTHREAD
eval $(scram runtime -sh)

cd $WORKDIR

# [NOTE] need to specify seeds otherwise gridpacks will be chosen from the same routine!!
# remember to identify process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(${SEED})"!!
# cmsDriver.py Configuration/GenProduction/python/${NAME}.py \
#   --python_filename "RunIISummer20UL16wmLHE_${NAME}_cfg.py" \
#   --eventcontent RAWSIM,LHE \
#   --customise Configuration/DataProcessing/Utils.addMonitoring \
#   --datatier GEN,LHE \
#   --fileout "file:RunIISummer20UL16wmLHE_$NAME_$JOBINDEX.root" \
#   --conditions 106X_mcRun2_asymptotic_v13 \
#   --beamspot Realistic25ns13TeV2016Collision \
#   --step LHE,GEN \
#   --geometry DB:Extended \
#   --era Run2_2016 \
#   --nThreads $NTHREAD \
#   --customise_commands "process.source.numberEventsInLuminosityBlock=cms.untracked.uint32(1000)\\nprocess.source.firstLuminosityBlock=cms.untracked.uint32(${LUMISTART})\\nprocess.source.firstEvent=cms.untracked.uint64(${EVENTSTART})\\nprocess.RandomNumberGeneratorService.externalLHEProducer.initialSeed=${SEED}" \
#   --mc \
#   -n $NEVENTS || exit $?

cmsDriver.py Configuration/GenProduction/python/${NAME}.py \
  --eventcontent FEVTDEBUG,LHE \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
  --datatier GEN-SIM,LHE \
  --conditions 140X_mcRun4_realistic_v4 \
  --beamspot HLLHC14TeV \
  --customise_commands "process.source.numberEventsInLuminosityBlock=cms.untracked.uint32(1000)\\nprocess.source.firstLuminosityBlock=cms.untracked.uint32(${LUMISTART})\\nprocess.source.firstEvent=cms.untracked.uint64(${EVENTSTART})\\nprocess.RandomNumberGeneratorService.externalLHEProducer.initialSeed=${SEED}" \
  --step LHE,GEN,SIM \
  --geometry Extended2026D110 \
  --era Phase2C17I13M9 \
  --python_filename TSG-Phase2Spring24wmLHEGS-00038_${NAME}_cfg.py \
  --fileout file:TSG-Phase2Spring24wmLHEGS-00038_$NAME_$JOBINDEX.root \
  --nThreads $NTHREAD \
  --nStreams 2 \
  --mc \
  -n $NEVENTS || exit $?

  # --number 100 \
  # --number_out 100 \
  # --nStreams 2 \
  # --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(${SEED})" \

############ SIM ############
export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
export RELEASE=CMSSW_14_0_9
if [ -r $RELEASE/src ]; then
  echo release $RELEASE already exists
else
  scram p CMSSW $RELEASE
fi
cd $RELEASE/src
eval $(scram runtime -sh)
cd $WORKDIR

# cmsDriver.py \
#   --python_filename "RunIISummer20UL16SIM_${NAME}_cfg.py" \
#   --eventcontent RAWSIM \
#   --customise Configuration/DataProcessing/Utils.addMonitoring \
#   --datatier GEN-SIM \
#   --fileout "file:RunIISummer20UL16SIM_$NAME_$JOBINDEX.root" \
#   --conditions 106X_mcRun2_asymptotic_v13 \
#   --beamspot Realistic25ns13TeV2016Collision \
#   --step SIM \
#   --geometry DB:Extended \
#   --filein "file:RunIISummer20UL16wmLHE_$NAME_$JOBINDEX.root" \
#   --era Run2_2016 \
#   --runUnscheduled \
#   --mc \
#   --nThreads $NTHREAD \
#   -n $NEVENTS || exit $?

cmsDriver.py --eventcontent FEVTDEBUGHLT \
  --pileup 'AVE_200_BX_25ns' \
  --customise SLHCUpgradeSimulations/Configuration/aging.customise_aging_1000,SimGeneral/MixingModule/customiseStoredTPConfig.higherPtTP,Configuration/DataProcessing/Utils.addMonitoring \
  --datatier GEN-SIM-DIGI-RAW \
  --conditions 140X_mcRun4_realistic_v4 \
  --customise_commands "process.FEVTDEBUGHLToutput.outputCommands.append('keep *_l1tSC8PFL1PuppiCorrectedEmulator_*_HLT')" \
  --step DIGI:pdigi_valid,L1TrackTrigger,L1,DIGI2RAW,HLT:@relval2026 \
  --geometry Extended2026D110 \
  --era Phase2C17I13M9 \
  --python_filename TSG-Phase2Spring24GENSIMDIGIRAW-00038_${NAME}_cfg.py \
  --fileout file:TSG-Phase2Spring24GENSIMDIGIRAW-00038_$NAME_$JOBINDEX.root \
  --filein file:TSG-Phase2Spring24wmLHEGS-00038_$NAME_$JOBINDEX.root \
  --pileup_input "dbs:/MinBias_TuneCP5_14TeV-pythia8/Phase2Spring24GS-140X_mcRun4_realistic_v4-v1/GEN-SIM" \
  --nThreads $NTHREAD \
  --nStreams 2 \
  --mc \
  -n $NEVENTS || exit $?

  # --number 100 \
  # --number_out 100 \
  # --nStreams 2 \
  # --runUnscheduled \

#########

cmsDriver.py \
  --eventcontent MINIAODSIM \
  --customise SLHCUpgradeSimulations/Configuration/aging.customise_aging_1000,Configuration/DataProcessing/Utils.addMonitoring \
  --datatier GEN-SIM-DIGI-RAW-MINIAOD \
  --inputCommands "keep *" \
  --conditions 140X_mcRun4_realistic_v4 \
  --customise_commands "process.MINIAODSIMoutput.outputCommands.append('keep *_*_*_HLT'); process.MINIAODSIMoutput.outputCommands.append('keep *_*_*_SIM');" \
  --step RAW2DIGI,RECO,RECOSIM,PAT \
  --geometry Extended2026D110 \
  --nThreads $NTHREAD \
  --nStreams 2 \
  --era Phase2C17I13M9 \
  --python_filename TSG-Phase2Spring24DIGIRECOMiniAOD-00038_${NAME}_cfg.py \
  --fileout file:TSG-Phase2Spring24DIGIRECOMiniAOD-00038_$NAME_$JOBINDEX.root \
  --filein file:TSG-Phase2Spring24GENSIMDIGIRAW-00038_$NAME_$JOBINDEX.root \
  --mc \
  -n $NEVENTS || exit $?


  # --number 100 \
  # --number_out 100 \
  # --no_exec \

############ MiniAODv2 ############
# export SCRAM_ARCH=slc7_amd64_gcc700
# source /cvmfs/cms.cern.ch/cmsset_default.sh
# export RELEASE=CMSSW_10_6_25
# if [ -r $RELEASE/src ]; then
#   echo release $RELEASE already exists
# else
#   scram p CMSSW $RELEASE
# fi
# cd $RELEASE/src
# eval $(scram runtime -sh)
# cd $WORKDIR

## for the last step, needs to run with -j FrameworkJobReport.xml
# cmsDriver.py \
#   --python_filename "RunIISummer20UL16MINIAODSIM_${NAME}_cfg.py" \
#   --eventcontent MINIAODSIM \
#   --customise Configuration/DataProcessing/Utils.addMonitoring \
#   --datatier MINIAODSIM \
#   --filein "file:RunIISummer20UL16RECO_$NAME_$JOBINDEX.root" \
#   --fileout file:mini.root \
#   --conditions 106X_mcRun2_asymptotic_v17 \
#   --step PAT \
#   --procModifiers run2_miniAOD_UL \
#   --geometry DB:Extended \
#   --era Run2_2016 \
#   --runUnscheduled \
#   --no_exec \
#   --nThreads $NTHREAD \
#   --mc \
#   -n $NEVENTS

#################################################################
# runInputs
#################################################################
export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
export RELEASE=CMSSW_15_1_0_pre1
if [ -r $RELEASE/src ]; then
  echo release $RELEASE already exists
else
  scram p CMSSW $RELEASE
fi
cd $RELEASE/src
eval $(scram runtime -sh)

# git cms-checkout-topic -u CMS-L1T-Jet-Tagging:15_1_pre1_L1TSC4NGJetTagger

# copy the inputs fragment
mkdir -pv $CMSSW_BASE/src/Configuration/GenProduction/python
cp $WORKDIR/inputs/runInputs.py $CMSSW_BASE/src/Configuration/GenProduction/python/runInputs.py
# sed "s@__GRIDPACKDIR__@$WORKDIR@g" -i $CMSSW_BASE/src/Configuration/GenProduction/python/runInputs.py
if [ ! -f "$CMSSW_BASE/src/Configuration/GenProduction/python/runInputs.py" ]; then
  echo "Fragment copy failed"
  exit 1
fi
scram b -j $NTHREAD
eval $(scram runtime -sh)

cd $WORKDIR

# cmsRun Configuration/GenProduction/python/runInputs.py \
#   outputFile=TSG-Phase2Spring24_inputs_$NAME_$JOBINDEX.root \
#   nThreads=$NTHREAD \
#   inFilename=file:TSG-Phase2Spring24DIGIRECOMiniAOD-00038_$NAME_$JOBINDEX.root \
#   maxEvents=$NEVENTS

edmConfigDump $CMSSW_BASE/src/Configuration/GenProduction/python/runInputs.py \
  outputFile=mini.root \
  nThreads=$NTHREAD nn=$NEVENTS \
  inFilename=file:TSG-Phase2Spring24DIGIRECOMiniAOD-00038_$NAME_$JOBINDEX.root > dumpedConfig_$NAME_$JOBINDEX.py

ls
# maxEvents=$NEVENTS
  # --nStreams $NTHREAD \

# cmsRun -j FrameworkJobReport.xml "TSG-Phase2Spring24DIGIRECOMiniAOD-00038_${NAME}_cfg.py"
cmsRun -j FrameworkJobReport.xml "dumpedConfig_$NAME_$JOBINDEX.py"
