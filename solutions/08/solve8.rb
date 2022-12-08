#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/8
# Run with: 'ruby solve8.rb'
# using Ruby 3.1.2
# by Zack Sargent

FILE_NAME = "input8.txt"
# FILE_NAME = "test.txt"
TREES = File.readlines(FILE_NAME, chomp: true).map{_1.chars.map(&:to_i)}

def visible? x, y
  # visible from top or bottom
  return true if [(0...y), (y+1...TREES.size)].map { |range|
    range.all?{ |y2| TREES[y2][x] < TREES[y][x] }
  }.any?

  # visible from left or right
  [(0...x), (x+1...TREES[0].size)].map { |range|
    range.all?{ |x2| TREES[y][x2] < TREES[y][x] }
  }.any?
end

def part_1
  visible_edges = (TREES.size * 2) + (TREES[0].size * 2) - 4

  center = (1...TREES.size-1).sum { |y|
    (1...TREES[0].size-1).count { |x|
      visible?(x,y)
    }
  }

  center + visible_edges
end


def viewing_distance x, y
  (up, down) = [(y-1).downto(0), (y+1...TREES.size)].map { |range|
    count = 0
    range.each do |y2|
      count += 1 
      break unless TREES[y2][x] < TREES[y][x] 
    end
    count
  }
  (left, right) = [(x-1).downto(0), (x+1...TREES[0].size)].map { |range|
    count = 0
    range.each do |x2|
      count += 1 
      break unless TREES[y][x2] < TREES[y][x] 
    end
    count
  }

  [up, left, right, down]
end


def scenic_score x, y
  viewing_distance(x,y).reduce(&:*)
end


p (1...TREES.size-1).to_a.product((1...TREES[0].size-1).to_a)
  .map{|(x,y)| scenic_score(x,y)}
  .max
