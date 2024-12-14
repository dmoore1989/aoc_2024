require_relative 'aoc_helper'

f = File.open('day_14.txt')
space = [101, 103]

# f = File.open('sample.txt')
# space = [11, 7]

output = f.readlines.map(&:chomp)

robots = []
output.each do |line|
  numbers = /p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/.match(line)[1..4].map(&:to_i)
  robots << numbers
end

100.times do |time|
  robots.map! do |robot|
    robot = [(robot[0] + robot[2]) % space[0], (robot[1] + robot[3]) % space[1], robot[2], robot[3]]
  end
end
ph('robots', robots)
quadrant_1 = 0
quadrant_2 = 0
quadrant_3 = 0
quadrant_4 = 0

robots.each do |robot|
  if robot[0] < space[0] / 2
    if robot[1] < space[1] / 2
      quadrant_1 += 1
    elsif robot[1] > space[1] / 2
      quadrant_2 += 1
    end
  elsif robot[0] > space[0] / 2
    if robot[1] < space[1] / 2
      quadrant_3 += 1
    elsif robot[1] > space[1] / 2
      quadrant_4 += 1
    end
  end
end
puts(quadrant_1 * quadrant_2 * quadrant_3 * quadrant_4)
