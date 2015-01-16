
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options="-l 0 --quiet"
stem=${filename/.fastq/}

skewer -x $N712F $options $filename -o $stem.N712F 2>  $stem.N712F.log
skewer -x $N712R $options $filename -o $stem.N712R 2>  $file.N712R.log
skewer -x $N504F $options $filename -o $stem.N504F 2>  $file.N504F.log
skewer -x $N504R $options $filename -o $stem.N504R 2>  $file.N504R.log

skewer -x $N712F $options $filename       -o $stem.1 2>  $stem.1.log
skewer -x $N712R $options $stem.1-trimmed.fastq -o $stem.2 2>  $stem.2.log
skewer -x $N504F $options $stem.2-trimmed.fastq -o $stem.3 2>  $stem.3.log
skewer -x $N504R $options $stem.3-trimmed.fastq -o $stem.4 2>  $stem.4.log
