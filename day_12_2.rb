require_relative 'aoc_helper'

f = File.open('day_12.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def calc_area_and_side_count(char, start, new_grid)
  movements = MOVEMENTS[..3]
  move_list = [[start[0], start[1]]]
  visited_points = Set.new
  area = 0
  while move_list.length > 0
    current_point = move_list.shift
    next if visited_points.include?(current_point)

    area += 1
    visited_points.add(current_point)
    movements.each do |movement|
      next_space = [current_point[0] + (movement[0] * 2), current_point[1] + (movement[1] * 2)]

      if outside_of_array?(next_space[0], new_grid.length) ||
         outside_of_array?(next_space[1], new_grid[0].length) ||
         new_grid[next_space[0]][next_space[1]] != char

        new_grid[current_point[0] + movement[0]][current_point[1] + movement[1]] = '*'
        next
      end

      move_list << next_space
    end

  end
  sides = 0
  new_grid.each_with_index do |line, i|
    line.each_with_index do |char, j|
      next unless char.nil?

      string = movements.map do |movement|
        next_space = [i + (movement[0]), j + (movement[1])]
        if outside_of_array?(next_space[0], new_grid.length) ||
           outside_of_array?(next_space[1], new_grid[0].length) ||
           new_grid[next_space[0]][next_space[1]] != '*'
          '-'
        else
          '*'
        end
      end.join

      sides += 2 if string == '****'
      sides += 1 if ['**--', '-**-', '--**', '*--*'].include?(string)
    end
  end

  [area, sides, visited_points]
end

new_grid = [[nil] * ((output[0].length * 2) + 1)]
output.each do |line|
  new_line = [nil]
  line.each_char do |x|
    new_line << x
    new_line << nil
  end

  new_grid << new_line
  new_grid << [nil] * ((output[0].length * 2) + 1)
end
cost = 0
visited_points = Set.new
new_grid.each_with_index do |line, i|
  line.each_with_index do |char, j|
    next if visited_points.include?([i, j]) || new_grid[i][j].nil?

    dup_grid = []
    new_grid.each_with_index do |line, x|
      dup_grid << []
      line.each do |char|
        dup_grid[x] << char
      end
    end
    area, side_count, new_visited_points = calc_area_and_side_count(char, [i, j], dup_grid)
    visited_points.merge(new_visited_points)
    cost += area * side_count
  end
end
puts(cost)
