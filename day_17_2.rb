require_relative 'aoc_helper'

f = File.open('day_17.txt')
f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

register_a = 0
register_b = output[1].split(': ')[1].to_i
register_c = output[2].split(': ')[1].to_i

program = output[4].split(': ')[1].split(',').map(&:to_i)
ph('stuff', register_a, register_b, register_c, program)
# 2,4,1,2,7,5,4,3,0,3,1,7,5,5,3,0
i = 0
output = []
item_find = program.reverse
register_a = 0
register_a_total = 0
item_find.each do |item|
  register_a_initial = 0
  register_b = 0
  register_c = 0
  until item == output[0]
    register_a = register_a_initial
    register_b = 0
    register_c = 0
    output = []
    i = 0
    while i < program.length
      jump = false
      instruction = program[i]
      operand = program[i + 1]
      combo = case operand
              when 0
                operand
              when 1
                operand
              when 2
                operand
              when 3
                operand
              when 4
                register_a
              when 5
                register_b
              when 6
                register_c
              end

      case instruction
      when 0 # adv
        register_a /= (2**combo)
      when 1 # bxl
        register_b ^= operand
      when 2 # bst
        register_b = combo % 8
      when 3 # jnz
        unless register_a.zero?
          i = operand
          jump = true
        end
      when 4 # bxc
        register_b ^= register_c
      when 5 # out
        output <<  combo % 8
      when 6 # bdv
        register_b = register_a / (2**combo)
      when 7 # cdv
        register_c = register_a / (2**combo)
      end
      i += 2 unless jump
    end
    register_a_initial += 1
  end
  puts(register_a_initial)
  register_a_total = (register_a_total << 3) + register_a_initial
end
ph('register_a', register_a_total)
