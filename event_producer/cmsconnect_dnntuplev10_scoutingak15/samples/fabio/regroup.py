# write a file that opens the file lists in this folder and rewrites them into new files that have 100 files per line, separated by commas
import os
filelist_dir = os.path.dirname(os.path.abspath(__file__))+"/orig/"
for filename in os.listdir(filelist_dir):
    if not filename.endswith('.txt'):
        continue
    filepath = os.path.join(filelist_dir, filename)
    with open(filepath, 'r') as f:
        lines = f.readlines()
    new_lines = []
    for i in range(0, len(lines), 10):
        chunk = lines[i:i+10]
        chunk = [line.strip() for line in chunk if line.strip()]
        if chunk:
            new_lines.append(','.join(chunk) + '\n')
    new_filepath = os.path.join(filelist_dir, "../",  filename)
    with open(new_filepath, 'w') as f:
        f.writelines(new_lines)