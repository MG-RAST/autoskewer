
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options="-O 6 -f fastq"

cutadapt -b $N712F $options  $filename > $filename.N712F.fastq 2>  $filename.N712F.log
cutadapt -b $N712R $options  $filename > $filename.N712R.fastq 2>  $filename.N712R.log
cutadapt -b $N504F $options  $filename > $filename.N504F.fastq 2>  $filename.N504F.log
cutadapt -b $N504R $options  $filename > $filename.N504R.fastq 2>  $filename.N504R.log
stem=${filename/.fastq/}

cutadapt -b $N712F $options  $filename   > $stem.1.fastq 2>  $stem.1.log
cutadapt -b $N712R $options  $stem.1.fastq > $stem.2.fastq 2>  $stem.2.log
cutadapt -b $N504F $options  $stem.2.fastq > $stem.3.fastq 2>  $stem.3.log
cutadapt -b $N504R $options  $stem.3.fastq > $stem.4.fastq 2>  $stem.4.log
