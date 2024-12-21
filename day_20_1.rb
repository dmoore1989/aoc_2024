require_relative 'aoc_helper'

f = File.open('day_20.txt')
f = File.open('sample.txt')
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

ph('this is the beginning of the end', startpoint, endpoint)
def run_maze(startpoint, endpoint, grid, cheat_time, cheating)
  ph('run this maze', startpoint, endpoint, cheat_time, cheating)
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
      not_valid ||= grid[new_point[0]][new_point[1]] == '#' unless cheating && [0, 1].include?(point[1])
      next if not_valid

      cheat_points = point[2].dup
      cheat_points << new_point if grid[new_point[0]][new_point[1]] == '#'
      visited_points.add(new_point)
      queue.push([new_point, point[1] + 1, cheat_points])
    end
  end
  if point[1] == cheat_time

    finish_maze = run_maze(point[0], endpoint, grid, -2, true)
    [point[1] + 2 + lowest_maze[0], finish_maze[1]]
  else
    [point[1], point[2]]
  end
end

time, cheat = run_maze(startpoint, endpoint, grid, -2, false)

items = {}
time.times do |picosecond|
  item = run_maze(startpoint, endpoint, grid, picosecond, false)
  ph('items!', item)
  items[item] ||= Set.new
  items[item].add(item)
end

counts = {}
items.each do |k, val|
  counts[time - k[0]] ||= 0
  counts[time - k[0]] += 1
end

ph('counts', counts)
