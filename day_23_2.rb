require_relative 'aoc_helper'

# Not 2272
f = File.open('day_23.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

map = {}
output.each do |line|
  items = line.split('-')
  map[items[0]] ||= Set.new
  map[items[0]].add(items[1])
  map[items[1]] ||= Set.new
  map[items[1]].add(items[0])
end

ph('map', map)
def find_networks(map, node, visited_nodes)
  node_set = Set.new
  items = map[node]
  return false unless visited_nodes.subset?(map[node] + [node])

  ph('node', node, visited_nodes, visited_nodes.count)

  node_set.add(visited_nodes)
  map[node].each do |new_node|
    next if visited_nodes.include?(new_node)

    new_set = find_networks(map, new_node, visited_nodes.merge([new_node]))
    node_set.merge(new_set) if new_set
  end
  node_set
end
set_of_points = Set.new
map.keys.each do |node|
  set_of_points.merge(find_networks(map, node, Set.new.add(node)))
end
# ph('set of points', set_of_points)
