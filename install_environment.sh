#!/bin/bash
set -e

# Author: Matt Ralston
# Date: 1/18/24
# Description:
# Check --help for options. Download and install rvm/twig, pyenv, and miniconda3.

VERSION=0.0.1
HELP=0
RVM=0
TWIG=1
PYENV=1
MINICONDA=1


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
	
	--with-rvm)
	RVM=1
	shift
	;;

	--no-twig)
	TWIG=0
	shift
	;;
	
	--no-pyenv)
	PYENV=0
	shift
	;;

	--no-miniconda)
	MINICONDA=0
	shift
	;;

	*)
	echo "Unknown option: $key" >2
	exit 1
	;;
    esac
    shift
fi

if [ $HELP == 1 ]; then
    echo "Usage: install_environment.sh" >2
    echo "Options:" >2
    echo "        --no-pyenv" >2
    echo "        --no-miniconda" >2
    echo "        --with-rvm" >2
    echo "        --no-twig" >2
    exit 1
fi


if [ $RVM == 1 ]; then
    clear >$(tty)
    echo >2
    echo >2
    echo "        Installing 'github/rvm' (rvm.io) to '$HOME/.rvm' " >2
    echo >2
    echo >2
    sleep 5

    # Note! this may not be an appropriate command for all environments.
    # Does not install by default.
    # Ensure system is up-to-date, otherwise script will crash...
    # That's why this is better done manually
    echo "'\curl -sSL https://get.rvm.io | bash'" >2
    \curl -sSL https://get.rvm.io | bash
    
    if [ $TWIG == 1 ]; then
	echo >2
	echo >2
	echo "        Installing twig via rvm/rubygems..." >2
	echo >2
	echo >2


	echo "'gem install twig'" >2
	gem install twig
    fi

fi

if [ $PYENV == 1 ]; then
    clear >$(tty)
    echo >2
    echo >2
    echo "        Installing 'github/pyenv' to '$HOME/.pyenv'" >2
    echo >2
    echo >2
    sleep 5

    # Install pyenv to user home directory
    echo "'git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv'" >2
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

    echo >2
    echo >2
    echo "        Installing 'github/pyenv-virtualenv' to '$HOME/.pyenv/plugins/pyenv-virtualenv'" >2
    echo >2
    echo >2
    sleep 5

    # Install pyenv-virtualenv to ~/.pyenv/plugins
    echo "'git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv.git'" >2
    git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv.git

    
    echo >2
    echo >2
    echo "        Pyenv install successful!" >2
    echo >2
    echo >2

    clear >$(tty)
    
    echo >2
    echo >2
    echo "        Reloading .bash_profile to ensure pyenv loads..." >2
    echo >2
    echo >2
    sleep 5
    . $HOME/.bash_profile
    
    if [ $MINICONDA == 1 ]; then
	echo >2
	echo >2
	echo "        Installing miniconda with pyenv..." >2
	echo >2
	echo >2
	sleep 5
	

	echo "'pyenv install miniconda3-4.6.14'" >2
	pyenv install miniconda3-4.6.14
    fi
fi


clear >$(tty)
echo >2
echo >2
echo "         Installations successful!" >2
if [ $RVM == 1 ]; then
    echo "         RVM installed" >2
fi
if [ $PYENV == 1 ]; then
    echo "         Pyenv installed" >2
    if [ $MINICONDA == 1 ]; then
	echo "         Miniconda3 installed" >2
    fi
fi
echo >2
echo >2
echo "          D o n e ." >2
