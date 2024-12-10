require_relative 'aoc_helper'

f = File.open('day_10.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

def get_path_count(grid, start, num, count)
  if outside_of_array?(start[0], grid.length) ||
     outside_of_array?(start[1], grid[0].length) ||
     grid[start[0]][start[1]].to_i != num
    return 0
  end
  return 1 if num == 9

  new_count = 0
  movements = MOVEMENTS[0..3]
  movements.each do |movement|
    new_count += get_path_count(grid, [start[0] + movement[0], start[1] + movement[1]], num + 1, count)
  end
  new_count
end

path_count = 0
output.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    path_count += get_path_count(output, [i, j], 0, 0) if char.to_i == 0
  end
end
puts(path_count)
