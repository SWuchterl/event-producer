# python3 crab.py --private-mc \
#     -p FAKEMiniAODv2_cfg.py \
#     --site T2_CH_CERN \
#     -o /store/group/cmst3/group/vhcc/privateMC/2024/mc \
#     -t RunIII2024Summer24NanoAODv15 \
#     -i samples/HPlusC_TauTau.conf \
#     -e exe_2024.sh \
#     --script-args beginseed=0 -s EventBased -n 1000 \
#     --max-units 2500000 \
#     --no-publication \
#     --input-files inputs --max-memory 10000 \
#     --num-cores 4 --work-area crab_projects_RunIII2024Summer24_mc

python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/cmst3/group/vhcc/privateMC/2024/mc \
    -t RunIII2024Summer24MiniAODv15 \
    -i samples/HPlusC_TauTau.conf \
    -e exe_2024.sh \
    --script-args beginseed=0 -s EventBased -n 1000 \
    --max-units 2500000 \
    --no-publication \
    --input-files inputs --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_RunIII2024Summer24_mc

python3 crab.py --private-mc \
    -p FAKEMiniAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/cmst3/group/vhcc/privateMC/2024/mc \
    -t RunIII2024Summer24MiniAODv15 \
    -i samples/HH4Tau.conf \
    -e exe_2024.sh \
    --script-args beginseed=0 -s EventBased -n 250 \
    --max-units 2500000 \
    --no-publication \
    --input-files inputs --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_RunIII2024Summer24_mc

# you can add --no-publication also to not publish in DAS
