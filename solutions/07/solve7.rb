#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/7
# Run with: 'ruby solve7.rb'
# using Ruby 3.1.2
# by Zack Sargent

class Directory
  attr_accessor :files
  attr_reader :parentDir, :name, :total_size

  def initialize(name, parentDir, files=[])
    @files = files
    @parentDir = parentDir
    @name = name
    @total_size = 0
  end

  def size # TODO: clean up
    @total_size = 0
    @files.each do |file|
      @total_size += file.size
    end
    return @total_size
  end

  def flatten_dirs # TODO: clean up
    buf = []
    @files.each do |file|
      if file.instance_of? Directory
        buf.push file
        buf.concat file.flatten_dirs
      end
    end
    return buf
  end
end

ElfFile = Struct.new(:size, :name) # "File" is already used

$top = Directory.new("/", nil)

def process inputs
  location = $top

  inputs.each do |input|
    case input
    when /\$ cd \.\./ # cd ..
      location = location.parentDir
    when /\$ cd (.*)/ # cd <name>
      location = location.files.find {|file|
        file.instance_of?(Directory) && file.name == $1
      }
    when /(\d+) (\S+)/ # a file, named $2 with size $1
      location.files.push ElfFile.new($1.to_i, $2)
    when /dir (\S+)/ # a directory named $1
      location.files.push Directory.new($1, location)
    end
  end
end

INPUTS = File.readlines("input7.txt", chomp: true)

process INPUTS.drop(1) # drop 1 to ignore "cd /"
TOAL_UNUSED_SPACE = 70_000_000 - $top.size
MIN_FILE_SIZE = 30_000_000 - TOAL_UNUSED_SPACE

# part 1
p $top.flatten_dirs
  .filter{ |dir| dir.total_size <= 100000 }
  .sum{ |dir| dir.total_size }

# part 2
p $top.flatten_dirs
  .filter{ |dir| dir.total_size >= MIN_FILE_SIZE }
  .sort_by{ |dir| dir.total_size }
  .min{ |dir| dir.total_size }
  .total_size
