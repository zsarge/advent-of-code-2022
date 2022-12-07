#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/2
# Run with: 'ruby solve2.rb'
# using Ruby 2.5.1
# by Zack Sargent

INPUTS = File.readlines("input2.txt").map(&:chomp).map {|line| line.split.map(&:to_sym)}

LOSES_TO = {
  :A => :Z, # Rock beats Scissors
  :B => :X, # Paper beats Rock
  :C => :Y  # Scissors beats Paper
}

BEATS = {
  :A => :Y, # Paper beats Rock
  :B => :Z, # Scissors beats Paper
  :C => :X  # Rock beats Scissors
}

CONVERT = {
  :A => :X,
  :B => :Y,
  :C => :Z
}

SCORE = {
  :X => 1,
  :Y => 2,
  :Z => 3
}

def outcome a, b
  if CONVERT[a] == b
    3 # draw
  elsif LOSES_TO[a] == b
    0 # b lost
  else
    6 # b won
  end
end

def move_needed a, result
  case result
  when :X # lose
    LOSES_TO[a]
  when :Y # draw
    CONVERT[a]
  when :Z # win
    BEATS[a]   
  end
end

# part 1
p INPUTS.sum{ |(opponent, me)|
  outcome(opponent, me) + SCORE[me]
}

# part 2
p INPUTS.sum{ |(opponent, result)|
  me = move_needed opponent, result
  outcome(opponent, me) + SCORE[me]
}
