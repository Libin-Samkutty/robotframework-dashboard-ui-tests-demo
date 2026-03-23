#!/usr/bin/env python

"""
Helper script to generate timestamped output directories for Robot Framework reports.

This script creates a directory structure like:
    reports/2025-03-23/10-30-45/

The timestamp ensures each test run has its own report directory.

Usage:
    robot --outputdir `python NameOutputDir.py` web/tests/
"""

import datetime
import os

now = datetime.datetime.now()
date = now.strftime("%Y-%m-%d")
time = now.strftime("%H-%M-%S")
current_date_dirpath = str("reports/" + date)
output_dir = current_date_dirpath + "/" + time

if not os.path.exists(current_date_dirpath):
    os.makedirs(current_date_dirpath)

os.makedirs(output_dir)

print('--outputdir ' + output_dir)
