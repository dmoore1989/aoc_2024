require_relative 'aoc_helper'

f = File.open('day_24.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

original_registers = {}
instruction_array = []
output.each do |line|
  if line.include?(':')
    original_registers[line.split(': ')[0]] = [line.split(': ')[1].to_i, []]
  elsif line.include?('->')
    split_line = line.split(' ')
    instruction_array << [split_line[0], split_line[2], split_line[4], split_line[1]]
  end
end

def run_instructions(registers, instruction_array)
  instructions = {}
  instruction_array.each do |instruction|
    instructions[instruction] = false
  end
  until instructions.all? { |_v, r| r }
    instructions.each do |instruction, value|
      next if value || registers[instruction[0]].nil? || registers[instruction[1]].nil?

      registers[instruction[2]] ||= 0
      case instruction[3]
      when 'AND'
        registers[instruction[2]] =
          [registers[instruction[0]][0] & registers[instruction[1]][0],
           [instruction[0], instruction[1]] + registers[instruction[0]][1] + registers[instruction[1]][1]]
      when 'OR'
        registers[instruction[2]] =
          [registers[instruction[0]][0] | registers[instruction[1]][0],
           [instruction[0], instruction[1]] + registers[instruction[0]][1] + registers[instruction[1]][1]]
      when 'XOR'
        registers[instruction[2]] =
          [registers[instruction[0]][0] ^ registers[instruction[1]][0],
           [instruction[0], instruction[1]] + registers[instruction[0]][1] + registers[instruction[1]][1]]
      end
      instructions[instruction] = true
    end
  end
  registers
end

registers = run_instructions(original_registers.dup, instruction_array)
registers.each do |key, register|
  ph('registers', key, register)
end
exit
x_registers = []
y_registers = []
z_registers = []
registers.each do |key, value|
  x_registers[key[1..].to_i] = value if key[0] == 'x'
  y_registers[key[1..].to_i] = value if key[0] == 'y'
  z_registers[key[1..].to_i] = value if key[0] == 'z'
end

instruction_set_length = instruction_array.length
instruction_length = instruction_set_length * 3
wire_1_x = 0
wire_1_y = 1
wire_2_x = 2
wire_2_y = 3
wire_3_x = 4
wire_3_y = 5
wire_4_x = 6
wire_4_y = 7

while true
  instructions = instruction_array.dup
  if [wire_1_x, wire_1_y, wire_2_x, wire_2_y, wire_3_x, wire_3_y, wire_4_x,
      wire_4_y].uniq == [wire_1_x, wire_1_y, wire_2_x, wire_2_y, wire_3_x, wire_3_y, wire_4_x, wire_4_y]
    instructions[wire_1_x % instruction_length / 3][wire_1_x % 3], instructions[wire_1_y  % instruction_length / 3][wire_1_y  % 3] =
      instructions[wire_1_y % instruction_length / 3][wire_1_y % 3],
instructions[wire_1_x % instruction_length / 3][wire_1_x % 3]
    instructions[wire_2_x % instruction_length / 3][wire_2_x % 3], instructions[wire_2_y  % instruction_length / 3][wire_2_y  % 3] =
      instructions[wire_2_y % instruction_length / 3][wire_2_y % 3],
instructions[wire_2_x % instruction_length / 3][wire_2_x % 3]
    instructions[wire_3_x % instruction_length / 3][wire_3_x % 3], instructions[wire_3_y  % instruction_length / 3][wire_3_y  % 3] =
      instructions[wire_3_y % instruction_length / 3][wire_3_y % 3],
instructions[wire_3_x % instruction_length / 3][wire_3_x % 3]
    instructions[wire_4_x % instruction_length / 3][wire_4_x % 3], instructions[wire_4_y  % instruction_length / 3][wire_4_y  % 3] =
      instructions[wire_4_y % instruction_length / 3][wire_4_y % 3],
instructions[wire_4_x % instruction_length / 3][wire_4_x % 3]
    registers = run_instructions(registers, instruction_array)
    x_registers = []
    y_registers = []
    z_registers = []
    registers.each do |key, value|
      x_registers[key[1..].to_i] = value if key[0] == 'x'
      y_registers[key[1..].to_i] = value if key[0] == 'y'
      z_registers[key[1..].to_i] = value if key[0] == 'z'
    end
    break if x_registers.reverse.join.to_i(2) + y_registers.reverse.join.to_i(2) == z_registers.reverse.join.to_i(2) &&
             x_registers.reverse.join.to_i(2) + y_registers.reverse.join.to_i(2) + z_registers.reverse.join.to_i(2) != 0
  end
  wire_4_y += 1
  next unless wire_4_y % instruction_length == 0

  wire_4_y %= instruction_length
  wire_4_x += 1
  next unless wire_4_x % instruction_length == 0

  wire_4_x %= instruction_length
  wire_3_y += 1
  next unless wire_3_y % instruction_length == 0

  wire_3_y %= instruction_length
  wire_3_x += 1
  next unless wire_3_x % instruction_length == 0

  wire_3_x %= instruction_length
  wire_2_y += 1
  next unless wire_2_y % instruction_length == 0

  wire_2_y %= instruction_length
  wire_2_x += 1
  next unless wire_2_x % instruction_length == 0

  wire_2_x %= instruction_length
  wire_1_y += 1
  next unless wire_1_y % instruction_length == 0

  wire_1_y %= instruction_length

  wire_1_x += 1
  ph('here we go', wire_1_x, wire_1_y, wire_2_x, wire_2_y, wire_3_x, wire_3_y, wire_4_x, wire_4_y)
end
ph('the wires', wire_1_x, wire_1_y, wire_2_x, wire_2_y, wire_3_x, wire_3_y, wire_4_x, wire_4_y)
ph('really?', x_registers.reverse.join.to_i(2), y_registers.reverse.join.to_i(2), z_registers.reverse.join.to_i(2))
