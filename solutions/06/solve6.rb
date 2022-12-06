#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/6
# Run with: 'ruby solve6.rb'
# using Ruby 3.1.2
# by Zack Sargent

INPUTS = File.read("input6.txt").chomp

def find_start buffer, size
  buffer.chars.each_cons(size).find_index{|str| 
    str.uniq.size == size 
  } + size
end

p find_start INPUTS, 4  # part 1
p find_start INPUTS, 14 # part 2
