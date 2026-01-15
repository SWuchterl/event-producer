# ls -1 --color=no /nfs/dust/cms/group/topcmsdesy/ntuple13tev/2015_10_22_TAG_V011/*.root | grep -v ttbarH > selectionList.txt

# root://eoscms.cern.ch//store/group/cmst3/group/deepjet/ScoutingAK15/ScoutingTrees/dnntuples/v10_ul_train/test/$(PROCNAME)/dnnTuples_$(Cluster)-$(Process).root

# basePath=/eos/cms/store/group/cmst3/group/deepjet/ScoutingAK15/2024/
basePath=/eos/cms/store/group/cmst3/group/deepjet/ScoutingAK15/2024MiniAOD_v2/
# basePathTest=/eos/cms/store/group/cmst3/group/deepjet/ScoutingAK15/2024_test/
basePathTest=/eos/cms/store/group/cmst3/group/deepjet/ScoutingAK15/2024MiniAOD_v2_test/

ls -1 --color=no ${basePath}/BulkGravitonToHHTo4QGluLTau_MX-600to6000_MH-15to650/MiniAODv6/*.root > mc_2024_higgs2p_private_filelist.txt
ls -1 --color=no ${basePath}/H3ToHpHmTo4Q_MX-600to6000_MH-15to650/MiniAODv6/*.root > mc_2024_hphm2p_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-170to300_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd170to300_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-300to470_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd300to470_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-470to600_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd470to600_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-600to800_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd600to800_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-800to1000_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd800to1000_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-1000to1400_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd1000to1400_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-1400to1800_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd1400to1800_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-1800to2400_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd1800to2400_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-2400to3200_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd2400to3200_private_filelist.txt
ls -1 --color=no ${basePath}/QCD_PT-3200toInf_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_qcd3200toinf_private_filelist.txt

ls -1 --color=no ${basePathTest}/BulkGravitonToHHTo4QGluLTau_MH-125_LowPt/MiniAODv6/*.root > mc_2024_test_higlo_private_filelist.txt
ls -1 --color=no ${basePathTest}/BulkGravitonToHHTo4QGluLTau_MH-125_HighPt/MiniAODv6/*.root > mc_2024_test_highi_private_filelist.txt
ls -1 --color=no ${basePathTest}/H3ToHpHmTo4Q_MH-80_LowPt/MiniAODv6/*.root > mc_2024_test_hphmlo_private_filelist.txt
ls -1 --color=no ${basePathTest}/H3ToHpHmTo4Q_MH-80_HighPt/MiniAODv6/*.root > mc_2024_test_hphmhi_private_filelist.txt
# ls -1 --color=no ${basePathTest}/QCD_PT-470to600_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcdlo_private_filelist.txt
# ls -1 --color=no ${basePathTest}/QCD_PT-1000to1400_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcdhi_private_filelist.txt
# new in bins
ls -1 --color=no ${basePathTest}/QCD_PT-170to300_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd170to300_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-300to470_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd300to470_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-470to600_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd470to600_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-600to800_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd600to800_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-800to1000_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd800to1000_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-1000to1400_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd1000to1400_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-1400to1800_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd1400to1800_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-1800to2400_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd1800to2400_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-2400to3200_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd2400to3200_private_filelist.txt
ls -1 --color=no ${basePathTest}/QCD_PT-3200toInf_TuneCP5_13p6TeV_pythia8/MiniAODv6/*.root > mc_2024_test_qcd3200toinf_private_filelist.txt
# replace mount with real eos path

find *.txt -type f -exec sed -z -i 's/\/eos\/cms\/store\//root:\/\/eoscms.cern.ch\/\/store\//g' {} \;