#!/usr/bin/env python

import sys

from setuptools import setup

setup(name='autoskewer',
      version='1.2',
      description='wrapper for skewer',
      author='W Trimble',
      author_email='trimble@anl.gov',
      url='https://github.com/MG-RAST/autoskewer',
      packages=['autoskewer'],
      data_files=[ ( "data", ["data/vectors-P5.1.bt2", "data/vectors-P5.2.bt2",
                          "data/vectors-P5.3.bt2", "data/vectors-P5.4.bt2",
                          "data/vectors-P7.1.bt2", "data/vectors-P7.2.bt2",
                          "data/vectors-P7.3.bt2", "data/vectors-P7.4.bt2",
                          "data/vectors-P7.fa", "data/vectors-P5.fa",
                          "data/vectors-P7.rev.1.bt2", "data/vectors-P7.rev.2.bt2",
                          "data/vectors-P5.rev.1.bt2", "data/vectors-P5.rev.2.bt2"])  ],
      scripts=['autoskewer/autoskewer.py'],
      install_requires=[]
     )
