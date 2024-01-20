#!/bin/bash
set -e

# Author: Matt Ralston
# Date: 1/31/16
# Description:
# This is a template script containing options parsing

VERSION=0.0.1
HELP=0

if [ $# -eq 0 ] # Print the help message if no arguments are provided
then
    HELP=1
fi

#######################
# Command line options
#######################
if [[ $# > 0 ]]
then
    key="$1"
    case $key in
	-h|--help)
	HELP=1
	;;

	-r|--required)
	REQUIRED="$2"
	shift
	;;

	-o|--optional)
	OPTIONAL="$2"
	shift
	;;

	-f|--flag)
	FLAG=1
	;;

	*)
	echo "Unknown option: $key" >2
	exit 1
	;;
    esac
    shift
fi

if [ $HELP == 1 ]; then
    echo "Usage: example.sh [-r|--required REQUIRED]" >2
    echo "Options:" >2
    echo "        -o|--optional OPTIONAL" >2
    echo "        -f|--flag" >2
    echo "        -h|--help" >2
    exit 1
fi
