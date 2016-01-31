#!/bin/env ruby

# Created 1/31/16
# Matthew Ralston
# This is a template script containing a logger and option parsing

######################
# PACKAGES
######################
require 'optparse'
require 'ostruct'

######################
# CONSTANTS
######################
LOGCONFIG = "/Users/Matthew/.config/ruby/logger.yaml" 
LOGFILE = "/Users/Matthew/logs/example.log"

######################
# FUNCTIONS
######################



def create_root_logger
  ycfg = YamlConfigurator
  ycfg["LOGFILE"] = OPTIONS[:logfile]
  ycfg.load_yaml_file(LOGCONFIG)
  root_logger = Logger['root_logger']
  root_logger.outputters.select{|x| x.name == "stderr"}[0].level = Object.const_get OPTIONS[:log]
  root_logger.outputters.select
  root_logger
end

######################
# OPTIONS AND MAIN
######################

options=OpenStruct.new
options.log = 'WARN' # Set defaults first

OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options] ARGV"
  opts.on("-v", "--[no-]verbose","Run verbosely") do |v|
    options[:verbose] = v
  end
  opts.on("-r", "--required","Error thrown without this flag") do |r|
    options[:required] = r
  end
  opts.on("-o", "--optional", "This is an optional flag") do |o|
    options[:optional] = o
  end
  opts.on("-l", "--log-level LEVEL", [:FATAL,:ERROR,:WARNING,:INFO,:DEBUG], "Log level for stdout [FATAL, ERROR, WARNING, INFO, DEBUG]") do |l|
    options.log = l
  end
  opts.on("-f", "--log-file", "Location of log file") do |f|
    options.logfile = f
  end
  opts.separator ""
  opts.separator "Common options:"
  # No argument, help is shown.
  opts.on_tail("-h", "--help","Show this message") do
    puts opts
    exit(-1)
  end
  OPTIONS = options
end.parse!
# Raise error without required arguments
raise OptionParser::MissingArgument, "Missing argument REQUIRED. See --help for details" unless OPTIONS[:required]
# Create the main logger
LOG = create_root_logger
# Run Main routine
main
