require 'debug'
require_relative 'aoc_helper'

f = File.open('day_4.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def is_crossed_xmas(i, j, output)
  movements = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  check_string = ''
  movements.each do |movement|
    check_string << output[i + movement[0]][j + movement[1]]
  end
  %w[SSMM MSSM MMSS SMMS].include?(check_string)
end
count = 0
output.each_with_index do |line, i|
  next if i.zero? || i >= output.length - 1

  line.each_char.with_index do |char, j|
    next if j.zero? || j >= line.length - 1

    count += 1 if char == 'A' && is_crossed_xmas(i, j, output)
  end
end

puts(count)
