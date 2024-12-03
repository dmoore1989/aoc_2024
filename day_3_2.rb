require_relative 'aoc_helper'

f = File.open('day_3.txt')
# f = File.open('sample.txt')
lines = f.readlines.map(&:chomp)

amount = 0
on = true
lines.each do |line|
  mults = line.scan(/(do\(\)|don't\(\))|(mul(\()([0-9]+),([0-9]+)(\)))/)
  mults.each do |mult|
    if on && mult[0] == 'don\'t()'
      on = false
    elsif !on && mult[0] == 'do()'
      on = true
    end
    amount += mult[3].to_i * mult[4].to_i if on
  end
end
puts(amount)
