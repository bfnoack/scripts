#!/bin/bash

# Use 2 nodes with 8 tasks each, for 16 MPI tasks:
#SBATCH --nodes=1
#SBATCH --tasks-per-node=8
#SBATCH -p bigmemm

# Specify a job name:
#SBATCH -J MPIBlast

# Specify an output file
#SBATCH -o out_MyMPIJob.%j
#SBATCH -e err_MyMPIJob.%j

# Load module and run a command
module load mpiBLAST

Data=/group/mahergrp/software/blast-2.2.24/data

BLASTDB=/group/mahergrp/data/refseq
BLASTMAT=/group/mahergrp/software/blast-2.2.24/data

Shared=/group/mahergrp/data/refseq
Local=/group/mahergrp/data/refseq

# to make your own database, please refer to: http://www.mpiblast.org/Docs/Guide

# if the database in the current folder
#export MPIBLAST_SHARED=.

# if the database in somewhere else
#export MPIBLAST_SHARED=/some/folder

# using default folder (/gpfs/scratch/shared/mpiblast)
SLURM_NPROCS=$(( $SLURM_NNODES * $SLURM_NTASKS_PER_NODE ))

mpirun -n $SLURM_NPROCS mpiblast -p blastx -d viral.1.protein.faa -i $1 -o $1.xml -b 1 -m 7
