require_relative 'aoc_helper'

f = File.open('day_3.txt')
# f = File.open('sample.txt')
lines = f.readlines.map(&:chomp)

amount = 0
lines.each do |line|
  mults = line.scan(/mul(\()([0-9]+),([0-9]+)(\))/)
  mults.each do |mult|
    amount += mult[1].to_i * mult[2].to_i
  end
end
puts(amount)
