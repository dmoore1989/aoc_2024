require_relative 'aoc_helper'

f = File.open('day_16.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

start = []
grid = []
output.each_with_index do |line, i|
  grid << []
  line.each_char.with_index do |char, j|
    start = [i, j] if char == 'S'
    grid[-1] << char
  end
end
def maze_finder(score, point, grid, direction, seen_points, min_score)
  # ph('point', point)
  movement_array = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  until grid[point[0]][point[1]] == 'E'
    possible_moves = [direction, (direction - 1) % 4, (direction + 1) % 4]
    possible_moves.filter! do |move|
      next_point = [point[0] + movement_array[move][0], point[1] + movement_array[move][1]]
      grid[next_point[0]][next_point[1]] != '#' && !seen_points.include?(next_point)
    end
    # ph('possible_moves', point)
    return nil if possible_moves.empty?

    if possible_moves.length == 1
      score += direction == possible_moves[0] ? 1 : 1001
      next_point = [point[0] + movement_array[possible_moves[0]][0], point[1] + movement_array[possible_moves[0]][1]]
      return nil if min_score && score > min_score

      seen_points.add(next_point)
      direction = possible_moves[0]
      point = next_point
    else
      # ph('move', possible_moves)
      possible_moves.each do |move|
        new_score = score + (direction == move ? 1 : 1001)
        return nil if min_score && new_score > min_score

        new_point = [point[0] + movement_array[move][0], point[1] + movement_array[move][1]]
        seen_points.add(new_point)
        find_end = maze_finder(new_score, new_point, grid, move, seen_points.dup, min_score)
        ph('min_score', min_score) if find_end && min_score && find_end < min_score
        min_score = find_end if find_end
      end
      # ph('min_score', min_score)
      return min_score
    end
  end
  # puts('here')
  score
end

first_set = Set.new
first_set.add(start)
puts(maze_finder(0, start, grid, 0, first_set, nil))
