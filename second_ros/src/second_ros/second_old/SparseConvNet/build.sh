#!/bin/bash
rm -rf build/ dist/ sparseconvnet.egg-info sparseconvnet_SCN*.so
python3.6 setup.py install
