require_relative 'aoc_helper'

f = File.open('day_6.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def traverse_grid(grid, position)
  visited_positions = Set.new
  movements = {
    '^' => [-1, 0],
    '>' => [0, 1],
    'v' => [1, 0],
    '<' => [0, -1]
  }
  turns = ['^', '>', 'v', '<']
  turn_index = 0

  while true
    visited_positions.add(position)
    # print_helper('movement', [movements, turns[turn_index], movements[turns[turn_index]]])
    next_step = [position[0] + movements[turns[turn_index]][0], position[1] + movements[turns[turn_index]][1]]
    if outside_of_array?(next_step[0], grid.length) || outside_of_array?(next_step[1], grid[0].length)
      return visited_positions
    elsif grid[next_step[0]][next_step[1]] == '#'
      turn_index = (turn_index + 1) % 4
    else
      position = next_step
    end
  end
end

grid = []
position = []
output.each_with_index do |line, i|
  line.each_char.with_index do |point, j|
    grid << [] if j == 0
    position = [i, j] if point == '^'

    grid[i] << point
  end
end

puts(traverse_grid(grid, position).count)
