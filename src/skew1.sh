#!/bin/bash

# This was the driver for skewer.  It creates a fasta file with a handful of fasta sequences
# passed on the command line, and invokes skewer using this file.

# skew1.sh sample.fastq sequence1 [sequence2] [sequence3] [sequence4]

filename=$1
stem=${filename/.fastq/}

# skew.sh sample.fastq TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG
if [ "x$2" != "x" ] 
then
echo ">adapt1"  > $stem.adapter.fa
echo $2        >> $stem.adapter.fa
fi
if [ "x$3" != "x" ] 
then
echo ">adapt2" >> $stem.adapter.fa
echo $3        >> $stem.adapter.fa
fi 
if [ "x$4" != "x" ] 
then
echo ">adapt3" >> $stem.adapter.fa
echo $4        >> $stem.adapter.fa
fi
if [ "x$5" != "x" ] 
then
echo ">adapt4" >> $stem.adapter.fa
echo $5        >> $stem.adapter.fa
fi

# echo "Not enough arguments!"
# echo "skew.sh filename.fastq ADAPTER1 ADAPTER2 [ADAPTER3 ADAPTER4]"
# exit 1 

options="-k 5 -l 0 --quiet -t 4 -r .2 -m any"

skewer -x $stem.adapter.fa $options $filename -o $stem.4 

# clean up
mv $stem.4-trimmed.fastq $stem.scrubbed.fastq
mv $stem.4-trimmed.log $stem.scrubbed.log
