require_relative 'aoc_helper'

f = File.open('day_18.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

corrupted_memory = Set.new

output.each_with_index do |item, i|
  corrupted_memory.add([item.split(',')[0].to_i, item.split(',')[1].to_i])
  break if i == 1023
end

endpoint = [70, 70]
startpoint = [0, 0]
visited_points = Set.new
movements = MOVEMENTS[..3]

queue = [[startpoint, 0]]
point = []
until queue.count == 0 || point.dig(0) == endpoint
  point = queue.shift
  movements.each do |movement|
    new_point = [point[0][0] + movement[0], point[0][1] + movement[1]]
    next if outside_of_array?(new_point[0], endpoint[0] + 1) || outside_of_array?(new_point[1], endpoint[1] + 1) ||
            visited_points.include?(new_point) || corrupted_memory.include?(new_point)

    visited_points.add(new_point)
    queue.push([new_point, point[1] + 1])
  end

end
ph('count', point[1])