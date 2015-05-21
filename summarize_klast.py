# usage: python summarize_klast.py <file.csv> [--sort-virus]
# this script will take a klast file and grab the
# organism name, contig name, contig length, read count

import csv
import re
import os
import ntpath
import operator
from sys import argv

results = []
with open(argv[1]) as f:
    reader = csv.reader(f)
    next(f) #skip header
    for line in reader:
        contig_name = line[0]
        contig_length = line[3]
        read_count = line[4]
        hit_def = line[6]
        try:
            # some fields have an n/a here so we need to avoid crashing if that happens
            pattern = r'.\[(.*?)\].'
            hit_sub = re.search(pattern, hit_def).group(1)
        except AttributeError:
            hit_sub = hit_def
        results.append([contig_name,contig_length, read_count, hit_sub])

path = os.path.dirname(os.path.abspath(argv[1]))
filename = ntpath.basename(argv[1])

if "--sort-virus" in argv:
    # sort viruses by name if the option is supplied
    results = sorted(results, key=operator.itemgetter(3))

with open(path+"/summary."+filename, "w") as f:
    writer = csv.writer(f)
    writer.writerow(["Contig Name", "Contig Length", "Read Count", "Species"])
    for l in results:
        writer.writerows([l])

