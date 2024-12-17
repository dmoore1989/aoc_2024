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
        point = [i, j * 2]
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
  new_check_points = Set.new
  has_new_check_points = true
  while has_new_check_points
    has_new_check_points = false
    check_point_layers[-1].each do |check_point|
      new_check_point = [check_point[0] + movement[0], check_point[1] + movement[1]]
      return point if grid[new_check_point[0]][new_check_point[1]] == '#'

      next if grid[new_check_point[0]][new_check_point[1]] == '.'

      new_check_points.add(new_check_point)
      next unless ['v', '^'].include?(instruction)

      if grid[new_check_point[0]][new_check_point[1]] == ']'
        new_check_points.add([new_check_point[0], new_check_point[1] - 1])
      else
        new_check_points.add([new_check_point[0], new_check_point[1] + 1])
      end
    end

    unless new_check_points.empty?
      check_point_layers << new_check_points
      has_new_check_points = true
    end
    # ph('check_point_length', check_point_layers)
    new_check_points = Set.new
  end

  check_point_layers.reverse.each do |check_point_layer|
    check_point_layer.each do |check_point|
      place_holder = grid[check_point[0]][check_point[1]]
      grid[check_point[0]][check_point[1]] = grid[check_point[0] + movement[0]][check_point[1] + movement[1]]
      grid[check_point[0] + movement[0]][check_point[1] + movement[1]] = place_holder
    end
  end

  [point[0] + movement[0], point[1] + movement[1]]
end

instructions.each_char.with_index do |instruction, t|
  # ph('point', point)
  # ph('move', instruction, point)
  point = move_point(point, instruction, grid)
  # pg(grid) { |i, j| print(grid[i][j]) }
end

count = 0
grid.each_with_index do |line, i|
  line.each_with_index do |char, j|
    count += 100 * i + j if char == '['
  end
end
puts(count)
