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

     autoskewer.py <input.fastq>
 
Produces
     input.fastq.P5.csv
     input.fastq.P5.err
     input.fastq.P7.csv
     input.fastq.P7.err
and the output
     input.scrubbed.fastq

`autoskewer.py` does not have any options at the moment.

Authors
=======

Will Trimble and Wolfgang Gerlath at University of Chicago, Institute for Genomics 
and Systems Biology.

