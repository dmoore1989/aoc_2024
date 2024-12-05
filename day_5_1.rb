require_relative 'aoc_helper'

f = File.open('day_5.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def follows_rules(manual, rules)
  manual.each_with_index do |page1, i|
    manual[i + 1..].each do |page2|
      return false if rules[page2] && rules[page2].include?(page1)
    end
  end

  true
end

rules = {}
manuals = []
total = 0
output.each do |line|
  next if line == ''

  if line.include?('|')
    rule_elements = line.split('|').map(&:to_i)
    rules[rule_elements[0]] ||= []
    rules[rule_elements[0]] << rule_elements[1]
  else
    manuals << line.split(',').map(&:to_i)
  end
end
manuals.each do |manual|
  total += manual[manual.length / 2] if follows_rules(manual, rules)
end
puts(total)
