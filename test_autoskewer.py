import os
from subprocess import call

def test_cmdline1Q():
    call(["autoskewer.py", '-i', "example/sample.fastq"])
    assert os.path.exists("example/sample.scrubbed.fastq")
    os.remove("example/sample.scrubbed.fastq")

def test_cmdline1A():
    call(["autoskewer.py", '-i', "example/sample.fasta"])
    assert os.path.exists("example/sample.scrubbed.fasta")
    os.remove("example/sample.scrubbed.fasta")
def test_cmdline2A():
    call(["autoskewer.py", '-i', "example/sample.fa"])
    assert os.path.exists("example/sample.fa.scrubbed.fasta")
    os.remove("example/sample.fa.scrubbed.fasta")
def test_cmdline2Q():
    call(["autoskewer.py", '-i', "example/sample.fq"])
    assert os.path.exists("example/sample.fq.scrubbed.fastq")
    os.remove("example/sample.fq.scrubbed.fastq")

def test_cmdline3Q():
    call(["autoskewer.py", "example/sample.fastq"])
    assert os.path.exists("example/sample.scrubbed.fastq")
    os.remove("example/sample.scrubbed.fastq")
def test_cmdline3A():
    call(["autoskewer.py", "example/sample.fasta"])
    assert os.path.exists("example/sample.scrubbed.fasta")
    os.remove("example/sample.scrubbed.fasta")
def test_cmdline4A():
    call(["autoskewer.py", "example/sample.fa"])
    assert os.path.exists("example/sample.fa.scrubbed.fasta")
    os.remove("example/sample.fa.scrubbed.fasta")
def test_cmdline4Q():
    call(["autoskewer.py", "example/sample.fq"])
    assert os.path.exists("example/sample.fq.scrubbed.fastq")
    os.remove("example/sample.fq.scrubbed.fastq")

def test_cmdline_explicit1Q():
    call(["autoskewer.py", '-i', "example/sample.fastq", "-o", "example/sample.fastq.scrubbed.fastq"])
    assert os.path.exists("example/sample.fastq.scrubbed.fastq")
    os.remove("example/sample.fastq.scrubbed.fastq")
def test_cmdline_explicit1A():
    call(["autoskewer.py", '-i', "example/sample.fasta", "-o", "example/sample.fasta.scrubbed.fasta"])
    assert os.path.exists("example/sample.fasta.scrubbed.fasta")
    os.remove("example/sample.fasta.scrubbed.fasta")
def test_cmdline_explicit2A():
    call(["autoskewer.py", '-i', "example/sample.fa", "-o", "example/sample.fa.scrubbed.fasta"])
    assert os.path.exists("example/sample.fa.scrubbed.fasta")
    os.remove("example/sample.fa.scrubbed.fasta")
def test_cmdline_explicit2Q():
    call(["autoskewer.py", '-i', "example/sample.fq", "-o", "example/sample.fq.scrubbed.fastq"])
    assert os.path.exists("example/sample.fq.scrubbed.fastq")
    os.remove("example/sample.fq.scrubbed.fastq")
