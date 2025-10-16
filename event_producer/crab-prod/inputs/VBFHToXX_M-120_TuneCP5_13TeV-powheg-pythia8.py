import FWCore.ParameterSet.Config as cms

# card
# https://github.com/alintulu/genproductions/blob/7625d99f760709a3609d2c5796cdc71ce9b8a8f6/bin/Powheg/production/Run3/13p6TeV/Higgs/VBF_H_NNPDF31_13TeV/VBF_H_NNPDF31_13p6TeV.input

    # args = cms.vstring('/cvmfs/cms.cern.ch/phys_generator/gridpacks/RunIII/13p6TeV/slc7_amd64_gcc700/Powheg/V2/VBF_H_slc7_amd64_gcc700_CMSSW_10_2_29_VBFHToBB.tgz'),


externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    # args=cms.vstring('__GRIDPACKDIR__/ttH_slc7_amd64_gcc700_CMSSW_10_6_30_patch1_my_ttH_ttTo2L2Nu_hdamp_NNPDF31_13TeV_M_HMASS_.tgz'),
    args=cms.vstring('__GRIDPACKDIR__/VBF_H_el8_amd64_gcc11_CMSSW_13_0_23_my_VBFH_TuneCP5_13TeV-powheg-pythia8_M120.tgz'),
    nEvents = cms.untracked.uint32(5000),
    generateConcurrently = cms.untracked.bool(True),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)

import FWCore.ParameterSet.Config as cms
from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.MCTunesRun3ECM13p6TeV.PythiaCP5Settings_cfi import *
from Configuration.Generator.Pythia8PowhegEmissionVetoSettings_cfi import *
from Configuration.Generator.PSweightsPythia.PythiaPSweightsSettings_cfi import *


generator = cms.EDFilter("Pythia8ConcurrentHadronizerFilter",
                         maxEventsToPrint = cms.untracked.int32(1),
                         pythiaPylistVerbosity = cms.untracked.int32(1),
                         filterEfficiency = cms.untracked.double(1.0),
                         pythiaHepMCVerbosity = cms.untracked.bool(False),
                         comEnergy = cms.double(13600.),
                         PythiaParameters = cms.PSet(
        pythia8CommonSettingsBlock,
        pythia8CP5SettingsBlock,
        pythia8PSweightsSettingsBlock,
        pythia8PowhegEmissionVetoSettingsBlock,
        processParameters = cms.vstring(
            'POWHEG:nFinal = 3',   ## Number of final state particles
                                   ## (BEFORE THE DECAYS) in the LHE
                                   ## other than emitted extra parton
            # 'TauDecays:externalMode=2',
            'SpaceShower:dipoleRecoil = on',
            '25:m0 = 120.0',
            '25:onMode = off',
            # '25:oneChannel = 1 0.1 100 5 -5', #b
            # '25:addChannel = 1 0.1 100 4 -4', #c
            # '25:addChannel = 1 0.1 100 3 -3', #s
            # '25:addChannel = 1 0.1 100 2 -2', #u
            # '25:addChannel = 1 0.1 100 1 -1', #d
            # '25:addChannel = 1 0.1 100 13 -13', #muon
            # '25:addChannel = 1 0.1 100 11 -11', #electron
            # '25:addChannel = 1 0.2 100 15 -15', #tau
            # '25:addChannel = 1 0.1 100 21 21', #gluon
            # 'ResonanceDecayFilter:filter = on',
            '25:onIfMatch = 5 -5',
            '25:onIfMatch = 4 -4',
        ),
        parameterSets = cms.vstring('pythia8CommonSettings',
                                    'pythia8CP5Settings',
                                    'pythia8PSweightsSettings',
                                    'pythia8PowhegEmissionVetoSettings',
                                    'processParameters'
                                    )
        )
                         )

ProductionFilterSequence = cms.Sequence(generator)