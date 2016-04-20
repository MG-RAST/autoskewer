#!/bin/bash

# Script to check the first N reads of an input file against two databases
# of known adapter sequences, count the adapters that have the most alingments,
# and create both a list of adapter counts (in the sample) and the bowtie2 
# output, recording the fraction of reads with alignments

filename=$1
filestem=${filename/.fastq/}

set -e
set -x

if [[ ! -e $filename ]] 
then
echo "Can't find file $filename !"
exit 1 
fi

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATAPATH=$DIR/../data

if [[ ! -e $DATAPATH/vectors-P5.4.bt2 ]] 
then
echo "Can't find file bowtie index (in $DATAPATH), perhaps you didn't make bowtie indexes?"
exit 1 
fi

bowtie2 -x $DATAPATH/vectors-P5  $filename --no-head --local --upto 2000000 -p 4 > $filestem.P5.tmp 2> $filestem.P5.err
bowtie2 -x $DATAPATH/vectors-P7  $filename --no-head --local --upto 2000000 -p 4 > $filestem.P7.tmp 2> $filestem.P7.err

cut -f 3  $filestem.P5.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $filestem.P5.csv
cut -f 3  $filestem.P7.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $filestem.P7.csv

rm  $filestem.P5.tmp
rm  $filestem.P7.tmp
