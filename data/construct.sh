cat 384.csv |sort| grep -v '#'| awk '{print ">Nextera-"$1"-"$2"\nTCTGTCTCTTATACACATCTCCGAGCCCACGAGAC" $2 "ATCTCGTATGCCGTCTTCTGCTTGAA" }' > nextera384.fa

