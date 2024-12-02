require_relative 'aoc_helper'

f = File.open('day_2.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def check_elements_without_item(elements, index)
  first_array = elements[0...index] + elements[index + 1..]
  second_array = elements[0...index + 1] + elements[index + 2..]
  check_elements(first_array, false) || check_elements(second_array, false)
end

def check_elements(elements, first_go)
  increasing = false

  if elements[0].to_i > elements[-1].to_i
    increasing = false
  elsif elements[0].to_i < elements[-1].to_i
    increasing = true
  else
    return false
  end
  elements.each_with_index do |element, i|
    element = element.to_i
    return true if elements.count == i + 1

    element_diff = element - elements[i + 1].to_i
    return first_go && check_elements_without_item(elements, i) if element_diff.zero?

    if element_diff.abs > 3 || (element_diff.negative? && !increasing) || (element_diff.positive? && increasing)
      return first_go && check_elements_without_item(elements, i)
    end
  end
  true
end

safe_count = 0
output.each do |line|
  elements = line.split(' ')
  check_elements = check_elements(elements, true)
  safe_count += 1 if check_elements
end
puts(safe_count)
