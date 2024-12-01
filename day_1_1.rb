require_relative 'aoc_helper'

f = File.open('day_1.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

list_1 = []
list_2 = []
output.each do |string|
  item = string.split('   ')
  list_1.push(item[0].to_i)
  list_2.push(item[1].to_i)
end

list_1.sort!
list_2.sort!

distance = 0
list_1.each_with_index do |item, index|
  distance += (list_2[index] - item).abs
end
puts(distance)
