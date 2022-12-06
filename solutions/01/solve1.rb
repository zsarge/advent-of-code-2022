#!/usr/bin/env ruby
# https://adventofcode.com/2022/day/1
# Run with: 'ruby solve1.rb'
# using Ruby 2.5.1
# by Zack Sargent

elves = File.read("input1.txt").split("\n\n").map {|elf| elf.split("\n").map(&:to_i)}

total_calories = elves.map(&:sum)

p total_calories.max # part 1
p total_calories.sort[-3..].sum # part 2

