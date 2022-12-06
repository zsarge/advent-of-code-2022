#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/3
# Run with: 'ruby solve3.rb'
# using Ruby 2.5.1
# by Zack Sargent

require 'set'

def priority letter
  case letter
  when ('a'..'z')
    1 + (letter.ord - 'a'.ord)
  else
    27 + (letter.ord - 'A'.ord)
  end
end

INPUTS = File.readlines("input3.txt").map(&:chomp)

# part 1
p INPUTS
  .flat_map{ |contents|
    halfway = contents.size/2
    left = Set.new(contents[...halfway].chars)
    right = Set.new(contents[halfway..].chars)
    left.intersection(right).map{ priority _1 }
  }
  .sum

# part 2
p INPUTS
  .map{ |line| Set.new line.chars }
  .each_slice(3)
  .flat_map{ |(elf_1, elf_2, elf_3)|
    elf_1.intersection(elf_2).intersection(elf_3).map{ priority _1 }
  }
  .sum

