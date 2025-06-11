./crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/cmst3/group/vhcc/privateMC/Phase2L1T/mc \
    -t Phase2Spring24DIGIRECOMiniAOD-PU200 \
    -i samples/hcc.conf \
    -e exe_Phase2L1T.sh \
    --script-args beginseed=0 -s EventBased -n 100 \
    --max-units 50000 \
    --input-files inputs --max-memory 15000 \
    --num-cores 8 --work-area crab_projects_Phase2_mc

# ./crab.py --private-mc -p FAKEMiniAODv2_cfg.py --site T2_CH_CERN -o /store/group/cmst3/group/vhcc/ttHcc_trees/privateMC/2018/mc -t RunIISummer20UL18MiniAODv2 -i samples/HPlusC_TauTau.conf -e exe_UL18.sh --script-args beginseed=0 -s EventBased -n 1000 --max-units 10000000 --input-files inputs --max-memory 10000 --num-cores 4 --work-area crab_projects_2018_mc_run3