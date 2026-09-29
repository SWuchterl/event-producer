condor_submit jdl_infer/submit_infer_higgs2p.jdl -batch-name offlineTuples_infer_higgs2p
sleep 5
condor_submit jdl_infer/submit_infer_qcd.jdl -batch-name offlineTuples_infer_qcd
sleep 5
condor_submit jdl_infer/submit_infer_ttbar_lxplus.jdl -batch-name offlineTuples_infer_ttbar
sleep 5


condor_submit jdl_train/submit_higgs2p.jdl --batch-name offlineTuples_train_higgs2p
sleep 5
condor_submit jdl_train/submit_higgs2phm.jdl --batch-name offlineTuples_train_higgs2phm
sleep 5
condor_submit jdl_train/submit_higgsbsm2p.jdl --batch-name offlineTuples_train_higgsbsm2p
sleep 5
condor_submit jdl_train/submit_higgsbsm2phm.jdl --batch-name offlineTuples_train_higgsbsm2phm
sleep 5
condor_submit jdl_train/submit_haa.jdl --batch-name offlineTuples_train_haa
sleep 5
condor_submit jdl_train/submit_haahm.jdl --batch-name offlineTuples_train_haahm
sleep 5
condor_submit jdl_train/submit_hww.jdl --batch-name offlineTuples_train_hww
sleep 5
condor_submit jdl_train/submit_hwwhm.jdl --batch-name offlineTuples_train_hwwhm
sleep 5
condor_submit jdl_train/submit_hww2dmesh.jdl --batch-name offlineTuples_train_hww2dmesh
sleep 5
condor_submit jdl_train/submit_hww2dmeshhm.jdl --batch-name offlineTuples_train_hww2dmeshhm
sleep 5
condor_submit jdl_train/submit_hzz.jdl --batch-name offlineTuples_train_hzz
sleep 5
condor_submit jdl_train/submit_hzzhm.jdl --batch-name offlineTuples_train_hzzhm
sleep 5
condor_submit jdl_train/submit_hzz2dmesh.jdl --batch-name offlineTuples_train_hzz2dmesh
sleep 5
condor_submit jdl_train/submit_hzz2dmeshhm.jdl --batch-name offlineTuples_train_hzz2dmeshhm
sleep 5
condor_submit jdl_train/submit_ttbarvm.jdl --batch-name offlineTuples_train_ttbarvm
sleep 5
condor_submit jdl_train/submit_ttbarvmhm.jdl --batch-name offlineTuples_train_ttbarvmhm
sleep 5
condor_submit jdl_train/submit_haa4p.jdl --batch-name offlineTuples_train_haa4p
sleep 5
condor_submit jdl_train/submit_haa4phm.jdl --batch-name offlineTuples_train_haa4phm
sleep 5
condor_submit jdl_train/submit_qcd.jdl --batch-name offlineTuples_train_qcd