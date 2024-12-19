require_relative 'aoc_helper'

f = File.open('day_19.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

available_patterns = output[0].split(', ')

def count_display(display, available_patterns, cache)
  return [cache[display], cache] if cache[display]
  # ph('can_display', display, available_patterns)
  return [1, cache] if display.length == 0

  count = 0
  available_patterns.each do |available_pattern|
    i = available_pattern.length
    # ph('check', display[...i], available_pattern)
    if display[...i] == available_pattern
      added_count, cache = count_display(display[i..], available_patterns, cache)
      count += added_count
    end
  end
  cache[display] = count
  [count, cache]
end

count = 0
output[2..].each do |display|
  new_count, cache = count_display(display, available_patterns, {})
  count += new_count
  # ph('---------', count)
end
puts(count)
