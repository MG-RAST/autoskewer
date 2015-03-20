#!/bin/bash

# Script to check the first N reads of an input file against two databases
# of known adapter sequences, count the adapters that have the most alingments,
# and create both a list of adapter counts (in the sample) and the bowtie2 
# output, recording the fraction of reads with alignments

filename=$1

set -e
set -x

if [[ ! -e $filename ]] 
then
echo "Can't find file $filename !"
exit 1 
fi

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATAPATH=$DIR/../data

bowtie2 -x $DATAPATH/vectors-P5  $filename --no-head --local --upto 2000000 -p 4 > $filename.P5.tmp 2> $filename.P5.err
bowtie2 -x $DATAPATH/vectors-P7  $filename --no-head --local --upto 2000000 -p 4 > $filename.P7.tmp 2> $filename.P7.err

cut -f 3  $filename.P5.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $filename.P5.csv
cut -f 3  $filename.P7.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $filename.P7.csv

rm  $filename.P5.tmp
rm  $filename.P7.tmp
