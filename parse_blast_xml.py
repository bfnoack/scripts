#!/usr/bin/env python
import csv
import os

from sys import argv
from Bio.Blast import NCBIXML
from Bio import SeqIO

try: 
    result_handle = open(argv[1])
    record_dict = SeqIO.index(argv[2], "fasta")
except: 
    print "Need to supply an XML file and fasta file.\nUsage: $ python parse_blast_xml.py <results.xml> <contig.fa>"
    exit(1)

blast_records = NCBIXML.parse(result_handle)
output_list = []

for res in blast_records:
    temp_list = []
    for alignment in res.alignments:
        sub_list = []
        sub_list.append(res.query)
        sub_list.append(alignment.title)
        sub_list.append(alignment.hsps[0].expect)
        sub_list.append(len(record_dict[res.query.split(" ")[0]].seq))
        sub_list.append(record_dict[res.query.split(" ")[0]].seq.tostring())
        temp_list.append(sub_list)
    output_list.append(temp_list)

path = os.path.dirname(os.path.abspath(argv[1]))


with open(path+"/contig.summary.tsv", "w") as f:
    writer = csv.writer(f, delimiter="\t")
    for l in output_list:
        writer.writerows(l)

    
