#!/bin/bash
bowtie2 ~/vectors-P5 $1 --no-head --local --upto 1000000 -p 4 > $1.P5.tmp 2> $1.P5.err
bowtie2 ~/vectors-P7 $1 --no-head --local --upto 1000000 -p 4 > $1.P7.tmp 2> $1.P7.err

cut -f 3  $1.P5.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $1.P5.csv
cut -f 3  $1.P7.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{print $2 "\t" $1}' | sort -k 2 -n -r > $1.P7.csv

rm  $1.P5.tmp
rm  $1.P7.tmp
