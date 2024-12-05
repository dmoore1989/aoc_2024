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

def sort_manual(manual, rules)
  until follows_rules(manual, rules)
    i = 0
    while i < manual.length
      j = i + 1
      while j < manual.length
        page1 = manual[i]
        page2 = manual[j]
        if rules[page2] && rules[page2].include?(page1)
          deleted_page = manual.delete_at(j)
          manual = manual[...i] + [deleted_page, manual[i]] + manual[i + 1..]
          i += 1
          j += 1
        end
        j += 1
      end
      i += 1
    end
  end
  print_helper('manual', manual)
  manual[manual.length / 2]
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
incorrect = []
manuals.each do |manual|
  incorrect << manual unless follows_rules(manual, rules)
end

incorrect.each do |manual|
  total += sort_manual(manual, rules)
end
puts(total)
