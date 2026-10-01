import FWCore.ParameterSet.Config as cms

externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('__GRIDPACKDIR__/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_2L2Nu_tToS.tgz'), # private Vts (t->sW) gridpack, shipped via CRAB --input-files
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh'),
    generateConcurrently = cms.untracked.bool(True)
)

#Link to datacards (with only change being the energy to 13.6TeV) 
# Not available

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
        	'POWHEG:nFinal = 2', ## Number of final state particles
        	## (BEFORE THE DECAYS) in the LHE
        	## other than emitted extra parton
        	'TimeShower:mMaxGamma = 1.0',#cutting off lepton-pair production
	        ##in the electromagnetic shower
    	    ##to not overlap with ttZ/gamma* samples
        	'6:m0 = 172.5',    # top mass'
		),
		parameterSets = cms.vstring(
    	    'pythia8CommonSettings',
			'pythia8CP5Settings',
			'pythia8PowhegEmissionVetoSettings',
			'pythia8PSweightsSettings',
			'processParameters'
		)
	),
)

ProductionFilterSequence = cms.Sequence(generator)