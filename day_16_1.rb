require_relative 'aoc_helper'

# its not 89344
f = File.open('day_16.txt')
f = File.open('sample.txt')

f = <<- OUTPUTTHATFUCKINGWORKS
###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
OUTPUTTHATFUCKINGWORKS
output = f.readlines.map(&:chomp)

start = []
endpoint = []
grid = []
output.each_with_index do |line, i|
  grid << []
  line.each_char.with_index do |char, j|
    start = [i, j] if char == 'S'
    endpoint = [i, j] if char == 'E'
    grid[-1] << char
  end
end

seen_points = Set.new
movements = [[0, 1], [-1, 0], [0, -1], [1, 0]]
queue = [[start, 0, 0]]
point = []
seen_points.add([start, 0])
walking_path = false
until queue.empty?
  point, position, score = queue.shift unless walking_path
  ph('point', point, position, score)
  new_items = []
  [position, (position + 1) % 4, (position - 1) % 4].each_with_index do |new_pos, i|
    new_point = [point[0] + movements[new_pos][0], point[1] + movements[new_pos][1]]
    new_score = i == 0 ? score + 1 : score + 1001
    unless grid[new_point[0]][new_point[1]] == '#' || seen_points.include?([new_point, position])
      new_items << [new_point, new_pos, new_score]
    end
  end
  if new_items.length == 1
    point, position, score = new_items[0]
    walking_path = true
  else
    new_items.each do |new_item|
      queue.push(new_item)
      seen_points.add([new_item[0], new_item[1]])
    end
    walking_path = false
  end
end
