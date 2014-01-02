#!/usr/bin/ruby

###############################################################################
#
# Filename: 	autotuner.rb
# Purpose:  	Given an audio file, apply auto-tuning of the ATC theme song
# Author:   	Justin Bachorik
# Date:  		Seredipity Days - January 2014
#
###############################################################################

require 'pathname'


# a few settings
TMP_DIR = '../tmp/'


# theme song data - keep it simple for now
ATC = [
	{ :pitch => "G4", 	:dur => 1},
	{ :pitch => "C5", 	:dur => 1},
	{ :pitch => "A5", 	:dur => 1},
	{ :pitch => "F4", 	:dur => 1},
	{ :pitch => "D4", 	:dur => 1},
	{ :pitch => "G4", 	:dur => 1},
	{ :pitch => "E4", 	:dur => 1},
	{ :pitch => "C4", 	:dur => 5}, # should this be padded out as rest?
	{ :pitch => "G4", 	:dur => 1},
	{ :pitch => "C5", 	:dur => 1},
	{ :pitch => "A5", 	:dur => 1},
	{ :pitch => "F4", 	:dur => 1},
	{ :pitch => "A5", 	:dur => 1},
	{ :pitch => "B5", 	:dur => 1},
	{ :pitch => "C5", 	:dur => 1}
	]

# check args
if ARGV.length == 0 then
	puts "Usage: autotuner.rb filename [duration_ratio]"
	exit
end

# first arg is input filename
infile = Pathname.new(ARGV[0])
unless infile.exist? 
	puts "File not found: #{infile}"
end

# ratio is second argument - dictates relative speed of notes
duration_ratio = ARGV[1].to_i != 0 ? ARGV[1].to_i : 0.5

# clear out tmp dir
`rm #{TMP_DIR}*`

# split it into the number of source pieces dictated by the ATC theme song
marker = 0 # track where we are in the audio file
ATC.each_with_index do |note, i|
	dur = duration_ratio * note[:dur]
	`sox #{infile} #{TMP_DIR + i.to_s}.mp3 trim #{marker} #{dur}`
	marker += dur
end

# autotune each piece

# put them together

# and write it to a file