require_relative 'aoc_helper'

f = File.open('day_11.txt')
# f = File.open('sample.txt')

stones = f.readlines.map(&:chomp)[0].split(' ')
# stones = %w[125 17]

blinks = 25
blinks.times do
  stones.map! do |stone|
    if stone.to_i == 0
      stone = '1'
    elsif stone.length.to_i.even?
      stone = [stone[0...stone.length / 2].to_i.to_s, stone[stone.length / 2..].to_i.to_s]
    else
      (stone.to_i * 2024).to_s
    end
  end
  stones = stones.flatten
end
puts(stones.count)
