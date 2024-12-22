require_relative 'aoc_helper'

f = File.open('day_21.txt')
f = File.open('sample21.txt')
output = f.readlines.map(&:chomp)

# traversal methods

NUMPAD = [
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
  ['', '0', 'A']
]
NUMPAD_START = [3, 2]

KEYPAD = [
  ['', '^', 'A'],
  ['<', 'v', '>']
]
KEYPAD_START = [0, 2]

def is_illegal_move?(new_point, grid)
  outside_of_array?(new_point[0], grid.length) ||
    outside_of_array?(new_point[1], grid[0].length) ||
    grid[new_point[0]][new_point[1]] == ''
end

def traverse(point, next_point, grid)
  queue = [[point, []]]
  seen_points = Set.new
  seen_points.add(point)
  current_point = []
  until queue.empty? || current_point.dig(0) == next_point
    current_point = queue.shift
    MOVEMENT_MAPPING.each do |movement, coor|
      new_point = [current_point[0][0] + coor[0], current_point[0][1] + coor[1]]
      next if is_illegal_move?(new_point, grid)

      queue << [new_point, current_point[1] + [movement]]
    end
  end
  current_point[1].permutation.map { |x| x.join + 'A' }.uniq
end

numpad_moves = {}

NUMPAD.each_with_index do |line, i|
  line.each_with_index do |char, j|
    next if char == ''

    numpad_moves[char] = {}
    NUMPAD.each_with_index do |line2, x|
      line2.each_with_index do |char2, y|
        next if char2 == ''

        numpad_moves[char][char2] = traverse([i, j], [x, y], NUMPAD)
      end
    end
  end
end

keypad_moves = {}
KEYPAD.each_with_index do |line, i|
  line.each_with_index do |char, j|
    next if char == ''

    keypad_moves[char] = {}
    KEYPAD.each_with_index do |line2, x|
      line2.each_with_index do |char2, y|
        next if char2 == ''

        keypad_moves[char][char2] = traverse([i, j], [x, y], KEYPAD)
      end
    end
  end
end

output.each do |line|
  movement_strings = Set.new([''])
  it_line = 'A' + line
  it_line.each_char.with_index do |c, i|
    next if i >= it_line.length - 1

    moves = numpad_moves[it_line[i]][it_line[i + 1]]
    new_movement_strings = Set.new
    movement_strings.each do |movement_string|
      moves.each do |move|
        new_movement_strings.add(movement_string + move)
      end
    end
    movement_strings = new_movement_strings
  end
  ph('movement_strings', movement_strings)
  strings = Set.new
  2.times do
    total_set = Set.new
    movement_strings.each do |movement_string|
      next_string = 'A' + movement_string
      new_set = Set.new([''])
      next_string.each_char.with_index do |mc, i|
        next if i >= next_string.length - 1

        moves = keypad_moves[next_string[i]][next_string[i + 1]]
        next_set = Set.new
        new_set.each do |item|
          moves.each do |move|
            next_set.add(item + move)
          end
        end
        new_set = next_set
      end
      total_set += new_set
    end
    movement_strings = total_set
    ph('total_set', movement_strings.count)
  end
end

# 029A: <vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A
# 029A: v<A<AA>^>AvA^<A>vA^Av<<A>^>AvA^Av<<A>^>AAvA<A^>A<A>Av<A<A>^>AAA<A>vA^A
#
# v<<A>^>A<A>A<AA>vA^Av<AAA^>A
# v<<A>>^A<A>AvA<^AA>A<vAAA>^A
#
# <A^A^^>AvvvA
#
#
# {
#   "^"=>{"^"=>"A", "A"=>">A", "<"=>"v<A", "v"=>"vA", ">"=>">vA"},
#   "A"=>{"^"=>"<A", "A"=>"A", "<"=>"v<<A", "v"=>"v<A", ">"=>"vA"},
#   "<"=>{"^"=>">^A", "A"=>">^>A", "<"=>"A", "v"=>">A", ">"=>">>A"},
#   "v"=>{"^"=>"^A", "A"=>"^>A", "<"=>"<A", "v"=>"A", ">"=>">A"},
#   ">"=>{"^"=>"^<A", "A"=>"^A", "<"=>"<<A", "v"=>"<A", ">"=>"A"}}
# it_lines = movement_strings.map { |movement_string| 'A' + movement_string }
# it_lines.each do |it_lineb|
#   it_lineb.each_char.with_index do |c, i|
#     ph('counts', it_lineb.length, i)
#     next if i >= it_lineb.length - 1
#
#     moves = keypad_moves[it_lineb[i]][it_lineb[i + 1]]
#
#     new_movement_strings = []
#     movement_strings.each do |movement_string|
#       moves.each do |move|
#         new_movement_strings << movement_string + move
#       end
#     end
#
#     movement_strings = new_movement_strings
#     ph('movement_counts', movement_strings.count)
#   end
# end
