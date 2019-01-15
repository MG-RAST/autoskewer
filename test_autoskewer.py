import os
from subprocess import call

def test_cmdline1Q():
    call(["autoskewer.py", '-i', "example/sample.fastq"])
    assert os.path.exists("example/sample.scrubbed.fastq")
    assert os.path.exists("example/sample.scrubbed.log")
    os.remove("example/sample.scrubbed.fastq")
    os.remove("example/sample.scrubbed.log")
def test_cmdline1A():
    call(["autoskewer.py", '-i', "example/sample.fasta"])
    assert os.path.exists("example/sample.scrubbed.fasta")
    assert os.path.exists("example/sample.scrubbed.log")
    os.remove("example/sample.scrubbed.fasta")
    os.remove("example/sample.scrubbed.log")
def test_cmdline2A():
    call(["autoskewer.py", '-i', "example/sample.fa"])
    assert os.path.exists("example/sample.fa.scrubbed.fasta")
    assert os.path.exists("example/sample.fa.scrubbed.log")
    os.remove("example/sample.fa.scrubbed.fasta")
    os.remove("example/sample.fa.scrubbed.log")
def test_cmdline2Q():
    call(["autoskewer.py", '-i', "example/sample.fq"])
    assert os.path.exists("example/sample.fq.scrubbed.fastq")
    assert os.path.exists("example/sample.fq.scrubbed.log")
    os.remove("example/sample.fq.scrubbed.fastq")
    os.remove("example/sample.fq.scrubbed.log")
def test_cmdline3Q():
    call(["autoskewer.py", "example/sample.fastq"])
    assert os.path.exists("example/sample.scrubbed.fastq")
    assert os.path.exists("example/sample.scrubbed.log")
    os.remove("example/sample.scrubbed.fastq")
    os.remove("example/sample.scrubbed.log")
def test_cmdline3A():
    call(["autoskewer.py", "example/sample.fasta"])
    assert os.path.exists("example/sample.scrubbed.fasta")
    assert os.path.exists("example/sample.scrubbed.log")
    os.remove("example/sample.scrubbed.fasta")
    os.remove("example/sample.scrubbed.log")
def test_cmdline4A():
    call(["autoskewer.py", "example/sample.fa"])
    assert os.path.exists("example/sample.fa.scrubbed.fasta")
    assert os.path.exists("example/sample.fa.scrubbed.log")
    os.remove("example/sample.fa.scrubbed.fasta")
    os.remove("example/sample.fa.scrubbed.log")
def test_cmdline4Q():
    call(["autoskewer.py", "example/sample.fq"])
    assert os.path.exists("example/sample.fq.scrubbed.fastq")
    assert os.path.exists("example/sample.fq.scrubbed.log")
    os.remove("example/sample.fq.scrubbed.fastq")
    os.remove("example/sample.fq.scrubbed.log")
def test_cmdline_explicit1Q():
    call(["autoskewer.py", '-i', "example/sample.fastq", "-o", "example/sample-processed.fastq"])
    assert os.path.exists("example/sample-processed.fastq")
    assert os.path.exists("example/sample-processed.log")
    os.remove("example/sample-processed.fastq")
    os.remove("example/sample-processed.log")
def test_cmdline_explicit1A():
    call(["autoskewer.py", '-i', "example/sample.fasta", "-o", "example/sample-processed.fasta"])
    assert os.path.exists("example/sample-processed.log")
    os.remove("example/sample-processed.fasta")
    os.remove("example/sample-processed.log")
def test_cmdline_explicit2A():
    call(["autoskewer.py", '-i', "example/sample.fa", "-o", "example/sample-processed.fasta"])
    assert os.path.exists("example/sample-processed.log")
    os.remove("example/sample-processed.fasta")
    os.remove("example/sample-processed.log")
def test_cmdline_explicit2Q():
    call(["autoskewer.py", '-i', "example/sample.fq", "-o", "example/sample-processed.fastq"])
    assert os.path.exists("example/sample-processed.log")
    os.remove("example/sample-processed.fastq")
    os.remove("example/sample-processed.log")
