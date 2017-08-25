# autoskewer

Purpose
=======
Autoskewer is a sequence adapter trimmer intended to robustly remove adapter 
contamination from fastq-formatted sequence data without prior knowledge of
the contaminating adapter sequences.

Autoskewer is a wrapper for skewer, which actually performs the trimming.

Dependencies
============
Autoskewer depends on
* bowtie2 http://bowtie-bio.sourceforge.net/bowtie2/index.shtml
* skewer http://github.com/relipmoc/skewer
* python 2.7

Installation
============

    git clone http://github.com/wltrimbl/autoskewer
    cd autoskewer
    make

bowtie2, skewer, and the autoskewer/src directory must be in PATH.

Example invokation
==================

     autoskewer.py -v -i example/sample.fastq -o scrubbed.fastq -l scrubbed.log
 
Produces in verbose mode:
     sample.P5.csv
     sample.P5.tmp
     sample.P5.err
     sample.P7.csv
     sample.P7.tmp
     sample.P7.err

Usage
=======

Usage: autoskewer.py -i <input seqfile> -o <scrubbed seqfile>
Examines FASTA or FASTQ for barcodes

Options:
  -h, --help            show this help message and exit
  -i INPUT, --input=INPUT
                        Input sequence file.
  -o OUTPUT, --output=OUTPUT
                        Output scrubbed file.
  -l LOGFILE, --logfile=LOGFILE
                        Output log file [default STDOUT]
  -t TMPDIR, --tmpdir=TMPDIR
                        DIR for intermediate files [default CWD]
  -v, --verbose         Verbose [default off]

Authors
=======

Will Trimble and Wolfgang Gerlach at University of Chicago, Institute for Genomics 
and Systems Biology.

