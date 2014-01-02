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
TMP_EXT = '.mp3'
SUPPRESS_OUT = '>/dev/null 2>&1'
CLEAN_UP = "rm #{TMP_DIR}* #{SUPPRESS_OUT}"

# theme song data - keep it simple for now
atc = [
	{ :pitch => :G, :dur => 1, :oct => 4, :rel => 0},
	{ :pitch => :C, :dur => 1, :oct => 5, :rel => 5},
	{ :pitch => :A, :dur => 1, :oct => 5, :rel => 2},
	{ :pitch => :F, :dur => 1, :oct => 4, :rel => -2},
	{ :pitch => :D, :dur => 1, :oct => 4, :rel => -5},
	{ :pitch => :G, :dur => 1, :oct => 4, :rel => 0},
	{ :pitch => :E, :dur => 1, :oct => 4, :rel => -3},
	{ :pitch => :C, :dur => 5, :oct => 4, :rel => -7}, # should this be padded out as rest?
	{ :pitch => :G, :dur => 1, :oct => 4, :rel => 0},
	{ :pitch => :C, :dur => 1, :oct => 5, :rel => 5},
	{ :pitch => :A, :dur => 1, :oct => 5, :rel => 2},
	{ :pitch => :F, :dur => 1, :oct => 4, :rel => -2},
	{ :pitch => :A, :dur => 1, :oct => 5, :rel => 2},
	{ :pitch => :B, :dur => 1, :oct => 5, :rel => 4},
	{ :pitch => :C, :dur => 1, :oct => 5, :rel => 5}
	]

# three times? why not
atc = [atc, atc, atc].flatten

# check args
if ARGV.length < 2 then
	puts "Usage: autotuner.rb input_filename output_filename [duration_ratio]"
	exit
end

# first arg is input filename
infile = Pathname.new(ARGV[0])
unless infile.exist? 
	puts "File not found: #{infile}"
end

outfile = ARGV[1]

# ratio is second argument - dictates relative speed of notes
duration_ratio = ARGV[2].to_i != 0 ? ARGV[2].to_i : 0.5

# clear out tmp dir
`#{CLEAN_UP}`

# split it into the number of source pieces dictated by the atc theme song
marker = 0 # track where we are in the audio file
atc.each_with_index do |note, i|
	dur = duration_ratio * note[:dur]
	`sox #{infile} #{TMP_DIR + i.to_s + TMP_EXT} trim #{marker} #{dur} #{SUPPRESS_OUT}`
	marker += dur
end

# autotune each piece
0.upto(atc.length - 1).each { |i| `sox #{TMP_DIR + i.to_s + TMP_EXT} #{TMP_DIR + i.to_s + TMP_EXT} pitch #{atc[i][:rel] * 100}` }

# put them together
# and write it to a file
merge_cmd = "sox "
0.upto(atc.length - 1).each { |i| merge_cmd += "#{TMP_DIR + i.to_s + TMP_EXT} "}
merge_cmd += outfile
`#{merge_cmd}`

# clean up
`#{CLEAN_UP}`


