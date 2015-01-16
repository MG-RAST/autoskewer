#!/usr/bin/env python

import sys, os
from optparse import OptionParser
from string import maketrans
from subprocess import check_call

def revc(s):
    '''reverse complement a string'''
    t = " " * len(s)
    l=len(s)
    intab = "AaCcGgTt"
    outtab = "TtGgCcAa"
    trantab = maketrans(intab, outtab)
    t=s.translate(trantab)[::-1]
    return t

def read_fasta_to_table(filen):
    table = {} 
    for line in open(filen):
        if line[0] == ">":  
            header = line.strip()[1:]
        else:
            sequence = line.strip()
            table[header] = sequence
    return table

def grab_first_field(filen):
    contents = open(filen).readlines()
    firstfield = contents[0].strip().split("\t")[0]
    return firstfield

if __name__ == '__main__':
    usage  = "usage: %prog -i <input sequence file> -o <output file>"
    parser = OptionParser(usage)
#    parser.add_option("-i", "--input",  dest="input", default=None, help="Input sequence file.")
#    parser.add_option("-o", "--output", dest="output", default=None, help="Output file.")
    parser.add_option("-v", "--verbose", dest="verbose", action="store_true", default=True, help="Verbose [default off]")
  
    (opts, args) = parser.parse_args()
    filename = args[0]
    if not (filename and os.path.isfile(filename) ):
        parser.error("Missing input file" )
    P5table = read_fasta_to_table("/home/ubuntu/vectors-P5.fa")
    P7table = read_fasta_to_table("/home/ubuntu/vectors-P7.fa")
    P5adaptername = grab_first_field(filename + ".P5.csv")
    P7adaptername = grab_first_field(filename + ".P7.csv")
    P5adapter = P5table[P5adaptername]
    P7adapter = P7table[P7adaptername]
    P5r = revc(P5adapter)
    P7r = revc(P7adapter)
    print P5adapter
    print P5r
    print P7adapter
    print P7r  
    check_call(["skew.sh", filename, P7adapter, P7r, P5adapter, P5r])
