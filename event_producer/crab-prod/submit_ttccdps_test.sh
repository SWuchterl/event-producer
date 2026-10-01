# Test submission for the ttcc DPS samples (0L/1L/2L), using the patched
# Pythia8 SecondHard:TwoCJets process (see inputs/pythia8_ttcc_patch and
# exe_2024.sh). Validated locally end-to-end (LHE->GEN->SIM->DIGI->RECO->
# MiniAOD) before this was written - see samples/ttccdps.conf for the
# dataset list.
#
# -n is the raw LHE events requested per job. Only a fraction of these
# survive the SecondHard hit-and-miss step (measured ~28-45% for the
# 2L2Nu channel locally) and end up as usable GEN events, so the output
# event count per job will be noticeably smaller than -n.
#
# Remove --dryrun once you're happy with the generated CRAB config.

python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc_test \
    -t RunIII2024Summer24MiniAODv15_ttccDPSTest \
    -i samples/ttccdps.conf \
    -e exe_2024.sh \
    --script-args beginseed=0 -s EventBased -n 500 \
    --max-units 2500 \
    --input-files inputs --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_ttccDPS_test_RunIII2024Summer24_mc
    
    
    
    # \
    # --dryrun
