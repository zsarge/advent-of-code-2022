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

  model = {}

  @rows.last.chars.each.with_index do |c, index| # todo: collect to map
    if c =~ /\d/
      # puts "#{c} = #{parse_index index}"
      model[c] = parse_index index
    end
  end

  model
end

def follow_instructions stacks, instructions
  instructions.split("\n").each do |line|
    match_data = line.match /move (\d+) from (\d) to (\d)/
    match_data[1].to_i.times do
      from = match_data[2]
      to = match_data[3]
      stacks[to].push stacks[from].pop
    end
  end
  return stacks
end

# FILE_NAME = "input5.txt"
FILE_NAME = "test.txt"
raw_stacks, instructions  = File.read(FILE_NAME).split "\n\n"

stacks = follow_instructions (parse_stacks raw_stacks), instructions
p stacks.values.reduce("") {|acc, ele| acc + ele.last}
