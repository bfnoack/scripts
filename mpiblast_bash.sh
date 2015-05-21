#!/bin/bash

module load mpiBLAST

Data=/group/mahergrp/software/blast-2.2.24/data

BLASTDB=/group/mahergrp/data/refseq
BLASTMAT=/group/mahergrp/software/blast-2.2.24/data

Shared=/group/mahergrp/data/refseq
Local=/group/mahergrp/data/refseq

mpirun -n 8 mpiblast -p blastx -d viral.1.protein.faa -i $1 -o $1.xml -b 1 -m 7
