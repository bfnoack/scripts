# FPS scripts
This repository contains scripts to analyze data at Foundation Plant Services.

## Scripts
`idba_assemble.sh <reads.fastq> <adapters.fasta>`: this script will trim adapters, remove low-quality sequences, and assemble sequences using IBDA_UD. It is meant to be used like so: `$ sbatch -p <cluster-queue> idba_assemble.sh <reads.fastq> <adapters.fasta>`. It will produce output in the directory it is currently running in. It will also save standard output in a file called `assemble-out-<jobID>.txt` and standard error in a file called `assemble-error-<jobID>.txt`. These files can be removed after a successful run.