require_relative 'aoc_helper'

f = File.open('day_15.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

grid = []
instructions = ''
point = []
build_grid = true
output.each_with_index do |line, i|
  if line == ''
    build_grid = false
  elsif build_grid
    grid << []
    line.each_char.with_index do |char, j|
      point = [i, j] if char == '@'
      grid[-1] << char
    end
  else
    instructions += line
  end
end

def move_point(point, instruction, grid)
  movement = MOVEMENT_MAPPING[instruction]
  check_point = point
  while grid[check_point[0]][check_point[1]] == 'O' || check_point == point
    check_point = [check_point[0] + movement[0], check_point[1] + movement[1]]
  end

  # ph('check_point', check_point)
  return point if grid[check_point[0]][check_point[1]] == '#'

  until check_point == point
    prior_point = [check_point[0] - movement[0], check_point[1] - movement[1]]
    prior_char = grid[prior_point[0]][prior_point[1]]
    grid[prior_point[0]][prior_point[1]] = grid[check_point[0]][check_point[1]]
    grid[check_point[0]][check_point[1]] = prior_char
    check_point = prior_point
  end

  [check_point[0] + movement[0], check_point[1] + movement[1]]
end

instructions.each_char.with_index do |instruction, t|
  # ph('point', point)
  point = move_point(point, instruction, grid)
  # ph('move', instruction, point)
  # pg(grid) { |i, j| print(grid[i][j]) }
end

count = 0
grid.each_with_index do |line, i|
  line.each_with_index do |char, j|
    count += 100 * i + j if char == 'O'
  end
end
puts(count)
