#!/bin/bash -l
#this script will assemble each file in the dsRNA W1-W12 samples

samples=( W10_CCGTCC_L008_R1_001.fastq.gz W1_ACAGTG_L007_R1_001.fastq.gz W4_GTGAAA_L007_R1_001.fastq.gz W7_CGATGT_L008_R1_001.fastq.gz W11_AGTCAA_L008_R1_001.fastq.gz W2_GCCAAT_L007_R1_001.fastq.gz W5_GTCCGC_L007_R1_001.fastq.gz W8_TGACCA_L008_R1_001.fastq.gz W12_AGTTCC_L008_R1_001.fastq.gz W3_CTTGTA_L007_R1_001.fastq.gz W6_ATGTCA_L007_R1_001.fastq.gz W9_CAGATC_L008_R1_001.fastq.gz )

for i in "${samples[@]}"
do
    sbatch -p bigmemm idba_assemble.sh $i ../resources/WGA_adapters.fasta
done
