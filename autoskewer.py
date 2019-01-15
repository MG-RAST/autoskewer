#!/usr/bin/env python

import sys, os
from optparse import OptionParser

try:
    from string import maketrans
except ImportError:
    maketrans = "".maketrans

from subprocess import check_call
import shutil

def idfiletype(fname):
    with open(fname) as p:
       firstline = p.readline()
       if firstline[0] == ">":
           return "FASTA"
       if firstline[0] == "@":
           return "FASTQ"
       sys.exit("Cannot identify sequence file type")

def idvector(fname):
    '''Run bowtie2 on dataset against library of adapters; create intermediate file with sorted list of adapter names'''
    if TYPE == "FASTA":
        OPTIONS = "-f"
    else:
        OPTIONS = "-q"
    if not os.path.exists(DATAPATH+"/vectors-P5.4.bt2"):
        sys.stderr.write("Can't find bowtie2 index in data directory!\n")
        sys.exit(1)
    check_call("bowtie2 -x {}/vectors-P5 {} {} --no-head --local --upto 2000000 -p 4 > {}.P5.tmp 2> {}.P5.err".format(DATAPATH, OPTIONS, fname, PATHPREFIX, PATHPREFIX), shell=True)
    check_call("bowtie2 -x {}/vectors-P7 {} {} --no-head --local --upto 2000000 -p 4 > {}.P7.tmp 2> {}.P7.err".format(DATAPATH, OPTIONS, fname, PATHPREFIX, PATHPREFIX), shell=True)
    check_call("cut -f 3  {}.P5.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{{print $2 \"\t\" $1}}' | sort -k 2 -n -r > {}.P5.csv".format(PATHPREFIX, PATHPREFIX), shell=True)
    check_call("cut -f 3  {}.P7.tmp | grep -v '*' | head -n 100000 | sort | uniq -c | awk '{{print $2 \"\t\" $1}}' | sort -k 2 -n -r > {}.P7.csv".format(PATHPREFIX, PATHPREFIX), shell=True)
    if not opts.verbose:
        os.remove(PATHPREFIX+".P5.tmp"); os.remove(PATHPREFIX+".P7.tmp"); os.remove(PATHPREFIX+".P5.err"); os.remove(PATHPREFIX+".P7.err")
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
    for i in range(int(len(namesandadapters)/2)):
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
    usage = "usage: %prog -i <input seqfile> -o <scrubbed seqfile>\nExamines FASTA or FASTQ for barcodes"
    parser = OptionParser(usage)
    parser.add_option("-p", "--processes", dest="processes", type=int, default=4, help="Number of processes (default 4)")
    parser.add_option("-i", "--input", dest="input", default=None, help="Input sequence file.")
    parser.add_option("-o", "--output", dest="output", default=None, help="Output scrubbed file.")
    parser.add_option("-l", "--logfile", dest="logfile", default=None, help="Output log file [default STDOUT]")
    parser.add_option("-t", "--tmpdir", dest="tmpdir", default=".", help="DIR for intermediate files [default CWD]")
    parser.add_option("-v", "--verbose", dest="verbose", action="store_true", default=False, help="Verbose [default off]")
  
    (opts, args) = parser.parse_args()
    if not (opts.input and os.path.isfile(opts.input)):
        if len(args) == 1 and os.path.isfile(args[0]):
             filename = args[0]
        else:
            parser.error("Missing input file or wrong number of arguments")
    else:
        filename = opts.input
    if filename[-6:-1] == ".fast": 
        filestem = filename[:-6]
    else:
        filestem = filename

    TYPE = idfiletype(filename)
    TMPDIR = opts.tmpdir
    DATAPATH = os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), "data")
    PATHPREFIX = os.path.join(TMPDIR, os.path.basename(filestem))
    if opts.verbose:
        print("TYPE: "+TYPE)
        print("TMPDIR: "+TMPDIR)
        print("DATAPATH: "+DATAPATH)
        print("PATHPREFIX: "+PATHPREFIX)
    if not opts.output:  # guess output file name
        outputfile = filestem + ".scrubbed." + TYPE.lower()
    else: 
        outputfile = opts.output

    idvector(filename)
    P5table = read_fasta_to_table(os.path.join(DATAPATH, "vectors-P5.fa"))
    P7table = read_fasta_to_table(os.path.join(DATAPATH, "vectors-P7.fa"))
    P5table[""] = ""
    P7table[""] = ""
    P5adaptername = grab_first_field(PATHPREFIX + ".P5.csv")
    P7adaptername = grab_first_field(PATHPREFIX + ".P7.csv")
    P5adapter = P5table[P5adaptername]
    P7adapter = P7table[P7adaptername]
    P5r = revc(P5adapter)
    P7r = revc(P7adapter)
    if opts.verbose:
        print(P5adapter)
        print(P5r)
        print(P7adapter)
        print(P7r)

    
    adaptorfile = PATHPREFIX + ".adapter.fa"
    skewoutname = PATHPREFIX + ".4"
    skewoptions = "-k 5 -l 0 --quiet -t {} -r .2 -m any".format(str(opts.processes))
    write_adapter_fasta(adaptorfile, 
                        [P5adaptername, P5adapter, P5adaptername+"_R", 
                        P5r, P7adaptername, P7adapter, 
                        P7adaptername+"_R", P7r])

    skewcmd = "skewer -x {adaptorfile} {options} {filename} -o {filestem}.4".format(adaptorfile=adaptorfile, options=skewoptions, filename=filename, filestem=filestem)
    if opts.verbose:
        print(skewcmd)
    check_call(skewcmd.split(" "))
    
    shutil.move(skewoutname+"-trimmed.fastq", opts.output)
    if opts.logfile:
        shutil.move(skewoutname+"-trimmed.log", opts.logfile)
    else:
        os.rename(filestem + ".4-trimmed.log", filestem + ".scrubbed.log")

    shutil.move(filestem + ".4-trimmed.fastq", outputfile)
    if (opts.logfile):
        shutil.move(filestem + ".4-trimmed.log", opts.logfile)
    else:
        shutil.move(filestem + ".4-trimmed.log", filestem + ".scrubbed.log")
#        print(open(filestem + ".4-trimmed.log", 'r').read())
    
    if not opts.verbose:
        os.remove(PATHPREFIX+".P5.csv"); os.remove(PATHPREFIX+".P7.csv");
