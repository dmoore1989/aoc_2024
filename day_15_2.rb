require_relative 'aoc_helper'

f = File.open('day_15.txt')
f = File.open('sample.txt')
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
      case char
      when '#'
        grid[-1] << '#'
        grid[-1] << '#'
      when 'O'
        grid[-1] << '['
        grid[-1] << ']'
      when '@'
        grid[-1] << '@'
        grid[-1] << '.'
        point = [i * 2, j]
      else
        grid[-1] << '.'
        grid[-1] << '.'
      end
    end
  else
    instructions += line
  end
end

def move_point(point, instruction, grid)
  movement = MOVEMENT_MAPPING[instruction]
  check_point_layers = [[point]]
  new_check_points = []
  has_new_check_points = true
  while has_new_check_points
    has_new_check_points = false
    check_point_layers[-1].each do |check_point|
      new_check_point = [check_point[0] + movement[0], check_point[1] + movement[1]]
      return point if grid[new_check_point[0]][new_check_point[1]] == '#'

      next if grid[new_check_point[0]][new_check_point[1]] == '.'

      new_check_points << new_check_point
      next unless ['v', '^'].include?(instruction)

      new_check_points << if grid[check_point[0]][check_point[1]] == ']'
                            [check_point[0], check_point[1] - 1]
                          else
                            [check_point[0], check_point[1] + 1]
                          end
    end

    unless new_check_points.empty?
      check_point_layers << new_check_points
      has_new_check_points = true
    end
    new_check_points = []
  end

  ph('check_point_layers', check_point_layers)
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
    count += 100 * i + j if char == '['
  end
end
puts(count)
