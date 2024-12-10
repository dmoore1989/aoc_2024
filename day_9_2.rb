require_relative 'aoc_helper'

# f = File.open('day_9.txt')
f = File.open('sample.txt')
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

ph('disk', disk)
pointer = disk.length - 1
file = [disk[pointer]]
disk[pointer] = nil
pointer -= 1
while pointer >= 0
  char = disk[pointer]

  if file[0] != char
    pointer_2 = 0
    until file.empty?
      if disk[pointer_2...pointer_2 + file.length] == [nil] * file.length
        file.length.times do
          disk[pointer_2] = file[0]
          pointer_2 += 1
        end
        disk[pointer_2] = file[0]
        file = []
      end
      pointer_2 += 1
    end
    pointer -= 1 while disk[pointer].nil?
    file = [disk[pointer]]
    disk[pointer] = nil
    pointer -= 1
  else
    file << char
    disk[pointer] = nil
    pointer -= 1
  end
  ph('disk', disk, file, pointer)
end

checksum = 0
disk.each_with_index do |space, i|
  checksum += i * (space || 0)
end
puts(checksum)
