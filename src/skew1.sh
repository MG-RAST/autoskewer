#!/bin/bash

filename=$1

# skew.sh sample.fastq TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG
echo ">adapt1" > adapter.fa
echo $2 >> adapter.fa
echo ">adapt2" >> adapter.fa
echo $3 >> adapter.fa
echo ">adapt3" >> adapter.fa
echo $4 >> adapter.fa
echo ">adapt4" >> adapter.fa
echo $5 >> adapter.fa

options="-l 1 --quiet"
stem=${filename/.fastq/}

#skewer -x $2 $options $filename       -o $stem.1 
#skewer -x $3 $options $stem.1-trimmed.fastq -o $stem.2 
#skewer -x $4 $options $stem.2-trimmed.fastq -o $stem.3 
#skewer -x $5 $options $stem.3-trimmed.fastq -o $stem.4 

skewer -x adapter.fa $options $filename -o $stem.4 

# clean up
#mv $stem.1-trimmed.log $stem.scrubbed.1.log
#mv $stem.2-trimmed.log $stem.scrubbed.2.log
#mv $stem.3-trimmed.log $stem.scrubbed.3.log
#mv $stem.4-trimmed.log $stem.scrubbed.4.log
mv $stem.4-trimmed.fastq $stem.scrubbed.fastq
# rm $stem.[123]-trimmed.fastq
