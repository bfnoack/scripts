#!/bin/bash
#SBATCH -e ./pipeline-err-%j
#SBATCH -o ./pipeline-out-%j
# this script will do the analysis pipeline on one sample. Call this script from a new script to customize it and run it over multiple samples.

#set -e
set -u

sample=$1
adapters=$2
SCRIPTS_DIR="/group/mahergrp/scripts"
CONTIG_DIR_TEMP="contigs-$(basename $sample)" #gets the folder where the contigs will be stored
CONTIG_DIR=${CONTIG_DIR_TEMP%%.*}

bash ${SCRIPTS_DIR}/idba_assemble.sh $sample $adapters
bash ${SCRIPTS_DIR}/clean_idba.sh ${CONTIG_DIR}
bash ${SCRIPTS_DIR}/mpiblast_bash.sh ${CONTIG_DIR}/contig.fa
python ${SCRIPTS_DIR}/parse_blast_xml.py ${CONTIG_DIR}/contig.fa.xml ${CONTIG_DIR}/contig.fa
python ${SCRIPTS_DIR}/strict_summary.py ${CONTIG_DIR}/contig.summary.tsv
