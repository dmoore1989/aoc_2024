require_relative 'aoc_helper'

f = File.open('day_1.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

list_1 = []
list_2 = {}
output.each do |string|
  item = string.split('   ')
  list_1.push(item[0].to_i)

  if list_2[item[1].to_i].nil?
    list_2[item[1].to_i] = 1
  else
    list_2[item[1].to_i] += 1
  end
end

score = 0
list_1.each do |item|
  score += item * (list_2[item] || 0)
end
puts(score)
