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

     autoskewer.py example/sample.fastq
 
Produces
     sample.fastq.P5.csv
     sample.fastq.P5.err
     sample.fastq.P7.csv
     sample.fastq.P7.err
and the output
     sample.scrubbed.fastq

`autoskewer.py` does not have any options at the moment.

Authors
=======

Will Trimble and Wolfgang Gerlach at University of Chicago, Institute for Genomics 
and Systems Biology.

