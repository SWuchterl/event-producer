masses = [10, 20, 30, 40, 50, 150, 250, 500, 1000, 1500, 2500, 4000, 6000]

template = open('VBFHToXX_M-MASS_TuneCP5_13TeV-powheg-pythia8.py').read()

for mass in masses:
    # print (template)
    content = template.replace('_MHMASS.0', f'{mass}.0')
    content = content.replace('_MHMASS', f'_M{mass}')
    with open(f'VBFHToXX_M-{mass}_TuneCP5_13TeV-powheg-pythia8.py', 'w') as fout:
        fout.write(content)