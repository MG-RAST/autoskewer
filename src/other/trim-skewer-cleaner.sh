
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options="-l 0 --quiet"
stem=${filename/.fastq/}

skewer -x $N712F $options $filename       -o $stem.1 
skewer -x $N712R $options $stem.1-trimmed.fastq -o $stem.2 
skewer -x $N504F $options $stem.2-trimmed.fastq -o $stem.3 
skewer -x $N504R $options $stem.3-trimmed.fastq -o $stem.4 

# clean up
mv $stem.1-trimmed.log $stem.scrubbed.1.log
mv $stem.2-trimmed.log $stem.scrubbed.2.log
mv $stem.3-trimmed.log $stem.scrubbed.3.log
mv $stem.4-trimmed.log $stem.scrubbed.4.log
mv $stem.4-trimmed.fastq $stem.scrubbed.fastq
rm $stem.[123]-trimmed.fastq
