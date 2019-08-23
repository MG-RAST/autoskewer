
FROM ubuntu:14.04

# example: docker build -t autoskewer:latest .

RUN apt-get update && apt-get install -y wget unzip git make g++ python python-setuptools

# bowtie
RUN wget --content-disposition http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.5/bowtie2-2.2.5-linux-x86_64.zip/download && unzip bowtie2-2.2.5-linux-x86_64.zip && cp /bowtie2-2.2.5/bowtie2* /usr/local/bin

# skewer (forked version)
RUN git clone --branch 0.2.2 http://github.com/relipmoc/skewer && cd skewer && make && make install

#autoskewer
RUN git clone http://github.com/wltrimbl/autoskewer && cd autoskewer && make && make install

ENV PATH /autoskewer/autoskewer:$PATH

CMD ["autoskewer.py"]
