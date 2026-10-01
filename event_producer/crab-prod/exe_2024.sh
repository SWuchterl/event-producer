#!/bin/bash -x

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

# Private Vts (t->sW) gridpacks were built for el9_amd64_gcc12 and need a
# newer glibc than el8 provides. Nested containers don't work inside a CRAB
# job, so the whole job (every step) must run as el9 instead of el8 for
# these fragments - detected from "el9" in the gridpack filename they carry.
if grep -q "el9" $WORKDIR/inputs/${NAME}.py; then
  JOB_SCRAM_ARCH=el9_amd64_gcc12
else
  JOB_SCRAM_ARCH=el8_amd64_gcc12
fi

############ LHEGEN ############
export SCRAM_ARCH=$JOB_SCRAM_ARCH
source /cvmfs/cms.cern.ch/cmsset_default.sh
export RELEASE=CMSSW_14_0_19
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

# ttcc DPS fragments use SecondHard:TwoCJets, which is not an official Pythia8
# process (see inputs/pythia8_ttcc_patch). Only those jobs build the small
# patched override; every other sample is untouched.
TTCC_PATCHED=0
if grep -q "SecondHard:TwoCJets" $WORKDIR/inputs/${NAME}.py; then
  TTCC_PATCHED=1
  PY8BASE=$(scram tool info pythia8 | sed -n 's/^PYTHIA8_BASE=//p')
  TTCCDIR=$WORKDIR/pythia8_ttcc_override
  mkdir -p $TTCCDIR/xmldoc
  g++ -std=c++17 -O2 -fPIC -shared -I$PY8BASE/include \
    $WORKDIR/inputs/pythia8_ttcc_patch/ProcessContainer.cc \
    -L$PY8BASE/lib -lpythia8 -Wl,-rpath,$PY8BASE/lib \
    -o $TTCCDIR/libpythia8_ttcc_override.so || exit $?
  # xmldoc holds both *.xml settings files and data files (e.g. HadronWidths.dat)
  # that Pythia8 loads relative to PYTHIA8DATA - ship all of them, not just xml.
  for f in $PY8BASE/share/Pythia8/xmldoc/*; do
    bn=$(basename $f)
    [ "$bn" = "SecondHardProcess.xml" ] && continue
    ln -sf $f $TTCCDIR/xmldoc/$bn
  done
  cp $WORKDIR/inputs/pythia8_ttcc_patch/SecondHardProcess.xml $TTCCDIR/xmldoc/SecondHardProcess.xml
  ln -sfn $PY8BASE/share/Pythia8/pdfdata $TTCCDIR/pdfdata
fi

cd $WORKDIR

# [NOTE] need to specify seeds otherwise gridpacks will be chosen from the same routine!!
# remember to identify process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(${SEED})"!!
if [ "$TTCC_PATCHED" = "1" ]; then
  # LD_PRELOAD is inherited by every child process, including the gridpack's
  # own runcmsgrid.sh (built against an older, incompatible glibc/libstdc++).
  # So the LHE step (which shells out to the gridpack) must run WITHOUT the
  # preload, and only the GEN,SIM step (in-process Pythia8 hadronization)
  # runs with it - hence the two-step split, only for ttcc jobs.
  cmsDriver.py Configuration/GenProduction/python/${NAME}.py \
    --python_filename "RunIII2024Summer24wmLHE_${NAME}_cfg.py" \
    --eventcontent LHE \
    --datatier LHE \
    --fileout "file:RunIII2024Summer24wmLHE_$NAME_$JOBINDEX.root" \
    --conditions 140X_mcRun3_2024_realistic_v26 \
    --step LHE \
    --era Run3_2024 \
    --nThreads $NTHREAD \
    --customise_commands "process.source.numberEventsInLuminosityBlock=cms.untracked.uint32(1000)\\nprocess.source.firstLuminosityBlock=cms.untracked.uint32(${LUMISTART})\\nprocess.source.firstEvent=cms.untracked.uint64(${EVENTSTART})\\nprocess.RandomNumberGeneratorService.externalLHEProducer.initialSeed=${SEED}" \
    --mc \
    -n $NEVENTS || exit $?

  export LD_PRELOAD=$TTCCDIR/libpythia8_ttcc_override.so
  export PYTHIA8DATA=$TTCCDIR/xmldoc

  cmsDriver.py Configuration/GenProduction/python/${NAME}.py \
    --python_filename "RunIII2024Summer24wmLHEGS_${NAME}_cfg.py" \
    --eventcontent RAWSIM,LHE \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier GEN-SIM,LHE \
    --filein "file:RunIII2024Summer24wmLHE_$NAME_$JOBINDEX.root" \
    --fileout "file:RunIII2024Summer24wmLHEGS_$NAME_$JOBINDEX.root" \
    --conditions 140X_mcRun3_2024_realistic_v26 \
    --beamspot DBrealistic \
    --step GEN,SIM \
    --geometry DB:Extended \
    --era Run3_2024 \
    --nThreads $NTHREAD \
    --mc \
    -n $NEVENTS || exit $?

  unset LD_PRELOAD PYTHIA8DATA
  rm -f RunIII2024Summer24wmLHE_$NAME_$JOBINDEX.root
else
  cmsDriver.py Configuration/GenProduction/python/${NAME}.py \
    --python_filename "RunIII2024Summer24wmLHEGS_${NAME}_cfg.py" \
    --eventcontent RAWSIM,LHE \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --datatier GEN-SIM,LHE \
    --fileout "file:RunIII2024Summer24wmLHEGS_$NAME_$JOBINDEX.root" \
    --conditions 140X_mcRun3_2024_realistic_v26 \
    --beamspot DBrealistic \
    --step LHE,GEN,SIM \
    --geometry DB:Extended \
    --era Run3_2024 \
    --nThreads $NTHREAD \
    --customise_commands "process.source.numberEventsInLuminosityBlock=cms.untracked.uint32(1000)\\nprocess.source.firstLuminosityBlock=cms.untracked.uint32(${LUMISTART})\\nprocess.source.firstEvent=cms.untracked.uint64(${EVENTSTART})\\nprocess.RandomNumberGeneratorService.externalLHEProducer.initialSeed=${SEED}" \
    --mc \
    -n $NEVENTS || exit $?
fi

ls *.root
# from https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_test/TOP-RunIII2024Summer24wmLHEGS-00001
# cmsDriver.py Configuration/GenProduction/python/TOP-RunIII2024Summer24wmLHEGS-00001-fragment.py \
# --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(${SEED})"\\nprocess.source.numberEventsInLuminosityBlock="cms.untracked.uint32(100)" \

############ SIM ############
# export SCRAM_ARCH=slc7_amd64_gcc700
# source /cvmfs/cms.cern.ch/cmsset_default.sh
# export RELEASE=CMSSW_10_6_17_patch1
# if [ -r $RELEASE/src ]; then
#   echo release $RELEASE already exists
# else
#   scram p CMSSW $RELEASE
# fi
# cd $RELEASE/src
# eval $(scram runtime -sh)
# cd $WORKDIR

# cmsDriver.py \
#   --python_filename "RunIISummer20UL18SIM_${NAME}_cfg.py" \
#   --eventcontent RAWSIM \
#   --customise Configuration/DataProcessing/Utils.addMonitoring \
#   --datatier GEN-SIM \
#   --fileout "file:RunIISummer20UL18SIM_$NAME_$JOBINDEX.root" \
#   --conditions 106X_upgrade2018_realistic_v11_L1v1 \
#   --beamspot Realistic25ns13TeVEarly2018Collision \
#   --step SIM \
#   --geometry DB:Extended \
#   --filein "file:TOP-RunIII2024Summer24wmLHEGS_$NAME_$JOBINDEX.root" \
#   --era Run2_2018 \
#   --runUnscheduled \
#   --mc \
#   --nThreads $NTHREAD \
#   -n $NEVENTS || exit $?

############ DIGIPremix ############
export SCRAM_ARCH=$JOB_SCRAM_ARCH
source /cvmfs/cms.cern.ch/cmsset_default.sh
# export RELEASE=CMSSW_14_0_21
export RELEASE=CMSSW_14_0_19
if [ -r $RELEASE/src ]; then
  echo release $RELEASE already exists
else
  scram p CMSSW $RELEASE
fi
cd $RELEASE/src
eval $(scram runtime -sh)
cd $WORKDIR

cmsDriver.py \
  --python_filename "RunIII2024Summer24DRPremix_${NAME}_cfg.py" \
  --eventcontent PREMIXRAW \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
  --datatier GEN-SIM-RAW \
  --filein "file:RunIII2024Summer24wmLHEGS_$NAME_$JOBINDEX.root" \
  --fileout "file:RunIII2024Summer24DRPremix_$NAME_$JOBINDEX.root" \
  --pileup_input "dbs:/Neutrino_E-10_gun/RunIIISummer24PrePremix-Premixlib2024_140X_mcRun3_2024_realistic_v26-v1/PREMIX" \
  --conditions 140X_mcRun3_2024_realistic_v26 \
  --step DIGI,DATAMIX,L1,DIGI2RAW,HLT:2024v14 \
  --procModifiers premix_stage2 \
  --geometry DB:Extended \
  --datamix PreMix \
  --era Run3_2024 \
  --runUnscheduled \
  --mc \
  --nThreads $NTHREAD \
  -n $NEVENTS || exit $?

ls *.root


# after running LHE->DIGI we delete the LHE
rm -f RunIII2024Summer24wmLHEGS_$NAME_$JOBINDEX.root

# from https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_test/TOP-RunIII2024Summer24DRPremix-00001
# cmsDriver.py \
# --python_filename TOP-RunIII2024Summer24DRPremix-00001_1_cfg.py \
# --fileout file:TOP-RunIII2024Summer24DRPremix-00001_0.root \
# --filein file:TOP-RunIII2024Summer24wmLHEGS-00001.root \

############ HLT ############
# export SCRAM_ARCH=slc7_amd64_gcc630
# source /cvmfs/cms.cern.ch/cmsset_default.sh
# export RELEASE=CMSSW_10_2_16_UL
# if [ -r $RELEASE/src ]; then
#   echo release $RELEASE already exists
# else
#   scram p CMSSW $RELEASE
# fi
# cd $RELEASE/src
# eval $(scram runtime -sh)
# cd $WORKDIR

# cmsDriver.py \
#   --python_filename "RunIISummer20UL18HLT_${NAME}_cfg.py" \
#   --eventcontent RAWSIM \
#   --customise Configuration/DataProcessing/Utils.addMonitoring \
#   --datatier GEN-SIM-RAW \
#   --filein "file:RunIISummer20UL18DIGIPremix_$NAME_$JOBINDEX.root" \
#   --fileout "file:RunIISummer20UL18HLT_$NAME_$JOBINDEX.root" \
#   --conditions 102X_upgrade2018_realistic_v15 \
#   --customise_commands 'process.source.bypassVersionCheck = cms.untracked.bool(True)' \
#   --step HLT:2018v32 \
#   --geometry DB:Extended \
#   --era Run2_2018 \
#   --mc \
#   -n $NEVENTS || exit $?

############ RECO ############
export SCRAM_ARCH=$JOB_SCRAM_ARCH
source /cvmfs/cms.cern.ch/cmsset_default.sh
export RELEASE=CMSSW_14_0_21
if [ -r $RELEASE/src ]; then
  echo release $RELEASE already exists
else
  scram p CMSSW $RELEASE
fi
cd $RELEASE/src
eval $(scram runtime -sh)
cd $WORKDIR

cmsDriver.py \
  --python_filename "RunIII2024Summer24DRPremix_${NAME}_cfg.py" \
  --eventcontent AODSIM \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
  --datatier AODSIM \
  --filein "file:RunIII2024Summer24DRPremix_$NAME_$JOBINDEX.root" \
  --fileout "file:RunIII2024Summer24RECO_$NAME_$JOBINDEX.root" \
  --conditions 140X_mcRun3_2024_realistic_v26 \
  --step RAW2DIGI,L1Reco,RECO,RECOSIM \
  --geometry DB:Extended \
  --era Run3_2024 \
  --runUnscheduled \
  --mc \
  --nThreads $NTHREAD \
  -n $NEVENTS || exit $?

ls *.root

# after running DIGI->RECO we delete the DIGI
rm -f RunIII2024Summer24DRPremix_$NAME_$JOBINDEX.root

# cmsDriver.py \
# --python_filename TOP-RunIII2024Summer24DRPremix-00001_2_cfg.py \
# --fileout file:TOP-RunIII2024Summer24DRPremix-00001.root \
# --filein file:TOP-RunIII2024Summer24DRPremix-00001_0.root \
# from https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_test/TOP-RunIII2024Summer24DRPremix-00001


############ MiniAODv2 ############
export SCRAM_ARCH=$JOB_SCRAM_ARCH
source /cvmfs/cms.cern.ch/cmsset_default.sh
export RELEASE=CMSSW_15_0_2
if [ -r $RELEASE/src ]; then
  echo release $RELEASE already exists
else
  scram p CMSSW $RELEASE
fi
cd $RELEASE/src
eval $(scram runtime -sh)
cd $WORKDIR

## for the last step, needs to run with -j FrameworkJobReport.xml
cmsDriver.py \
  --python_filename "RunIII2024Summer24MiniAODv6_${NAME}_cfg.py" \
  --eventcontent MINIAODSIM1 \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
  --datatier MINIAODSIM \
  --filein "file:RunIII2024Summer24RECO_$NAME_$JOBINDEX.root" \
  --fileout file:mini.root \
  --conditions 150X_mcRun3_2024_realistic_v2 \
  --step PAT \
  --runUnscheduled \
  --geometry DB:Extended \
  --era Run3_2024 \
  --nThreads $NTHREAD \
  --mc \
  -n $NEVENTS || exit $?

ls *.root


# dumb idea....
# # after running RECO->MINIAOD we delete the RECO
# rm -f RunIII2024Summer24RECO_$NAME_$JOBINDEX.root

  # --fileout file:mini.root \
  # --runUnscheduled \
  # --procModifiers run2_miniAOD_UL \

  # --fileout "file:RunIII2024Summer24MiniAODv6_$NAME_$JOBINDEX.root" \

# cmsDriver.py \
# --python_filename TOP-RunIII2024Summer24MiniAODv6-00001_1_cfg.py \
# --fileout file:TOP-RunIII2024Summer24MiniAODv6-00001.root \
# --filein "dbs:/TTtoLNuCB_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24DRPremix-140X_mcRun3_2024_realistic_v26-v2/AODSIM"

cmsRun -j FrameworkJobReport.xml "RunIII2024Summer24MiniAODv6_${NAME}_cfg.py"


############ nanoAODv15 ############
# export SCRAM_ARCH=el8_amd64_gcc12
# source /cvmfs/cms.cern.ch/cmsset_default.sh
# export RELEASE=CMSSW_15_0_2
# if [ -r $RELEASE/src ]; then
#   echo release $RELEASE already exists
# else
#   scram p CMSSW $RELEASE
# fi
# cd $RELEASE/src
# eval $(scram runtime -sh)
# cd $WORKDIR

# ## for the last step, needs to run with -j FrameworkJobReport.xml
# cmsDriver.py \
#   --python_filename "RunIII2024Summer24NanoAODv15_${NAME}_cfg.py" \
#   --eventcontent NANOAODSIM \
#   --customise Configuration/DataProcessing/Utils.addMonitoring \
#   --datatier NANOAODSIM \
#   --filein "file:RunIII2024Summer24MiniAODv6_$NAME_$JOBINDEX.root" \
#   --fileout file:nano.root \
#   --conditions 150X_mcRun3_2024_realistic_v2 \
#   --step NANO \
#   --era Run3_2024 \
#   --no_exec \
#   --scenario pp \
#   --nThreads $NTHREAD \
#   --mc \
#   -n $NEVENTS


  # --geometry DB:Extended \
# from https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_test/TOP-RunIII2024Summer24NanoAODv15-00001
# cmsDriver.py \
# --python_filename TOP-RunIII2024Summer24NanoAODv15-00001_1_cfg.py \
# --fileout file:TOP-RunIII2024Summer24NanoAODv15-00001.root \
# --filein "dbs:/TTtoLNuCB_TuneCP5_13p6TeV_powheg-pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v1/MINIAODSIM" \

# cmsRun -j FrameworkJobReport.xml "RunIII2024Summer24NanoAODv15_${NAME}_cfg.py"
