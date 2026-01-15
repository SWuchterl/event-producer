# # MINIAODs test
# condor_submit jdl/test/submit_highi.jdl -batch-name miniaod_test_highi
# sleep 5
# condor_submit jdl/test/submit_higlo.jdl -batch-name miniaod_test_higlo
# sleep 5
# condor_submit jdl/test/submit_hphmhi.jdl -batch-name miniaod_test_hphmhi
# sleep 5
# condor_submit jdl/test/submit_hphmlo.jdl -batch-name miniaod_test_hphmlo
# sleep 5
# condor_submit jdl/test/submit_qcdhi.jdl -batch-name miniaod_test_qcdhi
# sleep 5
# condor_submit jdl/test/submit_qcdlo.jdl -batch-name miniaod_test_qcdlo
# sleep 5
# condor_submit jdl/test/submit_qcd1000to1400.jdl -batch-name miniaod_test_qcd1000to1400
# sleep 5
# condor_submit jdl/test/submit_qcd1400to1800.jdl -batch-name miniaod_test_qcd1400to1800
# sleep 5
# condor_submit jdl/test/submit_qcd170to300.jdl -batch-name miniaod_test_qcd170to300
# sleep 5
# condor_submit jdl/test/submit_qcd1800to2400.jdl -batch-name miniaod_test_qcd1800to2400
# sleep 5
# condor_submit jdl/test/submit_qcd2400to3200.jdl -batch-name miniaod_test_qcd2400to3200
# sleep 5
# condor_submit jdl/test/submit_qcd300to470.jdl -batch-name miniaod_test_qcd300to470
# sleep 5
# condor_submit jdl/test/submit_qcd3200toinf.jdl -batch-name miniaod_test_qcd3200toinf
# sleep 5
# condor_submit jdl/test/submit_qcd470to600.jdl -batch-name miniaod_test_qcd470to600
# sleep 5
# condor_submit jdl/test/submit_qcd600to800.jdl -batch-name miniaod_test_qcd600to800
# sleep 5
# condor_submit jdl/test/submit_qcd800to1000.jdl -batch-name miniaod_test_qcd800to1000
# sleep 5

# # MINIAODs train
# condor_submit jdl/train/submit_higgs2p.jdl -batch-name miniaod_train_higgs2p
# sleep 5
condor_submit jdl/train/submit_higgs2plowpt.jdl -batch-name miniaod_train_higgs2plowpt
sleep 5
# condor_submit jdl/train/submit_hphm2p.jdl -batch-name miniaod_train_hphm2p
# sleep 5
# condor_submit jdl/train/submit_qcd1000to1400.jdl -batch-name miniaod_train_qcd1000to1400
# sleep 5
# condor_submit jdl/train/submit_qcd1400to1800.jdl -batch-name miniaod_train_qcd1400to1800
# sleep 5
# condor_submit jdl/train/submit_qcd170to300.jdl -batch-name miniaod_train_qcd170to300
# sleep 5
# condor_submit jdl/train/submit_qcd1800to2400.jdl -batch-name miniaod_train_qcd1800to2400
# sleep 5
# condor_submit jdl/train/submit_qcd2400to3200.jdl -batch-name miniaod_train_qcd2400to3200
# sleep 5
# condor_submit jdl/train/submit_qcd300to470.jdl -batch-name miniaod_train_qcd300to470
# sleep 5
# condor_submit jdl/train/submit_qcd3200toinf.jdl -batch-name miniaod_train_qcd3200toinf
# sleep 5
# condor_submit jdl/train/submit_qcd470to600.jdl -batch-name miniaod_train_qcd470to600
# sleep 5
# condor_submit jdl/train/submit_qcd600to800.jdl -batch-name miniaod_train_qcd600to800
# sleep 5
# condor_submit jdl/train/submit_qcd800to1000.jdl -batch-name miniaod_train_qcd800to1000
# sleep 5