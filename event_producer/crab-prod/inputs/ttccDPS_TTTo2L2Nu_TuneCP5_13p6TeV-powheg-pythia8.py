import FWCore.ParameterSet.Config as cms

externalLHEProducer = cms.EDProducer('ExternalLHEProducer',
    args = cms.vstring('/cvmfs/cms.cern.ch/phys_generator/gridpacks/PdmV/Run3Summer22/Powheg/TT/hvq_slc7_amd64_gcc10_CMSSW_12_4_8_TTto2L2Nu_powheg-pythia8.tgz'),
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
    PythiaParameters = cms.PSet(
        pythia8CommonSettingsBlock,
        pythia8CP5SettingsBlock,
        pythia8PowhegEmissionVetoSettingsBlock,
        pythia8PSweightsSettingsBlock,
        processParameters = cms.vstring(
            'POWHEG:nFinal = 2', ## Number of final state particles
            ## (BEFORE THE DECAYS) in the LHE
            ## other than emitted extra parton
            'TimeShower:mMaxGamma = 4.0',#cutting off lepton-pair production
            ##in the electromagnetic shower
            ##to not overlap with ttZ/gamma* samples
            '6:m0 = 172.5',    # top mass
            'SecondHard:generate = on',
            # Not an official Pythia8 process: requires the patched Pythia8
            # in inputs/pythia8_ttcc_patch (see exe_2024.sh), which mirrors
            # SecondHard:TwoBJets with idNew=4 (charm) instead of 5 (bottom).
            'SecondHard:TwoCJets = on',
        ),
        parameterSets = cms.vstring(
            'pythia8CommonSettings',
            'pythia8CP5Settings',
            'pythia8PowhegEmissionVetoSettings',
            'processParameters',
            'pythia8PSweightsSettings',
        )
    ),
    comEnergy = cms.double(13600),
    maxEventsToPrint = cms.untracked.int32(1),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    pythiaPylistVerbosity = cms.untracked.int32(1),
)

ProductionFilterSequence = cms.Sequence(generator)
