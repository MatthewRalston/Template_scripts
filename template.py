#!/bin/env python

# Author: Matt Ralston
# Date: 1/31/16
# Description:
# This is a template script including logging and argument parsing

####################
# PACKAGES
####################
import os
import argparse
import sys
import ConfigParser
import logging
import logging.config

####################
# CONSTANTS
####################
LOGCONFIG=

####################
# FUNCTIONS
####################


def get_root_logger(level):
    levels=[logging.WARNING, logging.INFO, logging.DEBUG]
    if level < 0 or level > 2:
        raise TypeError("{0}.get_root_logger expects a verbosity between 0-2".format(__file__))
    logging.basicConfig(level=levels(level),format="%(levelname)s: %(asctime)s %(funcName)s L%(lineno)s| %(message)s",datefmt="%Y/%m/%d %I:%M:%S %p")    
    root_logger = logging.getLogger()
    return root_logger

####################
# OPTIONS AND MAIN
####################

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--required', help="Required argument",required=True)
    parser.add_argument('--flag', help="This is a flag",action="store_true")
    parser.add_argument('-v, --verbose', help="Prints warnings to console by default",default=0, action="count")
    args = parser.parse_args()
    # Set up the root logger
    root_logger=get_root_logger(args.verbose)
    # Main routine
    main()
