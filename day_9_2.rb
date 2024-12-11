require_relative 'aoc_helper'

f = File.open('day_9.txt')
# f = File.open('sample.txt')

output = f.readlines.map(&:chomp)
# output = ['2333133121414131402']

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

# ph('disk', disk)
pointer = disk.length - 1
current_id = disk[pointer]
file = []
while pointer >= 0
  char = disk[pointer]
  if char != current_id
    file_pointer = 0
    until file.empty? || disk[file_pointer + (file.length - 1)] == current_id
      if disk[file_pointer...file_pointer + file.length] == [nil] * file.length
        file.length.times do |x|
          disk[pointer + x + 1] = nil
        end
        until file.empty?
          disk[file_pointer] = file.pop
          file_pointer += 1
        end
      end
      file_pointer += 1
    end
    file = []
    current_id -= 1
    pointer -= 1 until disk[pointer] == current_id
    file << disk[pointer]
  else
    file << char
  end
  pointer -= 1
  # ph('disk', disk, file, pointer)
end

checksum = 0
disk.each_with_index do |space, i|
  checksum += i * (space || 0)
end
puts(checksum)
