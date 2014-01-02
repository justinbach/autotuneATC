#!/usr/bin/ruby

###############################################################################
#
# Filename: 	autotuner.rb
# Purpose:  	Given an audio file, apply auto-tuning of the ATC theme song
# Author:   	Justin Bachorik
# Date:  		Seredipity Days - January 2014
#
###############################################################################

# a few settings
TMP_DIR = '../tmp'


# theme song data - keep it simple for now
ATC = [
	{ "pitch" => "G4", 	"dur" => 1},
	{ "pitch" => "C5", 	"dur" => 1},
	{ "pitch" => "A5", 	"dur" => 1},
	{ "pitch" => "F4", 	"dur" => 1},
	{ "pitch" => "D4", 	"dur" => 1},
	{ "pitch" => "G4", 	"dur" => 1},
	{ "pitch" => "E4", 	"dur" => 1},
	{ "pitch" => "C4", 	"dur" => 5}, # should this be padded out as rest?
	{ "pitch" => "G4", 	"dur" => 1},
	{ "pitch" => "C5", 	"dur" => 1},
	{ "pitch" => "A5", 	"dur" => 1},
	{ "pitch" => "F4", 	"dur" => 1},
	{ "pitch" => "A5", 	"dur" => 1},
	{ "pitch" => "B5", 	"dur" => 1},
	{ "pitch" => "C5", 	"dur" => 1}
	]

# check args
if ARGV.length == 0 then
	puts "Usage: autotuner.rb filename"
	exit
end

# first arg is input filename

# split it into the number of source pieces dictated by the ATC theme song

# autotune each piece

# put them together

# and write it to a file