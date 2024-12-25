require_relative 'aoc_helper'

f = File.open('day_24.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

registers = {}
instructions = {}
output.each do |line|
  if line.include?(':')
    registers[line.split(': ')[0]] = line.split(': ')[1].to_i
  elsif line.include?('->')
    split_line = line.split(' ')
    instructions[[split_line[0], split_line[2], split_line[1], split_line[4]]] = false
  end
end
ph('instructions', instructions)
until instructions.all? { |_v, r| r }
  instructions.each do |instruction, value|
    next if value || registers[instruction[0]].nil? || registers[instruction[1]].nil?

    registers[instruction[3]] ||= 0
    case instruction[2]
    when 'AND'
      registers[instruction[3]] = registers[instruction[0]] & registers[instruction[1]]
    when 'OR'
      registers[instruction[3]] = registers[instruction[0]] | registers[instruction[1]]
    when 'XOR'
      registers[instruction[3]] = registers[instruction[0]] ^ registers[instruction[1]]
    end
    instructions[instruction] = true
  end
end

z_registers = []
registers.each do |key, value|
  next unless key.include?('z')

  z_registers[key[1..].to_i] = value
end

ph('value', z_registers.reverse.join.to_i(2))
