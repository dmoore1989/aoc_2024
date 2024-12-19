require_relative 'aoc_helper'

f = File.open('day_19.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

available_patterns = output[0].split(', ')

def can_display?(display, available_patterns)
  return true if display.length == 0

  available_patterns.each do |available_pattern|
    i = available_pattern.length
    ph('check', display[...i], available_pattern)
    return true if display[...i] == available_pattern && can_display?(display[i..], available_patterns)
  end
  false
end

count = 0
output[2..].each do |display|
  count += 1 if can_display?(display, available_patterns)
end
puts(count)
