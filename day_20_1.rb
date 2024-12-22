require_relative 'aoc_helper'

f = File.open('day_20.txt')
f = File.open('sample20.txt')
output = f.readlines.map(&:chomp)

startpoint = []
endpoint = []
grid = []
output.each_with_index do |line, i|
  grid << []
  line.each_char.with_index do |char, j|
    startpoint = [i, j] if char == 'S'
    endpoint = [i, j] if char == 'E'
    grid[-1] << char
  end
end

CHEAT_MOVEMENTS = [[1, 1], [1, -1], [-1, 1], [-1, -1], [2, 0], [-2, 0], [0, 2], [0, -2]].freeze

ph('this is the beginning of the end', startpoint, endpoint)
def run_maze(startpoint, endpoint, grid, cheat_time)
  ph('run this maze', startpoint, endpoint, cheat_time)
  visited_points = Set.new
  movements = MOVEMENTS[0..3]
  queue = [[startpoint, 0, []]]
  visited_points.add(startpoint)
  point = []
  until queue.count == 0 || point[0] == endpoint || point[1] == cheat_time
    point = queue.shift
    # ph('its pointing time', point)
    movements.each do |movement|
      new_point = [point[0][0] + movement[0], point[0][1] + movement[1]]
      not_valid = outside_of_array?(new_point[0], grid.length) || outside_of_array?(new_point[1], grid[0].length) ||
                  visited_points.include?(new_point)
      not_valid ||= grid[new_point[0]][new_point[1]] == '#'
      next if not_valid

      cheat_points = point[2].dup
      cheat_points << new_point if grid[new_point[0]][new_point[1]] == '#'
      visited_points.add(new_point)
      queue.push([new_point, point[1] + 1, cheat_points])
    end
  end
  if point[1] == cheat_time
    lowest_maze = nil
    CHEAT_MOVEMENTS.each do |cheat_movement|
      new_point = [point[0][0] + cheat_movement[0], point[0][1] + cheat_movement[1]]
      next if outside_of_array?(new_point[0], grid.length) || outside_of_array?(new_point[1], grid[0].length)

      value = run_maze(new_point, endpoint, grid, -2)
      next if value.nil?

      lowest_maze = value if lowest_maze.nil? || lowest_maze > value
    end

    point[1] + lowest_maze
  elsif point[0] == endpoint
    point[1]
  else
    nil
  end
end

time = run_maze(startpoint, endpoint, grid, -2)

items = {}
time.times do |picosecond|
  item = run_maze(startpoint, endpoint, grid, picosecond)
  items[time - item] ||= 0
  items[time - item] += 1
end
ph('items!', items)