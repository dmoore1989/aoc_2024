require_relative 'aoc_helper'

f = File.open('day_12.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def calc_area_and_perimeter(char, start, grid)
  movements = MOVEMENTS[..3]
  move_list = [start]
  visited_points = Set.new
  area = 0
  perimeter = 0
  while move_list.length > 0
    current_point = move_list.shift
    next if visited_points.include?(current_point)

    visited_points.add(current_point)
    movements.each do |movement|
      next_space = [current_point[0] + movement[0], current_point[1] + movement[1]]
      next if visited_points.include?(next_space)

      if outside_of_array?(next_space[0],
                           grid.length) || outside_of_array?(next_space[1],
                                                             grid[0].length) || grid[next_space[0]][next_space[1]] != char
        perimeter += 1
        next
      end

      move_list << next_space
    end
    area += 1

  end
  [area, perimeter, visited_points]
end

cost = 0
visited_points = Set.new
output.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    next if visited_points.include?([i, j])

    area, perimeter, new_visited_points = calc_area_and_perimeter(char, [i, j], output)

    visited_points.merge(new_visited_points)
    cost += area * perimeter
  end
end
puts(cost)
