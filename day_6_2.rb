require_relative 'aoc_helper'

f = File.open('day_6.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def traverse_grid(grid, position, turn_index, has_block)
  first_position = position.dup
  set = Set.new
  movements = {
    '^' => [-1, 0],
    '>' => [0, 1],
    'v' => [1, 0],
    '<' => [0, -1]
  }
  turns = ['^', '>', 'v', '<']
  loop_set = Set.new
  while true

    return true if set.include?([position, turns[turn_index]])

    set.add([position, turns[turn_index]])
    next_step = [position[0] + movements[turns[turn_index]][0], position[1] + movements[turns[turn_index]][1]]
    if outside_of_array?(next_step[0], grid.length) || outside_of_array?(next_step[1], grid[0].length)
      return !has_block && loop_set
    elsif grid[next_step[0]][next_step[1]] == '#'
      turn_index = (turn_index + 1) % 4
    else
      unless has_block
        new_grid = grid.dup
        new_grid[next_step[0]] = grid[next_step[0]].dup
        new_grid[next_step[0]][next_step[1]] = '#'
        loop_set.add(next_step) if traverse_grid(new_grid, first_position, 0, true)
      end
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

puts(traverse_grid(grid, position, 0, false).count)
