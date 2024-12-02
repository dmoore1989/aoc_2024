require_relative 'aoc_helper'

f = File.open('day_2.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def check_elements(elements)
  increasing = false
  elements.each_with_index do |element, i|
    element = element.to_i
    return true if elements.count == i + 1

    element_diff = element - elements[i + 1].to_i
    return false if element_diff.zero?

    if i == 0 && element_diff.negative?
      increasing = true
    elsif i == 0
      increasing = false
    end

    return false if element_diff.abs > 3

    return false if element_diff.negative? && !increasing
    return false if element_diff.positive? && increasing
  end
  true
end

safe_count = 0
output.each do |line|
  elements = line.split(' ')
  safe_count += 1 if check_elements(elements)
end
puts(safe_count)
