#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/7
# Run with: 'ruby solve7.rb'
# using Ruby 3.1.2
# by Zack Sargent

class Directory
  attr_accessor :files
  attr_reader :parentDir, :name

  def initialize(name, parentDir)
    @parentDir = parentDir
    @name = name
    @files = []
  end

  def size
    @files.sum {|file| file.size}
  end

  def flatten_dirs
    @files.grep(Directory).reduce([]) { |acc, file|
      acc.push file
      acc.concat file.flatten_dirs
    }
  end
end

ElfFile = Struct.new(:size, :name) # the name "File" is already used

$top = Directory.new("/", nil)

def process inputs
  location = $top

  inputs.each do |input|
    case input
    when /\$ cd \.\./ # cd ..
      location = location.parentDir
    when /\$ cd (.*)/ # cd <name>
      location = location.files.find{ |file| file.name == $1 }
    when /(\d+) (\S+)/ # a file, named $2 with size $1
      location.files.push ElfFile.new($1.to_i, $2)
    when /dir (\S+)/ # a directory named $1
      location.files.push Directory.new($1, location)
    end
  end
end

INPUTS = File.readlines("input7.txt", chomp: true)

# build up directory tree with files
process INPUTS.drop(1) # drop 1 to ignore "cd /"

# calculate file sizes
TOAL_UNUSED_SPACE = 70_000_000 - $top.size
MIN_FILE_SIZE = 30_000_000 - TOAL_UNUSED_SPACE

sizes = $top.flatten_dirs.map{ |dir| dir.size }

# part 1
p sizes.filter{ _1 <= 100_000 }.sum

# part 2
p sizes.filter{ _1 >= MIN_FILE_SIZE }.min
