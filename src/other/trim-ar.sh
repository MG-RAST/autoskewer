
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options=""


AdapterRemoval $options --file $filename --pcr1 $N712F --5prime $N712F --output1 $filename.N712F.fastq 2>  $filename.N712F.log
AdapterRemoval $options --file $filename --pcr1 $N712R --5prime $N712R --output1 $filename.N712R.fastq 2>  $filename.N712R.log
AdapterRemoval $options --file $filename --pcr1 $N504F --5prime $N504F --output1 $filename.N504F.fastq 2>  $filename.N504F.log
AdapterRemoval $options --file $filename --pcr1 $N504R --5prime $N504R --output1 $filename.N504R.fastq 2>  $filename.N504R.log


AdapterRemoval $options --file $filename         --pcr1 $N712F --5prime $N712F --output1 $filename.1.fastq 2>  $filename.1.log
AdapterRemoval $options --file $filename.1.fastq --pcr1 $N712R --5prime $N712R --output1 $filename.2.fastq 2>  $filename.2.log
AdapterRemoval $options --file $filename.2.fastq --pcr1 $N504F --5prime $N504F --output1 $filename.3.fastq 2>  $filename.3.log
AdapterRemoval $options --file $filename.3.fastq --pcr1 $N504R --5prime $N504R --output1 $filename.4.fastq 2>  $filename.4.log


