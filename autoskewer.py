#!/usr/bin/env python

import sys, os
from optparse import OptionParser
from string import maketrans
from subprocess import check_call

def idvector(fname):
    '''Run bowtie2 on dataset against library of adapters; create intermediate file with sorted list of adapter names'''
    DATAPATH = os.path.dirname(sys.argv[0])+"/data"
    print(DATAPATH+"/vectors-P5.4.bt2")
    if not os.path.exists(DATAPATH+"/vectors-P5.4.bt2"):
        sys.stderr.write("Can't find bowtie2 index in data directory!\n")
        sys.exit(1)
    check_call("bowtie2 -x {}/vectors-P5  {} --no-head --local --upto 2000000 -p 4 > {}.P5.tmp 2> {}.P5.err".format(DATAPATH, fname, fname, fname), shell=True)
    check_call("bowtie2 -x {}/vectors-P7  {} --no-head --local --upto 2000000 -p 4 > {}.P7.tmp 2> {}.P7.err".format(DATAPATH, fname, fname, fname), shell=True)
    check_call("cut -f 3  {}.P5.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{{print $2 \"\t\" $1}}' | sort -k 2 -n -r > {}.P5.csv".format(fname, fname), shell=True)
    check_call("cut -f 3  {}.P7.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{{print $2 \"\t\" $1}}' | sort -k 2 -n -r > {}.P7.csv".format(fname,fname), shell=True)
    if not opts.verbose:
        os.remove(filename+".P5.tmp"); os.remove(filename+".P7.tmp"); os.remove(filename+".P5.err"); os.remove(filename+".P7.err")
    return

def revc(s):
    '''reverse complement a string'''
    t = " " * len(s)
    l = len(s)
    intab = "AaCcGgTt"
    outtab = "TtGgCcAa"
    trantab = maketrans(intab, outtab)
    t = s.translate(trantab)[::-1]
    return t

def write_adapter_fasta(filename, namesandadapters):
    '''Writes a fasta file containing a handful of sequence names, sequences'''
    fh = open(filename, 'w')
    assert len(namesandadapters) % 2 == 0
    for i in range(len(namesandadapters)/2):
        if len(namesandadapters[2*i + 1]) > 0:
            fh.write(">"+namesandadapters[2*i]+"\n" +
                     namesandadapters[2*i + 1] + "\n")
    fh.close()


def read_fasta_to_table(filen):
    '''Loads a simple fasta file into a dictionary'''
    table = {} 
    try:
        FILE = open(filen)
    except IOError:
        sys.stderr.write("Can't open file "+ filen + "!\n")
        sys.exit(1)
    for line in FILE: 
        if line[0] == ">":  
            header = line.strip()[1:].split()[0]
        else:
            sequence = line.strip()
            table[header] = sequence
    return table

def grab_first_field(filen):
    '''Opens file, returns the header name of the first field'''
    try:
        contents = open(filen).readlines()
    except IOError:
        sys.stderr.write("Can't open file "+ filen + "!\n")
        sys.exit(1)
    try:
        firstfield = contents[0].strip().split("\t")[0]
        return firstfield
    except IndexError:
        return ""

if __name__ == '__main__':
    usage = "usage: %prog <fastqfile>\nExamines FASTQ for barcodes, produces fastqfile-trimmed.fastq"
    parser = OptionParser(usage)
#    parser.add_option("-i", "--input",  dest="input", default=None, help="Input sequence file.")
#    parser.add_option("-o", "--output", dest="output", default=None, help="Output file.")
    parser.add_option("-v", "--verbose", dest="verbose", action="store_true", default=False, help="Verbose [default off]")
  
    (opts, args) = parser.parse_args()
    dirname = os.path.dirname(os.path.realpath(sys.argv[0]))
    if not len(args) == 1:
        parser.error("Missing input filename")
    filename = args[0]
    if filename[-6:] == ".fastq":
        filestem = filename[:-6]
    else:
        filestem = filename
    if not (filename and os.path.isfile(filename)):
        parser.error("Missing input file")
    idvector(filename)
    P5table = read_fasta_to_table(dirname + "/data/vectors-P5.fa")
    P7table = read_fasta_to_table(dirname + "/data/vectors-P7.fa")
    P5table[""] = ""
    P7table[""] = ""
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
    write_adapter_fasta(filestem+".adapter.fa", 
                        [P5adaptername, P5adapter, P5adaptername+"_R", 
                        P5r, P7adaptername, P7adapter, 
                        P7adaptername+"_R", P7r])
    options = "-k 5 -l 0 --quiet -t 4 -r .2 -m any"

    skewcmd = "skewer -x " + filestem + ".adapter.fa " + options + " " + filename +" -o " + filestem + ".4"
    print skewcmd
    check_call(skewcmd.split(" "))
    os.rename(filestem + ".4-trimmed.fastq", 
              filestem + ".scrubbed.fastq")
    os.rename(filestem + ".4-trimmed.log", 
              filestem + ".scrubbed.log")
    if not opts.verbose:
        os.remove(filename+".P5.csv"); os.remove(filename+".P7.csv"); 
