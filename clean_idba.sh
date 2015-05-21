#!/bin/bash
# use to clean idba assemblies. must provide directory as first argument
set -u

dir=$1

#find . -type f -name "graph-??.fa","align-??.fa","local-contig-??.fa" -exec rm {}
rm ${dir}/align-??
rm ${dir}/align-??-?
rm ${dir}/graph-??.fa
rm ${dir}/kmer
rm ${dir}/local-contig-??.fa
