#!/bin/bash

sed -i "34c#\\\t      'python-igraph>=0.8', " setup.py
#sed -i "34c\\\t  'python-igraph>=0.8', " setup.py

 $PYTHON  -m pip install . -vv
