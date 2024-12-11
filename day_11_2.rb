require_relative 'aoc_helper'

f = File.open('day_11.txt')
# f = File.open('sample.txt')

stones = f.readlines.map(&:chomp)[0].split(' ')
# stones = %w[125 17]

def stones_count(stone, count, memo)
  return [memo[stone][count], memo] if memo.dig(stone, count)
  return [1, memo] if count == 0

  memo[stone] ||= {}
  if stone.to_i == 0
    amount, memo = stones_count('1', count - 1, memo)
    memo[stone][count] = amount
    [amount, memo]
  elsif stone.length.to_i.even?
    amount1, memo = stones_count(stone[0...stone.length / 2].to_i.to_s, count - 1, memo)
    amount2, memo = stones_count(stone[stone.length / 2..].to_i.to_s, count - 1, memo)
    memo[stone][count] = amount1 + amount2
    [(amount1 + amount2), memo]
  else
    amount, memo = stones_count((stone.to_i * 2024).to_s, count - 1, memo)
    memo[stone][count] = amount
    [amount, memo]
  end
end
memo = {}
blinks = 75
total = 0
stones.each do |stone|
  amount, memo = stones_count(stone, blinks, memo)
  total += amount
end
puts(total)
