require_relative 'aoc_helper'

f = File.open('day_22.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp).map(&:to_i)
PRUNE = 16_777_216
sum = 0
mapping = {}
output.each do |num|
  secrets = []
  secret = num
  2000.times do |t|
    secrets << if t == 0
                 [secret % 10, nil]
               else
                 [secret % 10, secret % 10 - secrets[-1][0]]
               end
    secret ^= secret * 64
    secret %= PRUNE
    secret ^= secret / 32
    secret %= PRUNE
    secret ^= secret * 2048
    secret %= PRUNE
  end
  occurences = Set.new
  secrets[3..].each_with_index do |amount, i|
    changes = [secrets[i][1], secrets[i + 1][1], secrets[i + 2][1], secrets[i + 3][1]]
    next if occurences.include?(changes)

    mapping[changes] ||= 0
    mapping[changes] += amount[0]
    occurences.add(changes)
  end
end
ph('bananas!', mapping.values.max)
