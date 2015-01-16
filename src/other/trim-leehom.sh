
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options=""

leeHom -f $N712F $options -fq1 $filename -fqo $filename.N712F 2>  $filename.N712F.log
leeHom -f $N712R $options -fq1 $filename -fqo $filename.N712R 2>  $filename.N712R.log
leeHom -f $N504F $options -fq1 $filename -fqo $filename.N504F 2>  $filename.N504F.log
leeHom -f $N504R $options -fq1 $filename -fqo $filename.N504R 2>  $filename.N504R.log
gunzip $filename.N????.fq.gz 

leeHom -f $N712F $options -fq1 $filename   -fqo $filename.1 2>  $filename.1.log
leeHom -f $N712R $options -fq1 $filename.1.fq.gz -fqo $filename.2 2>  $filename.2.log
leeHom -f $N504F $options -fq1 $filename.2.fq.gz -fqo $filename.3 2>  $filename.3.log
leeHom -f $N504R $options -fq1 $filename.3.fq.gz -fqo $filename.4 2>  $filename.4.log
gunzip $filename.1.fq.gz $filename.2.fq.gz $filename.3.fq.gz $filename.4.fq.gz
mv $filename.1.fq $filename.1.fastq
mv $filename.2.fq $filename.2.fastq
mv $filename.3.fq $filename.3.fastq
mv $filename.4.fq $filename.4.fastq
