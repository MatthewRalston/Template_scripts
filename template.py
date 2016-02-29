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

def get_root_logger(loglevel, logfile=None, log_config="/Users/Matthew/.config/python/logger.conf"):
    def log_level(loglevel):
        case = {"DEBUG": logging.DEBUG,
                "INFO": logging.INFO,
                "WARNING": logging.WARNING,
                "ERROR": logging.error}
        return case[loglevel.upper()]
    logging.config.fileConfig(log_config)
    root_logger = logging.getLogger()
    log_format = root_logger.handlers[0].format
    for handler in root_logger.handlers:
        handler.setLevel(log_level(loglevel))
    if logfile:
        file_handler = logging.FileHandler(logfile,mode="a")
        file_handler.setLevel(logging.DEBUG)
        file_handler.format = log_format
        root_logger.addHandler(file_handler)
    return root_logger
#def get_root_logger(loglevel):
#    # Requires 'import logging' and 'import logging.config'
#    def log_level(loglevel):
#        case = {"DEBUG": logging.DEBUG,
#                "INFO": logging.INFO,
#                "WARNING": logging.WARNING,
#                "ERROR": logging.ERROR}
#        return case[loglevel.upper()]                
#    logging.basicConfig(level=log_level(loglevel),format="%(levelname)s: %(asctime)s %(user)s %(funcName)sL%(lineno)s| %(message)s",datefmt="%Y/%m/%d %I:%M:%S %p")    
#    root_logger = logging.getLogger()
#    log_format = root_logger.handlers[0].format
#    return root_logger

####################
# OPTIONS AND MAIN
####################

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--required', help="Required argument",required=True)
    parser.add_argument('--flag', help="This is a flag",action="store_true")
    parser.add_argument('--log-level', help="Prints warnings to console by default",default="WARNING",choices=["DEBUG","INFO","WARNING","ERROR"])
    parser.add_argument('--log-file', help="Print log to file.", default="/Users/Matthew/logs/example.log")
    args.parser.parse_args()
    # Set up the root logger
    root_logger=get_root_logger(args.log_level,logfile=args.log_file)
    # Main routine
    main()
