import csv
import os
import re
from collections import defaultdict
from sys import argv


threshold = 10E-20

data = defaultdict(dict)
with open(argv[1]) as infile:
    for contig, hit, e, length, nuc in csv.reader(infile, delimiter='\t'):
        contig = int(contig.split(' ')[0].split('-')[1].split('_')[1])
	
        e = float(e)
        if e > threshold: continue
        pattern=r'.*\[(.*?)\].*'
        hit_sub = re.search(pattern, hit).group(1)
        data[contig][e] = [hit_sub, length, nuc]
        if len(data[contig]) > 3: data[contig].pop(min(data[contig]))


results = []
for contig,d in data.items():
    for e in sorted(d):
        results.append([contig, d[e][0], e, d[e][1], d[e][2]])


path = os.path.dirname(os.path.abspath(argv[1]))

with open(path+"/strict.summary.tsv", "w") as f:
    writer = csv.writer(f, delimiter="\t")
    for l in results:
        writer.writerows([l])

