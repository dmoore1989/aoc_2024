require 'debug'
require_relative 'aoc_helper'

f = File.open('day_4.txt')
# f = File.open('sample.txt')
movements = MOVEMENTS
output = f.readlines.map(&:chomp)

count = 0
string = 'XMAS'
output.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    if char == string[0]
      movements.each do |movement|
        string_num = 1
        next_i = i
        next_j = j
        while string_num < string.length
          next_i += movement[0]
          next_j += movement[1]
          break if outside_of_array?(next_i, output.length) || outside_of_array?(next_j, line.length)

          next_char = output[next_i][next_j]
          break if next_char != string[string_num]

          string_num += 1
        end
        count += 1 if string_num >= string.length
      end
    end
  end
end

puts(count)
