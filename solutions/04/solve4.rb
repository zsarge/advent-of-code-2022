#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/4
# Run with: 'ruby solve4.rb'
# using Ruby 3.1.2
# by Zack Sargent


class Elf < Struct.new(:start, :end)
  def fully_contains? other
    self.start <= other.start && other.end <= self.end
  end

  def overlaps? other
    self.start <= other.start && other.start <= self.end
  end
end

INPUTS = File.readlines("input4.txt", chomp: true).map{ |line|
  /(\d+)-(\d+),(\d+)-(\d+)/ =~ line
  [Elf.new($1.to_i, $2.to_i), Elf.new($3.to_i, $4.to_i)]
}

p INPUTS.count{ |(elf1, elf2)|
    elf1.fully_contains?(elf2) || elf2.fully_contains?(elf1)
  }

p INPUTS.count{ |(elf1, elf2)|
    elf1.overlaps?(elf2) || elf2.overlaps?(elf1)
  }

