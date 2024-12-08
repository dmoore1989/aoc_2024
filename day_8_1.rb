require_relative 'aoc_helper'

f = File.open('day_8.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

antennas = {}

output.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    if char != '.'
      antennas[char] ||= []
      antennas[char] << [i, j]
    end
  end
end

antinodes = Set.new
antennas.each do |char, antenna|
  antenna.each do |antenna_1|
    antenna.each do |antenna_2|
      next if antenna_1 == antenna_2

      distance_calc = [antenna_1[0] - antenna_2[0], antenna_1[1] - antenna_2[1]]
      node_1 = [antenna_1[0] + distance_calc[0], antenna_1[1] + distance_calc[1]]
      node_2 = [antenna_2[0] - distance_calc[0], antenna_2[1] - distance_calc[1]]
      antinodes.add(node_1) unless outside_of_array?(node_1[0],
                                                     output.length) || outside_of_array?(node_1[1], output[0].length)
      antinodes.add(node_2) unless outside_of_array?(node_2[0],
                                                     output.length) || outside_of_array?(node_2[1], output[0].length)
    end
  end
end
puts(antinodes.count)
