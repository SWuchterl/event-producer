# now with publication
#     -o /store/group/cmst3/group/vhcc/privateMC/2024/mc \

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_top/Run3Vcb/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttcb.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 5000 \
#     --max-units 10000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttcb_RunIII2024Summer24_mc

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_top/Run3Vcb/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttbbdps.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 5000 \
#     --max-units 10000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttbbdps_RunIII2024Summer24_mc

# let's assume it's 10 times slower than HVQ

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_top/Run3Vcb/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttbb.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 500 \
#     --max-units 5000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttbb_RunIII2024Summer24_mc

# an extension only for the trial ttbb sample, seed increased by 10000 because that is the number of jobs above

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_top/Run3Vcb/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15_ext1 \
#     -i samples/ttbb.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=10001 -s EventBased -n 500 \
#     --max-units 5000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttbb_RunIII2024Summer24_mc_ext1

# and the rest, now with factor 2 more events per job, let's try

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_top/Run3Vcb/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttbb.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 1000 \
#     --max-units 10000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttbb_RunIII2024Summer24_mc



# tth should be fine


# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttHcc.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 5000 \
#     --max-units 10000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttHcc_RunIII2024Summer24_mc

# was not, only ttZ :D

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttHcc.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 2000 \
#     --max-units 10000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttHcc_RunIII2024Summer24_mc


# we will need ttz extensions, only 500k of 10M in 2L done, and 2.5 M for 1L and 0L
# original was 2k jobs each, max events 10M
# to reach 10M files really per job, we need to increase the number of events per job by a factor of 8 for 0L and 1L and by a factor of 20 for 2L
#  -> factor 8 more per job of 1L/0L and factor 20 more for 2L

# didnt work... was 4k jobs each. So we can o to max 10k jobs each, and reduce the number of events per job by 2.5 to reach 10M events per job, so 20k for 0L and 1L and 8k for 2L

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttZqq_0L.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 8000 \
#     --max-units 80000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttZqq_0L_RunIII2024Summer24_mc_ext3

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttZqq_1L.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 8000 \
#     --max-units 80000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttZqq_1L_RunIII2024Summer24_mc_ext3

# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttZqq_2L.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 20000 \
#     --max-units 200000000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttZqq_2L_RunIII2024Summer24_mc_ext3




# now the 2.5M per ttH mass point for each decay channel
# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
#     -t RunIII2024Summer24MiniAODv15 \
#     -i samples/ttH1L.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 2000 \
#     --max-units 2500000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_ttHcc_RunIII2024Summer24_mc_ttHVarMass_1L

# now the 2.5M per ttH mass point for each decay channel
python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/phys_higgs/ttHcc/privateMC/2024/mc \
    -t RunIII2024Summer24MiniAODv15 \
    -i samples/ttH0L.conf \
    -e exe_2024.sh \
    --script-args beginseed=0 -s EventBased -n 2000 \
    --max-units 2500000 \
    --input-files inputs --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_ttHcc_RunIII2024Summer24_mc_ttHVarMass_0L