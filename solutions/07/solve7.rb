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
    when /\$ cd \.\./
      # puts "cd up a dir"
      location = location.parentDir
    when /\$ cd (.*)/
      # puts "cd into #{$1}"
      location = location.files.find {|file| 
        file.instance_of?(Directory) && file.name == $1
      }
    when /(\d+) (\S+)/
      # puts "a file named #{$2} with a size #{$1}"
      location.files.push ElfFile.new($1.to_i, $2)
    when /dir (\S+)/
      # puts "a directory named #{$1}"
      location.files.push Directory.new($1, location)
    # else
      # puts "not implemented"
    end
  end
end

FILE_NAME = "input7.txt"
# FILE_NAME = "test.txt"
INPUTS = File.readlines(FILE_NAME, chomp: true)

process INPUTS.drop(1)
$top.size

p $top.flatten_dirs.filter{ |dir| dir.total_size <= 100000 }.sum{ |dir| dir.total_size }


