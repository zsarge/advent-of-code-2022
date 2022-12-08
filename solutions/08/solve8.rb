#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/8
# Run with: 'ruby solve8.rb'
# using Ruby 3.1.2
# by Zack Sargent

FILE_NAME = "input8.txt"
# FILE_NAME = "test.txt"
TREES = File.readlines(FILE_NAME, chomp: true).map{_1.chars.map(&:to_i)}

def viewing_distances x, y
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
  viewing_distances(x,y).reduce(&:*)
end

def visible? x, y
  viewing_distances(x,y).any? { _1 > 0}
end

center_points = Enumerator.new do |en| # could be replaced by Enumerator.product in later versions
  (1...TREES.size-1).each do |y|
    (1...TREES[0].size-1).each do |x|
      en << [x,y]
    end
  end
end

visible_edges = (TREES.size * 2) + (TREES[0].size * 2) - 4
p visible_edges + center_points.count {|(x,y)| visible?(x,y)}

# as opposed to calling .map then .max, .max_by avoids generating a new array, 
# and lets me pretend like this is totally optimized :)
p center_points
  .max_by {|(x,y)| scenic_score(x,y)} 
  .then {|(x,y)| scenic_score(x,y)}
