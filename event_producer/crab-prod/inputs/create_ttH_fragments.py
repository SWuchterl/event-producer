masses = [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]

template = open('ttH_M-MASS_TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8.py').read()

for mass in masses:
    # print (template)
    content = template.replace('_MHMASS.0', f'{mass}.0')
    content = content.replace('_MHMASS', f'_M{mass}')
    with open(f'ttH_M-{mass}_TTTo2L2Nu_TuneCP5_13TeV-powheg-pythia8.py', 'w') as fout:
        fout.write(content)

template = open('ttH_M-MASS_TTToHadronic_TuneCP5_13TeV-powheg-pythia8.py').read()

for mass in masses:
    # print (template)
    content = template.replace('_MHMASS.0', f'{mass}.0')
    content = content.replace('_MHMASS', f'_M{mass}')
    with open(f'ttH_M-{mass}_TTToHadronic_TuneCP5_13TeV-powheg-pythia8.py', 'w') as fout:
        fout.write(content)

template = open('ttH_M-MASS_TTToSemiLep_TuneCP5_13TeV-powheg-pythia8.py').read()

for mass in masses:
    # print (template)
    content = template.replace('_MHMASS.0', f'{mass}.0')
    content = content.replace('_MHMASS', f'_M{mass}')
    with open(f'ttH_M-{mass}_TTToSemiLep_TuneCP5_13TeV-powheg-pythia8.py', 'w') as fout:
        fout.write(content)