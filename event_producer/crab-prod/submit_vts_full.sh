# Full submission for the private tt Vts (t->sW) samples - target 3M
# final MiniAOD events per channel.
#
# No SecondHard-style efficiency loss here: the 5-job test batch (200
# events/job) produced exactly 1000/1000 events on every channel, so
# raw events requested == final events produced.
#
# Job size kept conservative (500/job, 2.5x the tested 200) rather than
# scaled up aggressively like the ttcc campaign: the test batch was
# already using 6.3-8.7GB of the 10GB requested at just 200 events/job,
# with low/inconsistent CPU efficiency (12-54%) and one job that took
# 4h24m against a ~30min average for the same work. That pattern usually
# means a fixed cost (e.g. pileup premix I/O), not per-event scaling, but
# this has not been verified at a larger job size - only 500/job has any
# empirical basis (from doubling/halving reasoning, not a real test).
# --max-memory padded from 10000 to 14000 for headroom; note some sites
# cap job memory well below that regardless of what's requested, which
# would just narrow the pool of eligible sites, not fail the submission.
#
# beginseed=10000 (not 0): the test batch already used jobindex 1-5 with
# beginseed=0, i.e. seeds 1-5. Reusing beginseed=0 here would regenerate
# identical events for the first several thousand jobs of this run.
#
# max-units=3000000 / -n 500 -> 6000 jobs/channel, 24000 jobs total
# across the 4 channels - a large campaign; consider whether you want to
# split this into smaller batches rather than one submission per channel.
#
# Remove --dryrun once you're happy with the generated CRAB config.

python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/phys_top/Run3Vcb/privateMC/2024/mc \
    -t RunIII2024Summer24MiniAODv15_Vts \
    -i samples/vts.conf \
    -e exe_2024.sh \
    --script-args beginseed=10000 -s EventBased -n 500 \
    --max-units 3000000 \
    --input-files inputs \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_2L2Nu_tToS.tgz \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_2L2Nu_tbarToS.tgz \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_LNu2Q_tToS.tgz \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_LNu2Q_tbarToS.tgz \
    --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_vts_RunIII2024Summer24_mc
    # --dryrun
