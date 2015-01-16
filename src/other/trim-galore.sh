
filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  
options="" 
stem=${filename/.fastq/}
trim_galore -a $N712F $options  $filename  2>  $filename.N712F.log ; mv ${stem}_trimmed.fq ${stem}.N712F.fastq

trim_galore -a $N712R $options  $filename  2>  $filename.N712R.log ; mv ${stem}_trimmed.fq ${stem}.N712R.fastq
trim_galore -a $N504F $options  $filename  2>  $filename.N504F.log ; mv ${stem}_trimmed.fq ${stem}.N504F.fastq
trim_galore -a $N504R $options  $filename  2>  $filename.N504R.log ; mv ${stem}_trimmed.fq ${stem}.N504R.fastq


trim_galore -a $N712F $options  $filename          2>  $filename.1.log ; mv  ${stem}_trimmed.fq ${stem}.1.fastq
trim_galore -a $N712R $options  ${stem}.1.fastq  2>  $filename.2.log ; mv ${stem}.1_trimmed.fq ${stem}.2.fastq 
trim_galore -a $N504F $options  ${stem}.2.fastq  2>  $filename.3.log ; mv ${stem}.2_trimmed.fq ${stem}.3.fastq
trim_galore -a $N504R $options  ${stem}.3.fastq  2>  $filename.4.log ; mv ${stem}.3_trimmed.fq ${stem}.4.fastq

