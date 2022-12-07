#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/5
# Run with: 'ruby solve5.rb'
# using Ruby 3.1.2
# by Zack Sargent

def parse_stacks stacks
  @rows = stacks.split "\n"

  def parse_index index
    (@rows.size-2).downto(0).map{ @rows[_1][index] }.take_while{ _1 =~ /\w/ }
  end

  @rows.last.chars.each.with_index
    .filter {|c, index| c =~ /\d/}
    .map {|c, index| [c, parse_index(index)]}
    .to_h
end

def parse_instructions instructions
  instructions.split("\n").map {|line| 
    results = line.match /move (\d+) from (\d) to (\d)/
    [results[1].to_i, results[2], results[3]]
  }
end

def part_1 stacks, instructions
  instructions.each do |(quantity, from, to)|
    quantity.times do
      stacks[to].push stacks[from].pop
    end
  end
  return stacks
end

def part_2 stacks, instructions
  instructions.each do |(quantity, from, to)|
    stacks[to].concat stacks[from].slice!(-quantity..)
  end
  return stacks
end

def solve stacks
  stacks.values.map(&:last).join
end

raw_stacks, raw_instructions = File.read("input5.txt").split "\n\n"
instructions = parse_instructions raw_instructions

# part 1
stacks = parse_stacks raw_stacks
puts solve part_1 stacks, instructions

# part 2
stacks = parse_stacks raw_stacks # reset to initial state
puts solve part_2 stacks, instructions
