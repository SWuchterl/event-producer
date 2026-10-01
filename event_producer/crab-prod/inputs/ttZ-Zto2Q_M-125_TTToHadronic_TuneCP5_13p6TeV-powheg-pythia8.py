import FWCore.ParameterSet.Config as cms

externalLHEProducer = cms.EDProducer('ExternalLHEProducer',
    args = cms.vstring('/cvmfs/cms-griddata.cern.ch/phys_generator/gridpacks_tarball/CommonBkg/RunIII2024Summer24/MadGraph5_aMCatNLO/TT/TTZ-ZtoQQ-1Jets_amcatnloFXFX-pythia8_slc7_amd64_gcc10_CMSSW_12_4_8_tarball.tar.xz'),
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh'),
    generateConcurrently = cms.untracked.bool(False)
)

from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.MCTunesRun3ECM13p6TeV.PythiaCP5Settings_cfi import *
from Configuration.Generator.Pythia8aMCatNLOSettings_cfi import *
from Configuration.Generator.PSweightsPythia.PythiaPSweightsSettings_cfi import *

generator = cms.EDFilter("Pythia8ConcurrentHadronizerFilter",
    PythiaParameters = cms.PSet(
        pythia8CommonSettingsBlock,
        pythia8CP5SettingsBlock,
        pythia8aMCatNLOSettingsBlock,
        pythia8PSweightsSettingsBlock,
        processParameters = cms.vstring(
            'JetMatching:setMad = off',
            'JetMatching:scheme = 1',
            'JetMatching:merge = on',
            'JetMatching:jetAlgorithm = 2',
            'JetMatching:etaJetMax = 999.',
            'JetMatching:coneRadius = 1.',
            'JetMatching:slowJetPower = 1',
            'JetMatching:doFxFx = on',
            'JetMatching:qCut = 42.',
            'JetMatching:qCutME = 20.',
            'JetMatching:nQmatch = 5',
            'JetMatching:nJetMax = 1',
            'TimeShower:mMaxGamma = 4.0',
            'TauDecays:externalMode = 2'
        ),
        parameterSets = cms.vstring(
            'pythia8CommonSettings',
            'pythia8CP5Settings',
            'pythia8aMCatNLOSettings',
            'processParameters',
            'pythia8PSweightsSettings'
        )
    ),
    comEnergy = cms.double(13600),
    maxEventsToPrint = cms.untracked.int32(1),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    pythiaPylistVerbosity = cms.untracked.int32(1),
)

lheGenericFilter = cms.EDFilter("LHEGenericFilter",
    src = cms.InputTag("externalLHEProducer"),
    NumRequired = cms.int32(0),
    ParticleID = cms.vint32(11,13,15),
    AcceptLogic = cms.string("EQ") 
)

ProductionFilterSequence = cms.Sequence(generator+lheGenericFilter)

