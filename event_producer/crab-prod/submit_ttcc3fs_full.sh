# Full submission for the POWHEG ttcc 3FS samples (SemiLep/2L2Nu/Hadronic).
# Generator details: genproductions_scripts/bin/Powheg/ttcc_production_handoff.md
# Same job setup as submit_ttcc3fs_test.sh - see there for the reasons
# (one crab.py call per mode, 4 cores / 10000 MB, 4 concurrent POWHEG
# copies). Confirm memory, time per event and seeds from the CRAB test
# before removing --dryrun.
#
# Event counts are scaled by the top-pair BR so that every mode has the same
# luminosity: SemiLep 3M is the reference (50.7 fb-1 nominal, about
# 19 fb-1 effective with ~19% negative weights, N_eff = 0.38 N).
#   SemiLep  BR 0.4387  3,000,000 events  5000 jobs
#   Hadronic BR 0.4558  3,120,000 events  5200 jobs
#   2L2Nu    BR 0.1056    724,200 events  1207 jobs   (11,407 jobs total)
# 600 events/job (4 copies x 150). The 400-event CRAB test (all jobs at
# T2_CH_CERN) took 3.2-5.9 h per job, one slow job 7.7 h, at a fixed ~8 GB
# memory peak. 600 events gives about 4.8-8.9 h at CERN and about 13-18 h
# on a 1.5-2x slower node, under the default 1250 min (20.8 h) runtime
# request everywhere. 800 events/job would reach that limit on slow nodes.
#
# A separate beginseed range per mode: the three gridpacks share the same
# production grids (only the decay differs), so equal seeds would give
# correlated production kinematics between the modes. With 16 seeds per
# job (NTHREAD x 4 in exe_2024.sh) the ranges do not overlap, and none
# overlaps the test (beginseed=0).
#
# Normalization: use sum(genWeight)/N, not the LHE header / GenXsecAnalyzer
# value (134.9 pb, without the BR).
#
# Remove --dryrun once you're happy with the generated CRAB config.

for MODE in SemiLep Hadronic 2L2Nu; do
  case $MODE in
    SemiLep)  GP=ttcc_el8_amd64_gcc10_CMSSW_12_4_11_ttcc_SemiLeptonic.tgz; NTOT=3000000; SEED=10000 ;;
    Hadronic) GP=ttcc_el8_amd64_gcc10_CMSSW_12_4_11_ttcc_Hadronic.tgz;     NTOT=3120000; SEED=20000 ;;
    2L2Nu)    GP=ttcc_el8_amd64_gcc10_CMSSW_12_4_11_ttcc_2L2Nu.tgz;        NTOT=724200;  SEED=30000 ;;
  esac
  python3 crab.py --private-mc \
      -p FAKEMiniAODv2_cfg.py \
      --site T2_CH_CERN \
      -o /store/group/cmst3/group/vhcc/privateMC/2024/mc \
      -t RunIII2024Summer24MiniAODv15_TTcc3FS \
      -i samples/ttcc3fs_${MODE}.conf \
      -e exe_2024.sh \
      --script-args beginseed=${SEED} -s EventBased -n 600 \
      --max-units ${NTOT} \
      --input-files inputs /eos/user/s/sewuchte/ttcc/gridpacks/${GP} \
      --max-memory 10000 \
      --num-cores 4 --work-area crab_projects_ttcc3fs_RunIII2024Summer24_mc
done
