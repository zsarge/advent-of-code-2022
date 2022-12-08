#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/8
# Run with: 'ruby solve8.rb'
# using Ruby 3.1.3
# by Zack Sargent

TREES = File.readlines("input8.txt", chomp: true).map{_1.chars.map(&:to_i)}

def viewing_distances x, y # TODO: Yield (range.size - 1)
  (up, down) = [(y-1).downto(0), (y+1...TREES.size)].map { |range|
	range.find_index {|y2| TREES[y2][x] >= TREES[y][x] } || yield(range)
  }
  (left, right) = [(x-1).downto(0), (x+1...TREES[0].size)].map { |range|
	range.find_index {|x2| TREES[y][x2] >= TREES[y][x] } || yield(range)
  }

  [up, left, right, down].map{ _1 + 1 }
end

def scenic_score x, y
  viewing_distances(x, y){ |range| range.size - 1 }.reduce(&:*)
end

def visible? x, y
  # trees that can see the edge have infinite viewing distance
  viewing_distances(x, y){ Float::INFINITY }.include?(Float::INFINITY) 
end

# could be replaced by Enumerator.product in later Ruby versions
center_points = (1...TREES.size-1).to_a.product((1...TREES[0].size-1).to_a)


# part 1
visible_edges = (TREES.size * 2) + (TREES[0].size * 2) - 4

# puts "visible_edges = #{visible_edges} + ? = "
p visible_edges + center_points.count {|(x, y)| visible?(x, y)}

# part 2
# As opposed to calling .map then .max, .max_by avoids generating a new array,
# and lets me pretend like this is totally optimized :)
p center_points
  .max_by {|(x, y)| scenic_score(x, y)}
  .then {|(x, y)| scenic_score(x, y)}
