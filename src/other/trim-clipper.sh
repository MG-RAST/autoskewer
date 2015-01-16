
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options=""


fastq-clipper $options $filename $N712F > $filename.N712F.fastq 2>  $filename.N712F.log
fastq-clipper $options $filename $N712R > $filename.N712R.fastq 2>  $filename.N712R.log
fastq-clipper $options $filename $N504F > $filename.N504F.fastq 2>  $filename.N504F.log
fastq-clipper $options $filename $N504R > $filename.N504R.fastq 2>  $filename.N504R.log


fastq-clipper $options $filename  $N712F:$N712R:$N504F:$N504R > $filename.all.fastq 2>  $filename.all.log


