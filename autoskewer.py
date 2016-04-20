#!/usr/bin/env python

import sys, os
from optparse import OptionParser
from string import maketrans
from subprocess import call

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
    fh = open(filename, 'w')
    assert len(namesandadapters) % 2 == 0
    for i in range(len(namesandadapters)/2):
        if len(namesandadapters[2*i+1]) > 0:
            fh.write(">"+namesandadapters[2*i]+"\n" +
                     namesandadapters[2*i+1] + "\n")
    fh.close()


def read_fasta_to_table(filen):
    table = {} 
    try:
        FILE = open(filen)
    except IOError:
        sys.stderr.write("Can't open file"+ filen+ "!\n")
        sys.exit(1)
    for line in FILE: 
        if line[0] == ">":  
            header = line.strip()[1:].split()[0]
        else:
            sequence = line.strip()
            table[header] = sequence
    return table

def grab_first_field(filen):
    try:
        contents = open(filen).readlines()
    except IOError:
        sys.stderr.write("Can't open file"+ filen+ "!\n")
        sys.exit(1)
    try:
        firstfield = contents[0].strip().split("\t")[0]
        return firstfield
    except IndexError:
        return ""

if __name__ == '__main__':
    usage = "usage: %prog <filestem>\nExamines already-calculated .P5.csv and .P7.csv and invokes skew.sh"
    parser = OptionParser(usage)
#    parser.add_option("-i", "--input",  dest="input", default=None, help="Input sequence file.")
#    parser.add_option("-o", "--output", dest="output", default=None, help="Output file.")
    parser.add_option("-v", "--verbose", dest="verbose", action="store_true", default=True, help="Verbose [default off]")
  
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
    if not (os.path.isfile(filestem+".P5.csv")):
        call([dirname+"/src/idvector.sh", filename])
    P5table = read_fasta_to_table(dirname + "/data/vectors-P5.fa")
    P7table = read_fasta_to_table(dirname + "/data/vectors-P7.fa")
    P5table[""] = ""
    P7table[""] = ""
    P5adaptername = grab_first_field(filestem + ".P5.csv")
    P7adaptername = grab_first_field(filestem + ".P7.csv")
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

    skewcmd = "skewer -x " + filestem + ".adapter.fa "+ options + " " + filename +" -o " + filestem + ".4"
    print skewcmd
    call(skewcmd.split(" "))
    os.rename(filestem + ".4-trimmed.fastq", 
              filestem + ".scrubbed.fastq")
    os.rename(filestem + ".4-trimmed.log", 
              filestem + ".scrubbed.log")
#    call([dirname+"/src/skew1.sh", filename, P7adapter, P7r, P5adapter, P5r])
