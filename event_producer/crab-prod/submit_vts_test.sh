# Test submission for the private tt Vts (t->sW) samples - see
# samples/vts.conf for the dataset list.
#
# The 4 gridpacks below are private (not on cvmfs) and were built for
# el9_amd64_gcc12; exe_2024.sh auto-detects them (by "el9" in the fragment's
# gridpack filename) and runs the WHOLE job as el9 instead of el8, since an
# el8-built CMSSW job cannot nest another OS's container on the grid.
#
# IMPORTANT, unverified: CRAB's own worker-node OS request (REQUIRED_OS) may
# be taken from the SCRAM_ARCH/CMSSW release active in *this* shell when you
# run crab.py, not just from what exe_2024.sh does at runtime. There is no
# CRABClient available to check this locally. Before removing --dryrun,
# inspect the generated crab config/JDL (or ask in the CRAB support channel)
# to confirm it will request an el9 node - if it requests el8, the job will
# hit the same GLIBC mismatch we saw testing this locally, just on the grid.
#
# Each of the 4 CRAB tasks below ships ALL 4 gridpacks (~67 MB total) in its
# input sandbox, even though it only uses one - wasteful but should still be
# within CRAB's sandbox size limit. Worth trimming (separate --input-files
# per sample) if that ever becomes a problem.
#
# Remove --dryrun once you're happy with the generated CRAB config.

python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/phys_top/Run3Vcb/privateMC/2024/mc_test \
    -t RunIII2024Summer24MiniAODv15_VtsTest \
    -i samples/vts.conf \
    -e exe_2024.sh \
    --script-args beginseed=0 -s EventBased -n 200 \
    --max-units 1000 \
    --input-files inputs \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_2L2Nu_tToS.tgz \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_2L2Nu_tbarToS.tgz \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_LNu2Q_tToS.tgz \
        /eos/user/s/sewuchte/Share/Vts/hvq_el9_amd64_gcc12_CMSSW_14_1_0_pre4_TT_sW_LNu2Q_tbarToS.tgz \
    --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_vts_test_RunIII2024Summer24_mc
    
    # \
    # --dryrun
