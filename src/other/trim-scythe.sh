
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options=""

scythe  -a adapters.fa  $filename > $filename.all.fastq 2>  $filename.all.log
scythe  -a N712F.fa  $filename > $filename.N712F.fastq 2>  $filename.N712F.log
scythe  -a N712R.fa  $filename > $filename.N712R.fastq 2>  $filename.N712R.log
scythe  -a N504F.fa  $filename > $filename.N504F.fastq 2>  $filename.N504F.log
scythe  -a N504R.fa  $filename > $filename.N504R.fastq 2>  $filename.N504R.log


