#!/bin/bash

set -e
set -u

sample=$1
adapters=$2

bash idba_assemble.sh $sample $adapters
bash mpiblast.sh contigs-$sample/contigs.fa
python blastxml_to_tabular.py --more optionsdfajsdlkj
