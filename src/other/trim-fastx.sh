
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options="-l 0 -n -v"
fastx_clipper -a $N712F $options -i $filename -o $filename.N712F
fastx_clipper -a $N712R $options -i $filename -o $filename.N712R
fastx_clipper -a $N504F $options -i $filename -o $filename.N504F
fastx_clipper -a $N504R $options -i $filename -o $filename.N504R

fastx_clipper -a $N712F $options -i $filename -o $filename.1.fastq
fastx_clipper -a $N712R $options -i $filename.1.fastq -o $filename.2.fastq
fastx_clipper -a $N504F $options -i $filename.2.fastq -o $filename.3.fastq
fastx_clipper -a $N504R $options -i $filename.3.fastq -o $filename.4.fastq

