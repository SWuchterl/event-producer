# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/cmst3/group/vhcc/privateMC/2024/mc \
#     -t RunIII2024Summer24NanoAODv15 \
#     -i samples/wcb.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 1000 \
#     --max-units 2500000 \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_RunIII2024Summer24_mc


    # --script-args beginseed=0 -s EventBased -n 1000 \
    # --max-units 2500000 \

# ./crab.py --private-mc -p FAKEMiniAODv2_cfg.py --site T2_CH_CERN -o /store/group/cmst3/group/vhcc/ttHcc_trees/privateMC/2018/mc -t RunIISummer20UL18MiniAODv2 -i samples/HPlusC_TauTau.conf -e exe_UL18.sh --script-args beginseed=0 -s EventBased -n 1000 --max-units 10000000 --input-files inputs --max-memory 10000 --num-cores 4 --work-area crab_projects_2018_mc_run3



python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/cmst3/group/vhcc/privateMC/2024/mc \
    -t RunIII2024Summer24NanoAODv15 \
    -i samples/wcb.conf \
    -e exe_BTV2024.sh --no-publication \
    --script-args beginseed=0 -s EventBased -n 30 \
    --max-units 30 \
    --input-files inputs --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_TestBTVSampleProdv0p6