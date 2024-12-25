require_relative 'aoc_helper'

f = File.open('day_25.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)
keys = []
locks = []
i = 0
is_key = false
is_lock = false
key_array = []
lock_array = []
while i < output.length
  if i % 8 != 0 && i % 8 != 6
    if is_key
      output[i].each_char.with_index do |char, j|
        key_array[j] += 1 if char == '#'
      end
    else
      output[i].each_char.with_index do |char, j|
        lock_array[j] += 1 if char == '#'
      end
    end
  elsif i % 8 == 0 && output[i] == '.....'
    is_key = true
    key_array = [0] * 5
  elsif i % 8 == 0 && output[i] == '#####'
    is_lock = true
    lock_array = [0] * 5
  else
    keys << key_array if is_key
    locks << lock_array if is_lock
    is_key = false
    is_lock = false
  end
  i += 1
end

count = 0
keys.each do |key|
  locks.each do |lock|
    fit = true
    lock.each_index do |i|
      fit = false if key[i] + lock[i] > 5
    end
    count += 1 if fit
  end
end
ph('count', count)
