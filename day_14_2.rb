require_relative 'aoc_helper'

f = File.open('day_14.txt')
space = [101, 103]

# f = File.open('sample.txt')
# space = [11, 7]

output = f.readlines.map(&:chomp)

grid = {}
space[0].times do |i|
  space[1].times do |j|
    grid[j] ||= {}
    grid[j][i] = []
  end
end

output.each do |line|
  numbers = /p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/.match(line)[1..4].map(&:to_i)
  grid[numbers[1]][numbers[0]] << [numbers[3], numbers[2]]
end

seconds = 0
def is_majority_tree(grid, robot_count)
  grid.each do |i, line|
    line.each do |j, point|
      next if point.empty?

      tree_count = count_tree([i, j], grid)
      puts('-----')
      return true if tree_count > robot_count / 2
    end
  end

  false
end

def count_tree(point, grid)
  max_count = 1
  row = 0
  array = [point]
  while true
    ph(array)
    ph(max_count) if max_count > 1
    return max_count if array.any? { |test| grid.dig(test[0], test[1]).nil? || grid[test[0]][test[1]].empty? }

    row += 1
    if array.count == 2

      range = (array[0][1] + 1...array[1][1])
      unless range.any? { |test| grid.dig(array[0], test).nil? || grid[array[0]][test].empty? }
        max_count = 1 + row * 2 + range.to_a.length
      end
    end

    array = [[array[0][0] + 1, array[0][1] - 1], [array[-1][0] + 1, array[-1][1] + 1]]
  end
end

def grid_shift(grid, space)
  new_grid = {}
  space[0].times do |i|
    space[1].times do |j|
      new_grid[j] ||= {}
      new_grid[j][i] = []
    end
  end
  grid.each do |ki, vi|
    vi.each do |kj, vj|
      vj.each do |item|
        new_grid[(ki + item[0]) % space[1]][(kj + item[1]) % space[0]] << item
      end
    end
  end
  new_grid
end

# until is_majority_tree(grid, output.length) || seconds == 100
until seconds == 10_000
  seconds += 1
  grid = grid_shift(grid, space)
  next unless (seconds - 97) % 101 == 0 || (seconds - 50) % 103 == 0

  puts("======== #{seconds} seconds ======")
  grid.each do |i, line|
    line.each do |j, val|
      if val.length > 0
        print('0')
      else
        print(' ')
      end
    end
    print("\n")
  end
  print("\n")

  gets
end
