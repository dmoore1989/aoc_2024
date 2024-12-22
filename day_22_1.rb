require_relative 'aoc_helper'

f = File.open('day_22.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp).map(&:to_i)
PRUNE = 16_777_216
sum = 0
output.each do |num|
  secret = num
  2000.times do |t|
    secret ^= secret * 64
    secret %= PRUNE

    secret ^= secret / 32
    secret %= PRUNE
    secret ^= secret * 2048
    secret %= PRUNE
  end
  sum += secret
end
puts(sum)
