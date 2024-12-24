require_relative 'aoc_helper'

# Not 2272
f = File.open('day_23.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

map = {}
output.each do |line|
  items = line.split('-')
  map[items[0]] ||= []
  map[items[0]] << items[1]
  map[items[1]] ||= []
  map[items[1]] << items[0]
  # map[items[1]] ||= Set.new
  # map[items[1]].add(items[0])
end

# def walk_mapping(mapping, items, test)
#   ph('items', test)
#   return test if test.length >= 3
#
#   mapping[test[-1]].each do |item|
#     new_items = walk_mapping(mapping, items, test + [item]) unless items.include?(item)
#     items << new_items if new_items
#   end
#   items
# end

set = Set.new
map.each do |key, values|
  values.each do |value1|
    next unless map[value1]

    map[value1].each do |value2|
      next unless map[value2].include?(key)

      set.add([key, value1, value2].sort)
    end
  end
end

# ph('set', set)
count = 0
set.each do |item|
  count += 1 if item.any? { |x| x[0] == 't' }
end
puts(count)
