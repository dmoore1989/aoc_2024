require_relative 'aoc_helper'

# its not 89344
f = File.open('day_16.txt')
f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

output = <<~OUTPUTTHATFRICKINGWORKS
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
OUTPUTTHATFRICKINGWORKS
output = output.split("\n")

start = []
endpoint = []
vertices = {}
grid = []
output.each_with_index do |line, i|
  grid << []
  line.each_char.with_index do |char, j|
    if char == 'S'
      start = [i, j]
      vertices[[i, j]] = 0
    end
    endpoint = [i, j] if char == 'E'
    grid[-1] << char
  end
end
print(grid)
# its dijkstras time!
#

seen_points = Set.new
movements = [[0, 1], [-1, 0], [0, -1], [1, 0]]
queue = [[start]]
point = []
seen_points.add([start, 0])
while queue.empty?
  point = queue.shift
  new_items = []
  [position, (position + 1) % 4, (position - 1) % 4].each_with_index do |new_pos, i|
    new_point = [point[0] + movements[new_pos][0], point[1] + movements[new_pos][1]]
    new_score = i == 0 ? score + 1 : score + 1001
    unless grid[new_point[0]][new_point[1]] == '#' || seen_points.include?([new_point, position])
      new_items << [new_point]
    end
  end
  new_items.each do |new_item|
    queue.push(new_item)
    seen_points.add([new_item[0], new_item[1]])
  end
end
ph('points', points)
