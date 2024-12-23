require_relative 'aoc_helper'

f = File.open('day_20.txt')
# f = File.open('sample20.txt')
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

def run_maze(startpoint, endpoint, grid)
  # ph('run this maze', startpoint, endpoint, cheat_time)
  mapping = {}
  reverse_mapping = {}
  visited_points = Set.new
  movements = MOVEMENTS[0..3]
  queue = [[startpoint, 0]]
  visited_points.add(startpoint)
  point = []
  until queue.count == 0 || point[0] == endpoint
    point = queue.shift
    # ph('its pointing time', point)
    mapping[point[0]] = point[1]
    reverse_mapping[point[1]] = point[0]
    movements.each do |movement|
      new_point = [point[0][0] + movement[0], point[0][1] + movement[1]]
      not_valid = outside_of_array?(new_point[0], grid.length) || outside_of_array?(new_point[1], grid[0].length) ||
                  visited_points.include?(new_point)
      not_valid ||= grid[new_point[0]][new_point[1]] == '#'
      next if not_valid

      visited_points.add(new_point)
      queue.push([new_point, point[1] + 1])
    end
  end
  [point[1], mapping, reverse_mapping]
end

time, mapping, reverse_mapping = run_maze(startpoint, endpoint, grid)
# ph('time mapping', time, mapping, reverse_mapping)

items = {}
movements = MOVEMENTS[0..3]
count_limit = 20
time.times do |picosecond|
  original_point = reverse_mapping[picosecond]
  # ph('------original_point', original_point)
  queue = [[original_point, 0]]
  visited_set = Set.new
  visited_set.add(original_point)
  until queue.empty?
    point = queue.shift
    # ph('get to the point', point)
    # ph('how are you doing', mapping[point[0]])
    # ph('distance', time, mapping[point[0]], point[1])
    if mapping[point[0]]
      distance = mapping[point[0]] - point[1] - picosecond
      # ph('new_point', picosecond, point, time, mapping[point[0]], distance)
      items[distance] ||= Set.new
      items[distance].add([original_point, point[0]])
    end

    movements.each do |movement|
      new_point = [point[0][0] + movement[0], point[0][1] + movement[1]]

      next if outside_of_array?(new_point[0], grid.length) ||
              outside_of_array?(new_point[1], grid[0].length) ||
              visited_set.include?(new_point) ||
              point[1] > count_limit - 1

      visited_set.add(new_point)
      queue.push([new_point, point[1] + 1])
    end
  end
end
# ph('items', items)

x = 0
items.each do |saving, points|
  # ph('hey', saving, points.count)
  x += points.count if saving >= 100
end
puts(x)
