masses = [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]

template = open('ZHToXX_M-MASS_TuneCP5_13TeV-powheg-pythia8.py').read()
for mass in masses:
    # print (template)
    content = template.replace('_MHMASS.0', f'{mass}.0')
    content = content.replace('_MHMASS', f'_M{mass}')
    with open(f'ZHToXX_M-{mass}_TuneCP5_13TeV-powheg-pythia8.py', 'w') as fout:
        fout.write(content)

template = open('WminusHToXX_M-MASS_TuneCP5_13TeV-powheg-pythia8.py').read()
for mass in masses:
    # print (template)
    content = template.replace('_MHMASS.0', f'{mass}.0')
    content = content.replace('_MHMASS', f'_M{mass}')
    with open(f'WminusHToXX_M-{mass}_TuneCP5_13TeV-powheg-pythia8.py', 'w') as fout:
        fout.write(content)

template = open('WplusHToXX_M-MASS_TuneCP5_13TeV-powheg-pythia8.py').read()
for mass in masses:
    # print (template)
    content = template.replace('_MHMASS.0', f'{mass}.0')
    content = content.replace('_MHMASS', f'_M{mass}')
    with open(f'WplusHToXX_M-{mass}_TuneCP5_13TeV-powheg-pythia8.py', 'w') as fout:
        fout.write(content)