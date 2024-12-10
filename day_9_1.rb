require_relative 'aoc_helper'

f = File.open('day_9.txt')
# f = File.open('sample.txt')
output = f.readlines.map(&:chomp)

disk = []
id = 0
output[0].each_char.with_index do |c, i|
  if i.even?
    content = id
    id += 1
  else
    content = nil
  end

  c.to_i.times do
    disk << content
  end
end

pointer = 0
while pointer < disk.length
  pointer += 1 until disk[pointer].nil?

  id = disk.pop
  unless id.nil?
    disk[pointer] = id
    pointer += 1
  end
end
disk = disk.compact

checksum = 0
disk.each_with_index do |space, i|
  checksum += i * space
end
puts(checksum)
