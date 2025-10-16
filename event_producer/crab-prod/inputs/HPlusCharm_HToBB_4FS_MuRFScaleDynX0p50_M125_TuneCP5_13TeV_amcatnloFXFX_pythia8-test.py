import FWCore.ParameterSet.Config as cms

# https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/HIG-RunIISummer19UL17wmLHEGEN-00105/0

# see https://cms-pdmv-prod.web.cern.ch/mcm/public/restapi/requests/get_fragment/HIG-Run3Summer23wmLHEGS-00865/0

externalLHEProducer = cms.EDProducer('ExternalLHEProducer',
    args = cms.vstring("/cvmfs/cms.cern.ch/phys_generator/gridpacks/RunIII/13p6TeV/slc7_amd64_gcc10/MadGraph5_aMCatNLO/HPlusCharm_4FS_MuRFScaleDynX0p50_HToGG_M125_TuneCP5_13p6TeV_amcatnlo_pythia8_slc7_amd64_gcc10_CMSSW_12_4_8_tarball.tar.xz"),
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)

from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.MCTunesRun3ECM13p6TeV.PythiaCP5Settings_cfi import * # this is changed
from Configuration.Generator.PSweightsPythia.PythiaPSweightsSettings_cfi import *
from Configuration.Generator.Pythia8aMCatNLOSettings_cfi import *

#generator = cms.EDFilter('Pythia8HadronizerFilter',
generator = cms.EDFilter('Pythia8ConcurrentHadronizerFilter',
    maxEventsToPrint = cms.untracked.int32(1),
    pythiaPylistVerbosity = cms.untracked.int32(1),
    filterEfficiency = cms.untracked.double(1.0),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    comEnergy = cms.double(13600.),
    PythiaParameters = cms.PSet(
        pythia8CommonSettingsBlock,
        pythia8CP5SettingsBlock,
        pythia8PSweightsSettingsBlock,
        pythia8aMCatNLOSettingsBlock,
        processParameters = cms.vstring(
            'TimeShower:nPartonsInBorn = 0', # number of coloured particles (before resonance decays) in born matrix element
            'SLHA:useDecayTable = off',
            '25:m0 = 125',
            '25:onMode = off',
            '25:onIfMatch = -5 5',
        ),
        parameterSets = cms.vstring(
            'pythia8CommonSettings',
            'pythia8CP5Settings',
            'pythia8PSweightsSettings',
            'pythia8aMCatNLOSettings',
            'processParameters',
        )
    )
)
