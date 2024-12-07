require_relative 'aoc_helper'

f = File.open('day_7.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

equations = output.map do |line|
  [line.split(': ')[0].to_i, line.split(': ')[1].split(' ').map(&:to_i)]
end

# equations = [[101, [1, 2, 3, 4]]]
def calculate_total(nums, calcs, check)
  total = nums[0]
  nums.each_with_index do |num, i|
    return total if i == nums.length - 1

    if calcs[i] == '0'
      total += nums[i + 1]
    else
      total *= nums[i + 1]
    end
  end
end

def can_be_computed?(equation)
  calcs = (2**(equation[1].length - 1))

  calcs.times do |calc|
    bin_string = calc.to_s(2)
    if bin_string.length < equation[1].length
      bin_string = ('0' * (equation[1].length - 1 - calc.to_s(2).length)) + bin_string
    end
    return true if equation[0] == calculate_total(equation[1], bin_string, equation[0])
  end
  false
end

sum = 0
equations.each do |equation|
  sum += equation[0] if can_be_computed?(equation)
end
puts(sum)
