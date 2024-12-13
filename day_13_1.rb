require_relative 'aoc_helper'

f = File.open('day_13.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def lowest_cost(button_a, button_b, prize)
  a1 = button_a[0]
  a2 = button_a[1]
  b1 = button_b[0]
  b2 = button_b[1]
  c1 = -prize[0]
  c2 = -prize[1]
  i = (b1 * c2 - b2 * c1).fdiv(a1 * b2 - a2 * b1)
  j = (a2 * c1 - a1 * c2).fdiv(a1 * b2 - a2 * b1)

  if i % 1 == 0 && j % 1 == 0
    (3 * i + j).to_i
  else
    0
  end
end

cost = 0
a_coord = []
b_coord = []
prize = []
output.each_with_index do |line, i|
  line_number = i % 4
  if line_number.zero?
    a_coord = [/X\+([0-9]+)/.match(line)[1].to_i, /Y\+([0-9]+)/.match(line)[1].to_i]
  elsif line_number == 1
    b_coord = [/X\+([0-9]+)/.match(line)[1].to_i, /Y\+([0-9]+)/.match(line)[1].to_i]
  elsif line_number == 2
    prize = [/X=([0-9]+)/.match(line)[1].to_i, /Y=([0-9]+)/.match(line)[1].to_i]
  else
    cost += lowest_cost(a_coord, b_coord, prize)
  end
end
puts(cost + lowest_cost(a_coord, b_coord, prize))
