import FWCore.ParameterSet.Config as cms

# POWHEG-BOX-RES ttcc, 3FS NLO, top decays with spin correlations in POWHEG.
# See genproductions_scripts/bin/Powheg/ttcc_production_handoff.md.
externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('__GRIDPACKDIR__/ttcc_el8_amd64_gcc10_CMSSW_12_4_11_ttcc_2L2Nu.tgz'),
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh'),
    generateConcurrently = cms.untracked.bool(True),
)

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
        pythia8PowhegEmissionVetoSettingsBlock,
        pythia8PSweightsSettingsBlock,
        processParameters = cms.vstring(
            'POWHEG:nFinal = 4',   # t t~ c c~ before the decays
        ),
        parameterSets = cms.vstring(
            'pythia8CommonSettings',
            'pythia8CP5Settings',
            'pythia8PowhegEmissionVetoSettings',
            'pythia8PSweightsSettings',
            'processParameters',
        )
    ),
)

ProductionFilterSequence = cms.Sequence(generator)
