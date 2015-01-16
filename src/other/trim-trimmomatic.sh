#!/bin/bash

filename=$1
N712F=TCTGTCTCTTATACACATCTCCGAGCCCACGAGACgtagaggaATCTCGTATGCCGTCTTCTGCTTGAA
N504F=CTGTCTCTTATACACATCTGACGCTGCCGACGAtctactctGTGTAGATCTCGGTGGTCGCCGTATCATT
N712R=TTCAAGCAGAAGACGGCATACGAGATtcctctacGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGA   
N504R=AATGATACGGCGACCACCGAGATCTACACagagtagaTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  

echo java -jar $HOME/build/Trimmomatic-0.30/trimmomatic-0.30.jar SE $filename ${filename}.out ILLUMINACLIP:TruSeq2-SE:2:30:10
#java -jar $HOME/build/Trimmomatic-0.30/trimmomatic-0.30.jar SE $filename ${filename}.out ILLUMINACLIP:$HOME/build/Trimmomatic-0.30/adapters/TruSeq2-SE.fa:2:30:10
java -jar $HOME/build/Trimmomatic-0.30/trimmomatic-0.30.jar SE $filename ${filename}.out ILLUMINACLIP:adapters.fa:2:30:10 MINLEN:0

mv $filename.out $filename.4.fastq
