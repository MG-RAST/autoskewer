#!/bin/bash

# Script to check the first N reads of an input file against two databases
# of known adapter sequences, count the adapters that have the most alingments,
# and create both a list of adapter counts (in the sample) and the bowtie2 
# output, recording the fraction of reads with alignments

set -e
set -x
 
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATAPATH=$DIR/../data

if [[ ! -e $1 ]] 
then
echo "Can't find file $1 !"
exit 1 
fi

bowtie2 -x $DATAPATH/vectors-P5  $1 --no-head --local --upto 2000000 -p 4 > $1.P5.tmp 2> $1.P5.err
bowtie2 -x $DATAPATH/vectors-P7  $1 --no-head --local --upto 2000000 -p 4 > $1.P7.tmp 2> $1.P7.err

cut -f 3  $1.P5.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $1.P5.csv
cut -f 3  $1.P7.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $1.P7.csv

rm  $1.P5.tmp
rm  $1.P7.tmp
