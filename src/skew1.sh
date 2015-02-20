#!/bin/bash

filename=$1
stem=${filename/.fastq/}

if [ $# != 5 ] 
then
echo "Not enough arguments!"
echo "skew.sh filename.fastq ADAPTER1 ADAPTER2 ADAPTER3 ADAPTER4"
exit 1
fi

# skew.sh sample.fastq TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG
echo ">adapt1"  > $stem.adapter.fa
echo $2        >> $stem.adapter.fa
echo ">adapt2" >> $stem.adapter.fa
echo $3        >> $stem.adapter.fa
echo ">adapt3" >> $stem.adapter.fa
echo $4        >> $stem.adapter.fa
echo ">adapt4" >> $stem.adapter.fa
echo $5        >> $stem.adapter.fa

options="-k 5 -l 1 --quiet -t 4"

skewer -x $stem.adapter.fa $options $filename -o $stem.4 

# clean up
mv $stem.4-trimmed.fastq $stem.scrubbed.fastq
mv $stem.4-trimmed.log $stem.scrubbed.log
