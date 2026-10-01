# Full submission for the ttcc DPS samples (0L/1L/2L) - target 3M final
# MiniAOD events per channel.
#
# Measured on the 5-job test batch (500 raw events/job): only
# 24.6-25.8% of raw LHE events survive the SecondHard hit-and-miss step
# (614/2500, 636/2500, 644/2500 for 2L2Nu/SemiLep/Hadronic). Using the
# worst case (24.6%) for a safety margin:
#   3,000,000 / 0.246 = 12.2M -> 12.5M raw events/channel
#
# Job size bumped 10x from the validated 500/job to 5000/job: test jobs
# finished in 12-35 min on ~4.5GB average (max 8.1GB) with plenty of
# headroom under typical grid limits, and much of that time is fixed
# per-job overhead (checking out 3-4 CMSSW releases), so bigger jobs use
# it more efficiently. --max-memory padded from 10000 to 12000 for the
# bigger job size; this has NOT been tested at 5000 events/job specifically.
#
# beginseed=10000 (not 0): the test batch already used jobindex 1-5 with
# beginseed=0, i.e. seeds 1-5. Reusing beginseed=0 here would regenerate
# identical events for the first several thousand jobs of this run.
#
# max-units=12500000 / -n 5000 -> 2500 jobs/channel, 7500 jobs total.
#
# Remove --dryrun once you're happy with the generated CRAB config.

python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
    -t RunIII2024Summer24MiniAODv15_ttccDPS \
    -i samples/ttccdps.conf \
    -e exe_2024.sh \
    --script-args beginseed=10000 -s EventBased -n 5000 \
    --max-units 12500000 \
    --input-files inputs --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_ttccDPS_RunIII2024Summer24_mc
    # --dryrun
