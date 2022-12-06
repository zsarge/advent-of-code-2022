#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/3
# Run with: 'ruby solve3.rb'
# using Ruby 2.5.1
# by Zack Sargent

require 'set'

class Rucksack
  attr_reader :left, :right

  def initialize contents
    halfway = contents.size/2 
    @left = Set.new(contents[...halfway].chars)
    @right = Set.new(contents[halfway..].chars)
  end

  def difference 
    @left.intersection @right
  end
end


def priority letter
  case letter
  when ('a'..'z')
    1 + (letter.ord - 'a'.ord)
  else
    27 + (letter.ord - 'A'.ord)
  end 
end

FILE_NAME = "input3.txt"
# FILE_NAME = "test.txt"
INPUTS = File.readlines(FILE_NAME).map(&:chomp)

# part 1
p INPUTS.map{|line| Rucksack.new line}.flat_map{|rucksack|
  rucksack.difference.map{ priority _1 }
}.sum

# part 2
p INPUTS.map{|line| Set.new line.chars}.each_slice(3).map{|(elf_1, elf_2, elf_3)|
  elf_1.intersection(elf_2).intersection(elf_3)
}.flat_map{|set| set.map {priority _1}}.sum

