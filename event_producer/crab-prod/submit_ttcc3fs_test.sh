# Test submission for the POWHEG ttcc 3FS samples (SemiLep/2L2Nu/Hadronic).
# Generator details: genproductions_scripts/bin/Powheg/ttcc_production_handoff.md
#
# One crab.py call per decay mode: crab.py ships the same --input-files to
# every task of a call, and the three gridpacks together (3 x 43 MB) are
# above the CRAB sandbox limit.
#
# --num-cores 4 / --max-memory 10000 (the grid limit is 2.5 GB per core).
# Measured DIGI+HLT peak (summed RSS): 1 thread 3746 MB (> 2500), 2 threads
# 5068 MB (> 5000), 4 threads 8.1 GB in the ttcc DPS CRAB jobs of the same
# chain (< 10000). The fragments use generateConcurrently=True, so the
# ~100 s/event POWHEG LHE step runs as 4 parallel copies and no core is
# idle. Read the real memory peak from crab status before the full
# production.
#
# Normalization: use sum(genWeight)/N (about 19% negative weights), not the
# LHE header / GenXsecAnalyzer value (134.9 pb, without the BR).
#
# Check after the first jobs: each job, and each of the 4 POWHEG copies in a
# job, must have a different seed ("random seed used for the run" in the
# job log), or events are duplicated. Locally (2 copies) the seeds were
# different and there were no duplicate events.
#
# -n 400 per job = 4 copies x 100 events, about 3 h at ~100 s/event.
#
# Remove --dryrun once you're happy with the generated CRAB config.

for MODE in SemiLep 2L2Nu Hadronic; do
  case $MODE in
    SemiLep)  GP=ttcc_el8_amd64_gcc10_CMSSW_12_4_11_ttcc_SemiLeptonic.tgz ;;
    2L2Nu)    GP=ttcc_el8_amd64_gcc10_CMSSW_12_4_11_ttcc_2L2Nu.tgz ;;
    Hadronic) GP=ttcc_el8_amd64_gcc10_CMSSW_12_4_11_ttcc_Hadronic.tgz ;;
  esac
  python3 crab.py --private-mc \
      -p FAKEMiniAODv2_cfg.py \
      --site T2_CH_CERN \
      -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc_test \
      -t RunIII2024Summer24MiniAODv15_TTcc3FSTest \
      -i samples/ttcc3fs_${MODE}.conf \
      -e exe_2024.sh \
      --script-args beginseed=0 -s EventBased -n 400 \
      --max-units 2000 \
      --input-files inputs /eos/user/s/sewuchte/ttcc/gridpacks/${GP} \
      --max-memory 10000 \
      --num-cores 4 --work-area crab_projects_ttcc3fs_test_RunIII2024Summer24_mc \
      --no-publication
done
