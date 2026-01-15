# testing samples
condor_submit jdl/test/submit_highi_nanov15_private.jdl -batch-name ScoutingTree_test_highi
sleep 5
condor_submit jdl/test/submit_higlo_nanov15_private.jdl -batch-name ScoutingTree_test_higlo
sleep 5
condor_submit jdl/test/submit_hphmhi_nanov15_private.jdl -batch-name ScoutingTree_test_hphmhi
sleep 5
condor_submit jdl/test/submit_hphmlo_nanov15_private.jdl -batch-name ScoutingTree_test_hphmlo
sleep 5
# condor_submit jdl/test/submit_qcdhi_nanov15_private.jdl -batch-name ScoutingTree_test_qcdhi
sleep 5
# condor_submit jdl/test/submit_qcdlo_nanov15_private.jdl -batch-name ScoutingTree_test_qcdlo
sleep 5
# new in bins
condor_submit jdl/test/submit_qcd1000to1400_nanov15_private.jdl -batch-name ScoutingTree_test_qcd1000to1400
sleep 5
condor_submit jdl/test/submit_qcd1400to1800_nanov15_private.jdl -batch-name ScoutingTree_test_qcd1400to1800
sleep 5
condor_submit jdl/test/submit_qcd170to300_nanov15_private.jdl -batch-name ScoutingTree_test_qcd170to300
sleep 5
condor_submit jdl/test/submit_qcd1800to2400_nanov15_private.jdl -batch-name ScoutingTree_test_qcd1800to2400
sleep 5
condor_submit jdl/test/submit_qcd2400to3200_nanov15_private.jdl -batch-name ScoutingTree_test_qcd2400to3200
sleep 5
condor_submit jdl/test/submit_qcd300to470_nanov15_private.jdl -batch-name ScoutingTree_test_qcd300to470
sleep 5
condor_submit jdl/test/submit_qcd3200toinf_nanov15_private.jdl -batch-name ScoutingTree_test_qcd3200toinf
sleep 5
condor_submit jdl/test/submit_qcd470to600_nanov15_private.jdl -batch-name ScoutingTree_test_qcd470to600
sleep 5
condor_submit jdl/test/submit_qcd600to800_nanov15_private.jdl -batch-name ScoutingTree_test_qcd600to800
sleep 5
condor_submit jdl/test/submit_qcd800to1000_nanov15_private.jdl -batch-name ScoutingTree_test_qcd800to1000
sleep 5
# training samples
condor_submit jdl/train/submit_higgs2p_nanov15_private.jdl -batch-name ScoutingTree_train_higgs2p
sleep 5
condor_submit jdl/train/submit_hphm2p_nanov15_private.jdl -batch-name ScoutingTree_train_hphm2p
sleep 5
condor_submit jdl/train/submit_qcd1000to1400_nanov15_private.jdl -batch-name ScoutingTree_train_qcd1000to1400
sleep 5
condor_submit jdl/train/submit_qcd1400to1800_nanov15_private.jdl -batch-name ScoutingTree_train_qcd1400to1800
sleep 5
condor_submit jdl/train/submit_qcd170to300_nanov15_private.jdl -batch-name ScoutingTree_train_qcd170to300
sleep 5
condor_submit jdl/train/submit_qcd1800to2400_nanov15_private.jdl -batch-name ScoutingTree_train_qcd1800to2400
sleep 5
condor_submit jdl/train/submit_qcd2400to3200_nanov15_private.jdl -batch-name ScoutingTree_train_qcd2400to3200
sleep 5
condor_submit jdl/train/submit_qcd300to470_nanov15_private.jdl -batch-name ScoutingTree_train_qcd300to470
sleep 5
condor_submit jdl/train/submit_qcd3200toinf_nanov15_private.jdl -batch-name ScoutingTree_train_qcd3200toinf
sleep 5
condor_submit jdl/train/submit_qcd470to600_nanov15_private.jdl -batch-name ScoutingTree_train_qcd470to600
sleep 5
condor_submit jdl/train/submit_qcd600to800_nanov15_private.jdl -batch-name ScoutingTree_train_qcd600to800
sleep 5
condor_submit jdl/train/submit_qcd800to1000_nanov15_private.jdl -batch-name ScoutingTree_train_qcd800to1000
sleep 5