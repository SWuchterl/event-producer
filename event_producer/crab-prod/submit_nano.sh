python3 crab.py --private-mc \
    -p FAKENanoAODv2_cfg.py \
    --site T2_CH_CERN \
    -o /store/group/cmst3/group/vhcc/privateMC/nanoAODv15/2024/mc \
    -t RunIII2024Summer24NanoAODv15 \
    -i samples/ttH1L.conf \
    -e exe_2024_Nano.sh \
    --script-args beginseed=0 -s EventBased -n 1000 \
    --max-units 2500000 \
    --input-files inputs --max-memory 10000 \
    --num-cores 4 --work-area crab_projects_RunIII2024Summer24NanoAODv15_mc

# you can add --no-publication also to not publish in DAS
