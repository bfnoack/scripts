#!/bin/bash -l
#SBATCH -J ibda_ud_assembly
#SBATCH -o assembly-out-%j.txt
#SBATCH -e assembly-error-%j.txt

module load python

set -e
set -u

software=/home/adurvasu/software

reads=$1
temp_sample=${reads##*/}
sample_no_file_ending=${temp_sample%%.*}
trimmedreads=$sample_no_file_ending-trimmed.fastq.gz
qualreads=$sample_no_file_ending-qual.fastq


#trim adaptors with WGA adaptors
>&2 echo "Trimming adaptors with cutadapt using supplied adaptor sequences"
${software}/cutadapt -a file:$2 \
    -e 0.1 -O 5 -m 15 \
    -o $trimmedreads $reads

#remove low quality sequences using the defaults
>&2 echo "Removing low quality sequences with sickle"
${software}/sickle se -f $trimmedreads -t sanger -o $qualreads

mkdir contigs-$sample_no_file_ending
>&2 echo '##########################'
>&2 echo '### Assembling '$reads' ###'
>&2 echo '##########################'
${software}/idba_ud -r $qualreads -o contigs-$sample_no_file_ending --mink 29 --maxk 49 --step 2
